﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace EmployeePoints.Controllers
{
    public class PublicController : Controller
    {
        //
        // GET: /Public/

        public ActionResult Signin()
        {
            return View();
        }
        
        public ActionResult Registration()
        {
            return View();
        }

    }
}
