using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace GJHF.Data.Factory.SYS
{
    public class FSysIOSSound
    {
        public static GJHF.Data.Interface.SYS.ISysIOSSound Create()
        {
            return new GJHF.Data.MSSQL.SYS.DSysIOSSound();
        }
    }
}
