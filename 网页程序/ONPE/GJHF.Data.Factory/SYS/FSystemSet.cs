using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace GJHF.Data.Factory.SYS
{
    public class FSystemSet
    {
        public static Interface.SYS.ISystemSet Create()
        {
            return new MSSQL.SYS.DSystemSet();
        }
    }
}
