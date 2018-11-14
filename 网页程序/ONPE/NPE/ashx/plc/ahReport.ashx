<%@ WebHandler Language="C#" Class="ahReport" %>

using System;

using System.Web;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using Newtonsoft.Json;
using ModelClass;
using System.Text;
using NPE.UIDataClass;

public class ahReport : IHttpHandler {

    string sort = "";
    string order = "";
    string chanxian = "";

    int page = 1;
    int rows = 10;
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
        if(context.Request.Params["cx"] != null)
        {
            chanxian = context.Request.Params["cx"];
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
            case "cbox":
                context.Response.Write(this.GetCombobox());
                break;
            case "cboxgzfl":
                context.Response.Write(this.GetComboboxGzfl());
                break;
            case "add":
                Add(context);
                break;
            case "Edit":
                Edit(context);
                break;
            case "Del":
                Del(context);
                break;
            default:
                break;
        }
    }
    private string getGrid()
    {
        float x = 0.0001f;
        string y = x.ToString("1111");
        StringBuilder sb = new StringBuilder();
        List<Report> Grid = new List<Report>();
        string lStrSql = @"SELECT    dVchChanxianName, dFltCL, dFltYS, dFltRQXH, dFltRQNH, dFltDLXH, dFltZHNH, dFltZYL, dFltDWYSXH, dFltDWDN, dFltDWNH, dFltDWZHNH, dFltTT611, 
                            dFltTT612, dFltTT613, dFltTT614, dFltTT615, dFltTT616, dFltTT617, dFltTT618, dFltTT619, dFltTT620, dVchUserName, dVchRemark
                            FROM  tProductAllReport " + GetWhere() + GetOrder();

        DataTable dt = null;
        using (dt = claSqlConnDB.ExecuteDataset( claSqlConnDB.gStrConnDefault, CommandType.Text, lStrSql).Tables[0])
        {

            for (int i = 0; i < dt.Rows.Count; i++)
            {
                Report mModel = new Report();
                mModel.dVchChanxianName = dt.Rows[i][0].ToString();
                if (dt.Rows[i][1].ToString() != "")
                {
                    mModel.dFltCL = Math.Round(double.Parse(dt.Rows[i][1].ToString()),0);
                }

                if (dt.Rows[i][2].ToString() != "")
                {
                    mModel.dFltYS = Math.Round(double.Parse(dt.Rows[i][2].ToString()),0);
                }

                if (dt.Rows[i][3].ToString() != "")
                {
                    mModel.dFltRQXH = Math.Round(double.Parse(dt.Rows[i][3].ToString()), 0);
                }
                if (dt.Rows[i][4].ToString() != "")
                {
                    mModel.dFltRQNH = Math.Round(double.Parse(dt.Rows[i][4].ToString()),0);
                }
                if (dt.Rows[i][5].ToString() != "")
                {
                    mModel.dFltDLXH = Math.Round(double.Parse(dt.Rows[i][5].ToString()),0);
                }
                if (dt.Rows[i][6].ToString() != "")
                {
                    mModel.dFltZHNH = Math.Round(double.Parse(dt.Rows[i][6].ToString()),0);
                }
                if (dt.Rows[i][7].ToString() != "")
                {
                    mModel.dFltZYL = Math.Round(double.Parse(dt.Rows[i][7].ToString()),0);
                }
                if (dt.Rows[i][8].ToString() != "")
                {
                    mModel.dFltDWYSXH = Math.Round(double.Parse(dt.Rows[i][8].ToString()),2);
                }
                if (dt.Rows[i][9].ToString() != "")
                {
                    mModel.dFltDWDN = Math.Round(double.Parse(dt.Rows[i][9].ToString()),0);
                }
                if (dt.Rows[i][10].ToString() != "")
                {
                    mModel.dFltDWNH = Math.Round(double.Parse(dt.Rows[i][10].ToString()),0);
                }
                if (dt.Rows[i][11].ToString() != "")
                {
                    mModel.dFltDWZHNH = Math.Round(double.Parse(dt.Rows[i][11].ToString()),0);
                }
                if (dt.Rows[i][12].ToString() != "")
                {
                    mModel.dFltTT611 = Math.Round(double.Parse(dt.Rows[i][12].ToString()),0);
                }
                if (dt.Rows[i][13].ToString() != "")
                {
                    mModel.dFltTT612 = Math.Round(double.Parse(dt.Rows[i][13].ToString()),0);
                }
                if (dt.Rows[i][14].ToString() != "")
                {
                    mModel.dFltTT613 = Math.Round(double.Parse(dt.Rows[i][14].ToString()),0);
                }
                if (dt.Rows[i][15].ToString() != "")
                {
                    mModel.dFltTT614 = Math.Round(double.Parse(dt.Rows[i][15].ToString()), 0);
                }
                if (dt.Rows[i][16].ToString() != "")
                {
                    mModel.dFltTT615 = Math.Round(double.Parse(dt.Rows[i][16].ToString()),0);
                }
                if (dt.Rows[i][17].ToString() != "")
                {
                    mModel.dFltTT616 = Math.Round(double.Parse(dt.Rows[i][17].ToString()),0);
                }
                if (dt.Rows[i][18].ToString() != "")
                {
                    mModel.dFltTT617 = Math.Round(double.Parse(dt.Rows[i][18].ToString()),0);
                }
                if (dt.Rows[i][19].ToString() != "")
                {
                    mModel.dFltTT618 = Math.Round(double.Parse(dt.Rows[i][19].ToString()),0);
                }
                if (dt.Rows[i][20].ToString() != "")
                {
                    mModel.dFltTT619 = Math.Round(double.Parse(dt.Rows[i][20].ToString()),0);
                }
                if (dt.Rows[i][21].ToString() != "")
                {
                    mModel.dFltTT620 = Math.Round(double.Parse(dt.Rows[i][8].ToString()),0);
                }

                mModel.dVchUserName = dt.Rows[i][22].ToString();
                mModel.dVchRemark = dt.Rows[i][23].ToString();
                Grid.Add(mModel);

            }
        }
 
        return JsonConvert.SerializeObject(Grid);

    }

    private string GetRecord()
    {
        string total = "";
        total = claSqlConnDB.GetRecordCount(claSqlConnDB.gStrConnDefault, "select count(*) from tProductAllReport " + GetWhere()).ToString();
        return total;
    }
    private string GetWhere()
    {
        int mIntTemp = 0;
        string mStrWhere = "";
        if (chanxian != "")
        {
            mStrWhere = "WHERE  (dIntChanXianID  IN (" + chanxian + "))";
        }
       
        return mStrWhere;
    }
    private string GetOrder()
    {
        string mStrOrder = " ";
        //if (sort != "")
        //{
        //    mStrOrder = " order by " + sort;
        //    if (order != "")
        //    {
        //        mStrOrder = mStrOrder + " " + order;
        //    }
        //}
        return mStrOrder;
    }


    public string GetCombobox()
    {
        string result;
        StringBuilder sb = new StringBuilder();
        List<plcgzdc> mList = new List<plcgzdc>();
        string sql = string.Format(@"select dIntGzID,dVchGzName from tZPLCGzCL", "", null);

        DataTable dt;
        using (dt = claSqlConnDB.ExecuteDataset(claSqlConnDB.gStrConnDefault, CommandType.Text, sql).Tables[0])
        {
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                plcgzdc mModel = new plcgzdc();
                mModel.dIntGzID = (int)dt.Rows[i][0];
                mModel.dVchGzName = dt.Rows[i][1].ToString();
                mList.Add(mModel);
            }
        }
        result = JsonConvert.SerializeObject(mList);
        return JsonConvert.SerializeObject(mList);
    }

    //combobox故障分类
    public string GetComboboxGzfl()
    {
        StringBuilder sb = new StringBuilder();
        List<plcgzfl> mList = new List<plcgzfl>();
        string sql = string.Format("select dIntGzType,dVchGzTypeName from tZPLCGzFl order by dIntGzType", "", null);

        DataTable dt;
        using (dt = claSqlConnDB.ExecuteDataset(claSqlConnDB.gStrConnDefault, CommandType.Text, sql).Tables[0])
        {
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                plcgzfl mModel = new plcgzfl();
                mModel.dIntGzType = (int)dt.Rows[i][0];
                mModel.dVchGzTypeName = dt.Rows[i][1].ToString();
                mList.Add(mModel);
            }
        }
        return JsonConvert.SerializeObject(mList);

    }

    //添加
    private void Add(HttpContext context)
    {
        string mStrBeginTime = context.Request.Params["BeginTime"];
        string mStrEndTime = context.Request.Params["EndTime"];
        
        int voIntReturn;
        SqlParameter[] myParameter = new SqlParameter[5]
        {
              new SqlParameter("@viVchReportName",SqlDbType.VarChar,30),
              new SqlParameter("@viVchBeginTime",SqlDbType.VarChar,100),
              new SqlParameter("@viVchEndTime",SqlDbType.VarChar,100),
              new SqlParameter("@viVchUserBiaozhi",SqlDbType.VarChar,100),
              new SqlParameter("@voIntReturn",SqlDbType.Int,4)
              
        };

        myParameter[0].Value = "生产总量统计报表";
        myParameter[1].Value = mStrBeginTime;
        myParameter[2].Value = mStrEndTime;
        myParameter[3].Value = "aaa";
       
        myParameter[4].Direction = ParameterDirection.Output;
        claSqlConnDB.ExecuteNonQuery(claSqlConnDB.gStrConnDefault, CommandType.StoredProcedure, "pReportSRadd", myParameter);
        voIntReturn = (int)myParameter[4].Value;
        if (voIntReturn == 0)
        {
            context.Response.Write(voIntReturn);
        }

    }

    //编辑
    private void Edit(HttpContext context)
    {
        int mIntGzID = Int32.Parse(context.Request.QueryString["vID"]);
        string mStrGzName = context.Request.Form["nGzName"];
        string mStrGzXx = context.Request.Form["nGzxx"];
        string mStrGzyy = context.Request.Form["nGzyy"];
        string mStrGzCL = context.Request.Form["nGzclbf"];
        int mIntGzType = Int32.Parse(context.Request.Form["nGzfl"]);
        int voIntReturn;

        SqlParameter[] myParameter = new SqlParameter[7]
        {
            new SqlParameter("@viIntGzID",SqlDbType.Int,4),
            new SqlParameter("@viVchGzName",SqlDbType.VarChar,30),   
            new SqlParameter("@viVchGzXx",SqlDbType.VarChar,100),
            new SqlParameter("@viVchGzYy",SqlDbType.VarChar,100),
            new SqlParameter("@viVchGzCL",SqlDbType.VarChar,100),
            new SqlParameter("@viIntGzType",SqlDbType.VarChar,100),
            new SqlParameter("@voIntReturn",SqlDbType.Int,4),
            
        };

        myParameter[0].Value = mIntGzID;
        myParameter[1].Value = mStrGzName;
        myParameter[2].Value = mStrGzXx;
        myParameter[3].Value = mStrGzyy;
        myParameter[4].Value = mStrGzCL;
        myParameter[5].Value = mIntGzType;
        myParameter[6].Direction = ParameterDirection.Output;
        claSqlConnDB.ExecuteNonQuery(claSqlConnDB.gStrConnDefault, CommandType.StoredProcedure, "pZPLCGzCLEdit", myParameter);
        voIntReturn = (int)myParameter[6].Value;
        if (voIntReturn == 0)
        {
            context.Response.Write(voIntReturn);
        }
    }

    //删除
    private void Del(HttpContext context)
    {
        int mIntGzID = Int32.Parse(context.Request.QueryString["vID"]);
        int voIntReturn;

        SqlParameter[] myParameter = new SqlParameter[2]
        {
            new SqlParameter("@viIntGzID",SqlDbType.Int,4),
            new SqlParameter("@voIntReturn",SqlDbType.Int,4),
        };

        myParameter[0].Value = mIntGzID;
        myParameter[1].Direction = ParameterDirection.Output;
        claSqlConnDB.ExecuteNonQuery(claSqlConnDB.gStrConnDefault, CommandType.StoredProcedure, "pZPLCGzCLDel", myParameter);
        voIntReturn = (int)myParameter[1].Value;
        if (voIntReturn == 0)
        {
            context.Response.Write(voIntReturn);
        }
    }
    
    public bool IsReusable {
        get {
            return false;
        }
    }

}