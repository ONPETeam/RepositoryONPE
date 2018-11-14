using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using GJHF.Data.Interface.HR;

namespace GJHF.Data.Factory.HR
{
    public class FHRCompany
    {
        public static IHRCompany Create()
        {
            return new GJHF.Data.MSSQL.HR.DHRCompany();
        }
    }
}
