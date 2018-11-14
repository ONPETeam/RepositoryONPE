using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Reflection;
using GJHF.Data.Interface.PUSH;

namespace GJHF.Data.Factory.PUSH
{
    public class FPushTarget
    {
        public static IPushTarget Create()
        {
            return new GJHF.Data.MSSQL.PUSH.DPushTarget();
        }
    }
}
