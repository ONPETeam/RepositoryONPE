using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
///plcXitong 的摘要说明
/// </summary>
public class plcXitong
{
	public plcXitong()
	{
		//
		//TODO: 在此处添加构造函数逻辑
		//
	}

    public int dIntNoteID { get; set; }
    public string dVchPointType { get; set; }
    public string dVchRemark { get; set; }
    public int dIntSjNoteID { get; set; }
    public int dIntPx { get; set; }

}

public class plcXitongTree
{
    public int id {get;set;}
    public string name{get;set;}
    public string state { get; set; }

}
public class plcXitongNode
{
    public int id { get; set; }
    public string name { get; set; }
    public int _parentId { get; set; }
    public string state { get; set; }

}

