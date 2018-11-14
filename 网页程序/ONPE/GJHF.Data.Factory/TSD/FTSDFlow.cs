using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace GJHF.Data.Factory.TSD
{
    public class FTSDFlow
    {
        public static Interface.TSD.ITSDFlow Create()
        {
            return new MSSQL.TSD.DTSDFlow();
        }
    }
}
