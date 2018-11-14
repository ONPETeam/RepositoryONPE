<%@ WebHandler Language="C#" Class="SeqValueHandler" %>

using System;
using System.Web;
using System.Collections.Generic;
using System.Data.SqlClient;

public class SeqValueHandler : IHttpHandler {

    string type = "";
    public void ProcessRequest (HttpContext context) {
        context.Response.ContentType = "text/plain";
        type = context.Request.Params["type"];
        switch (type)
        {
            case "gp":
                context.Response.Write(getSeqValue());
                break;

            default:
                break;
        }
    }
 
    
    private string getSeqValue()
    {
        string lRwgdNum = common.GetRwdNum(common.SeqType.PCRWGP.ToString());
        return lRwgdNum;
    }
    
    public bool IsReusable {
        get {
            return false;
        }
    }

}