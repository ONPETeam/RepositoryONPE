using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace GJHF.Data.Factory.TSD
{
    public class FExamineUnit
    {
        public static Interface.TSD.IExamineUnit Create()
        {
            return new MSSQL.TSD.DExamineUnit();
        }
    }
}
