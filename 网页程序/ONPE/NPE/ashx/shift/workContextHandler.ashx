<%@ WebHandler Language="C#" Class="workContextHandler" %>

using System;
using System.Web;
using ModelClass;
using Newtonsoft.Json;
using NPE.UIDataClass;
using System.Data;
using System.Collections.Generic;

public class workContextHandler : IHttpHandler {

    int rows = 10;
    int page = 1;
    
    string branch_id = "";
    string work_date = "";
    string classnum_code = "";
    DateTime mDtmStartTime = DateTime.Now.Date;
    DateTime mDtmEndTime = DateTime.Now.AddDays(1).Date;
    
    public void ProcessRequest (HttpContext context) {
        string action = "";
        
        context.Response.ContentType = "text/plain";
        if (context.Request.Params["action"] != null)
        {
            action = context.Request.Params["action"]; 
        }
        if (context.Request.Params["branch_id"] != null)
        {
            branch_id = context.Request.Params["branch_id"];
        }
        if (context.Request.Params["work_date"] != null)
        {
            work_date = context.Request.Params["work_date"];
        }
        if (context.Request.Params["classnum_code"] != null)
        {
            classnum_code = context.Request.Params["classnum_code"];
        }
        if (context.Request.Params["rows"] != null)
        {
            rows = int.Parse(context.Request.Params["rows"]);
        }
        if (context.Request.Params["page"] != null)
        {
            page = int.Parse(context.Request.Params["page"]);
        }
        switch (action)
        {
            case "get":
                GetWorkTime(classnum_code, work_date);
                System.Text.StringBuilder sb = new System.Text.StringBuilder();
                sb.Append("{ ");
                sb.Append(string.Format("\"total\":{0},\"rows\":", GetCount()));
                string s = showData();
                sb.Append(s);
                sb.Append("}");
                context.Response.Write(sb.ToString());
                break;
            default:

                break;
        }
    }
    private string GetCount()
    {
        string mStrSQL = @" select count(0) from t_GZP " + GetWhere();
        int i = claSqlConnDB.GetRecordCount(claSqlConnDB.gStrConnDefault, mStrSQL);
        return i.ToString();
    }
    private void GetWorkTime(string vStrClassNumCode, string vStrWorkDate)
    {
        
        DateTime mDtmDate;
        if(DateTime.TryParse(vStrWorkDate,out mDtmDate)!=true)
        {
            mDtmDate=DateTime.Now.Date;
        }
        string mStrSQL = @" select dDtmClassStart,dDtmClassEnd,dIntFlagTorrmory from tCDClass where dVchClassID='" + vStrClassNumCode + "'";
        DataTable dt = null;
        using(dt=claSqlConnDB.ExecuteDataset(claSqlConnDB.gStrConnDefault,CommandType.Text,mStrSQL).Tables[0])
        {
            if (dt.Rows.Count > 0)
            {
                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    mDtmStartTime = DateTime.Parse(mDtmDate.ToShortDateString() + " " + DateTime.Parse(dt.Rows[i][0].ToString()).ToShortTimeString());
                    if (dt.Rows[i][2].ToString() == "1")
                    {
                        mDtmEndTime = DateTime.Parse(mDtmDate.AddDays(1).ToShortDateString() + " " + DateTime.Parse(dt.Rows[i][1].ToString()).ToShortTimeString());
                    }
                    else
                    {
                        mDtmEndTime = DateTime.Parse(mDtmDate.ToShortDateString() + " " + DateTime.Parse(dt.Rows[i][1].ToString()).ToShortTimeString());
                    }
                }
            }
        }
    }

    public string showData()
    {
        string returnStr = "";
        List<gzp> gzpGrid = new List<gzp>();
        string lStrSQL = "select dVchWorkNote,dVchWorkCreatUnit,dVchWorkCreatPeo,dDaeWorkSys,dVchActionDep,dVchArea,dDaeWorkStart,dVchWorkPeo,dVchWorkPeoQZ,dDaeWorkEnd,dVchWorkPeo1,dVchWorkPeoQZ1,dVchFromType from t_GZP " + GetWhere() + GetOrder();
        DataTable dt = null;
        using (dt = claSqlConnDB.ExecuteDataset(rows, page, claSqlConnDB.gStrConnDefault, CommandType.Text, lStrSQL).Tables[0])
        {
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                gzp gzptmp = new gzp();
                gzptmp.dVchWorkNote = dt.Rows[i][0].ToString();
                gzptmp.dVchWorkCreatUnit = dt.Rows[i][1].ToString();
                gzptmp.dVchWorkCreatPeo = dt.Rows[i][2].ToString();
                gzptmp.dDaeWorkSys = dt.Rows[i][3].ToString();
                gzptmp.dVchActionDep = dt.Rows[i][4].ToString();
                gzptmp.dVchArea = dt.Rows[i][5].ToString();
                gzptmp.dDaeWorkStart = dt.Rows[i][6].ToString();
                gzptmp.dVchWorkPeo = dt.Rows[i][7].ToString();
                gzptmp.dVchWorkPeoQZ = dt.Rows[i][8].ToString();
                gzptmp.dDaeWorkEnd = dt.Rows[i][9].ToString();
                gzptmp.dVchWorkPeo1 = dt.Rows[i][10].ToString();
                gzptmp.dVchWorkPeoQZ1 = dt.Rows[i][11].ToString();
                gzptmp.dVchFromType = dt.Rows[i][12].ToString();
                gzptmp.Item = "";
                gzpGrid.Add(gzptmp);
            }
        }
        return returnStr = JsonConvert.SerializeObject(gzpGrid);
    }

    private string GetWhere()
    {
        string mStrWhere = " where dVchActionDep = '" + branch_id + "' and dDaeWorkSys >='" + mDtmStartTime.ToString() + "' and dDaeWorkSys <'" + mDtmEndTime.ToString() + "'";
        
        return mStrWhere; 
    }

    private string GetOrder()
    {
        string mStrOrder = " order by dDaeWorkSys desc";
        return mStrOrder; 
    }
    public bool IsReusable {
        get {
            return false;
        }
    }

}