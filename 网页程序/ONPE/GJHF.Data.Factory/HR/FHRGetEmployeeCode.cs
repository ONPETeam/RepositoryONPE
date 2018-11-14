using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Reflection;
using GJHF.Data.Interface.HR;

namespace GJHF.Data.Factory.HR
{
    public class FHRGetEmployeeCode
    {
        public static IHRGetEmployee Create()
        {
            return new GJHF.Data.MSSQL.HR.DHRGetEmployeeCode();
        }
    }
}
