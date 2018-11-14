<%@ WebHandler Language="C#" Class="HistoryDataHandler" %>

using System;
using System.Web;
using ModelClass;
using Newtonsoft.Json;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;

public class HistoryDataHandler : IHttpHandler {

    string type = "";
    string m_StrAllAdress;//全地址
    string m_IntCollectSec;//采集周期 500毫秒、1000、60000、3600000、86400000
    string m_IntCollectType;//采集类型  0 --- 普通   1 --- 报表型   2 --- 临时短周期

    public void ProcessRequest (HttpContext context) {
        context.Response.ContentType = "text/plain";
        //context.Response.Write("Hello World");
        type = context.Request.Params["type"];
        
        m_StrAllAdress = context.Request.Params["alladdress"];
        m_IntCollectSec = context.Request.Params["collectsec"];
        m_IntCollectType = context.Request.Params["collecttype"];

        switch (type)
        {
            //设置点可以历史采集数据
            case "para1":
                context.Response.Write(AddPlcPointConfig());
                break;
            default:
                break;
        }
    }

    public int AddPlcPointConfig()
    {
        int lIntReturn = -1;
        SqlParameter[] _Parameter = new SqlParameter[4]
            {
                new SqlParameter("@viVchAllAdress",SqlDbType.VarChar,100),
                new SqlParameter("@viIntCollectSec",SqlDbType.Int,4),
                new SqlParameter("@viIntCollectType",SqlDbType.Int,4),
                new SqlParameter("@voIntReturn",SqlDbType.Int),
            };
        _Parameter[0].Value = m_StrAllAdress;
        _Parameter[1].Value = m_IntCollectSec;
        _Parameter[2].Value = m_IntCollectType;
        _Parameter[3].Direction = System.Data.ParameterDirection.Output;
        claSqlConnDB.ExecuteNonQuery(claSqlConnDB.gStrConnDefault, CommandType.StoredProcedure, "p_AddPlcPointConfig", _Parameter);
        lIntReturn = (int)_Parameter[3].Value;
        return lIntReturn;
    }
    
    public bool IsReusable {
        get {
            return false;
        }
    }

}