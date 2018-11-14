<%@ WebHandler Language="C#" Class="ValueHandler" %>

using System;
using System.Web;
using ModelClass;
using Newtonsoft.Json;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;

public class ValueHandler : IHttpHandler
{
    string type = "";
    string pointId = "";
    List<basePara> lst = new List<basePara>();

    public void ProcessRequest (HttpContext context) {
        context.Response.ContentType = "text/plain";
        type = context.Request.Params["type"];

        pointId = context.Request.Params["pointid"];

        //type=value&pointid = 1
        switch (type)
        {
            case "value":
                context.Response.Write(showParaData());
                break;

            default:
                break;
        }
    }

    /// <summary>
    /// 获取某个参数的值
    /// </summary>
    /// <returns></returns>
    public string showParaData()
    {
        string returnStr = "";
        List<basePara> Grid = new List<basePara>();

        string lStrSQL = @"SELECT dIntPLCID,dDaeGengxinSj,dVchValue
                    FROM tZPLCTimerMobel
                    WHERE (tZPLCTimerMobel.dIntPLCID = " + pointId + ")";
        System.Data.DataTable dt = null;
        using (dt = claSqlConnDB.ExecuteDataset(claSqlConnDB.gStrConnDefault, System.Data.CommandType.Text, lStrSQL).Tables[0])
        {
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                CircleData tmp = new CircleData();
                tmp.dIntPointID = Int32.Parse(dt.Rows[i][0].ToString());
                tmp.dFatPointValue = float.Parse(dt.Rows[i][2].ToString());
                tmp.dDaeGetTime = DateTime.Parse(dt.Rows[i][1].ToString());
                Grid.Add(tmp);
            }
        }
        return returnStr = JsonConvert.SerializeObject(Grid);
    }

  
    public bool IsReusable {
        get {
            return false;
        }
    }

}