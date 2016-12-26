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
        
        public bool Registration(Registration modal)
        {
            try
            {
                InitializeConnection();
                con.Open();
                using (SqlCommand cmd = new SqlCommand("spInsertEmployee", con))
                {
                    cmd.Parameters.AddWithValue("@EmployeeId", modal.EmployeeId);
                    cmd.Parameters.AddWithValue("@DesignationId", modal.DesignationId);
                    cmd.Parameters.AddWithValue("@EmployeeName", modal.EmployeeName);
                    cmd.Parameters.AddWithValue("@Email", modal.Email);
                    cmd.Parameters.AddWithValue("@Password", modal.Password);
                    cmd.Parameters.AddWithValue("@Contact", modal.Contact);
                    cmd.Parameters.AddWithValue("@ProfilePic", modal.ProfilePic);
                    cmd.Parameters.AddWithValue("@TotalEarnedPoints", 0);

                    cmd.CommandType = CommandType.StoredProcedure;

                    var affectedRows = cmd.ExecuteNonQuery();
                    if (affectedRows > 0)
                        return true;
                    else
                        return false;
                }
            }
            catch
            {
                return false;
            }
            finally
            {
                con.Close();
            }
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

        public List<Employee> GetEmployee(Int64? empId = null)
        {
            var employeeList = new List<Employee>();
            try
            {
                InitializeConnection();
                using (SqlCommand cmd = new SqlCommand("spGetEmployee", con))
                {
                    cmd.Parameters.AddWithValue("@LoginId", empId);

                    cmd.CommandType = CommandType.StoredProcedure;

                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    DataSet ds = new DataSet();
                    da.Fill(ds);

                    var dt = ds.Tables[0];

                    employeeList = dt.AsEnumerable().Select(a => new Employee
                    {
                        EmployeeName = Convert.ToString(a["EmployeeName"]),
                        Title = Convert.ToString(a["Title"]),
                        EmployeeId = Convert.ToInt64(a["EmployeeId"]),
                        ProfilePic = Convert.ToString(a["ProfilePic"]),
                        TotalEarnedPoints = Convert.ToInt64(a["TotalEarnedPoints"]),
                        LoginId = Convert.ToInt64(a["LoginId"]),
                        Email = Convert.ToString(a["Email"]),
                        Contact = Convert.ToString(a["Contact"]),
                        DateCreated = Convert.ToDateTime(a["DateCreated"])
                    }).ToList();
                }
                return employeeList;
            }
            catch (Exception)
            {
                return new List<Employee>();
            }
        }
        
        public bool DonatePoints(TransferPoints data)
        {
            try
            {
                InitializeConnection();
                con.Open();
                using (SqlCommand cmd = new SqlCommand("spTransferPoints", con))
                {
                    cmd.Parameters.AddWithValue("@FromLoginId", data.FromEmployeeId);
                    cmd.Parameters.AddWithValue("@ToEmployeeId", data.ToEmployeeId);
                    cmd.Parameters.AddWithValue("@Points", data.Points);
                    cmd.Parameters.AddWithValue("@Reason", data.Reason);
                    cmd.CommandType = CommandType.StoredProcedure;

                    cmd.ExecuteNonQuery();
                    return true;
                }
            }
            catch
            {
                return false;
            }
            finally
            {
                con.Close();
            }
        }

        public List<GraphPoints> PointsGraph(EmpSignin Id)
        {
            try
            {
                InitializeConnection();
                using (SqlCommand cmd = new SqlCommand("spPointsGraph", con))
                {
                    cmd.Parameters.AddWithValue("@ToEmployeeId", Id.EmployeeId);
                    cmd.CommandType = CommandType.StoredProcedure;

                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    DataSet ds = new DataSet();
                    da.Fill(ds);

                    var dt = ds.Tables[0];

                    return dt.AsEnumerable().Select(a => new GraphPoints
                    {
                        DateGiven = Convert.ToDateTime(a["DateGiven"]),
                        Points = Convert.ToInt64(a["TotalPoints"])
                    }).ToList();
                }
            }
            catch (Exception)
            {
                return new List<GraphPoints>();
            }
        }

        public Points PointsBetweenDates(PointsBetween date)
        {
            try
            {
                InitializeConnection();
                using (SqlCommand cmd = new SqlCommand("spPointsBetweenDates", con))
                {
                    cmd.Parameters.AddWithValue("@ToEmployeeId", date.EmployeeId);
                    cmd.Parameters.AddWithValue("@FromDate", date.FromDate);
                    cmd.Parameters.AddWithValue("@ToDate", date.ToDate);
                    cmd.CommandType = CommandType.StoredProcedure;

                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    DataSet ds = new DataSet();
                    da.Fill(ds);

                    var dt = ds.Tables[0];

                    return dt.AsEnumerable().Select(a => new Points
                    {
                        EarnedPoints = Convert.ToInt64(a["TotalPoints"])
                    }).FirstOrDefault();
                }
            }
            catch (Exception)
            {
                return new Points();
            }
        }

        public bool CheckExistingEmail(EmpSignin check)
        {
            try
            {
                InitializeConnection();
                con.Open();
                using (SqlCommand cmd = new SqlCommand("spCheckByEmail", con))
                {
                    cmd.CommandType = CommandType.StoredProcedure;

                    cmd.Parameters.AddWithValue("@Email", check.Email);

                    //Int32 count = Convert.ToInt32(cmd.ExecuteScalar());
                    object o = cmd.ExecuteScalar();
                    if (o != null)
                    {
                        return true;
                    }
                    else
                    {
                        return false;
                    }
                }
            }
            catch (Exception)
            {
                return false;
            }
            finally
            {
                con.Close();
            }
        }


        public bool CheckExistingContact(EmpSignin check)
        {
            try
            {
                InitializeConnection();
                con.Open();
                using (SqlCommand cmd = new SqlCommand("spCheckByContact", con))
                {
                    cmd.CommandType = CommandType.StoredProcedure;

                    cmd.Parameters.AddWithValue("@Contact", check.Contact);

                    //Int32 count = Convert.ToInt32(cmd.ExecuteScalar());
                    object o = cmd.ExecuteScalar();
                    if (o != null)
                    {
                        return true;
                    }
                    else
                    {
                        return false;
                    }
                }
            }
            catch (Exception)
            {
                return false;
            }
            finally
            {
                con.Close();
            }
        }



        public bool CheckExistingEmployeeId(EmpSignin check)
        {
            try
            {
                InitializeConnection();
                con.Open();
                using (SqlCommand cmd = new SqlCommand("spCheckByEmployeeId", con))
                {
                    cmd.CommandType = CommandType.StoredProcedure;

                    cmd.Parameters.AddWithValue("@EmployeeId", check.EmployeeId);

                    //Int32 count = Convert.ToInt32(cmd.ExecuteScalar());
                    object o = cmd.ExecuteScalar();
                    if (o != null)
                    {
                        return true;
                    }
                    else
                    {
                        return false;
                    }
                }
            }
            catch (Exception)
            {
                return false;
            }
            finally
            {
                con.Close();
            }
        }
    }
}