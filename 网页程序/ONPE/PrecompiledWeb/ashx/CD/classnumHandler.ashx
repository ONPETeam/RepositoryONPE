<%@ WebHandler Language="C#" Class="classnumHandler" %>

using System;
using System.Web;

public class classnumHandler : IHttpHandler {

    string branch_id = "";
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
        switch (action)
        { 
            case "combo":
                
                break;
            default:
                
                break;
        }
    }

   
    public bool IsReusable {
        get {
            return false;
        }
    }

}