<%@ WebHandler Language="C#" Class="ahLsReport" %>

using System;
using System.Web;
using System.Data;
using System.Data.SqlClient;

public class ahLsReport : IHttpHandler {
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
        //context.Response.ContentType = "text/plain";
        //context.Response.Write("Hello World");
        string action = "";
        if (Request.Params["action"] != null)
        {
            action = Request.Params["action"];
        }
        switch (action)
        {
                //显示历史统计数据
            case "GetLsTotalData":
                GetLsTotalData();
                break;
                //添加历史统计数据
            case "AddLsTotalData":
                AddLsTotalData();
                break;
                //编辑历史统计数据
            case "EditLsTotalData":
                EditLsTotalData();
                break;
                //删除历史统计数据
            case"DelLsTotalData":
                DelLsTotalData();
                break;
                //点地址grid下拉框 
            case"GetDdzCombogrid":
                GetDdzCombogrid();
                break;
            case"ChangeState":
                ChangeState();
                break;
            case "GetJsLsTotalData":
                GetJsLsTotalData();
                break;
            case "GetDdzCombogrid_Js":
                GetDdzCombogrid_Js();
                break;
            case"AddJsLsTotalData":
                AddJsLsTotalData();
                break;
            case"EditJsLsTotalData":
                EditJsLsTotalData();
                break;
            case"DelJsLsTotalData":
                DelJsLsTotalData();
                break;
                
            default:
                break;

        }
    }
    
    private void GetLsTotalData()
    {
        string mStrResult = "";
        DataTable dt = null;
        int rows = 10;
        int pages = 1;
        string mStrUser = "";
        int outmsg = -1;
            
        try
        {
            if (int.TryParse(Request.Params["rows"], out outmsg))
            {
                rows = Int32.Parse(Request.Params["rows"]);
            }
            if (int.TryParse(Request.Params["page"], out outmsg))
            {
                pages = Int32.Parse(Request.Params["page"]);
            }
            mStrUser = Request.Params["p_User"];
            dt = GJHF.Business.PLC.BPlcLsReport.GetData(rows, pages, mStrUser);

            mStrResult = GJHF.Utility.WEBUI.EasyuiControl.GetGridReturn(dt.Rows.Count, dt);
            //var result = new { total = dt.Rows.Count, rows = Newtonsoft.Json.JsonConvert.SerializeObject(dt) };
            Response.Write(mStrResult);
        }
        catch (Exception eee)
        {
            Response.Write(eee.ToString());
        }
    }

    private void AddLsTotalData()
    {
        int mIntCjdzId = -1;
        string mStrStartTime ="";
        string mStrEndTime="";
        string mStrName = "";
        string mStrAddress = "";
        string mStrCjdz = "";
        int mIntalgorithm = 0;
        string mStrValue = "";
        string mStrUser = "";
        int mIntRead = 0;
        
        bool isSuccess = false;
        string outStrMsg = "";

        
        try
        {
            mStrStartTime = Request.Params["nstarttime"];
            mStrEndTime = Request.Params["nendtime"];
            mStrName = Request.Params["nName"];
            mStrAddress = Request.Params["p_Address"];
            mStrCjdz = Request.Params["p_Cjdz"];
            if (!string.IsNullOrEmpty(Request.Params["nleiji"]))
            {
                mIntalgorithm = Int32.Parse(Request.Params["nleiji"]);
            }
            if (!string.IsNullOrEmpty(Request.Params["p_CjdzId"]))
            {
                mIntCjdzId = Int32.Parse(Request.Params["p_CjdzId"]);
            }
            //mStrValue = Request.Params["p_Value"];
            mStrUser = Request.Params["p_User"];
            isSuccess = GJHF.Business.PLC.BPlcLsReport.AddData(mStrStartTime, mStrEndTime, mStrName, mIntCjdzId,mStrAddress, mStrCjdz, mIntalgorithm, mStrValue, mStrUser, mIntRead, out outStrMsg);
    
           Response.Write(isSuccess.ToString()); 
            
        }
        catch (Exception eee)
        {
            Response.Write(eee.ToString());
        }
    }

    private void EditLsTotalData()
    {
        int mIntDataID = -1;
        int mIntCjdzId =-1;
        string mStrStartTime = "";
        string mStrEndTime = "";
        string mStrName = "";
        string mStrAddress = "";
        string mStrCjdz = "";
        int mIntalgorithm = 0;
        string mStrValue = "";
        string mStrUser = "";
        int mIntRead = 0;
        bool isSuccess = false;
        string outStrMsg = "";

        try
        {
            string aa = Request.Params["p_Dataid"];
            if (!string.IsNullOrEmpty(Request.Params["p_Dataid"].ToString()))
            {
                mIntDataID = Int32.Parse(Request.Params["p_Dataid"].ToString());
            }
            mStrStartTime = Request.Params["nstarttime"];
            mStrEndTime = Request.Params["nendtime"];
            mStrName = Request.Params["nName"];
            mStrAddress = Request.Params["p_Address"];
            mStrCjdz = Request.Params["p_Cjdz"];
            if (!string.IsNullOrEmpty(Request.Params["nleiji"].ToString()))
            {
                mIntalgorithm = Int32.Parse(Request.Params["nleiji"].ToString());
            }
            if (!string.IsNullOrEmpty(Request.Params["p_CjdzId"]))
            {
                mIntCjdzId = Int32.Parse(Request.Params["p_CjdzId"]);
            }
            mStrValue = Request.Params["p_Value"];
            mStrUser = Request.Params["p_User"];
            isSuccess = GJHF.Business.PLC.BPlcLsReport.EditData(mIntDataID,mStrStartTime, mStrEndTime, mStrName, mIntCjdzId,mStrAddress, mStrCjdz, mIntalgorithm, mStrValue, mStrUser, mIntRead, out outStrMsg);
            Response.Write(isSuccess.ToString());
        }
        catch (Exception eee)
        {
            Response.Write(eee.ToString());
        }
    }

    private void DelLsTotalData()
    {
        int mIntDataID = -1;
        bool isSuccess = false;
        string outStrMsg = "";

        try
        {
            
            if (!string.IsNullOrEmpty(Request.Params["p_Dataid"].ToString()))
            {
                mIntDataID = Int32.Parse(Request.Params["p_Dataid"].ToString());
            }
            isSuccess = GJHF.Business.PLC.BPlcLsReport.DelData(mIntDataID, out outStrMsg);
            Response.Write(isSuccess.ToString());
        }
        catch (Exception eee)
        {
            Response.Write(eee.ToString()); 
        }
    }
    
    private void GetDdzCombogrid()
    {
        string mStrResult = "";
        mStrResult = Newtonsoft.Json.JsonConvert.SerializeObject(GJHF.Business.PLC.BPlcLsReport.GetCombogrid(""));
        Response.Write(mStrResult);
    }

    private void ChangeState()
    {
        string str_outMsg = "";
        int mIntState = 0;
        int mIntOut = -1;

        if (int.TryParse(Request.Params["vIntState"].ToString(), out mIntOut))
        {
            mIntState = Int32.Parse(Request.Params["vIntState"].ToString());
        }
        
        bool isSuccess = GJHF.Business.PLC.BPlcLsReport.ChangeReadBiaoshi(1, out str_outMsg);
        Response.Write(isSuccess.ToString());
    }

    private void GetJsLsTotalData()
    {
        string mStrResult = "";
        DataTable dt = null;
        int rows = 10;
        int pages = 1;
        string mStrUser = "";
        int outmsg = -1;

        try
        {
            if (int.TryParse(Request.Params["rows"], out outmsg))
            {
                rows = Int32.Parse(Request.Params["rows"]);
            }
            if (int.TryParse(Request.Params["page"], out outmsg))
            {
                pages = Int32.Parse(Request.Params["page"]);
            }
            mStrUser = Request.Params["p_User"];
            dt = GJHF.Business.PLC.BPlcJsLsReport.GetData(rows, pages, mStrUser);

            mStrResult = GJHF.Utility.WEBUI.EasyuiControl.GetGridReturn(dt.Rows.Count, dt);
            //var result = new { total = dt.Rows.Count, rows = Newtonsoft.Json.JsonConvert.SerializeObject(dt) };
            Response.Write(mStrResult);
        }
        catch (Exception eee)
        {
            Response.Write(eee.ToString());
        }

    }
    private void AddJsLsTotalData()
    {
        string mStrName = "";
        int mIntHistoryReport_A =-1;
        string mStrHistoryReport_A = "a";
        string mStrHistoryReport_A_Value = "";
        int mIntHistoryReport_B =-1;
        string mStrHistoryReport_B = "b";
        string mStrHistoryReport_B_Value = "";
        int mIntHistoryReport_C=-1;
        string mStrHistoryReport_C = "c";
        string mStrHistoryReport_C_Value = "";
        string mStrFormula ="";
        string mStrValue = "";
        string mStrUser = "";
        int mIntRead = 0;
        bool isSuccess = false;
        string outStrMsg = "";
        
        try
        {
            mStrName = Request.Params["vjsname"].ToString();
            mIntHistoryReport_A = Convert.ToInt32(Request.Params["vjsA"]);
            mIntHistoryReport_B = Convert.ToInt32(Request.Params["vjsB"]);
            mIntHistoryReport_C = Convert.ToInt32(Request.Params["vjsC"]);
            mStrFormula = Request.Params["vformula"].ToString();
            
            //mStrUser = Request.Params["p_User"];
            isSuccess = GJHF.Business.PLC.BPlcJsLsReport.AddData(mStrName,mIntHistoryReport_A, mStrHistoryReport_A, mStrHistoryReport_A_Value, mIntHistoryReport_B, mStrHistoryReport_B, mStrHistoryReport_B_Value, mIntHistoryReport_C, mStrHistoryReport_C, mStrHistoryReport_C_Value, mStrFormula, mStrValue, mStrUser, mIntRead, out outStrMsg);
            Response.Write(isSuccess.ToString());
        }
        catch (Exception eee)
        {
            Response.Write(eee.ToString());
        }
    }

    private void EditJsLsTotalData()
    {
        int mIntDataID = -1;
        string mStrName = "";
        int mIntHistoryReport_A = -1;
        string mStrHistoryReport_A = "a";
        string mStrHistoryReport_A_Value = "";
        int mIntHistoryReport_B = -1;
        string mStrHistoryReport_B = "b";
        string mStrHistoryReport_B_Value = "";
        int mIntHistoryReport_C = -1;
        string mStrHistoryReport_C = "c";
        string mStrHistoryReport_C_Value = "";
        string mStrFormula = "";
        string mStrValue = "";
        string mStrUser = "";

        int mIntRead = 0;
        bool isSuccess = false;
        string outStrMsg = "";

        try
        {
            mIntDataID = Convert.ToInt32(Request.Params["vdataid"]);
            mStrName = Request.Params["vjsname"].ToString();
            mIntHistoryReport_A = Convert.ToInt32(Request.Params["vjsA"]);
            mIntHistoryReport_B = Convert.ToInt32(Request.Params["vjsB"]);
            mIntHistoryReport_C = Convert.ToInt32(Request.Params["vjsC"]);
            mStrFormula = Request.Params["vformula"].ToString();
            isSuccess = GJHF.Business.PLC.BPlcJsLsReport.EditData(mIntDataID, mStrName,mIntHistoryReport_A, mStrHistoryReport_A, mStrHistoryReport_A_Value, mIntHistoryReport_B, mStrHistoryReport_B, mStrHistoryReport_B_Value, mIntHistoryReport_C, mStrHistoryReport_C, mStrHistoryReport_C_Value, mStrFormula, mStrValue, mStrUser, mIntRead, out outStrMsg);
            Response.Write(isSuccess.ToString());
        }
        catch (Exception eee)
        {
            Response.Write(eee.ToString());
        }
    }

    private void DelJsLsTotalData()
    {
        int mIntDataID = -1;
        bool isSuccess = false;
        string outStrMsg = "";

        try
        {

            if (!string.IsNullOrEmpty(Request.Params["vdataid"].ToString()))
            {
                mIntDataID = Int32.Parse(Request.Params["vdataid"].ToString());
            }
            isSuccess = GJHF.Business.PLC.BPlcJsLsReport.DelData(mIntDataID, out outStrMsg);
            Response.Write(isSuccess.ToString());
        }
        catch (Exception eee)
        {
            Response.Write(eee.ToString());
        }
    }

    private void GetDdzCombogrid_Js()
    {
        string mStrResult = "";
        mStrResult = Newtonsoft.Json.JsonConvert.SerializeObject(GJHF.Business.PLC.BPlcJsLsReport.GetCombogrid(""));
        Response.Write(mStrResult);
    }

    
    public bool IsReusable {
        get {
            return false;
        }
    }

}