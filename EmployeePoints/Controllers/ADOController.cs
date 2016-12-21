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

        //[HttpPost]
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

            return Json(new { messageType = messageType, res = res,message = message }, JsonRequestBehavior.AllowGet);
        }


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
        
    }
}
