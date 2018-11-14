<%@ WebHandler Language="C#" Class="lqfHandler" %>

using System;
using System.Web;
using ModelClass;
using Newtonsoft.Json;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;

public class lqfHandler : IHttpHandler {
    string type = "";

    List<basePara> lst = new List<basePara>();

    public void ProcessRequest (HttpContext context) {
        context.Response.ContentType = "text/plain";
        type = context.Request.Params["type"];

        switch (type)
        {
            //冷却风系统
            case "para1":
                context.Response.Write(showParaData());
                break;
            //燃烧系统1
            case "para2":
                context.Response.Write(showParaData2());
                break;
            //燃烧系统2
            case "para3":
                context.Response.Write(showParaData3());
                break;
            default:
                break;
        }
    }

    /// <summary>
    /// 冷却风系统mobile参数
    /// </summary>
    /// <returns></returns>
    public string showParaData()
    {
        string returnStr = "";
        List<basePara> Grid = new List<basePara>();

        string lStrSQL = @"SELECT   tZPlcPointDiZhi.dIntDataID, tZPlcPointDiZhi.dVchAdressName, tZPlcPointDiZhi.dIntPointType,tZPLCTimerMobel.dVchValue
                    FROM tZPLCTimerMobel INNER JOIN
                                    tZPlcPointDiZhi ON tZPLCTimerMobel.dIntPLCID = tZPlcPointDiZhi.dIntDataID
                    WHERE (tZPlcPointDiZhi.dIntPointType = 1)";
        System.Data.DataTable dt = null;
        using (dt = claSqlConnDB.ExecuteDataset(claSqlConnDB.gStrConnDefault, System.Data.CommandType.Text, lStrSQL).Tables[0])
        {
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                basePara tmp = new basePara();
                tmp.dIntPointID = Int32.Parse(dt.Rows[i][0].ToString());
                tmp.dVchPointName = dt.Rows[i][1].ToString();
                tmp.dFatPointValue = float.Parse(dt.Rows[i][3].ToString());
                Grid.Add(tmp);
            }
        }
        return returnStr = JsonConvert.SerializeObject(Grid);
    }

    /// <summary>
    /// 燃烧系统1
    /// </summary>
    /// <returns></returns>
    public string showParaData2()
    {
        string returnStr = "";
        List<basePara> Grid = new List<basePara>();

        string lStrSQL = @"SELECT   tZPlcPointDiZhi.dIntDataID, tZPlcPointDiZhi.dVchAdressName, tZPlcPointDiZhi.dIntPointType,tZPLCTimerMobel.dVchValue
                    FROM tZPLCTimerMobel INNER JOIN
                                    tZPlcPointDiZhi ON tZPLCTimerMobel.dIntPLCID = tZPlcPointDiZhi.dIntDataID
                    WHERE (tZPlcPointDiZhi.dIntPointType = 2)";
        System.Data.DataTable dt = null;
        using (dt = claSqlConnDB.ExecuteDataset(claSqlConnDB.gStrConnDefault, System.Data.CommandType.Text, lStrSQL).Tables[0])
        {
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                basePara tmp = new basePara();
                tmp.dIntPointID = Int32.Parse(dt.Rows[i][0].ToString());
                tmp.dVchPointName = dt.Rows[i][1].ToString();
                tmp.dFatPointValue = float.Parse(dt.Rows[i][3].ToString());
                Grid.Add(tmp);
            }
        }
        return returnStr = JsonConvert.SerializeObject(Grid);
    }

    /// <summary>
    /// 燃烧系统2
    /// </summary>
    /// <returns></returns>
    public string showParaData3()
    {
        string returnStr = "";
        List<basePara> Grid = new List<basePara>();

        string lStrSQL = @"SELECT   tZPlcPointDiZhi.dIntDataID, tZPlcPointDiZhi.dVchAdressName, tZPlcPointDiZhi.dIntPointType,tZPLCTimerMobel.dVchValue
                    FROM tZPLCTimerMobel INNER JOIN
                                    tZPlcPointDiZhi ON tZPLCTimerMobel.dIntPLCID = tZPlcPointDiZhi.dIntDataID
                    WHERE (tZPlcPointDiZhi.dIntPointType = 3)";
        System.Data.DataTable dt = null;
        using (dt = claSqlConnDB.ExecuteDataset(claSqlConnDB.gStrConnDefault, System.Data.CommandType.Text, lStrSQL).Tables[0])
        {
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                basePara tmp = new basePara();
                tmp.dIntPointID = Int32.Parse(dt.Rows[i][0].ToString());
                tmp.dVchPointName = dt.Rows[i][1].ToString();
                tmp.dFatPointValue = float.Parse(dt.Rows[i][3].ToString());
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