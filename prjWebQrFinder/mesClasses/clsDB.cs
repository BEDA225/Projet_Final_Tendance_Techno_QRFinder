using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace prjWebQrFinder.mesClasses
{
    public class clsDB
    {
        /// <summary>
        /// Exécuter une stored procedure et retourner un DataTable
        /// </summary>
        public static DataTable ExecuterProcedure(string procedureName, params SqlParameter[] parameters)
        {
            DataTable dt = new DataTable();

            try
            {
                using (SqlConnection conn = new SqlConnection(clsGlobales.ConnectionString))
                {
                    using (SqlCommand cmd = new SqlCommand(procedureName, conn))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;

                        if (parameters != null)
                        {
                            cmd.Parameters.AddRange(parameters);
                        }

                        using (SqlDataAdapter adapter = new SqlDataAdapter(cmd))
                        {
                            adapter.Fill(dt);
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                throw new Exception($"Erreur lors de l'exécution de {procedureName}: {ex.Message}");
            }

            return dt;
        }

        /// <summary>
        /// Exécuter une stored procedure sans retour de données
        /// </summary>
        public static int ExecuterNonQuery(string procedureName, params SqlParameter[] parameters)
        {
            int rowsAffected = 0;

            try
            {
                using (SqlConnection conn = new SqlConnection(clsGlobales.ConnectionString))
                {
                    using (SqlCommand cmd = new SqlCommand(procedureName, conn))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;

                        if (parameters != null)
                        {
                            cmd.Parameters.AddRange(parameters);
                        }

                        conn.Open();
                        rowsAffected = cmd.ExecuteNonQuery();
                    }
                }
            }
            catch (Exception ex)
            {
                throw new Exception($"Erreur lors de l'exécution de {procedureName}: {ex.Message}");
            }

            return rowsAffected;
        }

        /// <summary>
        /// Exécuter une stored procedure et retourner une valeur scalaire
        /// </summary>
        public static object ExecuterScalar(string procedureName, params SqlParameter[] parameters)
        {
            object result = null;

            try
            {
                using (SqlConnection conn = new SqlConnection(clsGlobales.ConnectionString))
                {
                    using (SqlCommand cmd = new SqlCommand(procedureName, conn))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;

                        if (parameters != null)
                        {
                            cmd.Parameters.AddRange(parameters);
                        }

                        conn.Open();
                        result = cmd.ExecuteScalar();
                    }
                }
            }
            catch (Exception ex)
            {
                throw new Exception($"Erreur lors de l'exécution de {procedureName}: {ex.Message}");
            }

            return result;
        }
    }
}