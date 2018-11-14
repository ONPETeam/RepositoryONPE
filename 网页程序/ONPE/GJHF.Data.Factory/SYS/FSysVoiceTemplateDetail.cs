using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace GJHF.Data.Factory.SYS
{
    public class FSysVoiceTemplateDetail
    {
        public static GJHF.Data.Interface.SYS.ISysVoiceTemplateDetail Create()
        {
            return new GJHF.Data.MSSQL.SYS.DSysVoiceTemplateDetail();
        }
    }
}
