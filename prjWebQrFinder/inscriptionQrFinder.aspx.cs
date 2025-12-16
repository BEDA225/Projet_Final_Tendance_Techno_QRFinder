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
    public partial class inscriptionQrFinder : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                cboRole.Focus();

                RemplirListeRole();
                RemplirListeCivilite();
            }
        }

        /// <summary>
        /// Remplir la liste des civilités
        /// </summary>
        private void RemplirListeCivilite()
        {
            cboCivilite.Items.Clear();
            cboCivilite.Items.Add(new ListItem("-- Sélectionner --", "0"));
            cboCivilite.Items.Add(new ListItem("Madame", "Mme"));
            cboCivilite.Items.Add(new ListItem("Monsieur", "M."));
            cboCivilite.SelectedIndex = 0;
        }

        /// <summary>
        /// Remplir la liste des rôles via stored procedure
        /// </summary>
        private void RemplirListeRole()
        {
            try
            {
                cboRole.Items.Clear();
                cboRole.Items.Add(new ListItem("-- Sélectionner --", "0"));

                // Appeler la stored procedure sp_Roles avec action SELECTALL
                SqlParameter[] parameters = new SqlParameter[]
                {
                    new SqlParameter("@Action", "SELECTALL")
                };

                DataTable dt = clsDB.ExecuterProcedure("sp_Roles", parameters);

                foreach (DataRow row in dt.Rows)
                {
                    ListItem item = new ListItem();
                    item.Text = row["NomRole"].ToString();
                    item.Value = row["RoleId"].ToString();
                    cboRole.Items.Add(item);
                }

                cboRole.SelectedIndex = 0;
            }
            catch (Exception ex)
            {
                lblMsg.Text = "Erreur lors du chargement des rôles : " + ex.Message;
                lblMsg.CssClass = "text-danger";
            }
        }

        /// <summary>
        /// Bouton Inscrire
        /// </summary>
        protected void btnInscrire_Click(object sender, EventArgs e)
        {
            try
            {
                // Vérifier les conditions d'utilisation
                if (!chkConditions.Checked)
                {
                    lblMsg.Text = "Vous devez accepter les conditions d'utilisation.";
                    lblMsg.CssClass = "text-danger";
                    return;
                }

                // Validation de la civilité
                if (cboCivilite.SelectedValue == "0")
                {
                    lblMsg.Text = "Veuillez sélectionner votre civilité.";
                    lblMsg.CssClass = "text-danger";
                    cboCivilite.Focus();
                    return;
                }

                // Validation du rôle
                if (cboRole.SelectedValue == "0")
                {
                    lblMsg.Text = "Veuillez sélectionner votre rôle.";
                    lblMsg.CssClass = "text-danger";
                    cboRole.Focus();
                    return;
                }

                // Récupérer les valeurs saisies
                string nom = txtNom.Text.Trim();
                string prenom = txtPrenom.Text.Trim();
                string email = txtEmail.Text.Trim();
                string civilite = cboCivilite.SelectedValue; 
                string tel = txtTel.Text.Trim();
                string mdp = txtMotdepasse.Text.Trim();
                int roleId = Convert.ToInt32(cboRole.SelectedValue);
                string nomRole = cboRole.SelectedItem.Text;

                // Validation des champs
                if (string.IsNullOrEmpty(nom) || string.IsNullOrEmpty(prenom) ||
                    string.IsNullOrEmpty(email) || string.IsNullOrEmpty(mdp))
                {
                    lblMsg.Text = "Tous les champs obligatoires doivent être remplis.";
                    lblMsg.ForeColor = System.Drawing.Color.Red;
                    return;
                }

                // Créer un objet membre
                clsMembres nouveauMembre = new clsMembres
                {
                    Nom = nom,
                    Prenom = prenom,
                    Civilite = civilite,
                    Email = email,
                    Telephone = tel,
                    Motdepasse = mdp,
                    RoleId = roleId
                };

                // Inscrire le membre via stored procedure
                int membreId = nouveauMembre.Inscrire();

                if (membreId > 0)
                {
                    // Inscription réussie - Stocker en session
                    Session["Prenom"] = prenom;
                    Session["Nom"] = nom;
                    Session["Civilite"] = civilite;
                    Session["Telephone"] = tel;
                    Session["Email"] = email;
                    Session["Role"] = nomRole;
                    Session["Partenaires"] = chkPartenaires.Checked ? "Oui" : "Non";

                    // Message de succès (optionnel)
                    Session["MessageSucces"] = "Inscription réussie ! Vous pouvez maintenant vous connecter.";

                    // Rediriger vers la page de connexion
                    Response.Redirect("connexionQrFinder.aspx");
                }
                else
                {
                    lblMsg.Text = "Une erreur est survenue lors de l'inscription.";
                    lblMsg.ForeColor = System.Drawing.Color.Red;
                }
            }
            catch (SqlException sqlEx)
            {
                // Gestion des erreurs SQL spécifiques
                if (sqlEx.Message.Contains("email est déjà utilisé"))
                {
                    lblMsg.Text = "Désolé, cet email est déjà utilisé par un autre utilisateur.";
                }
                else
                {
                    lblMsg.Text = "Erreur de base de données : " + sqlEx.Message;
                }
                lblMsg.ForeColor = System.Drawing.Color.Red;
            }
            catch (Exception ex)
            {
                lblMsg.Text = "Erreur lors de l'inscription : " + ex.Message;
                lblMsg.ForeColor = System.Drawing.Color.Red;
            }
        }

        protected void cboCivilite_SelectedIndexChanged(object sender, EventArgs e)
        {

        }

        protected void cboRole_SelectedIndexChanged(object sender, EventArgs e)
        {

        }

        protected void chkPartenaires_CheckedChanged(object sender, EventArgs e)
        {

        }

        protected void chkConditions_CheckedChanged(object sender, EventArgs e)
        {

        }
    }
}