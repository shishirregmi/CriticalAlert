using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Web;


namespace DAL.DAL
{
    public class Dao
    {
        private SqlConnection _connection;
        
        public Dao()
        {
            Init();
        }

        private void Init()
        {
            _connection = new SqlConnection(GetConnectionString());
        }

        private void OpenConnection()
        {
            if (_connection.State == ConnectionState.Open)
                _connection.Close();
            _connection.Open();
        }

        private void CloseConnection()
        {
            if (_connection.State == ConnectionState.Open)
                this._connection.Close();
        }

        private string GetConnectionString()
        {
            return ConfigurationManager.AppSettings["connectionString"].ToString();
        }

        private int GetCommandTimeOut()
        {
            int cto = 0;
            try
            {
                int.TryParse(ConfigurationManager.AppSettings["eto"].ToString(), out cto);

                if (cto == 0)
                    cto = 30;
            }
            catch (Exception)
            {
                cto = 30;
            }
            return cto;
        }

        public DataSet ExecuteDatasetV2(string sql)
        {
            var ds = new DataSet();
            var cmd = new SqlCommand(sql, _connection);
            cmd.CommandTimeout = GetCommandTimeOut();
            SqlDataAdapter da;
            try
            {
                OpenConnection();
                da = new SqlDataAdapter(cmd);
                da.Fill(ds);
                da.Dispose();
                CloseConnection();
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                da = null;
                cmd.Dispose();
                CloseConnection();
            }
            return ds;
        }

        public DataSet ExecuteDataset(string sql)
        {
            var ds = new DataSet();
            var cmd = new SqlCommand(sql, _connection);
            cmd.CommandTimeout = GetCommandTimeOut();
            SqlDataAdapter da;
            try
            {
                OpenConnection();
                da = new SqlDataAdapter(cmd);
                da.Fill(ds);
                da.Dispose();
                CloseConnection();
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                da = null;
                cmd.Dispose();
                CloseConnection();
            }
            return ds;
        }

        public DataTable ExecuteDataTable(string sql)
        {
            using (var ds = ExecuteDataset(sql))
            {
                if (ds == null || ds.Tables.Count == 0)
                    return null;

                return ds.Tables[0];
            }
        }

        public DataRow ExecuteDataRow(string sql)
        {
            using (var ds = ExecuteDataset(sql))
            {
                if (ds == null || ds.Tables.Count == 0)
                    return null;

                if (ds.Tables[0].Rows.Count == 0)
                    return null;

                return ds.Tables[0].Rows[0];
            }
        }

        public String GetSingleResult(string sql)
        {
            try
            {
                var ds = ExecuteDataset(sql);
                if (ds == null || ds.Tables.Count == 0 || ds.Tables[0].Rows.Count == 0)
                    return "";

                return ds.Tables[0].Rows[0][0].ToString();
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                CloseConnection();
            }
        }

        public string RemoveDecimal(double amt)
        {
            return Math.Floor(amt).ToString();
        }

        public String FilterStringNative(string strVal)
        {
            var str = FilterQuoteNative(strVal);

            if (str.ToLower() != "null")
                str = "'" + str + "'";

            return str;
        }

        public String FilterString(string strVal)
        {
            var str = FilterQuote(strVal);

            if (str.ToLower() != "null")
                str = "'" + str + "'";

            return str;
        }

        private string Encode(string strVal)
        {
            var sb = new StringBuilder(HttpUtility.HtmlEncode(HttpUtility.JavaScriptStringEncode(strVal)));
            // Selectively allow  <b> and <i>
            sb.Replace("&lt;b&gt;", "<b>");
            sb.Replace("&lt;/b&gt;", "");
            sb.Replace("&lt;i&gt;", "<i>");
            sb.Replace("&lt;/i&gt;", "");
            return sb.ToString();
        }

        public String FilterQuoteNative(string strVal)
        {
            if (string.IsNullOrEmpty(strVal))
            {
                strVal = "";
            }
            var str = Encode(strVal.Trim());

            if (!string.IsNullOrEmpty(str))
            {
                str = str.Replace(";", "");
                //str = str.Replace(",", "");
                str = str.Replace("--", "");
                str = str.Replace("'", "");

                str = str.Replace("/*", "");
                str = str.Replace("*/", "");

                str = str.Replace(" select ", "");
                str = str.Replace(" insert ", "");
                str = str.Replace(" update ", "");
                str = str.Replace(" delete ", "");

                str = str.Replace(" drop ", "");
                str = str.Replace(" truncate ", "");
                str = str.Replace(" create ", "");

                str = str.Replace(" begin ", "");
                str = str.Replace(" end ", "");
                str = str.Replace(" char(", "");

                str = str.Replace(" exec ", "");
                str = str.Replace(" xp_cmd ", "");

                str = str.Replace("<script", "");
            }
            else
            {
                str = "null";
            }
            return str;
        }

        public String FilterQuote(string strVal)
        {
            if (string.IsNullOrEmpty(strVal))
            {
                strVal = "";
            }

            var str = strVal.Trim();

            if (!string.IsNullOrEmpty(str))
            {
                str = str.Replace(";", "");
                //str = str.Replace(",", "");
                str = str.Replace("--", "");
                str = str.Replace("'", "");

                str = str.Replace("/*", "");
                str = str.Replace("*/", "");

                str = str.Replace(" select ", "");
                str = str.Replace(" insert ", "");
                str = str.Replace(" update ", "");
                str = str.Replace(" delete ", "");

                str = str.Replace(" drop ", "");
                str = str.Replace(" truncate ", "");
                str = str.Replace(" create ", "");

                str = str.Replace(" begin ", "");
                str = str.Replace(" end ", "");
                str = str.Replace(" char(", "");

                str = str.Replace(" exec ", "");
                str = str.Replace(" xp_cmd ", "");
                str = str.Replace("svg/onload", "");

                str = str.Replace("<script", "");
            }
            else
            {
                str = "null";
            }
            return str;
        }

        public DbResult ParseDbResult(DataTable dt)
        {
            var res = new DbResult();
            if (dt.Rows.Count > 0)
            {
                res.ErrorCode = dt.Rows[0][0].ToString();
                res.Msg = dt.Rows[0][1].ToString();
                res.Id = dt.Rows[0][2].ToString();
            }

            if (dt.Columns.Count > 3)
            {
                res.Extra = dt.Rows[0][3].ToString();
            }

            if (dt.Columns.Count > 4)
            {
                res.Extra2 = dt.Rows[0][4].ToString();
            }
            return res;
        }

        public DbResult ParseDbResult(string sql)
        {
            return ParseDbResult(ExecuteDataset(sql).Tables[0]);
        }

        public string AutoSelect(string str1, string str2)
        {
            if (str1.ToLower() == str2.ToLower())
                return "selected=\"selected\"";

            return "";
        }

        public DataTable getTable(string sql)
        {
            return ExecuteDataTable(sql);
        }

        public void ExecuteProcedure(string spName, SqlParameter[] param)
        {
            using (SqlConnection _connection = new SqlConnection(GetConnectionString()))
            {
                try
                {
                    _connection.Open();
                    SqlCommand command = new SqlCommand(spName, _connection);
                    command.CommandType = CommandType.StoredProcedure;

                    foreach (SqlParameter p in param)
                    {
                        command.Parameters.Add(p);
                    }
                    command.ExecuteNonQuery();
                }
                catch (Exception ex)
                {
                    throw ex;
                }
            }
        }

        public string DataTableToText(ref DataTable dt, string delemeter, Boolean includeColHeader)
        {
            var sb = new StringBuilder();
            var del = "";
            var rowcnt = 0;
            if (includeColHeader)
            {
                foreach (DataColumn col in dt.Columns)
                {
                    sb.Append(del);
                    sb.Append(col.ColumnName);
                    del = delemeter;
                }
                rowcnt++;
            }

            foreach (DataRow row in dt.Rows)
            {
                if (rowcnt > 0)
                {
                    sb.AppendLine();
                }
                del = "";
                foreach (DataColumn col in dt.Columns)
                {
                    sb.Append(del);
                    sb.Append((row[col.ColumnName].ToString().Replace(",", "")));
                    del = delemeter;
                }
                rowcnt++;
            }
            return sb.ToString();
        }

    }
}
