using prjWebQrFinder.mesClasses;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Services.Description;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace prjWebQrFinder
{
    public partial class DeclarerObjets : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack) 
            {
                ChargerCategories();
                InitialiserFormulaire();
            }
        }

        /// <summary>
        /// Initialise le formulaire de déclaration d'objet perdu.
        /// </summary>

        private void InitialiserFormulaire()
        {
            hfEtat.Value = "Perdu";
            hfQuand.Value = DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss");
            txtDatePrecise.Text = DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss");
        }

        /// <summary>
        /// Charge les catégories d'objets depuis la base de données.
        /// </summary>
        private void ChargerCategories()
        {
            try
            {
                SqlParameter[] parameters = new SqlParameter[]
                {
                    new SqlParameter("@Action", "SELECTACTIVE")
                };

                DataTable dt = clsDB.ExecuterProcedure("sp_Categories", parameters);

                rptCategories.DataSource = dt;
                rptCategories.DataBind();
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine("Erreur ChargerCategories: " + ex.Message);
                AfficherMessage(" Erreur lors du chargement des catégories.", "danger");
            }
        }
        /// <summary>
        /// Afficher un message à l'utilisateur
        /// </summary>
        private void AfficherMessage(string message, string type)
        {
            lblMessage.Text = message;
            pnlMessage.CssClass = $"alert alert-{type} mt-4";
            pnlMessage.Visible = true;

            // Scroll vers le message
            ScriptManager.RegisterStartupScript(this, GetType(), "scrollToMessage",
                "$('html, body').animate({ scrollTop: 0 }, 500);", true);
        
        }
        /// <summary>
        /// Gestion des boutons Couleur
        /// </summary>
        protected void btnCouleur_Click(object sender, EventArgs e)
        {
            Button btn = (Button)sender;

            // Extraire le nom de la couleur (après l'emoji)
            string[] parts = btn.Text.Split(' ');
            string couleur = parts.Length > 1 ? parts[1] : btn.Text;

            hfCouleur.Value = couleur;

            // Réinitialiser tous les boutons couleur
            btnNoir.CssClass = "btn-couleur";
            btnGris.CssClass = "btn-couleur";
            btnBlanc.CssClass = "btn-couleur";
            btnCreme.CssClass = "btn-couleur";
            btnRouge.CssClass = "btn-couleur";
            btnBleu.CssClass = "btn-couleur";
            btnVert.CssClass = "btn-couleur";
            btnJaune.CssClass = "btn-couleur";
            btnOrange.CssClass = "btn-couleur";
            btnRose.CssClass = "btn-couleur";
            btnMarron.CssClass = "btn-couleur";

            // Ajouter la classe selected au bouton cliqué
            btn.CssClass = "btn-couleur selected";
        }

        /// <summary>
        /// Gestion des boutons État (Perdu/Trouvé)
        /// </summary>
        protected void btnEtat_Click(object sender, EventArgs e)
        {
            Button btn = (Button)sender;
            hfEtat.Value = btn.Text; // "Perdu" ou "Trouvé"

            // Mettre à jour les classes CSS
            btnPerdu.CssClass = btn.ID == "btnPerdu" ? "btn-etat active" : "btn-etat";
            btnTrouve.CssClass = btn.ID == "btnTrouve" ? "btn-etat active" : "btn-etat";
        }

        /// <summary>
        /// Gestion des boutons Quand
        /// </summary>
        protected void btnQuand_Click(object sender, EventArgs e)
        {
            Button btn = (Button)sender;
            DateTime date = DateTime.Now;

            if (btn.Text == "Hier")
                date = DateTime.Now.AddDays(-1);
            else if (btn.Text == "Avant-hier")
                date = DateTime.Now.AddDays(-2);

            hfQuand.Value = date.ToString("yyyy-MM-dd HH:mm:ss");
            txtDatePrecise.Text = date.ToString("yyyy-MM-ddTHH:mm");
            // Mettre à jour les classes CSS
            btnAujourdhui.CssClass = btn.ID == "btnAujourdhui" ? "btn-quand active" : "btn-quand";
            btnHier.CssClass = btn.ID == "btnHier" ? "btn-quand active" : "btn-quand";
            btnAvantHier.CssClass = btn.ID == "btnAvantHier" ? "btn-quand active" : "btn-quand";
        }

        protected void rptCategories_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "SelectCategorie")
            {
                int categorieId = Convert.ToInt32(e.CommandArgument);
                hfCategorieSelectionnee.Value = categorieId.ToString();

                System.Diagnostics.Debug.WriteLine($"Catégorie sélectionnée : {categorieId}");

                ChargerSousCategories(categorieId);

                pnlSousCategories.Visible = true;

                ScriptManager.RegisterStartupScript(this, GetType(), "scrollToSousCategories",
                    "$('html, body').animate({ scrollTop: $('#" + pnlSousCategories.ClientID + "').offset().top - 100 }, 500);", true);
            }
        }
        /// <summary>
        /// Retour aux catégories
        /// </summary>
        protected void btnRetourCategories_Click(object sender, EventArgs e)
        {
            pnlSousCategories.Visible = false;
            pnlDetailsObjet.Visible = false;
            hfCategorieSelectionnee.Value = "";
            hfSousCategorieSelectionnee.Value = "";
        }
        /// <summary>
        /// Quand on sélectionne une sous-catégorie
        /// </summary>
        protected void rptSousCategories_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "SelectSousCategorie")
            {
                int sousCategorieId = Convert.ToInt32(e.CommandArgument);
                hfSousCategorieSelectionnee.Value = sousCategorieId.ToString();

                // Afficher le formulaire de détails
                pnlDetailsObjet.Visible = true;

                // Scroll vers les détails
                ScriptManager.RegisterStartupScript(this, GetType(), "scrollToDetails",
                    "$('html, body').animate({ scrollTop: $('#<%= pnlDetailsObjet.ClientID %>').offset().top - 100 }, 500);", true);
            }

        }
        /// <summary>
        /// PUBLIER L'OBJET - Insérer dans la BD
        /// </summary>
        protected void btnPublier_Click(object sender, EventArgs e)
        {
            try
            {
                // Validation
                if (string.IsNullOrEmpty(hfCategorieSelectionnee.Value))
                {
                    AfficherMessage("Veuillez sélectionner une catégorie.", "danger");
                    return;
                }

                if (string.IsNullOrEmpty(hfSousCategorieSelectionnee.Value))
                {
                    AfficherMessage(" Veuillez sélectionner un type d'objet.", "danger");
                    return;
                }

                if (string.IsNullOrEmpty(txtLieu.Text.Trim()))
                {
                    AfficherMessage("Veuillez indiquer le lieu.", "danger");
                    return;
                }

                // Upload de la photo
                string photoPath = null;
                if (filePhoto.HasFile)
                {
                    try
                    {
                        string extension = Path.GetExtension(filePhoto.FileName).ToLower();
                        string[] extensionsAutorisees = { ".jpg", ".jpeg", ".png", ".gif" };

                        if (Array.IndexOf(extensionsAutorisees, extension) == -1)
                        {
                            AfficherMessage(" Format d'image non autorisé. Utilisez JPG, PNG ou GIF.", "danger");
                            return;
                        }

                        // Créer un nom unique
                        string uniqueFileName = Guid.NewGuid().ToString() + extension;
                        string uploadPath = Server.MapPath("~/images/objets/");

                        // Créer le dossier s'il n'existe pas
                        if (!Directory.Exists(uploadPath))
                            Directory.CreateDirectory(uploadPath);

                        // Sauvegarder le fichier
                        filePhoto.SaveAs(uploadPath + uniqueFileName);
                        photoPath = "images/objets/" + uniqueFileName;
                    }
                    catch (Exception ex)
                    {
                        System.Diagnostics.Debug.WriteLine("Erreur upload photo: " + ex.Message);
                    }
                }

                // Récupérer l'ID du membre connecté
                int membreId = Convert.ToInt32(Session["MembreId"]);

                // Déterminer la couleur
                string couleur = !string.IsNullOrEmpty(hfCouleur.Value) ?
                    hfCouleur.Value :
                    txtAutreCouleur.Text.Trim();

                // Déterminer la date
                DateTime dateLocalisation = !string.IsNullOrEmpty(txtDatePrecise.Text) ?
                    Convert.ToDateTime(txtDatePrecise.Text) :
                    Convert.ToDateTime(hfQuand.Value);

                // Extraire la ville du lieu
                string ville = ExtraireVille(txtLieu.Text);

                // Insérer l'objet dans la BD
                SqlParameter[] parameters = new SqlParameter[]
                {
                    new SqlParameter("@Action", "INSERT"),
                    new SqlParameter("@MembreId", membreId),
                    new SqlParameter("@CategorieID", Convert.ToInt32(hfCategorieSelectionnee.Value)),
                    new SqlParameter("@SousCategorieID", Convert.ToInt32(hfSousCategorieSelectionnee.Value)),
                    new SqlParameter("@Titre", GetNomSousCategorie(Convert.ToInt32(hfSousCategorieSelectionnee.Value))),
                    new SqlParameter("@Description", txtDetail.Text.Trim()),
                    new SqlParameter("@Lieu", txtLieu.Text.Trim()),
                    new SqlParameter("@DateLocalisation", dateLocalisation),
                    new SqlParameter("@TypeDeclaration", hfEtat.Value),
                    new SqlParameter("@Statut", "Actif"),
                    new SqlParameter("@Couleur", (object)couleur ?? DBNull.Value),
                    new SqlParameter("@Marque", chkPasDeMarque.Checked ? "Sans marque" : txtMarque.Text.Trim()),
                    new SqlParameter("@Materiel", (object)txtMateriel.Text.Trim() ?? DBNull.Value),
                    new SqlParameter("@Modele", (object)txtModele.Text.Trim() ?? DBNull.Value),
                    new SqlParameter("@EtatObjet", (object)ddlEtatObjet.SelectedValue ?? DBNull.Value),
                    new SqlParameter("@QuestionAuthentification", (object)txtQuestionAuth.Text.Trim() ?? DBNull.Value),
                    new SqlParameter("@PhotoPrincipale", (object)photoPath ?? DBNull.Value),
                    new SqlParameter("@Ville", (object)ville ?? DBNull.Value)
                };

                DataTable result = clsDB.ExecuterProcedure("sp_Objets", parameters);

                // Message de succès
                AfficherMessage(" Votre annonce a été publiée avec succès !", "success");

                // Rediriger vers la page appropriée
                string pageRedirection = hfEtat.Value == "Trouvé" ? "Objetstrouves.aspx" : "Objetstrouves.aspx";
                ScriptManager.RegisterStartupScript(this, GetType(), "redirect",
                    $"setTimeout(function(){{ window.location.href='{pageRedirection}'; }}, 2000);", true);
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine("Erreur btnPublier_Click: " + ex.Message);
                AfficherMessage("Erreur lors de la publication : " + ex.Message, "danger");
            }
        }

        /// <summary>
        /// Charger les sous-catégories depuis la BD
        /// </summary>
        private void ChargerSousCategories(int categorieId)
        {
            try
            {
                SqlParameter[] parameters = new SqlParameter[]
                {
                    new SqlParameter("@Action", "SELECTBYCATEGORY"),
                    new SqlParameter("@CategorieID", categorieId)
                };

                DataTable dt = clsDB.ExecuterProcedure("sp_SousCategories", parameters);

                rptSousCategories.DataSource = dt;
                rptSousCategories.DataBind();
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine("Erreur ChargerSousCategories: " + ex.Message);
                AfficherMessage(" Erreur lors du chargement des sous-catégories.", "danger");
            }
        }

        /// <summary>
        /// Extraire la ville du lieu
        /// </summary>
        private string ExtraireVille(string lieu)
        {
            if (string.IsNullOrEmpty(lieu))
                return null;

            // Logique simple : prendre le dernier mot après une virgule
            string[] parties = lieu.Split(',');
            if (parties.Length > 0)
            {
                return parties[parties.Length - 1].Trim();
            }
            return lieu;
        }

        /// <summary>
        /// Récupérer le nom de la sous-catégorie
        /// </summary>
        private string GetNomSousCategorie(int sousCategorieId)
        {
            try
            {
                SqlParameter[] parameters = new SqlParameter[]
                {
                    new SqlParameter("@Action", "SELECT"),
                    new SqlParameter("@SousCategorieID", sousCategorieId)
                };

                DataTable dt = clsDB.ExecuterProcedure("sp_SousCategories", parameters);

                if (dt != null && dt.Rows.Count > 0)
                {
                    return dt.Rows[0]["NomSousCategorie"].ToString();
                }
                return "Objet";
            }
            catch
            {
                return "Objet";
            }
        }

    }
}