using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace GJHF.Data.Factory.HR
{
    public class FEmployee
    {
        public static Interface.HR.IEmployee Create()
        {
            return new MSSQL.HR.DEmployee();
        }
    }
}
