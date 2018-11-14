using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Reflection;
using GJHF.Utility;
using GJHF.Data.Interface.FLOW.DESIGN;

namespace GJHF.Data.Factory.FLOW.DESIGN
{
    public    class FFlowDesignLine
    {
        public static IFlowDesignLine Create()
        {
            return new GJHF.Data.MSSQL.FLOW.DESIGN.DFLOWDesignLine();
        }
    }
}
