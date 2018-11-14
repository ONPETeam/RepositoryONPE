using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace ModelClass
{
    /// <summary>
    ///PLCManager 的摘要说明
    /// </summary>
    public class PLCManager
    {
        public PLCManager()
        {
            //
            //TODO: 在此处添加构造函数逻辑
            //
        }

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
        public string icon { get; set; }
        public string dVchPointType { get; set; }
        public string dVchArea { get; set; }
    }

    public class PlcDtTemp
    {
        public int dIntDataID { get; set; }
        public string dVchFactoryCode { get; set; }
        public string dVchPLCCode { get; set; }
        public string dVchAdress { get; set; }
        public string dVchCjdz { get; set; }
        public string dVchValue { get; set; }
        public string dVchUnit { get; set; }
        public int dIntDqBz { get; set; }
        public string dVchFactoryName { get; set;}
        public string dVchRemark { get; set;}
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
    public class PlcDtTempLS
    {
        public int dIntDataID { get; set; }
        public string dVchCjdz { get; set; }
        public string dVchValue { get; set; }
        public string dVchSjValue { get; set; }
        public string dDaeCurrentTime { get; set; }
        public string dFltSjMax { get; set; }
        public string dFltSjMin { get; set; }
        public string dFltBdMax { get; set; }
        public string dFltBdMin { get; set; }
    }

    public class plcBaojingFanwei
    {
        public int dIntDataID { get; set; }
        public string dVchSbCode { get; set; }
        public string dVchAllAdress { get; set; }
        public int dIntAdressTypeID { get; set; }
        public float dfltMax { get; set; }
        public float dfltMin { get; set; }
        public string dVchKgAlermValue { get; set; }
        public int dIntBaojingJBID { get; set; }
        public string dVchRemark { get; set; }
    }
    public class VariableType
    {
        public int dIntVariableID { get; set; }
        public string dVchVariableCode { get; set; }
        public string dVchVariableName { get; set; }
    }
    public class plcfactory
    {
        public string dVchFactoryCode { get; set; }
        public string dVchFactoryName { get; set; }
        public int dIntArea { get; set; }
    }

    public class plcgz
    {
        public int dIntGZID { get; set; }
        public string dVchGZQZ { get; set; }
        public string dVchJSSM { get; set; }
        public int dIntPLCPinPaiID { get; set; }
    }

    public class PlcHistoryJK
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
        public float dFltSjMax { get; set; }
        public float dFltSjMin { get; set; }
        public float dFltBdMax { get; set; }
        public float dFltBdMin { get; set; }
        public string dVchfwqdh { get; set; }
        public string dVchSjValue { get; set; }
        public string dVchName { get; set; }
        public int dIntdizhiID { get; set; }
        public string equip_code { get; set; }
        public string equip_name { get; set; }
        public string dVchDescription { get; set; }
        public string dVchVariableType { get; set; }
        public int dIntHsBz { get; set; }
        public int dIntBjBz { get; set; }
        public int dIntDxjBz { get; set; }
        public int dIntTsdBz { get; set; }
        public string dVchUser { get; set; }
        public int dIntYzBz { get; set; }
    }


    public class PlcBjGxDisplay
    {
        public int dIntID { get; set; }
        public int dIntdizhiID { get; set; }
        public string dVchCjdz { get; set; }
        public string dVchEquip_code { get; set; }
        public string equip_name { get; set; }
        public string dVchAdress { get; set; }
        public string dVchName { get; set; }
        public DateTime dDaeGzCs{get;set;}
        public DateTime dDaeGzHf { get; set; }
        public string dVchValue { get; set; }
        public string dVchRemark { get; set; }

    }

    public class PLCVariableAndAddress
    {
        public int dIntDataID { get; set; }
        public string dVchVariable { get; set; }
        public string dVchCollectAddress { get; set; }
        public string dVchParameterNum { get; set; }
    }
}