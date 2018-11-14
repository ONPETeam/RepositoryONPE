<%@ WebHandler Language="C#" Class="jobHandler" %>

using System;
using System.Web;
using ModelClass;
using Newtonsoft.Json;
using NPE.UIDataClass;
using System.Data;
using System.Collections.Generic;

public class jobHandler : IHttpHandler
{

    string job_id = "";
    string job_innum = "";
    string job_name = "";
    string job_branch = "";
    string job_build = "";
    string job_state = "";
    string job_close = "";
    string job_close_reason = "";
    string order = "";
    string sort = "";
    int page = 1;
    int rows = 10;
    public void ProcessRequest(HttpContext context)
    {
        string action = "";
        context.Response.ContentType = "text/plain";
        if (context.Request.Params["job_id"] != null)
        {
            job_id = context.Request.Params["job_id"].ToString();
        }
        if (context.Request.Params["job_innum"] != null)
        {
            job_innum = context.Request.Params["job_innum"].ToString();
        }
        if (context.Request.Params["job_name"] != null)
        {
            job_name = context.Request.Params["job_name"].ToString();
        }
        if (context.Request.Params["job_branch"] != null)
        {
            job_branch = context.Request.Params["job_branch"].ToString();
        }
        if (context.Request.Params["job_build"] != null)
        {
            job_build = context.Request.Params["job_build"].ToString();
        }
        if (context.Request.Params["job_state"] != null)
        {
            job_state = context.Request.Params["job_state"].ToString();
        }
        if (context.Request.Params["job_close"] != null)
        {
            job_close = context.Request.Params["job_close"].ToString();
        }
        if (context.Request.Params["job_close_reason"] != null)
        {
            job_close_reason = context.Request.Params["job_close_reason"].ToString();
        }
        if (context.Request.Params["sort"] != null)
        {
            sort = context.Request.Params["sort"].ToString();
        }
        if (context.Request.Params["order"] != null)
        {
            order = context.Request.Params["order"].ToString();
        }
        if (context.Request.Params["page"] != null)
        {
            page = int.Parse(context.Request.Params["page"].ToString());
        }
        if (context.Request.Params["rows"] != null)
        {
            rows = int.Parse(context.Request.Params["rows"].ToString());
        }
        if (context.Request.Params["action"] != null)
        {
            action = context.Request.Params["action"].ToString();
        }
        switch (action)
        {
            case "add":
                context.Response.Write(AddJob());
                break;
            case "edit":
                context.Response.Write(EditJob());
                break;
            case "del":
                context.Response.Write(DelJob());
                break;
            case "cancle":
                context.Response.Write(CancleJob());
                break;
            case "grid":
                System.Text.StringBuilder sb = new System.Text.StringBuilder();
                sb.Append("{ ");
                sb.Append(string.Format("\"total\":{0},\"rows\":", GetJobCount()));
                string s = ShowJobGrid();
                sb.Append(s);
                sb.Append("}");
                context.Response.Write(sb.ToString());
                break;
            default:

                break;
        }
    }
    public string AddJob()
    {
        global mglobal = new global();
        job_id = mglobal.GetIdentityID("PC", "HR", "GW", System.DateTime.Now, 4);
        job_state = "0";
        job_close = "1900-01-01";
        job_close_reason = "";
        string mStrSQL = @" Insert Into t_Job (job_id, job_innum, job_name, job_branch, job_build, job_state, 
                        job_close, job_close_reason)VALUES (
                      '" + job_id + "','" + job_innum + "','" + job_name + "'," + job_branch + ",'" + job_build + "'," + job_state
                        + ",'" + job_close + "','" + job_close_reason + "')";
        int i = claSqlConnDB.ExecuteNonQuery(claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL);
        return i.ToString();
    }
    public string EditJob()
    {        
        string mStrSQL = @" UPDATE t_Job SET
                              job_innum='" + job_innum
                         + "',job_name='" + job_name
                         + "',job_branch=" + job_branch
                         + " ,job_build='" + job_build
                         + "' WHERE job_id='" + job_id + "'";
        int i = claSqlConnDB.ExecuteNonQuery(claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL);
        return i.ToString();
    }
    public string CancleJob()
    {
        string mStrSQL=@"UPDATE t_Job SET 
                        job_close='" + job_close
                         + "',job_close_reason='" + job_close_reason
                         + "' WHERE job_id='" + job_id + "'";
        int i = claSqlConnDB.ExecuteNonQuery(claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL);
        return i.ToString();        
    }
    public string DelJob()
    {
        string mStrSQL = "DELETE FROM t_Job WHERE job_id='" + job_id + "'";
        int i = claSqlConnDB.ExecuteNonQuery(claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL);
        return i.ToString();
    }
    public string GetJobCount()
    {
        string mStrSQL = "SELECT count(0) FROM t_Job " + GetWhere();
        int i = claSqlConnDB.GetRecordCount(claSqlConnDB.gStrConnDefault, mStrSQL);
        return i.ToString();
    }

    public string ShowJobGrid()
    {
        string mStrReturn = "";
        List<Job> listTemp = new List<Job>();
        string mStrSQL = @"SELECT     t_Job.job_id, t_Job.job_innum, t_Job.job_name, t_Job.job_branch AS job_branch_id, tHRBranchInfo.dVchBranchName AS job_branch_name, tHRCompany.dIntCompanyID AS job_company_id, 
                                      tHRCompany.dVchCompanyName AS job_company_name, t_Job.job_build, t_Job.job_state, t_Job.job_close, t_Job.job_close_reason
                           FROM       tHRCompany RIGHT OUTER JOIN
                                      tHRBranchInfo ON tHRCompany.dIntCompanyID = tHRBranchInfo.dIntCompanyID RIGHT OUTER JOIN
                                      t_Job ON tHRBranchInfo.dIntBranchID = t_Job.job_branch " + GetWhere() + GetOrder();
        DataTable dt = null;
        using (dt = claSqlConnDB.ExecuteDataset(rows, page, claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL).Tables[0])
        {
            if (dt.Rows.Count > 0)
            {
                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    Job jobTemp = new Job();
                    jobTemp.job_id = dt.Rows[i][0].ToString();
                    jobTemp.job_innum = dt.Rows[i][1].ToString();
                    jobTemp.job_name = dt.Rows[i][2].ToString();
                    jobTemp.job_branch_id=dt.Rows[i][3].ToString();
                    jobTemp.job_branch_name = dt.Rows[i][4].ToString();
                    jobTemp.job_company_id = dt.Rows[i][5].ToString();
                    jobTemp.job_company_name = dt.Rows[i][6].ToString();
                    if (dt.Rows[i][7].ToString() != "")
                    {
                        jobTemp.job_build = ((DateTime)dt.Rows[i][7]).ToShortDateString().Replace("/", "-");
                    }
                    else
                    {
                        jobTemp.job_build = "未知";
                    }
                    jobTemp.job_state = dt.Rows[i][8].ToString();
                    jobTemp.job_close = dt.Rows[i][9].ToString();
                    jobTemp.job_close_reason = dt.Rows[i][10].ToString();
                    listTemp.Add(jobTemp);
                }
            }
        }
        mStrReturn = JsonConvert.SerializeObject(listTemp);
        return mStrReturn;
    }

    public bool IsReusable
    {
        get
        {
            return false;
        }
    }

    public string GetWhere()
    {
        string mStrWhere = "";
        if (job_name != "")
        {
            if (mStrWhere != "")
            {
                mStrWhere = mStrWhere + " and t_Job.job_name like '%" + job_name + "%'";
            }
            else
            {
                mStrWhere = " where t_Job.job_name like '%" + job_name + "%'";
            }
        }
        return mStrWhere;
    }
    public string GetOrder()
    {
        string mStrOrder = "";
        if (sort != "")
        {
            mStrOrder = " order by " + sort + " ";
            if (order != "")
            {
                mStrOrder = mStrOrder + order;
            }
        }
        return mStrOrder;
    }
}

