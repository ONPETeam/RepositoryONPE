using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace GJHF.Data.Factory.PUSH
{
    public class FPushVoiceNotify
    {
        public static GJHF.Data.Interface.PUSH.IPushVoiceNotify Create()
        {
            return new GJHF.Data.MSSQL.PUSH.DPushVoiceNotify();
        }
    }
}
