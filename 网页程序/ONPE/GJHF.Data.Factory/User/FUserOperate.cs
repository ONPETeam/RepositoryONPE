using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace GJHF.Data.Factory.User
{
    public class FUserOperate
    {
        public static Interface.User.IUserOperate Create()
        {
            return new MSSQL.User.DUserOperate();
        }
    }
}
