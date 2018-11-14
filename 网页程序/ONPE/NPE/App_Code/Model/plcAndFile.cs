using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
///plcAndFile 的摘要说明
/// </summary>
public class plcAndFile
{
	public plcAndFile()
	{
		//
		//TODO: 在此处添加构造函数逻辑
		//
	}
    public int dIntID { get; set; }
    public string dVchSbBianHao { get; set; }
    //plc地址ID
    public string dVchPLCAddress { get; set; }


    public string equipfile_code { get; set; }
    public string equip_code { get; set; }
    //public string equip_innum { get; set; }
    public string file_code { get; set; }
    public string file_name { get; set; }
    public string file_innum { get; set; }
    public string file_type { get; set; }
    public string fileclass_code { get; set; }
    public string fileclass_name { get; set; }
    public string diretory_code { get; set; }
    public string diretory_name { get; set; }
    public string file_size { get; set; }
    public string file_data_flag { get; set; }
    public string file_address { get; set; }
    public byte[] file_context { get; set; }
    public string file_time { get; set; }
    public string file_people { get; set; }
    public string file_remark { get; set; }
}