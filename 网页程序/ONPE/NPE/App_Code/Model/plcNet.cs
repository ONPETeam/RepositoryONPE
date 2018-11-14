using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
///plcNet 的摘要说明
/// </summary>
public class plcNet
{
	public plcNet()
	{
		//
		//TODO: 在此处添加构造函数逻辑
		//
	}

    public int dIntDataID { get; set; }
    public string dVchName { get; set; }
    public string dVchIP { get; set; }
    public int dIntType { get; set; }
    public string dVchType { get; set; }
    public int dIntAreaOrXt { get; set; }
    public string dVchPointType { get; set; }
    public string dVchState { get; set; }

}

public class IPType
{
    public int dIntType { get;set; }
    public string dVchType { get; set; }
}