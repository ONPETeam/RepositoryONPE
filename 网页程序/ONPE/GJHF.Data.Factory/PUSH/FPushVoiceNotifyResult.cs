using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace GJHF.Data.Factory.PUSH
{
    public class FPushVoiceNotifyResult
    {
        public static GJHF.Data.Interface.PUSH.IPushVoiceNotifyResult Create()
        {
            return new GJHF.Data.MSSQL.PUSH.DPushVoiceNotifyResult();
        }
    }
}
