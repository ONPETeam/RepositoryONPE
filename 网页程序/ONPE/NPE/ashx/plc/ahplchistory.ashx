<%@ WebHandler Language="C#" Class="ahplchistory" %>

using System;
using System.Web;

public class ahplchistory : IHttpHandler {
    public HttpRequest Request
    {
        get
        {
            return HttpContext.Current.Request;
        }
    }
    private HttpResponse Response
    {
        get { return HttpContext.Current.Response; }
    }
    public void ProcessRequest (HttpContext context) {
        string action = "";
        if (Request.Params["action"] != null)
        {
            action = Request.Params["action"];
        }
        switch (action)
        {
            case "GethistoryById" :
                GetHistoryById();
                break;
            case"SaveHistoryData":
                SaveHistoryData();
                break;
            case"CancelHistoryData":
                CancelHistoryData();
                break;
            default:
                break;
                
        }
        //context.Response.ContentType = "text/plain";
        //context.Response.Write("Hello World");
    }
    
    //1.根据id获取详细历史数据配置信息,这个方法暂时没有使用
    private void GetHistoryById()
    {
        int mIntId = -1;
        string mStrResult = "";
        try
        {
            mStrResult = Newtonsoft.Json.JsonConvert.SerializeObject(GJHF.Business.PLC.BPlcHistoryData.GetData(mIntId));
            Response.Write(mStrResult);
        }
        catch (Exception eee)
        {
            Response.Write(eee.ToString());
        }
        
    }
    //2.保存设置详细历史数据配置
    private void SaveHistoryData()
    {
        string mStrAllAdress ="";
        string mStrAdressName = "";
        string mStrAddress = "";
        
        
        int mIntDataType = 0;
        int mIntGongType = 0; 
        int mIntIsCollect = 0;
        int mIntCollectSec = 0;
        int mIntCollectType = 0;
        int mIntCollectIndex =0;

        int mIntMsg = 0;
        string mStrMsg = "";
        
        try
        {
            mStrAllAdress = Request.Params["vlscjdz"];
            mStrAdressName = Request.Params["vlsddzn"];
            mStrAddress = Request.Params["vlsddz"];
            if (int.TryParse(Request.Params["vlsDataType"], out mIntMsg) == true)
            {
                mIntDataType = Int32.Parse(Request.Params["vlsDataType"]);
            }
            if (int.TryParse(Request.Params["vlsType"], out mIntMsg) == true)
            {
                mIntGongType = Int32.Parse(Request.Params["vlsType"]);
            }
            if (int.TryParse(Request.Params["vlsCollect"], out mIntMsg) == true)
            {
                mIntIsCollect = Int32.Parse(Request.Params["vlsCollect"]);
            }
            if (int.TryParse(Request.Params["vlscjzq"], out mIntMsg) == true)
            {
                mIntCollectSec = Int32.Parse(Request.Params["vlscjzq"]);
            }
            if (int.TryParse(Request.Params["vlsid"], out mIntMsg) == true)
            {
                mIntCollectIndex = Int32.Parse(Request.Params["vlsid"]);
            }
            
            bool isSuccess = GJHF.Business.PLC.BPlcHistoryData.AddData(mStrAllAdress, mStrAdressName, mStrAddress, mIntDataType, mIntGongType, mIntIsCollect, mIntCollectSec, mIntCollectType, mIntCollectIndex, out mStrMsg);
            Response.Write(isSuccess.ToString());
        }
        catch (Exception eee)
        {
            Response.Write(eee.ToString());
        }
        
        
    }
    //3.取消历史数据
    private void CancelHistoryData()
    {
        int mIntDataID = -1;
        string mStrMsg ="";
        int mIntMsg = 0;
       
        try
        {
            if (int.TryParse(Request.Params["vlsid"], out mIntMsg) == true)
            {
                mIntDataID = Int32.Parse(Request.Params["vlsid"]);
            }
            if (mIntDataID != -1)
            {
                bool isSuccess = GJHF.Business.PLC.BPlcHistoryData.DelData(mIntDataID, out mStrMsg);
                Response.Write(isSuccess);
            }
            else
            {
                Response.Write(false);
            }
        }
        catch (Exception eee)
        {
            Response.Write(eee.ToString()); 
        }
    }
    public bool IsReusable {
        get {
            return false;
        }
    }

}