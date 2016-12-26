using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace EmployeePoints.Controllers
{
    public class PrivateController : Controller
    {
        //
        // GET: /Private/
        public ActionResult DashBoard()
        {
            return View();
        }

        public ActionResult Index()
        {
            return View();
        }

        public ActionResult Logout()
        {
            return View();
        }
        public ActionResult DonatePoints()
        {
            return View();
        }
    }
}
