<%@ WebHandler Language="C#" Class="HistoryDataShow" %>

using System;
using System.Web;
using System.Data;
using System.Data.SqlClient;

public class HistoryDataShow : IHttpHandler {
    
    public void ProcessRequest (HttpContext context) {
        context.Response.ContentType = "text/plain";
        //context.Response.Write("Hello World");
        string type = "";
        string mStrReturn = "";
        if (context.Request.Params["type"] != null)
        {
            type = context.Request.Params["type"].ToString();
        }
        
        switch (type.ToLower())
        {
            case "para1":
                int m_para1_page = 1;
                if (context.Request.Params["page"] != null)
                {
                    if (int.TryParse(context.Request.Params["page"], out m_para1_page) == false)
                    {
                        m_para1_page = 1;
                    }
                }
                int m_para1_rows = 10;
                if (context.Request.Params["rows"] != null)
                {
                    if (int.TryParse(context.Request.Params["rows"], out m_para1_rows) == false)
                    {
                        m_para1_rows = 10;
                    }
                }
                string m_para1_AllAdress = "";
                if (context.Request.Params["alladdress"] != null)
                {
                    m_para1_AllAdress = context.Request.Params["alladdress"].ToString();
                }
                string m_para1_starttime = "";
                if (context.Request.Params["starttime"] != null)
                {
                    m_para1_starttime = context.Request.Params["starttime"].ToString();
                }
                string m_para1_endtime = "";
                if (context.Request.Params["endtime"] != null)
                {
                    m_para1_endtime = context.Request.Params["endtime"].ToString();
                }
                mStrReturn = "{\"total\":" + GetHistoryDataCount(m_para1_AllAdress, m_para1_starttime, m_para1_endtime) + ",\"rows\":" + "[" + GetHistoryData(m_para1_AllAdress, m_para1_starttime, m_para1_endtime, m_para1_rows, m_para1_page) + "]" + "}";
                break;
            default:
                mStrReturn = "";
                break; 
        }
        context.Response.Write(mStrReturn);
    }

    private int GetHistoryDataCount(string v_AllAdress, string v_starttime, string v_endtime)
    {
        string tabletemp = GetTableByAddress(v_AllAdress);
        string mStrSQL = "";
        mStrSQL = @"SELECT COUNT(0) FROM " + tabletemp + " where dDaeCollectSys >= '" + v_starttime + "' and dDaeCollectSys <= '" + v_endtime + "'";
        int i = claSqlConnDB.GetRecordCount(claSqlConnDB.gStrConnDefault, mStrSQL);
        return i;
    }
    private string GetHistoryData(string v_AllAdress, string v_starttime, string v_endtime, int v_rows, int v_page)
    {
        string tabletemp = GetTableByAddress(v_AllAdress);
        string returnJson = "";
        string strSQL = "";
        strSQL = "select * from " + tabletemp + " where dDaeCollectSys >= '" + v_starttime + "' and dDaeCollectSys <= '" + v_endtime + "'";
        DataSet ds = null;
        using (ds = claSqlConnDB.ExecuteDataset(v_rows, v_page, claSqlConnDB.gStrConnDefault, CommandType.Text, strSQL))
        {
            returnJson = common.GetJsonByDataset1(ds);
        }
        return returnJson;
    }

    private string GetTableByAddress(string v_AllAdress)
    {
        string tableTemp = "";
        string mStrAddress = "";
        int mIntIndex = -100;
        string mStrSQL = "select dVchAddress,dIntCollectIndex from tZPlcPointConfig where dVchAllAdress = '" + v_AllAdress + "'";
        SqlDataReader dr = null;
        using (dr = claSqlConnDB.ExecuteReader(claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL))
        {
            if (dr.Read())
            {
                mStrAddress = dr.GetString(0);
                mIntIndex = dr.GetInt32(1);

                tableTemp = "Data_Log_" + mStrAddress + '_' + mIntIndex.ToString();
            }
            dr.Close();
        }
        dr.Dispose();
        return tableTemp;
    }
    public bool IsReusable {
        get {
            return false;
        }
    }
}