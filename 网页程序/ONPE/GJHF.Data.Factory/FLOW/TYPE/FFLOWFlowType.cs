using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Reflection;
using GJHF.Data.Model.FLOW.TYPE;
using GJHF.Data.Interface.FLOW.TYPE;

namespace GJHF.Data.Factory.FLOW.TYPE
{
    public class FFLOWFlowType
    {
        public static IFLOWFlowType Create()
        {
            return new GJHF.Data.MSSQL.FLOW.TYPE.DFLOWFlowType();
        }
    }
}
