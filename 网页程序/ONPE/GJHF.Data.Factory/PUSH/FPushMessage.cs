using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Reflection;
using GJHF.Data.Interface.PUSH;

namespace GJHF.Data.Factory.PUSH
{
    public class FPushMessage
    {
        public static IPushMessage Create()
        {
            string path = GJHF.Utility.Config.DAOClassPath;
            string DAOClassName = path + ".PUSH.DPushMessage";
            return new GJHF.Data.MSSQL.PUSH.DPushMessage();
            //return (IPushMessage)Assembly.Load(path).CreateInstance(DAOClassName);
        }
    }
}
