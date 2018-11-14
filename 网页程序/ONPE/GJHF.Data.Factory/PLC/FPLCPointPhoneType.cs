using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace GJHF.Data.Factory.PLC
{
    public class FPLCPointPhoneType
    {
        public static GJHF.Data.Interface.PLC.IPLCPointPhoneType Create()
        {
            return new GJHF.Data.MSSQL.PLC.DPLCPointPhoneType();
        }
    }
}
