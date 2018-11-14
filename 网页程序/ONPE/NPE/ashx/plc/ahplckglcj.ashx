<%@ WebHandler Language="C#" Class="ahplckglcj" %>

using System;
using System.Web;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using Newtonsoft.Json;
using ModelClass;
using System.Text;
using NPE.UIDataClass;


public class ahplckglcj : IHttpHandler {
    string sort = "";
    string order = "";

    int page = 1;
    int rows = 10;

    string mStrplc = "";
    string mStrddz = "";
    
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
        if (context.Request.Params["ddzcz"] != null)
        {
            mStrddz = context.Request.Params["ddzcz"];
        }
        switch (action)
        {
            case "grid":
                System.Text.StringBuilder sb = new System.Text.StringBuilder();
                sb.Append("{ ");
                sb.Append(string.Format("\"total\":{0},\"rows\":", GetRecord()));
                string s = getGrid();
                sb.Append(s);
                sb.Append("}");
                context.Response.Write(sb.ToString());
                break;
            default:
                break;
        }
    }
    private string getGrid()
    {
        StringBuilder sb = new StringBuilder();
        List<plckglcj> Grid = new List<plckglcj>();
        string lStrSql = @"select  dIntDataID, dIntdizhiID, dVchAddress, dVchAllAdress, dDatGetTime, dIntState, dIntDataType, dVchDanwei, dVchRemark FROM tZPLCKaiGuanLiangCaijiData " + GetWhere() + GetOrder();

        DataTable dt = null;
        using (dt = claSqlConnDB.ExecuteDataset(rows, page, claSqlConnDB.gStrConnDefault, CommandType.Text, lStrSql).Tables[0])
        {

            for (int i = 0; i < dt.Rows.Count; i++)
            {
                plckglcj mModel = new plckglcj();
                if (dt.Rows[i][0].ToString() != "")
                {
                    mModel.dIntDataID = Int32.Parse(dt.Rows[i][0].ToString());
                }
                if (dt.Rows[i][1].ToString() != "")
                {
                    mModel.dIntdizhiID = (int)dt.Rows[i][1];
                }
                mModel.dVchAddress = dt.Rows[i][2].ToString();
                mModel.dVchAllAdress = dt.Rows[i][3].ToString();
                if (dt.Rows[i][4].ToString() != "")
                {
                    mModel.dDatGetTime = (DateTime)dt.Rows[i][4];
                }
                if (dt.Rows[i][5].ToString() != "")
                {
                    mModel.dIntState = (int)dt.Rows[i][5];
                }
                if (dt.Rows[i][6].ToString() != "")
                {
                    mModel.dIntDataType = (int)dt.Rows[i][6];
                }
                mModel.dVchDanwei = dt.Rows[i][7].ToString();
                mModel.dVchRemark = dt.Rows[i][8].ToString();
                Grid.Add(mModel);
            }
           

        }
      
        return JsonConvert.SerializeObject(Grid);

    }
    private string GetRecord()
    {
        string total = "";
        total = claSqlConnDB.GetRecordCount(claSqlConnDB.gStrConnDefault, "select count(*) from tZPLCKaiGuanLiangCaijiData " + GetWhere()).ToString();
        return total;
    }
    private string GetWhere()
    {
        string mStrWhere = " where dIntDataID <> -10";
        if (mStrddz != "")
        {
            mStrWhere = mStrWhere + " and dIntdizhiID = " + mStrddz;
        }
        
        return mStrWhere;
    }

    private string GetOrder()
    {
        string mStrOrder = "order by dIntDataID desc ";
        if (sort != "")
        {
            mStrOrder = " order by " + sort;
            if (order != "")
            {
                mStrOrder = mStrOrder + " " + order;
            }
        }
        return mStrOrder;
    }
    public bool IsReusable {
        get {
            return false;
        }
    }

}