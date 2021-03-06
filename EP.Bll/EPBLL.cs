﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.IO;
using System.Web;
using System.Text;
using System.Threading.Tasks;
using EP.Bo;
using EP.Dll;

namespace EP.Bll
{
    public class EPBLL
    {
        EPDLL epObj = new EPDLL();

        public LogId SignIn(EmpSignin modal)
        {
            return epObj.SignIn(modal);
        }

        public bool Registration(Registration modal)
        {
            return epObj.Registration(modal);
        }

        public List<Employee> Update(UpdateInfo Modal)
        {
            return epObj.Update(Modal);
        }

        public List<Employee> GetEmployee(SearchBy modal)
        {
            return epObj.GetEmployee(modal);
        }
        public bool DonatePoints(TransferPoints data)
        {
            return epObj.DonatePoints(data);
        }
        public List<GraphPoints> PointsGraph(EmpSignin Id)
        {
            return epObj.PointsGraph(Id);
        }
        public Points PointsBetweenDates(PointsBetween date)
        {
            return epObj.PointsBetweenDates(date);
        }
        public bool CheckExistingEmail(EmpSignin check)
        {
            return epObj.CheckExistingEmail(check);
        }
        public bool CheckExistingContact(EmpSignin check)
        {
            return epObj.CheckExistingContact(check);
        }
        public bool CheckExistingEmployeeId(EmpSignin check)
        {
            return epObj.CheckExistingEmployeeId(check);
        }
    }
}