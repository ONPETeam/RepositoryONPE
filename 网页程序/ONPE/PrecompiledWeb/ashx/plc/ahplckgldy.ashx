<%@ WebHandler Language="C#" Class="ahplckgldy" %>

using System;
using System.Web;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using Newtonsoft.Json;
using ModelClass;
using System.Text;
using NPE.UIDataClass;

public class ahplckgldy : IHttpHandler {

    public HttpRequest Request
    {
        get
        {
            return HttpContext.Current.Request;
        }
    }
    private HttpResponse Response
    {
        get { return HttpContext.Current.Response; }
    }
    string sort = "";
    string order = "";

    int page = 1;
    int rows = 10;

    string address = "";
    public void ProcessRequest (HttpContext context) {
        string action = "";
        string mtest = "";
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
        if (context.Request.Params["vAsid"] != null)
        {
            address = context.Request.Params["vAsid"];
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
            //case"yy":
                
            //    break;
            //case"add":
            //    Add(context);
            //    break;
            //case"delete":
            //    Del(context);
            //    break;
            default:
                break;
        }
    }
    private string getGrid()
    {
        //grid mgrid = new grid();
        //int Total =0;
        StringBuilder sb = new StringBuilder();
        List<plckgldy> plckgldyGrid = new List<plckgldy>();


        string lStrSql = @"select dIntdizhiID, dVchAddress, dVchAllAdress, dIntState, dVchStateName, dVchMiaoshu, dIntAlermState, dIntType, dVchGzCsYy, dVchCLBF from tZPLCKaiguanDy " + GetWhere() + GetOrder();

//        string lStrSql = string.Format(@"select * from (select dIntdizhiID, dVchAddress, dVchAllAdress, dIntState, dVchStateName, dVchMiaoshu, dIntAlermState, dIntType, dVchGzCsYy, dVchCLBF,ROW_NUMBER() over (order by dIntdizhiID  DESC) as id from tZPLCKaiguanDy )
//                                            as tmp where tmp.id between {0}+1  and {1}", (pageindex - 1) * pagesize, pagesize * pageindex);

        //Total = claSqlConnDB.GetRecordCount(claSqlConnDB.gStrConnDefault, "select count(*) from tZPLCKaiguanDy");
        DataTable dt = null;
        using (dt = claSqlConnDB.ExecuteDataset(rows,page,claSqlConnDB.gStrConnDefault, CommandType.Text, lStrSql).Tables[0])
        {
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                plckgldy mplckgldy = new plckgldy();
                if(dt.Rows[i][0].ToString() != "")
                {
                    mplckgldy.dIntdizhiID = (int)dt.Rows[i][0];
                }
                mplckgldy.dVchAddress = dt.Rows[i][1].ToString();
                mplckgldy.dVchAllAdress = dt.Rows[i][2].ToString();
                if (dt.Rows[i][3].ToString() != "")
                {
                    mplckgldy.dIntState = (int)dt.Rows[i][3];
                }
                mplckgldy.dVchStateName = dt.Rows[i][4].ToString();
                mplckgldy.dVchMiaoshu = dt.Rows[i][5].ToString();
                if (dt.Rows[i][6].ToString() != "")
                {
                    mplckgldy.dIntAlermState = (int)dt.Rows[i][6];
                }
                //else
                //{
                //    mplckgldy.dIntAlermState = 100;
                //}
                
                mplckgldy.dIntType = (int)dt.Rows[i][7];
                mplckgldy.dVchGzCsYy = dt.Rows[i][8].ToString();
                mplckgldy.dVchCLBF = dt.Rows[i][9].ToString();
                plckgldyGrid.Add(mplckgldy);
                
            }
            //mgrid.rows = plckgldyGrid;
            //mgrid.total = Total;
        }
        //return JsonConvert.SerializeObject(mgrid);
        return JsonConvert.SerializeObject(plckgldyGrid);

    }

    private string GetRecord()
    {
        string total = "";
        total = claSqlConnDB.GetRecordCount(claSqlConnDB.gStrConnDefault, "select count(*) from tZPLCKaiguanDy " + GetWhere()).ToString();
        return total;
    }
    private string GetWhere()
    {
        string mStrWhere = "where dIntdizhiID <> -1";
        if(address != "")
        {
            mStrWhere = mStrWhere + " and dIntdizhiID = " + address;
        }
        return mStrWhere;
    }
    private string GetOrder()
    {
        string mStrOrder = "order by dIntdizhiID desc ";
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
   

    public static string gzyy(string vdcid)
    {
        string mStrgzyy = "";
        string sql = "select dVchGzCsYy from tZPLCGzCL where dIntGzID = " + vdcid;
        mStrgzyy = (string)claSqlConnDB.ExecuteScalar(claSqlConnDB.gStrConnDefault, CommandType.Text, sql);
        return mStrgzyy; 
    }
    public bool IsReusable {
        get {
            return false;
        }
    }

}