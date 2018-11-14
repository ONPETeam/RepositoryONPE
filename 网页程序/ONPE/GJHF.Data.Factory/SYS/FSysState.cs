using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace GJHF.Data.Factory.SYS
{
    public class FSysState
    {
        public static Interface.SYS.ISysState Create()
        {
            return new MSSQL.SYS.DSysState();
        }
    }
}
