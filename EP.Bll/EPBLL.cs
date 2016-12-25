using System;
using System.Collections.Generic;
using System.Linq;
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
        public List<Employee> GetEmployee(Int64? empId = null)
        {
            return epObj.GetEmployee(empId);
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
    }
}
