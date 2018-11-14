using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace GJHF.Data.Factory.TSD
{
    public class FRequestUnit
    {
        public static Interface.TSD.IRequestUnit Create()
        {
            return new MSSQL.TSD.DRequestUnit();
        }
    }
}
