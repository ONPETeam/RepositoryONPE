using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Reflection;
using GJHF.Data.Model.FLOW.DESIGN;
using GJHF.Data.Interface.FLOW.DESIGN;

namespace GJHF.Data.Factory.FLOW.DESIGN
{
    public class FFlowDesignFlow
    {
        public static IFlowDesignFlow Create()
        {
            return new GJHF.Data.MSSQL.FLOW.DESIGN.DFLOWDesignFlow();
        }
    }
}
