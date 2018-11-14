using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Text;
using System.Data;
using Newtonsoft.Json;

/// <summary>
///claConvertJason 的摘要说明
/// </summary>
public class claConvertJason
{
	public claConvertJason()
	{
		//
		//TODO: 在此处添加构造函数逻辑
		//
	}

    //下拉框
    public string Jasoncombobox(DataTable dt)
    {
        StringBuilder sb = new StringBuilder();
        sb.Append("[");
        using(dt)
        {
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                sb.Append("{");
                if (i == 0)
                {

                    sb.Append("\"id\":\"" + Int32.Parse(dt.Rows[i][0].ToString()) + "\",\"text\":\" " + dt.Rows[i][1].ToString() + "\",\"selected\":true");
                }
                else
                {

                    sb.Append("\"id\":\"" + Int32.Parse(dt.Rows[i][0].ToString()) + "\",\"text\":\" " + dt.Rows[i][1].ToString() + "\"");
                }

                sb.Append("},");

            }
            sb.Remove(sb.Length - 1, 1);
            sb.Append("]");


        }
        return sb.ToString();
    }
    //grid/p,r
    public string JasonGrid(string vgrid,string total)
    {
        StringBuilder sb = new StringBuilder();
        sb.Append("{\"total\":" + total);
        sb.Append(",");
        sb.Append("\"rows\":");

        sb.Append(vgrid);
        sb.Append("}");
        return sb.ToString();
    }
}