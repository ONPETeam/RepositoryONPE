<%@ WebHandler Language="C#" Class="ahplciofl" %>

using System;
using System.Web;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using Newtonsoft.Json;
using ModelClass;
using System.Text;
using NPE.UIDataClass;

public class ahplciofl : IHttpHandler {
    
    public void ProcessRequest (HttpContext context) {
        context.Response.ContentType = "text/plain";
        string type = context.Request.Params["type"];
        string mstrResult = "";
        switch (type)
        {
            case "cbox":
                mstrResult = JsonConvert.SerializeObject(GJHF.Business.PLC.BPlcManager.GetComboIOData(""));
                context.Response.Write(mstrResult); 
                break;
        }
        
    }

   
    public bool IsReusable {
        get {
            return false;
        }
    }

}