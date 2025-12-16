using prjWebQrFinder.mesClasses;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace prjWebQrFinder
{
    public partial class accueilUtilisateurs : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Vérifier si l'utilisateur est connecté
            if (Session["Email"] == null || Session["Nom"] == null || Session["Prenom"] == null)
            {
                Response.Redirect("connexionQrFinder.aspx");
                return;
            }

            // Vérifier si c'est bien un utilisateur (pas un admin)
            if (Session["NomRole"] != null && Session["NomRole"].ToString() == "Admin")
            {
                Response.Redirect("accueilAdminsQrFinder.aspx");
                return;
            }

            if (!IsPostBack)
            {
                ChargerDonneesUtilisateur();
                ChargerStatistiques();
                ChargerObjetsRecents();
            }
        }
        /// <summary>
        /// Charger les informations de l'utilisateur
        /// </summary>
        private void ChargerDonneesUtilisateur()
        {
            try
            {
                string prenom = Session["Prenom"] != null ? Session["Prenom"].ToString() : "";
                string nom = Session["Nom"] != null ? Session["Nom"].ToString() : "";

                lblNomUtilisateur.Text = $"{prenom} {nom}";
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine("Erreur ChargerDonneesUtilisateur: " + ex.Message);
                lblNomUtilisateur.Text = "Utilisateur";
            }
        }

        /// <summary>
        /// Charger les statistiques de l'utilisateur
        /// </summary>
        private void ChargerStatistiques()
        {
            try
            {
                if (Session["MembreId"] == null)
                {
                    lblObjetsPerdu.Text = "0";
                    lblObjetsTrouves.Text = "0";
                    lblObjetsRestitues.Text = "0";
                    lblCodesQR.Text = "0";
                    return;
                }

                int membreId = Convert.ToInt32(Session["MembreId"]);

                // Compter tous les objets de l'utilisateur
                SqlParameter[] paramsAll = new SqlParameter[]
                {
                    new SqlParameter("@Action", "SELECTMEMBRE"),
                    new SqlParameter("@MembreId", membreId)
                };
                DataTable dtAll = clsDB.ExecuterProcedure("sp_Objets", paramsAll);

                if (dtAll != null && dtAll.Rows.Count > 0)
                {
                    // Compter les objets perdus
                    int perdus = 0;
                    int trouves = 0;
                    int restitues = 0;

                    foreach (DataRow row in dtAll.Rows)
                    {
                        string typeDeclaration = row["TypeDeclaration"].ToString();
                        string statut = row["Statut"] != DBNull.Value ? row["Statut"].ToString() : "";

                        if (typeDeclaration == "Perdu")
                            perdus++;
                        else if (typeDeclaration == "Trouvé")
                            trouves++;

                        if (statut == "Restitué")
                            restitues++;
                    }

                    lblObjetsPerdu.Text = perdus.ToString();
                    lblObjetsTrouves.Text = trouves.ToString();
                    lblObjetsRestitues.Text = restitues.ToString();
                }
                else
                {
                    lblObjetsPerdu.Text = "0";
                    lblObjetsTrouves.Text = "0";
                    lblObjetsRestitues.Text = "0";
                }

                // Codes QR actifs (à implémenter plus tard avec la table CodesQR)
                lblCodesQR.Text = "0";
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine("Erreur ChargerStatistiques: " + ex.Message);
                lblObjetsPerdu.Text = "0";
                lblObjetsTrouves.Text = "0";
                lblObjetsRestitues.Text = "0";
                lblCodesQR.Text = "0";
            }
        }

        /// <summary>
        /// Charger les 5 objets les plus récents de l'utilisateur
        /// </summary>
        private void ChargerObjetsRecents()
        {
            try
            {
                if (Session["MembreId"] == null)
                {
                    rptObjetsRecents.DataSource = null;
                    rptObjetsRecents.DataBind();
                    return;
                }

                int membreId = Convert.ToInt32(Session["MembreId"]);

                SqlParameter[] parameters = new SqlParameter[]
                {
                    new SqlParameter("@Action", "SELECTMEMBRE"),
                    new SqlParameter("@MembreId", membreId)
                };

                DataTable dt = clsDB.ExecuterProcedure("sp_Objets", parameters);

                if (dt != null && dt.Rows.Count > 0)
                {
                    // Trier par date de création décroissante et prendre les 5 premiers
                    DataView dv = dt.DefaultView;
                    dv.Sort = "DateCreation DESC";
                    DataTable dtSorted = dv.ToTable();

                    // Prendre seulement les 5 plus récents
                    DataTable dtRecents = dtSorted.Clone();
                    int count = Math.Min(5, dtSorted.Rows.Count);
                    for (int i = 0; i < count; i++)
                    {
                        dtRecents.ImportRow(dtSorted.Rows[i]);
                    }

                    rptObjetsRecents.DataSource = dtRecents;
                    rptObjetsRecents.DataBind();
                }
                else
                {
                    rptObjetsRecents.DataSource = null;
                    rptObjetsRecents.DataBind();
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine("Erreur ChargerObjetsRecents: " + ex.Message);
                rptObjetsRecents.DataSource = null;
                rptObjetsRecents.DataBind();
            }
        }
        /// <summary>
        /// Déconnexion de l'utilisateur
        /// </summary>
        protected void btnDeconnexion_Click(object sender, EventArgs e)
        {
            try
            {
                // Effacer toutes les variables de session
                Session.Clear();
                Session.Abandon();

                // Rediriger vers la page d'accueil
                Response.Redirect("Default.aspx");
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine("Erreur btnDeconnexion_Click: " + ex.Message);
            }
        }
        /// <summary>
        /// Confirmer la suppression du compte
        /// </summary>
        protected void btnConfirmerSuppression_Click(object sender, EventArgs e)
        {
            try
            {
                if (Session["MembreId"] == null)
                {
                    Response.Redirect("connexionQrFinder.aspx");
                    return;
                }

                int membreId = Convert.ToInt32(Session["MembreId"]);

                // Supprimer le membre (soft delete)
                SqlParameter[] parameters = new SqlParameter[]
                {
                    new SqlParameter("@Action", "DELETE"),
                    new SqlParameter("@MembreId", membreId)
                };

                clsDB.ExecuterProcedure("sp_Membres", parameters);

                // Déconnecter l'utilisateur
                Session.Clear();
                Session.Abandon();

                // Rediriger vers la page d'accueil avec un message
                Response.Redirect("Default.aspx");
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine("Erreur btnConfirmerSuppression_Click: " + ex.Message);
                // Optionnel : afficher un message d'erreur
            }

        }
    }
}