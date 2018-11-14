using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace GJHF.Data.Model.PLC
{
    public class MPlcManager
    {
        public int dIntPLCID { get; set; }
        public string dVchPLCName { get; set; }
        public string dVchIPAdress { get; set; }
        public int dIntPLCPinPaiID { get; set; }
        public int dIntGongYiXitongID { get; set; }
        public string dVchRemark { get; set; }
        public string dVchPLCXitongName { get; set; }
        public string dVchPLCPinPaiName { get; set; }
        public string dVchPLCbianma { get; set; }
        public string dVchFactoryCode { get; set; }
        public string dVchState { get; set; }
        public string dVchPointType { get; set; }
        public string dVchArea { get; set; }
    }
    public class MPlcManage_Combox
    {
        public string dVchPLCbianma { get; set; }
        public string dVchPLCName { get; set; }
        public string dVchIPAdress { get; set; }
        public string dVchRemark { get; set; }
        public string dVchState { get; set; }
        public string icon { get; set; }
    }
}
