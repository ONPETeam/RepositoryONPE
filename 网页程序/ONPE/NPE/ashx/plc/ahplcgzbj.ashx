<%@ WebHandler Language="C#" Class="ahplcgzbj" %>

using System;
using System.Web;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using Newtonsoft.Json;
using ModelClass;
using System.Text;
using NPE.UIDataClass;

public class ahplcgzbj : IHttpHandler {
    string sort = "";
    string order = "";

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
        //string result = "";
        //gridgzbj mgrid = new gridgzbj();
        //int Total = 0;
        StringBuilder sb = new StringBuilder();
        List<plcgzbj> Grid = new List<plcgzbj>();
        string lStrSql = @"select  dIntID, dIntPLCdianID, dVchAddress, dVchBaojingValue, dVchBaojingMiaoshu, dIntBiaozhi, dDaeBaojingShijian, dVchBanbie, dVchBanci, dIntBaojingID, 
                            dVchGzCsYy, dVchCLBF from tZPLCBaojingGuzhang " + GetWhere() + GetOrder();

//        string lStrSql = string.Format(@"select * from (select  dIntID, dIntPLCdianID, dVchAddress, dVchBaojingValue, dVchBaojingMiaoshu, dIntBiaozhi, dDaeBaojingShijian, dVchBanbie, dVchBanci, dIntBaojingID, 
//                      dVchGzCsYy, dVchCLBF, ROW_NUMBER() over (order by dIntID  DESC) as id from tZPLCBaojingGuzhang)
//                        as tmp where tmp.id between {0}+1  and {1}", (pageindex - 1) * pagesize, pagesize * pageindex);

        //Total = claSqlConnDB.GetRecordCount(claSqlConnDB.gStrConnDefault, "select count(*) from tZPLCBaojingGuzhang");
        DataTable dt = null;
        using (dt = claSqlConnDB.ExecuteDataset(rows,page,claSqlConnDB.gStrConnDefault, CommandType.Text, lStrSql).Tables[0])
        {

            for (int i = 0; i < dt.Rows.Count; i++)
            {
                plcgzbj mModel = new plcgzbj();
                if (dt.Rows[i][0].ToString() != "")
                {
                    mModel.dIntID = Int32.Parse(dt.Rows[i][0].ToString());
                }
                if (dt.Rows[i][1].ToString() != "")
                {
                    mModel.dIntPLCdianID = Int32.Parse(dt.Rows[i][1].ToString());
                }

                mModel.dVchAddress = dt.Rows[i][2].ToString();
                mModel.dVchBaojingValue = dt.Rows[i][3].ToString();
                mModel.dVchBaojingMiaoshu = dt.Rows[i][4].ToString();
                if (dt.Rows[i][5].ToString() != "")
                {
                    mModel.dIntBiaozhi = (int)dt.Rows[i][5];
                }

                if (dt.Rows[i][6].ToString() != "")
                {
                    mModel.dDaeBaojingShijian = DateTime.Parse(dt.Rows[i][6].ToString());
                }
                
                mModel.dVchBanbie = dt.Rows[i][7].ToString();
               
                
                mModel.dVchBanci = dt.Rows[i][8].ToString();
              
                if (dt.Rows[i][9].ToString() != "")
                {
                    mModel.dIntBaojingID = Int32.Parse(dt.Rows[i][9].ToString());
                }
             
                mModel.dVchGzCsYy = dt.Rows[i][10].ToString();


                mModel.dVchGzCsYy = dt.Rows[i][11].ToString();

                Grid.Add(mModel);
            }
            
            //mgrid.rows = Grid;
            //mgrid.total = Total;

        }
        //result = JsonConvert.SerializeObject(mgrid);
        //return JsonConvert.SerializeObject(mgrid);
        return JsonConvert.SerializeObject(Grid);

    }
    private string GetRecord()
    {
        string total = "";
        total = claSqlConnDB.GetRecordCount(claSqlConnDB.gStrConnDefault, "select count(*) from tZPLCBaojingGuzhang " + GetWhere()).ToString();
        return total;
    }
    private string GetWhere()
    {
        string mStrWhere = "";

        return mStrWhere;
    }
    private string GetOrder()
    {
        string mStrOrder = "order by dIntID desc ";
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