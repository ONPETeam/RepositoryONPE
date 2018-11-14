<%@ WebHandler Language="C#" Class="ahplcAndFile" %>

using System;
using System.Web;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using Newtonsoft.Json;
using ModelClass;
using System.Text;
using NPE.UIDataClass;

public class ahplcAndFile : IHttpHandler {
    
    string sort = "";
    string order = "";
    string ddz = "";
    int page = 1;
    int rows = 10;
    public void ProcessRequest (HttpContext context) {
        string action = "";
        context.Response.ContentType = "text/plain";
        if (context.Request.Params["sort"] != null)
        {
            sort = context.Request.Params["sort"];
        }
        if (context.Request.Params["order"] != null)
        {
            order = context.Request.Params["order"];
        }
        if (context.Request.Form["page"] != null)
        {
            page = int.Parse(context.Request.Form["page"]);//页码
        }
        if (context.Request.Form["rows"] != null)
        {
            rows = int.Parse(context.Request.Form["rows"]);//页容量
        }

        if (context.Request.Params["action"] != null)
        {
            action = context.Request.Params["action"];
        }
        if (context.Request.Params["vddz"] != null)
        {
            ddz = context.Request.Params["vddz"];
        }
        switch (action)
        {
            case "grid":
                //System.Text.StringBuilder sb = new System.Text.StringBuilder();
                //sb.Append("{ ");
                //sb.Append(string.Format("\"total\":{0},\"rows\":", GetRecord()));
                //string s = getGrid();
                //sb.Append(s);
                //sb.Append("}");
                //context.Response.Write(sb.ToString());
                GetData(context);
                break;
            default:
                break;
        }
    }

    private void GetData(HttpContext context)
    {
        int count = GJHF.Business.PLC.BPlcAndFile.GetRecord(ddz);
        DataTable dt = GJHF.Business.PLC.BPlcAndFile.GetData(rows, page, ddz);
        string mstrJson = GJHF.Utility.WEBUI.EasyuiControl.GetGridReturn(count, dt);
        context.Response.Write(mstrJson);
    }
    
//    private string getGrid()
//    {
//        StringBuilder sb = new StringBuilder();
//        List<plcAndFile> Grid = new List<plcAndFile>();
//        string lStrSql = @"select dIntID,dVchSbBianHao,dVchPLCAddress,t_EquipFile.equip_code,t_File.file_code,file_name,file_type,file_size,file_time,file_people,file_context  from tZSbAndPLC left outer join t_EquipFile on  tZSbAndPLC.dVchSbBianHao = t_EquipFile.equip_code 
//                            left outer join t_File on t_EquipFile.file_code = t_File.file_code" + GetWhere() + GetOrder();

//        DataTable dt = null;
//        using (dt = claSqlConnDB.ExecuteDataset(rows, page, claSqlConnDB.gStrConnDefault, CommandType.Text, lStrSql).Tables[0])
//        {
//            for (int i = 0; i < dt.Rows.Count; i++)
//            {
//                plcAndFile mModel = new plcAndFile();
//                if (dt.Rows[i][0].ToString() != "")
//                {
//                    mModel.dIntID = Int32.Parse(dt.Rows[i][0].ToString());
//                }

//                mModel.dVchSbBianHao = dt.Rows[i][1].ToString();
//                mModel.dVchPLCAddress = dt.Rows[i][2].ToString();
//                mModel.equip_code = dt.Rows[i][3].ToString();
//                mModel.file_code = dt.Rows[i][4].ToString();
//                mModel.file_name = dt.Rows[i][5].ToString();
//                mModel.file_type = dt.Rows[i][6].ToString();
//                mModel.file_size = dt.Rows[i][7].ToString();
//                mModel.file_time = dt.Rows[i][8].ToString();
//                mModel.file_people = dt.Rows[i][9].ToString();
//                //mModel.file_context = (byte[])dt.Rows[i][10];
//                Grid.Add(mModel);

//            }
//        }

//        return JsonConvert.SerializeObject(Grid);

//    }
//    private string GetRecord()
//    {
//        string total = "";
//        total = claSqlConnDB.GetRecordCount(claSqlConnDB.gStrConnDefault, @"select count(*)  from tZSbAndPLC left outer join t_EquipFile on  tZSbAndPLC.dVchSbBianHao = t_EquipFile.equip_code 
//                            left outer join t_File on t_EquipFile.file_code = t_File.file_code " + GetWhere()).ToString();
//        return total;
//    }
//    private string GetWhere()
//    {
//        string mStrWhere = " where dIntID <> -10";
//        if (ddz != "")
//        {
//            mStrWhere = mStrWhere + " and dVchPLCAddress = " + ddz;
//        }
//        return mStrWhere;
//    }

//    private string GetOrder()
//    {
//        string mStrOrder = "order by dIntID  ";
//        if (sort != "")
//        {
//            mStrOrder = " order by " + sort;
//            if (order != "")
//            {
//                mStrOrder = mStrOrder + " " + order;
//            }
//        }
//        return mStrOrder;
//    }
    
    
    
    public bool IsReusable {
        get {
            return false;
        }
    }

}