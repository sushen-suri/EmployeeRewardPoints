using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

using System.Web.Script.Serialization;
using EP.Bll;
using EP.Bo;

namespace EmployeePoints.Controllers
{
    public class ADOController : Controller
    {
        //
        // GET: /ADO/

        
        /// <summary>
        /// Login Comtroller
        /// </summary>
        /// <param name="modal"></param>
        /// <returns></returns>
        public JsonResult SignIn(EmpSignin modal)
        {
            var res = new LogId();
            var messageType = "error";
            var message = "Error occured while signing in.";

            try
            {
                if (ModelState.IsValid)
                {
                    //ADOBLLWithQuery bll = new ADOBLLWithQuery();
                    EPBLL bll = new EPBLL();
                    var isSuccess = bll.SignIn(modal);
                    //if (isSuccess.LoginId==new LogId())
                    //{
                    res = isSuccess;
                    messageType = "success";
                    message = "Signed in Successfully.";
                    //}
                }
                else
                {
                    res = new LogId();
                }
            }
            catch (Exception)
            {
                //message = "Exception occurred while performing operation.";
            }

            return Json(new { messageType = messageType, res = res, message = message }, JsonRequestBehavior.AllowGet);
        }

        /// <summary>
        /// Registration (SignUp)
        /// </summary>
        /// <param name="modal"></param>
        /// <returns></returns>
        public JsonResult Registration(Registration modal)
        {
            var res = false;
            var messageType = "error";
            var message = "Error occured while registering user.";

            try
            {
                if (ModelState.IsValid)
                {
                    //ADOBLLWithQuery bll = new ADOBLLWithQuery();
                    EPBLL bll = new EPBLL();
                    var isSuccess = bll.Registration(modal);
                    if (isSuccess)
                    {
                        res = isSuccess;
                        messageType = "success";
                        message = "Successfully registered.";
                    }
                }
            }
            catch (Exception)
            {
                message = "Exception occurred while performing operation.";
            }

            return Json(new { messageType = messageType, res = res, message = message }, JsonRequestBehavior.AllowGet);
        }

        /// <summary>
        /// to get List of Employees OR to get a perticular Employee nby LoginId
        /// </summary>
        /// <param name="empId"></param>
        /// <returns></returns>
        [HttpGet]
        public JsonResult GetEmployee(Int64? empId)
        {
            var res = new List<Employee>();
            var messageType = "error";
            var message = "Error occured while getting user.";

            try
            {
                if (ModelState.IsValid)
                {
                    EPBLL bll = new EPBLL();
                    var isSuccess = bll.GetEmployee(empId);
                    if (isSuccess.Count != 0)
                    {
                        res = isSuccess;
                        messageType = "success";
                        message = "Success.";
                    }
                }
            }
            catch (Exception)
            {
                message = "Exception occurred while performing operation.";
            }
            return Json(new { messageType = messageType, res = res, message = message }, JsonRequestBehavior.AllowGet);
        }

        /// <summary>
        /// Transfer Points 
        /// </summary>
        /// <param name="data"></param>
        /// <returns></returns>
        public JsonResult DonatePoints(TransferPoints data)
        {
            var res = false;
            var messageType = "error";
            var message = "Error occured.";

            try
            {
                if (ModelState.IsValid)
                {
                    //ADOBLLWithQuery bll = new ADOBLLWithQuery();
                    EPBLL bll = new EPBLL();
                    var isSuccess = bll.DonatePoints(data);
                    if (isSuccess)
                    {
                        res = isSuccess;
                        messageType = "success";
                        message = "Successfully Donated.";
                    }
                }
            }
            catch (Exception)
            {
                message = "Exception occurred while performing operation.";
            }

            return Json(new { messageType = messageType, res = res, message = message }, JsonRequestBehavior.AllowGet);
        }

        /// <summary>
        /// graph to total points earned
        /// </summary>
        /// <param name="Id"></param>
        /// <returns></returns>
        public JsonResult PointsGraph(EmpSignin Id)
        {
            var res = new List<GraphPoints>();
            var messageType = "error";
            var message = "Error occured while getting reward Points.";

            try
            {
                if (ModelState.IsValid)
                {
                    EPBLL bll = new EPBLL();
                    var isSuccess = bll.PointsGraph(Id);
                    if (isSuccess.Count != 0)
                    {
                        res = isSuccess;
                        messageType = "success";
                        message = "Reward Points.";
                    }
                }
            }
            catch (Exception)
            {
                message = "No Reward Points.";
            }
            return Json(new { messageType = messageType, res = res, message = message }, JsonRequestBehavior.AllowGet);
        }


        /// <summary>
        /// To Get Total points earned between specific Dates
        /// </summary>
        /// <param name="date"></param>
        /// <returns></returns>
        public JsonResult PointsBetweenDates(PointsBetween date)
        {
            var res = new Points();
            var messageType = "error";
            var message = "Error occured while getting reward Points.";

            try
            {
                if (ModelState.IsValid)
                {
                    EPBLL bll = new EPBLL();
                    var isSuccess = bll.PointsBetweenDates(date);
                    if (isSuccess != null)
                    {
                        res = isSuccess;
                        messageType = "success";
                        message = "Reward Points.";
                    }
                }
            }
            catch (Exception)
            {
                message = "No Reward Points.";
            }
            return Json(new { messageType = messageType, res = res, message = message }, JsonRequestBehavior.AllowGet);
      
        }


        /// <summary>
        /// Check Existing Email
        /// </summary>
        /// <param name="check"></param>
        /// <returns></returns>
        [HttpPost]
        public JsonResult CheckExistingEmail(EmpSignin check)
        {
            var res = false;
             var messageType = "Succes";
            var message = "Emailid Available.";

            try
            {
                if (ModelState.IsValid)
                {
                    EPBLL bll = new EPBLL();
                    var isSuccess =  bll.CheckExistingEmail(check);
                    if (isSuccess == true)
                    {
                        res = isSuccess;
                        messageType = "failure";
                        message = "Email Already Exist.";
                    }
                }
            }
            catch (Exception)
            {
                message = "Email Already Exist.";
            }
            return Json(new { messageType = messageType, res = res, message = message }, JsonRequestBehavior.AllowGet);
      
        }


        /// <summary>
        /// Check Existing Contact
        /// </summary>
        /// <param name="check"></param>
        /// <returns></returns>
        [HttpPost]
        public JsonResult CheckExistingContact(EmpSignin check)
        {
            var res = false;
             var messageType = "Succes";
             var message = "Contact Available.";

            try
            {
                if (ModelState.IsValid)
                {
                    EPBLL bll = new EPBLL();
                    var isSuccess = bll.CheckExistingContact(check);
                    if (isSuccess == true)
                    {
                        res = isSuccess;
                        messageType = "failure";
                        message = "Contact Already Exist.";
                    }
                }
            }
            catch (Exception)
            {
                message = "Contact Already Exist.";
            }
            return Json(new { messageType = messageType, res = res, message = message }, JsonRequestBehavior.AllowGet);
      
        }
            

        [HttpPost]
        public JsonResult CheckExistingEmployeeId(EmpSignin check)
        {
            var res = false;
             var messageType = "Succes";
             var message = "EmployeeId Available.";

            try
            {
                if (ModelState.IsValid)
                {
                    EPBLL bll = new EPBLL();
                    var isSuccess = bll.CheckExistingEmployeeId(check);
                    if (isSuccess == true)
                    {
                        res = isSuccess;
                        messageType = "failure";
                        message = "EmployeeId Already Exist.";
                    }
                }
            }
            catch (Exception)
            {
                message = "EmployeeId Already Exist.";
            }
            return Json(new { messageType = messageType, res = res, message = message }, JsonRequestBehavior.AllowGet);
      
        }
    }

    
}