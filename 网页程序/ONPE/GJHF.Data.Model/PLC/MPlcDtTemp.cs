using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace GJHF.Data.Model.PLC
{
    public class MPlcDtTemp
    {
        public int dIntDataID { get; set; }
        public string dVchFactoryCode { get; set; }
        public string dVchPLCCode { get; set; }
        public string dVchAdress { get; set; }
        public string dVchCjdz { get; set; }
        public string dVchValue { get; set; }
        public string dVchUnit { get; set; }
        public int dIntDqBz { get; set; }
        public string dVchFactoryName { get; set; }
        public string dVchRemark { get; set; }
        public string dFltSjMax { get; set; }
        public string dFltSjMin { get; set; }
        public string dFltBdMax { get; set; }
        public string dFltBdMin { get; set; }
        public string dVchSjValue { get; set; }
        public string dVchName { get; set; }

        public int dIntdizhiID { get; set; }
        public string equip_code { get; set; }
        public string equip_name { get; set; }
        public string dVchDescription { get; set; }
        public string dVchVariableType { get; set; }
        public string dDaeCurrentTime { get; set; }
        public int dIntBjState { get; set; }
        public int dIntJsBz { get; set; }
        public string dVchFormula { get; set; }
    }
}
