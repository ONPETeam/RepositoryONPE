using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Reflection;
using GJHF.Data.Interface.PUSH;

namespace GJHF.Data.Factory.PUSH
{
    public class FPushResult
    {
        public static IPushResult Create()
        {
            return new GJHF.Data.MSSQL.PUSH.DPushResult();
        }
    }
}
