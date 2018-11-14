using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace GJHF.Data.Factory.User
{
    public class FUser
    {
        public static Interface.User.IUser Create()
        {
            return new MSSQL.User.DUser();
        }
    }
}
