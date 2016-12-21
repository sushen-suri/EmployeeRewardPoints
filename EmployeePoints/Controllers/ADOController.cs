﻿using System;
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

        [HttpPost]
        public JsonResult SignIn(EmpSignin modal)
        {
            var message = "Enter Correct Details.";
            var messageType = "error";

            try
            {
                if (ModelState.IsValid)
                {
                    //ADOBLLWithQuery bll = new ADOBLLWithQuery();
                    EPBLL bll = new EPBLL();
                    var isSuccess = bll.SignIn(modal);
                    if (isSuccess.LoginId!=null)
                    {
                        message = "Employee added successfully";
                        messageType = "success";
                    }
                }
                else
                {
                    message = "All field(s) are mandatory.";
                }
            }
            catch (Exception)
            {
                message = "Exception occurred while performing operation.";
            }

            return Json(new { messageType = messageType, message = message }, JsonRequestBehavior.AllowGet);
        }

    }
}
