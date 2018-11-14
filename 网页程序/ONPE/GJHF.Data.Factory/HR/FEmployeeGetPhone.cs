using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace GJHF.Data.Factory.HR
{
    public class FEmployeeGetPhone
    {
        public static GJHF.Data.Interface.HR.IEmployeeGetPhone Create()
        {
            return new GJHF.Data.MSSQL.HR.DEmployeeGetPhone();
        }
    }
}
