using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
//using EP.Modal;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using EP.Bo;

namespace EP.Dll
{
    public class EPDLL
    {
        public SqlConnection con;
        /// <summary>
        /// For connection initialization
        /// </summary>
        public void InitializeConnection()
        {
            var connectionString = ConfigurationManager.ConnectionStrings["AdoConnection"].ToString();
            con = new SqlConnection(connectionString);
        }


        public LogId SignIn(EmpSignin SigninData)
        {
            //var employeesList = new List<EmployeeList>();
            try
            {
                InitializeConnection();
                using (SqlCommand cmd = new SqlCommand("spSignin", con))
                {
                    cmd.Parameters.AddWithValue("@EmployeeId", SigninData.EmployeeId);
                    cmd.Parameters.AddWithValue("@Password", SigninData.Password);
                    cmd.CommandType = CommandType.StoredProcedure;

                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    DataSet ds = new DataSet();
                    da.Fill(ds);

                    var dt = ds.Tables[0];

                    return dt.AsEnumerable().Select(a => new LogId
                    {
                        LoginId = Convert.ToInt64(a["LoginId"])
                    }).FirstOrDefault();
                }
            }
            catch (Exception)
            {
                return new LogId();
            }
        }

    }
}
