using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using GJHF.Data.Interface.FLOW.VERSION;
using GJHF.Data.MSSQL.FLOW.VERSION;

namespace GJHF.Data.Factory.FLOW.VERSION
{
    public class  FFlowVersion
    {
        public static IFlowVersion Create()
        {
            return new GJHF.Data.MSSQL.FLOW.VERSION.DFlowVersion();
        }
    }
}
