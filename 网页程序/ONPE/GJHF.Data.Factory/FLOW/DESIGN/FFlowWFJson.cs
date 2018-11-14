using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace GJHF.Data.Factory.FLOW.DESIGN
{
    public class FFlowWFJson
    {
        public static GJHF.Data.Interface.FLOW.DESIGN.IFlowWFJson Create()
        {
            return new GJHF.Data.MSSQL.FLOW.DESIGN.DFlowWFJson();
        }
    }
}
