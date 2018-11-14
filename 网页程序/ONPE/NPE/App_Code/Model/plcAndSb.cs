using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
///plcAndSb 的摘要说明
/// </summary>
public class plcAndSb
{
	public plcAndSb()
	{
		//
		//TODO: 在此处添加构造函数逻辑
		//
	}


    public int dIntID { get; set; }
    public string dVchSbBianHao { get; set; }
    //plc地址ID
    public string dVchPLCAddress { get; set; }

    public string equip_code { get; set; }
    public string equip_innum { get; set; }
    public string equip_name { get; set; }
    public string equip_mark { get; set; }
    public string equip_type { get; set; }
    public string equip_parent { get; set; }
    public string area_id { get; set; }
    public string equip_manageDep { get; set; }
    public string equip_checkDep { get; set; }
    public string equip_header { get; set; }
    public string equip_remark { get; set; }
    public string area_name { get; set; }


}

public class plcbd:plcAndSb
{
    public int dIntDataID { get; set; }
    public string dVchAddress { get; set; }
    public string dVchAdressName { get; set; }
    public string dVchDescription { get; set; }
    public string dVchDataValue { get; set; }
    public int dIntBaojingType { get; set; }

}