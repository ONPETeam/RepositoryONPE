using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace GJHF.Data.Factory.SYS
{
    public class FSysVoiceTemplate
    {
        public static GJHF.Data.Interface.SYS.ISysVoiceTemplate Create()
        {
            return new GJHF.Data.MSSQL.SYS.DSysVoiceTemplate();
        }
    }
}
