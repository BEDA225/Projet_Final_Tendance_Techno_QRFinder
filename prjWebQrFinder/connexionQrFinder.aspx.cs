using prjWebQrFinder.mesClasses;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace prjWebQrFinder
{
    public partial class connexionFinder : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // au demarrage de la page
            

            if (!IsPostBack) 
            {
                // mettre le focus sur le mail
                txtEmail.Focus();

                // Afficher le message de succès après inscription
                if (Session["MessageSucces"] != null)
                {
                    lblMsgErreur.Text = Session["MessageSucces"].ToString();
                    lblMsgErreur.CssClass = "badge bagde-texte-success";
                    Session.Remove("MessageSucces");
                }
            }
        }

        protected void btnConnecter_Click(object sender, EventArgs e)
        {
            try
            {
                // Récupérer les valeurs des champs
                string email = txtEmail.Text.Trim();
                string mdp = txtMotdepasse.Text.Trim();

                // Validation des champs
                if (string.IsNullOrEmpty(email) || string.IsNullOrEmpty(mdp))
                {
                    lblMsgErreur.Text = "Veuillez remplir tous les champs.";
                    lblMsgErreur.ForeColor = System.Drawing.Color.Red;
                    return;
                }

                // Connexion via la stored procedure
                clsMembres membre = clsMembres.Connecter(email, mdp);

                if (membre != null)
                {
                    // Sauvegarder dans Session
                    Session[clsGlobales.SESSION_MEMBRE_ID] = membre.MembreId;
                    Session[clsGlobales.SESSION_NOM_COMPLET] = membre.NomComplet;
                    Session[clsGlobales.SESSION_EMAIL] = membre.Email;
                    Session[clsGlobales.SESSION_ROLE_ID] = membre.RoleId;
                    Session[clsGlobales.SESSION_NOM_ROLE] = membre.NomRole;

                    // Pour compatibilité avec ton code existant
                    Session["Nom"] = membre.Nom;
                    Session["Prenom"] = membre.Prenom;
                    Session["RoleId"] = membre.RoleId;
                    Session["NomRole"] = membre.NomRole;

                    // Rediriger vers la page selon le rôle
                    if (membre.RoleId == clsGlobales.ROLE_ADMIN)
                    {
                        Response.Redirect("accueilAdmins.aspx");
                    }
                    else
                    {
                        Response.Redirect("accueilUtilisateursQrFinder.aspx");
                    }
                }
                else
                {
                    lblMsgErreur.Text = "Email ou mot de passe invalide.";
                    lblMsgErreur.CssClass = "text-danger";
                    txtMotdepasse.Text = ""; // Effacer le mot de passe
                    txtEmail.Focus();
                }
            }
            catch (Exception ex)
            {
                lblMsgErreur.Text = "Erreur de connexion : " + ex.Message;
                lblMsgErreur.ForeColor = System.Drawing.Color.Red;
            }
        }



    }
    
}