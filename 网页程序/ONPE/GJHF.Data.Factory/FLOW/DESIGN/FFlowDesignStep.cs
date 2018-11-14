using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using GJHF.Data.Interface.FLOW.DESIGN;

namespace GJHF.Data.Factory.FLOW.DESIGN
{
   public class FFlowDesignStep
    {
       public static IFlowDesignStep Create()
       {
           return new GJHF.Data.MSSQL.FLOW.DESIGN.DFlowDesignStep();
       }
    }
}
