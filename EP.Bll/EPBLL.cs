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
    }
}
