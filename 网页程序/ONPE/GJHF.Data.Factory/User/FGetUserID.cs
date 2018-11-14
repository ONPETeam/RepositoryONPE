using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace GJHF.Data.Factory.User
{
    public class FGetUserID
    {
        public static Interface.User.IGetUserID Create()
        {
            return new MSSQL.User.DGetUserID();
        }
    }
}
