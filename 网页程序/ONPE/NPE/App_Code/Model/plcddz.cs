using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
///plcddz 的摘要说明
/// </summary>
public class plcddz
{
	public plcddz()
	{
		//
		//TODO: 在此处添加构造函数逻辑
		//
	}

    public int dIntDataID { get; set; }
    public string dVchAdressName { get; set; }
    public string dVchAddress { get; set; }
    public string dVchAllAdress { get; set; }
    public string dVchDescription { get; set; }
    public int dIntDataType { get; set; }
    public float dFltBeishu { get; set; }
    public float dFltMoniMax { get; set; }
    public float dFltMoniMin { get; set; }
    public float dFltSjMax { get; set; }
    public float dFltSjMin { get; set; }
    public string dVchDanwei { get; set; }
    public int dIntGongType { get; set; }
    public int dIntNengYuanType { get; set; }
    public int dIntPLCXitong { get; set; }
    public string dVchDataType { get; set; }
    public int dIntZongGZ { get; set; }
    public string dVchSheBei1 { get; set; }
    public string dVchSheBei2 { get; set; }
    public string dVchNeiBuBL1 { get; set; }
    public string dVchNeiBuBL2 { get; set; }
    public int dIntIOType { get; set; }
    public int dIntPLCID { get; set; }
    public string dVchIOTypeName { get; set; }
    public string plcqm { get; set; }
    public string dVchPLCXitongName { get; set; }
    public int dIntGzOrQd { get; set; }
    public string dVchDataValue { get; set; }
    public int dIntBaojingType { get; set; }
    public DateTime dDaeDateTime { get; set; }
    public string dVchPLCAddress { get; set; }
    public string dVchFactoryName { get; set; }
    public string dVchFactoryCode { get; set; }
    public string dVchPLCbianma { get; set; }
    public string dVchFwqdh { get; set; }
    public int dIntPointType { get; set; }
    public int dIntAreaXitongID { get; set; }
    public int dIntShouJiPx { get; set; }
    public string dVchPointType { get; set; }
    public string dVchVariableName { get; set; }
    public string equip_code { get; set; }
    public int dIntAdressTypeID { get; set; }
    public float dfltMax { get; set; }
    public float dfltMin { get; set; }
    public string dVchKgAlermValue { get; set; }
    public int dIntBaojingJBID { get; set; }
    public string bjRemark { get; set; }
    //计算量
    public int dIntJsBz{get;set;}
    public string dVchFormula { get; set; }
    //历史标识
    public int dIntHsBz { get; set; }
    public int dIntBjBz { get; set; }
    public int dIntDxjBz { get; set; }
    public int dIntTsdBz { get; set; }

}

//dIntDataID, dVchAdressName, dVchAddress, dVchAllAdress, dVchDescription, dIntDataType, 
          //dFltBeishu, dFltMoniMax, dFltMoniMin, dFltSjMax, dFltSjMin, dVchDanwei, dVchDataType,  
         // tZPlcDtTemp.dVchValue
public class plcgycs
{
    public int dIntDataID { get; set; }
    public string dVchAdressName { get; set; }
    public string dVchAddress { get; set; }
    public string dVchAllAdress { get; set; }
    public string dVchDescription { get; set; }
    public int dIntDataType { get; set; }
    public float dFltBeishu { get; set; }
    public float dFltMoniMax { get; set; }
    public float dFltMoniMin { get; set; }
    public float dFltSjMax { get; set; }
    public float dFltSjMin { get; set; }
    public string dVchDanwei { get; set; }
    public string dVchDataType { get; set; }
    //计算量
    public int dIntJsBz { get; set; }
    public string dVchFormula { get; set; }

}

public class plcgycsValue
{
    public string dVchAllAdress { get; set; }
    public string dVchValue { get; set; }
    public int dIntDqBz { get; set; } 
}

public class PLCpdmsgLs
{
    public int dIntID { get; set; }
    public string dVchpdMsg { get; set; }
    public DateTime dDeaGxTime { get; set; }
    public string dVchRemark { get; set; }
}

public class plctsp
{
    public string employee_name { get; set; }
    public string branch_name { get; set; }
    public string company_name { get; set; }
    public string dVchCjdz { get; set; }
    public string employee_code { get; set; }
}

