using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace GJHF.Data.Factory.HR
{
    public class FBranch
    {
        public static Interface.HR.IBranch Create()
        {
            return new MSSQL.HR.DBranch();
        }
    }
}
