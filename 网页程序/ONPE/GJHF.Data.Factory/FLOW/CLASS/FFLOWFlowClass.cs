using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Reflection;
using GJHF.Data.Model.FLOW.CLASS;
using GJHF.Data.Interface.FLOW.CLASS;

namespace GJHF.Data.Factory.FLOW.CLASS
{
    public class FFLOWFlowClass
    {
        public static IFLOWFlowClass Create()
        {
            return new GJHF.Data.MSSQL.FLOW.CLASS.DFLOWFlowClass();
        }
    }
}
