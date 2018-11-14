<%@ WebHandler Language="C#" Class="JH" %>

using System;
using System.Web;
using System.Data.SqlClient;
using System.Data;
using ModelClass;
using Newtonsoft.Json;
using System.Collections.Generic;


public class JH : IHttpHandler {

    string RWID = "";
    string RWName = "";
    string RWNameMX = "";
    string RWBTime = "";
    string RWETime = "";
    string RWETimeSJ = "";
    string RWUser = "";
    string RWDo = "";
    string RWRemark = "";
    
    
    
    public void ProcessRequest (HttpContext context) {
        context.Response.ContentType = "text/plain";
        string type = context.Request.Params["type"];
        RWID = context.Request.Params["RWID"];
        RWName = context.Request.Params["RWName"];
        RWNameMX = context.Request.Params["RWNameMX"];
        RWBTime = context.Request.Params["RWBTime"];
        RWETime = context.Request.Params["RWETime"];
        RWETimeSJ = context.Request.Params["RWETimeSJ"];
        RWUser = context.Request.Params["RWUser"];
        RWDo = context.Request.Params["RWDo"];
        RWRemark = context.Request.Params["RWRemark"];
        
        string rwdid = context.Request.Params["RWID"];
        switch (type)
        {
            case "grid":
                context.Response.Write(showData());
                break;
            default:
                break;
        }
    }

    public string showData()
    {
        string returnStr = "";
        List<jh> rwdGrid = new List<jh>();
        string lStrSQL = "select JH_RWID,JH_RWName,JH_RWNameMX,JH_RWBTime,JH_RWETime,JH_RWETimeSJ,JH_RWUser,JH_RWDo,JH_RWRemark from tJH order by JH_RWDo desc";
        
        DataTable dt = null;
        using (dt = claSqlConnDB.ExecuteDataset(claSqlConnDB.gStrConnDefault, CommandType.Text, lStrSQL).Tables[0])
        {
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                jh jhtmp = new jh();
                jhtmp.JH_RWID =int.Parse(dt.Rows[i][0].ToString());
                jhtmp.JH_RWName = dt.Rows[i][1].ToString();
                jhtmp.JH_RWNameMX = dt.Rows[i][2].ToString();
                jhtmp.JH_RWBTime = dt.Rows[i][3].ToString();
                jhtmp.JH_RWETime = dt.Rows[i][4].ToString();
                jhtmp.JH_RWETimeSJ = dt.Rows[i][5].ToString();
                jhtmp.JH_RWUser = dt.Rows[i][6].ToString();
                jhtmp.JH_RWDo = dt.Rows[i][7].ToString();
                jhtmp.JH_RWRemark = dt.Rows[i][8].ToString();
                rwdGrid.Add(jhtmp);
            }
        }
        return returnStr = JsonConvert.SerializeObject(rwdGrid);

    }
 
    public bool IsReusable {
        get {
            return false;
        }
    }

}