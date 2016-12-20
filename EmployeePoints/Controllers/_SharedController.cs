using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace EmployeePoints.Controllers
{
    public class _SharedController : Controller
    {
        //
        // GET: /_Shared/

        public ActionResult Index()
        {
            return View();
        }

    }
}
