using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace prjWebQrFinder.mesClasses
{
    public class clsGlobales
    {
        // Chaîne de connexion
        public static string ConnectionString
        {
            get
            {
                return ConfigurationManager.ConnectionStrings["MaConnexion"].ConnectionString;
            }
        }

        // Constantes de l'application
        public const string APP_NAME = "QRFinder";
        public const string APP_VERSION = "1.0.0";

        // Constantes pour les rôles
        public const int ROLE_ADMIN = 1;
        public const int ROLE_UTILISATEUR = 2;
        public const int ROLE_MODERATEUR = 3;

        // Constantes pour les types de déclaration
        public const string TYPE_PERDU = "Perdu";
        public const string TYPE_TROUVE = "Trouvé";

        // Constantes pour les statuts
        public const string STATUT_PERDU = "Perdu";
        public const string STATUT_TROUVE = "Trouvé";
        public const string STATUT_EN_POSSESSION = "En possession";
        public const string STATUT_RESTITUE = "Restitué";
        public const string STATUT_ARCHIVE = "Archivé";

        // Constantes pour les sessions
        public const string SESSION_MEMBRE_ID = "MembreId";
        public const string SESSION_NOM_COMPLET = "NomComplet";
        public const string SESSION_EMAIL = "Email";
        public const string SESSION_ROLE_ID = "RoleId";
        public const string SESSION_NOM_ROLE = "NomRole";

        /// <summary>
        /// Tester la connexion à la base de données
        /// </summary>
        public static bool TestConnection()
        {
            try
            {
                using (SqlConnection conn = new SqlConnection(ConnectionString))
                {
                    conn.Open();
                    return true;
                }
            }
            catch
            {
                return false;
            }
        }

        /// <summary>
        /// Obtenir les informations de connexion
        /// </summary>
        public static string GetConnectionInfo()
        {
            try
            {
                using (SqlConnection conn = new SqlConnection(ConnectionString))
                {
                    conn.Open();
                    return $"Serveur: {conn.DataSource} | BD: {conn.Database} | Version: {conn.ServerVersion}";
                }
            }
            catch (Exception ex)
            {
                return "Erreur: " + ex.Message;
            }
        }

        /// <summary>
        /// Générer un numéro de référence pour un objet
        /// </summary>
        public static string GenererNumeroReference()
        {
            return "OBJ-" + DateTime.Now.ToString("yyyyMMdd") + "-" + Guid.NewGuid().ToString().Substring(0, 5).ToUpper();
        }

        /// <summary>
        /// Générer un code QR
        /// </summary>
        public static string GenererCodeQR()
        {
            return "QR-" + DateTime.Now.ToString("yyyyMMdd") + "-" + Guid.NewGuid().ToString().Substring(0, 8).ToUpper();
        }

        /// <summary>
        /// Hasher un mot de passe (simple - à améliorer avec BCrypt ou similaire)
        /// </summary>
        public static string HashPassword(string password)
        {
            using (var sha256 = System.Security.Cryptography.SHA256.Create())
            {
                byte[] bytes = sha256.ComputeHash(System.Text.Encoding.UTF8.GetBytes(password));
                return Convert.ToBase64String(bytes);
            }
        }
    }
}
