using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Reflection;
using GJHF.Data.Model.FLOW.DB;
using GJHF.Data.Interface.FLOW.DB;

namespace GJHF.Data.Factory.FLOW.DB
{
    public class FFLOWValueType
    {
        public static IFLOWValueType Create()
        {
            return new GJHF.Data.MSSQL.FLOW.DB.DFLOWValueType();
        }
    }
}
