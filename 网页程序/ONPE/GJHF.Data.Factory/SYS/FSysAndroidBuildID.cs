using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace GJHF.Data.Factory.SYS
{
    public class FSysAndroidBuildID
    {
        public static GJHF.Data.Interface.SYS.ISysAndroidBuildID Create()
        {
            return new GJHF.Data.MSSQL.SYS.DSysAndroidBuildID();
        }
    }
}
