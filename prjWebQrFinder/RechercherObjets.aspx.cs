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
    public partial class Objetstrouves : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                InitialiserFiltres();
                RemplirListeCategories();
                RemplirListeObjets();
                ChargerObjetsTrouves();
            }
        }

        /// <summary>
        /// Remplir la liste des catégories
        /// </summary>
        private void RemplirListeCategories()
        {
            try
            {
                cboCategorie.Items.Clear();
                cboCategorie.Items.Add(new ListItem("Catégories", "0"));

                SqlParameter[] parameters = new SqlParameter[]
                {
                    new SqlParameter("@Action", "SELECTACTIVE")
                };

                DataTable dt = clsDB.ExecuterProcedure("sp_Categories", parameters);

                foreach (DataRow row in dt.Rows)
                {
                    cboCategorie.Items.Add(new ListItem(
                        row["NomCategorie"].ToString(),
                        row["CategorieID"].ToString()
                    ));
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine("Erreur RemplirListeCategories: " + ex.Message);
            }
        }

        /// <summary>
        /// Remplir la liste des types d'objets
        /// </summary>
        private void RemplirListeObjets()
        {
            try
            {
                cboObjets.Items.Clear();
                cboObjets.Items.Add(new ListItem("Qu'est-ce que tu cherches?", "0"));
                cboObjets.Items.Add(new ListItem("Téléphone", "Téléphone"));
                cboObjets.Items.Add(new ListItem("Portefeuille", "Portefeuille"));
                cboObjets.Items.Add(new ListItem("Clés", "Clés"));
                cboObjets.Items.Add(new ListItem("Sac", "Sac"));
                cboObjets.Items.Add(new ListItem("Ordinateur", "Ordinateur"));
                cboObjets.Items.Add(new ListItem("Bijoux", "Bijoux"));
                cboObjets.Items.Add(new ListItem("Autre", "Autre"));
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine("Erreur RemplirListeObjets: " + ex.Message);
            }
        }

        /// <summary>
        /// Charger les objets trouvés depuis la base de données
        /// </summary>
        private void ChargerObjetsTrouves()
        {
            try
            {
                SqlParameter[] parameters = new SqlParameter[]
                {
                    new SqlParameter("@Action", "RECHERCHETROUVE")
                };

                DataTable dt = clsDB.ExecuterProcedure("sp_Objets", parameters);

                // Lier les données aux deux repeaters (grid et list)
                rptObjetsTrouvesGrid.DataSource = dt;
                rptObjetsTrouvesGrid.DataBind();

                rptObjetsTrouvesList.DataSource = dt;
                rptObjetsTrouvesList.DataBind();

                // Mettre à jour les labels de pagination
                int total = dt.Rows.Count;
                lblTotalObjets.Text = total.ToString();
                lblTotal.Text = total.ToString();
                lblDebut.Text = total > 0 ? "1" : "0";
                lblFin.Text = total > 20 ? "20" : total.ToString();
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine("Erreur ChargerObjetsTrouves: " + ex.Message);
            }
        }

        /// <summary>
        /// MÉTHODES POUR LES STATISTIQUES - Utilisées dans le HTML avec <%= %>
        /// </summary>
        protected string GetStatObjetsPerdus()
        {
            return GetStatistique("TotalPerdus");
        }

        protected string GetStatObjetsTrouves()
        {
            return GetStatistique("TotalTrouves");
        }

        protected string GetStatMembres()
        {
            return GetStatistique("TotalMembres");
        }

        /// <summary>
        /// Méthode centralisée pour obtenir les statistiques
        /// </summary>
        private string GetStatistique(string colonneNom)
        {
            try
            {
                SqlParameter[] parameters = new SqlParameter[]
                {
                    new SqlParameter("@Action", "GENERAL")
                };

                DataTable dt = clsDB.ExecuterProcedure("sp_Statistiques", parameters);

                if (dt != null && dt.Rows.Count > 0)
                {
                    return dt.Rows[0][colonneNom].ToString();
                }
                return "0";
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"Erreur GetStatistique ({colonneNom}): " + ex.Message);
                return "0";
            }
        }

        /// <summary>
        /// Événement du bouton Rechercher
        /// </summary>
        protected void btnChercher_Click(object sender, EventArgs e)
        {
            try
            {
                // Récupérer les filtres
                int? categorieId = null;
                if (cboCategorie.SelectedValue != "0")
                {
                    categorieId = Convert.ToInt32(cboCategorie.SelectedValue);
                }

                string motCle = null;
                if (cboObjets.SelectedValue != "0")
                {
                    motCle = cboObjets.SelectedValue;
                }

                // Rechercher avec les filtres
                SqlParameter[] parameters = new SqlParameter[]
                {
                    new SqlParameter("@Action", "RECHERCHETROUVE"),
                    new SqlParameter("@CategorieID", (object)categorieId ?? DBNull.Value),
                    new SqlParameter("@MotCle", (object)motCle ?? DBNull.Value)
                };

                DataTable dt = clsDB.ExecuterProcedure("sp_Objets", parameters);

                // Lier les résultats filtrés
                rptObjetsTrouvesGrid.DataSource = dt;
                rptObjetsTrouvesGrid.DataBind();

                rptObjetsTrouvesList.DataSource = dt;
                rptObjetsTrouvesList.DataBind();

                // Mettre à jour les compteurs
                int total = dt.Rows.Count;
                lblTotalObjets.Text = total.ToString();
                lblTotal.Text = total.ToString();
                lblDebut.Text = total > 0 ? "1" : "0";
                lblFin.Text = total > 20 ? "20" : total.ToString();
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine("Erreur btnChercher_Click: " + ex.Message);
                // Optionnel: Afficher un message d'erreur à l'utilisateur
                // lblMessage.Text = "Erreur lors de la recherche: " + ex.Message;
            }
        }

        private void InitialiserFiltres()
        {
            try
            {
                // Remplir les catégories
                cboCategorieFiltre.Items.Clear();
                cboCategorieFiltre.Items.Add(new ListItem("Toutes les catégories", ""));

                SqlParameter[] parameters = new SqlParameter[]
                {
            new SqlParameter("@Action", "SELECTACTIVE")
                };

                DataTable dt = clsDB.ExecuterProcedure("sp_Categories", parameters);

                foreach (DataRow row in dt.Rows)
                {
                    cboCategorieFiltre.Items.Add(new ListItem(
                        row["NomCategorie"].ToString(),
                        row["CategorieID"].ToString()
                    ));
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine("Erreur InitialiserFiltres: " + ex.Message);
            }
        }
        /// <summary>
        /// Réinitialiser tous les filtres du modal
        /// </summary>
        protected void btnReinitialiser_Click(object sender, EventArgs e)
        {
            try
            {
                // Vider tous les champs du modal
                txtMotCle.Text = "";
                cboCategorieFiltre.SelectedIndex = 0;
                cboVilleFiltre.SelectedIndex = 0;
                cboCouleurFiltre.SelectedIndex = 0;
                txtMarqueFiltre.Text = "";
                txtDateDebut.Text = "";
                txtDateFin.Text = "";
                CboStatutFiltre.SelectedIndex = 0;

                // Réinitialiser aussi les filtres du banner
                cboCategorie.SelectedIndex = 0;
                cboObjets.SelectedIndex = 0;

                // Recharger tous les objets
                ChargerObjetsTrouves();

                // Fermer le modal
                ScriptManager.RegisterStartupScript(this, GetType(), "closeModal",
                    "$('#filterPopUp').modal('hide');", true);
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine("Erreur btnReinitialiser_Click: " + ex.Message);
            }
        
        }

        /// <summary>
        /// Appliquer les filtres
        /// </summary>
        protected void btnAppliquerFiltre_Click(object sender, EventArgs e)
        {
            try
            {
                // Récupérer les valeurs des filtres
                int? categorieId = string.IsNullOrEmpty(cboCategorieFiltre.SelectedValue) ?
                    (int?)null : Convert.ToInt32(cboCategorieFiltre.SelectedValue);

                string motCle = string.IsNullOrEmpty(txtMotCle.Text.Trim()) ? null : txtMotCle.Text.Trim();
                string ville = string.IsNullOrEmpty(cboVilleFiltre.SelectedValue) ? null : cboVilleFiltre.SelectedValue;
                string couleur = string.IsNullOrEmpty(cboCouleurFiltre.SelectedValue) ? null : cboCouleurFiltre.SelectedValue;
                string marque = string.IsNullOrEmpty(txtMarqueFiltre.Text.Trim()) ? null : txtMarqueFiltre.Text.Trim();

                DateTime? dateDebut = string.IsNullOrEmpty(txtDateDebut.Text) ? (DateTime?)null : Convert.ToDateTime(txtDateDebut.Text);
                DateTime? dateFin = string.IsNullOrEmpty(txtDateFin.Text) ? (DateTime?)null : Convert.ToDateTime(txtDateFin.Text);

                // Construire la requête avec tous les filtres
                SqlParameter[] parameters = new SqlParameter[]
                {
                    new SqlParameter("@Action", "RECHERCHETROUVE"),
                    new SqlParameter("@CategorieID", (object)categorieId ?? DBNull.Value),
                    new SqlParameter("@MotCle", (object)motCle ?? DBNull.Value),
                    new SqlParameter("@Ville", (object)ville ?? DBNull.Value),
                    new SqlParameter("@DateDebut", (object)dateDebut ?? DBNull.Value),
                    new SqlParameter("@DateFin", (object)dateFin ?? DBNull.Value)
                };

                DataTable dt = clsDB.ExecuterProcedure("sp_Objets", parameters);

                // Filtrer par couleur et marque en mémoire si nécessaire
                if (!string.IsNullOrEmpty(couleur))
                {
                    dt = dt.AsEnumerable()
                        .Where(row => row.Field<string>("Couleur") != null &&
                                      row.Field<string>("Couleur").IndexOf(couleur, StringComparison.OrdinalIgnoreCase) >= 0)
                        .CopyToDataTable();
                }

                if (!string.IsNullOrEmpty(marque))
                {
                    dt = dt.AsEnumerable()
                        .Where(row => row.Field<string>("Marque") != null &&
                                      row.Field<string>("Marque").IndexOf(marque, StringComparison.OrdinalIgnoreCase) >= 0)
                        .CopyToDataTable();
                }

                // Lier les résultats
                rptObjetsTrouvesGrid.DataSource = dt;
                rptObjetsTrouvesGrid.DataBind();

                rptObjetsTrouvesList.DataSource = dt;
                rptObjetsTrouvesList.DataBind();

                // Mettre à jour les compteurs
                int total = dt.Rows.Count;
                lblTotalObjets.Text = total.ToString();
                lblTotal.Text = total.ToString();
                lblDebut.Text = total > 0 ? "1" : "0";
                lblFin.Text = total > 20 ? "20" : total.ToString();

                // Fermer le modal avec JavaScript
                ScriptManager.RegisterStartupScript(this, GetType(), "closeModal",
                    "$('#filterPopUp').modal('hide');", true);
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine("Erreur btnAppliquerFiltre_Click: " + ex.Message);
            }
        }
    }
}