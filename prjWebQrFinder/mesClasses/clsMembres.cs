using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace prjWebQrFinder.mesClasses
{
    public class clsMembres
    {
        // Propriétés
        public int MembreId { get; set; }
        public string Nom { get; set; }
        public string Prenom { get; set; }
        public string Civilite { get; set; }
        public string Email { get; set; }
        public string Telephone { get; set; }
        public string Motdepasse { get; set; }
        public int RoleId { get; set; }
        public string NomRole { get; set; }
        public DateTime DateInscription { get; set; }

        // Constructeur vide
        public clsMembres() { }

        // Constructeur avec DataRow
        public clsMembres(DataRow row)
        {
            if (row != null)
            {
                MembreId = Convert.ToInt32(row["MembreId"]);
                Nom = row["Nom"].ToString();
                Prenom = row["Prenom"].ToString();
                Civilite = row["Civilite"].ToString();
                Email = row["Email"].ToString();
                Telephone = row["Telephone"].ToString();
                RoleId = Convert.ToInt32(row["RoleId"]);
                NomRole = row["NomRole"].ToString();
                DateInscription = Convert.ToDateTime(row["DateInscription"]);
            }
        }

        /// <summary>
        /// Inscrire un nouveau membre
        /// </summary>
        public int Inscrire()
        {
            try
            {
                // Hasher le mot de passe
                string passwordHash = clsGlobales.HashPassword(this.Motdepasse);

                SqlParameter[] parameters = new SqlParameter[]
                {
                    new SqlParameter("@Action", "INSERT"),
                    new SqlParameter("@Nom", this.Nom),
                    new SqlParameter("@Prenom", this.Prenom),
                    new SqlParameter("@Civilite", this.Civilite),
                    new SqlParameter("@Email", this.Email),
                    new SqlParameter("@Telephone", this.Telephone),
                    new SqlParameter("@Motdepasse", passwordHash),
                    new SqlParameter("@RoleId", this.RoleId)
                };

                DataTable dt = clsDB.ExecuterProcedure("sp_Membres", parameters);

                if (dt.Rows.Count > 0)
                {
                    this.MembreId = Convert.ToInt32(dt.Rows[0]["MembreId"]);
                    return this.MembreId;
                }

                return 0;
            }
            catch (Exception ex)
            {
                throw new Exception("Erreur lors de l'inscription: " + ex.Message);
            }
        }

        /// <summary>
        /// Connexion d'un membre
        /// </summary>
        public static clsMembres Connecter(string email, string motdepasse)
        {
            try
            {
                // Hasher le mot de passe
                string passwordHash = clsGlobales.HashPassword(motdepasse);

                SqlParameter[] parameters = new SqlParameter[]
                {
                    new SqlParameter("@Action", "LOGIN"),
                    new SqlParameter("@Email", email),
                    new SqlParameter("@Motdepasse", passwordHash)
                };

                DataTable dt = clsDB.ExecuterProcedure("sp_Membres", parameters);

                if (dt.Rows.Count > 0)
                {
                    return new clsMembres(dt.Rows[0]);
                }

                return null;
            }
            catch (Exception ex)
            {
                throw new Exception("Erreur lors de la connexion: " + ex.Message);
            }
        }

        /// <summary>
        /// Obtenir un membre par ID
        /// </summary>
        public static clsMembres ObtenirParId(int membreId)
        {
            try
            {
                SqlParameter[] parameters = new SqlParameter[]
                {
                    new SqlParameter("@Action", "SELECT"),
                    new SqlParameter("@MembreId", membreId)
                };

                DataTable dt = clsDB.ExecuterProcedure("sp_Membres", parameters);

                if (dt.Rows.Count > 0)
                {
                    return new clsMembres(dt.Rows[0]);
                }

                return null;
            }
            catch (Exception ex)
            {
                throw new Exception("Erreur lors de la récupération: " + ex.Message);
            }
        }

        /// <summary>
        /// Obtenir tous les membres
        /// </summary>
        public static DataTable ObtenirTous()
        {
            try
            {
                SqlParameter[] parameters = new SqlParameter[]
                {
                    new SqlParameter("@Action", "SELECTALL")
                };

                return clsDB.ExecuterProcedure("sp_Membres", parameters);
            }
            catch (Exception ex)
            {
                throw new Exception("Erreur lors de la récupération: " + ex.Message);
            }
        }

        /// <summary>
        /// Mettre à jour un membre
        /// </summary>
        public bool MettreAJour()
        {
            try
            {
                SqlParameter[] parameters = new SqlParameter[]
                {
                    new SqlParameter("@Action", "UPDATE"),
                    new SqlParameter("@MembreId", this.MembreId),
                    new SqlParameter("@Nom", this.Nom),
                    new SqlParameter("@Prenom", this.Prenom),
                    new SqlParameter("@Civilite", this.Civilite),
                    new SqlParameter("@Email", this.Email),
                    new SqlParameter("@Telephone", this.Telephone),
                    new SqlParameter("@RoleId", this.RoleId)
                };

                int rows = clsDB.ExecuterNonQuery("sp_Membres", parameters);
                return rows > 0;
            }
            catch (Exception ex)
            {
                throw new Exception("Erreur lors de la mise à jour: " + ex.Message);
            }
        }

        /// <summary>
        /// Supprimer un membre
        /// </summary>
        public bool Supprimer()
        {
            try
            {
                SqlParameter[] parameters = new SqlParameter[]
                {
                    new SqlParameter("@Action", "DELETE"),
                    new SqlParameter("@MembreId", this.MembreId)
                };

                int rows = clsDB.ExecuterNonQuery("sp_Membres", parameters);
                return rows > 0;
            }
            catch (Exception ex)
            {
                throw new Exception("Erreur lors de la suppression: " + ex.Message);
            }
        }

        /// <summary>
        /// Nom complet du membre
        /// </summary>
        public string NomComplet
        {
            get { return $"{Prenom} {Nom}"; }
        }
    }
}