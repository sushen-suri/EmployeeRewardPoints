﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace EP.Bo
{
    public class EmpSignin
    {
        public Int64 EmployeeId { get; set; }
        public string Password { get; set; }
    }

    public class LogId
    {
        public Int64 LoginId { get; set; }
    }

    public class Registration
    {
        public long EmployeeId { get; set; }
        public string Email { get; set; }
        public string Password { get; set; }
        public string Contact { get; set; }

        public string EmployeeName { get; set; }
        public int DesignationId { get; set; }
        public string ProfilePic { get; set; }
    }
}
