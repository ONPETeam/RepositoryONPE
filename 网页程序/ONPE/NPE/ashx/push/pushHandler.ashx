<%@ WebHandler Language="C#" Class="pushHandler" %>

using System;
using System.Web;

public class pushHandler : IHttpHandler {
    
    public void ProcessRequest (HttpContext context) {
        context.Response.ContentType = "text/plain";
        string action = "";
        string mStrReturn = "";
        if (context.Request.Params["action"] != null)
        {
            action = context.Request.Params["action"].ToString(); 
        }
        switch (action.ToLower())
        {
            case "getresult":
                mStrReturn = GetPushResultDetail(context);
                break; 
        }
        context.Response.Write(mStrReturn);
    }

    private string GetPushResultDetail(HttpContext context)
    {
        string mStrReturn = "";
        string mStrPushID = "";
        if (context.Request.Params["push_id"] != null)
        {
            mStrPushID = context.Request.Params["push_id"].ToString();
        }
        if (mStrPushID == "") return GJHF.Utility.WEBUI.EasyuiControl.GetParamFailRetuen();
        System.Data.DataTable dt = GJHF.Business.PUSH.PushMessage.GetPushResultDetail(mStrPushID);
        mStrReturn = GJHF.Utility.WEBUI.EasyuiControl.GetGridReturn(999, dt);
        return mStrReturn; 
    }
    
    public bool IsReusable {
        get {
            return false;
        }
    }

}