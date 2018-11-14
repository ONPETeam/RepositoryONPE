<%@ WebHandler Language="C#" Class="TSDQueryHandler" %>

using System;
using System.Web;

public class TSDQueryHandler : IHttpHandler {

    private GJHF.Business.TSD.TSDQuery mTSDQuery;

    public TSDQueryHandler()
    {
        this.mTSDQuery = new GJHF.Business.TSD.TSDQuery(); 
    }
    
    public void ProcessRequest (HttpContext context) {
        string mStrReturn = "";
        context.Response.ContentType = "text/plain";
        string action = "";
        if (context.Request.Params["action"] != null)
        {
            action = context.Request.Params["action"].ToString(); 
        }
        switch (action.ToLower())
        {
            case "poweroffdata":
                mStrReturn = GetPowerOffData(context);
                break;
            case "powerondata":
                mStrReturn = GetPowerOnData(context);
                break;
            case "examinedata":
                mStrReturn = GetExamineData(context);
                break;
            case "flowdata":
                mStrReturn = GetFlowData(context);
                break;
            case "flowdetail":
                mStrReturn = GetFlowDetail(context);
                break;
            case "poweroffdetail":
                mStrReturn = GetPowerOffDetailByID(context);
                break;
            default:
                mStrReturn = GJHF.Utility.WEBUI.EasyuiControl.GetMissParamReturn();
                break;
        }
        context.Response.Write(mStrReturn);
    }
    public string GetPowerOffData(HttpContext context)
    {
        int m_page=1;
        if(context.Request.Params["page"]!=null)
        {
            if(int.TryParse(context.Request.Params["page"],out m_page)==false)
            {
                m_page=1;
            }
        }
        int m_rows=10;
        if(context.Request.Params["rows"]!=null)
        {
            if(int.TryParse(context.Request.Params["rows"],out m_rows)==false)
            {
                m_rows=10;
            }
        }
        int m_request_status = -1;
        if (context.Request.Params["request_status"] != null)
        {
            if (int.TryParse(context.Request.Params["request_status"], out m_request_status) == false)
            {
                m_request_status = -1; 
            } 
        }
        int m_request_company = 0;
        if (context.Request.Params["request_company"] != null)
        {
            if (int.TryParse(context.Request.Params["request_company"], out m_request_company) == false)
            {
                m_request_company = 0;
            }
        }
        int m_request_branch = 0;
        if (context.Request.Params["request_branch"] != null)
        {
            if (int.TryParse(context.Request.Params["request_branch"], out m_request_branch) == false)
            {
                m_request_branch = 0;
            }
        }
        string m_request_people = "";
        if (context.Request.Params["request_people"] != null)
        {
            m_request_people = context.Request.Params["request_people"].ToString(); 
        }
        DateTime m_request_start = DateTime.Parse("1900-01-01 00:00");
        if (context.Request.Params["request_start"] != null)
        {
            if (DateTime.TryParse(context.Request.Params["request_start"], out m_request_start) == false)
            {
                m_request_start = DateTime.Parse("1900-01-01 00:00");
            }
        }
        DateTime m_request_end = DateTime.Parse("1900-01-01 00:00");
        if (context.Request.Params["request_end"] != null)
        {
            if (DateTime.TryParse(context.Request.Params["request_end"], out m_request_end) == false)
            {
                m_request_end = DateTime.Parse("1900-01-01 00:00");
            }
        }
        string m_stop_equip = "";
        if (context.Request.Params["stop_equip"] != null)
        {
            m_stop_equip = context.Request.Params["stop_equip"].ToString(); 
        }
        DateTime m_stop_start = DateTime.Parse("1900-01-01 00:00");
        if (context.Request.Params["stop_start"] != null)
        {
            if (DateTime.TryParse(context.Request.Params["stop_start"], out m_stop_start) == false)
            {
                m_stop_start = DateTime.Parse("1900-01-01 00:00");
            }
        }
        DateTime m_stop_end = DateTime.Parse("1900-01-01 00:00");
        if (context.Request.Params["stop_end"] != null)
        {
            if (DateTime.TryParse(context.Request.Params["stop_end"], out m_stop_end) == false)
            {
                m_stop_end = DateTime.Parse("1900-01-01 00:00");
            }
        }
        float m_stop_duration = 0;
        if (context.Request.Params["stop_duration"] != null)
        {
            if (float.TryParse(context.Request.Params["stop_duration"], out m_stop_duration) == false)
            {
                m_stop_duration = 0; 
            } 
        }
        string m_sort="";
        if (context.Request.Params["sort"] != null)
        {
            m_sort = context.Request.Params["sort"].ToString(); 
        }
        string m_order="";
        if (context.Request.Params["order"] != null)
        {
            m_order = context.Request.Params["order"].ToString(); 
        }
        return GJHF.Utility.WEBUI.EasyuiControl.GetGridReturn(mTSDQuery.GetPowerOffRequestCount(m_request_status, m_request_company, m_request_branch, m_request_people, m_request_start, m_request_end, m_stop_equip, m_stop_start, m_stop_end, m_stop_duration),
            mTSDQuery.GetPowerOffRequest(m_page, m_rows, m_request_status, m_request_company, m_request_branch, m_request_people, m_request_start, m_request_end, m_stop_equip, m_stop_start, m_stop_end, m_stop_duration, m_sort, m_order));
    }
    public string GetPowerOnData(HttpContext context)
    {
        int m_page = 1;
        if (context.Request.Params["page"] != null)
        {
            if (int.TryParse(context.Request.Params["page"], out m_page) == false)
            {
                m_page = 1;
            }
        }
        int m_rows = 10;
        if (context.Request.Params["rows"] != null)
        {
            if (int.TryParse(context.Request.Params["rows"], out m_rows) == false)
            {
                m_rows = 10;
            }
        }
        int m_request_status = -1;
        if (context.Request.Params["request_status"] != null)
        {
            if (int.TryParse(context.Request.Params["request_status"], out m_request_status) == false)
            {
                m_request_status = -1; 
            } 
        }
        int m_request_company = 0;
        if (context.Request.Params["request_company"] != null)
        {
            if (int.TryParse(context.Request.Params["request_company"], out m_request_company) == false)
            {
                m_request_company = 0;
            }
        }
        int m_request_branch = 0;
        if (context.Request.Params["request_branch"] != null)
        {
            if (int.TryParse(context.Request.Params["request_branch"], out m_request_branch) == false)
            {
                m_request_branch = 0;
            }
        }
        string m_request_people = "";
        if (context.Request.Params["request_people"] != null)
        {
            m_request_people = context.Request.Params["request_people"].ToString();
        }
        DateTime m_request_start = DateTime.Parse("1900-01-01 00:00");
        if (context.Request.Params["request_start"] != null)
        {
            if (DateTime.TryParse(context.Request.Params["request_start"], out m_request_start) == false)
            {
                m_request_start = DateTime.Parse("1900-01-01 00:00");
            }
        }
        DateTime m_request_end = DateTime.Parse("1900-01-01 00:00");
        if (context.Request.Params["request_end"] != null)
        {
            if (DateTime.TryParse(context.Request.Params["request_end"], out m_request_end) == false)
            {
                m_request_end = DateTime.Parse("1900-01-01 00:00");
            }
        }
        DateTime m_poweron_start = DateTime.Parse("1900-01-01 00:00");
        if (context.Request.Params["poweron_start"] != null)
        {
            if (DateTime.TryParse(context.Request.Params["poweron_start"], out m_poweron_start) == false)
            {
                m_poweron_start = DateTime.Parse("1900-01-01 00:00");
            }
        }
        DateTime m_poweron_end = DateTime.Parse("1900-01-01 00:00");
        if (context.Request.Params["poweron_end"] != null)
        {
            if (DateTime.TryParse(context.Request.Params["poweron_end"], out m_poweron_end) == false)
            {
                m_poweron_end = DateTime.Parse("1900-01-01 00:00");
            }
        }
        string m_sort = "";
        if (context.Request.Params["sort"] != null)
        {
            m_sort = context.Request.Params["sort"].ToString();
        }
        string m_order = "";
        if (context.Request.Params["order"] != null)
        {
            m_order = context.Request.Params["order"].ToString();
        }
        return GJHF.Utility.WEBUI.EasyuiControl.GetGridReturn(mTSDQuery.GetPowerOnRequestCount(m_request_status, m_request_company, m_request_branch, m_request_people, m_request_start, m_request_end, "", m_poweron_start, m_poweron_end),
            mTSDQuery.GetPowerOnRequest(m_page, m_rows, m_request_status, m_request_company, m_request_branch, m_request_people, m_request_start, m_request_end, "", m_poweron_start, m_poweron_end, m_sort, m_order));
    }
    public string GetExamineData(HttpContext context)
    {
        int m_page = 1;
        if (context.Request.Params["page"] != null)
        {
            if (int.TryParse(context.Request.Params["page"], out m_page) == false)
            {
                m_page = 1;
            }
        }
        int m_rows = 10;
        if (context.Request.Params["rows"] != null)
        {
            if (int.TryParse(context.Request.Params["rows"], out m_rows) == false)
            {
                m_rows = 10;
            }
        }
        int m_request_type = -1;
        if (context.Request.Params["request_type"] != null)
        {
            if (int.TryParse(context.Request.Params["request_type"], out m_request_type) == false)
            {
                m_request_type = -1; 
            } 
        }
        //if (m_request_type == -1) return GJHF.Utility.WEBUI.EasyuiControl.GetGridReturn(0,null);
        DateTime m_examine_start = DateTime.Parse("1900-01-01 00:00");
        if (context.Request.Params["examine_start"] != null)
        {
            if(DateTime.TryParse(context.Request.Params["examine_start"],out m_examine_start)==false)
            {
                m_examine_start = DateTime.Parse("1900-01-01 00:00");
            }
        }
        DateTime m_examine_end = DateTime.Parse("1900-01-01 00:00");
        if (context.Request.Params["examine_end"] != null)
        {
            if (DateTime.TryParse(context.Request.Params["examine_end"], out m_examine_end) == false)
            {
                m_examine_end = DateTime.Parse("1900-01-01 00:00");
            }
        }
        string m_examine_people = "";
        if (context.Request.Params["examine_people"] != null)
        {
            m_examine_people = context.Request.Params["examine_people"].ToString(); 
        }
        string m_equip_code = "";
        if (context.Request.Params["equip_code"] != null)
        {
            m_equip_code = context.Request.Params["equip_code"].ToString();
        }
        int m_examine_result = -1;
        if (context.Request.Params["examine_result"] != null)
        {
            if (int.TryParse(context.Request.Params["examine_result"], out m_examine_result) == false)
            {
                m_examine_result = -1;
            }
        }
        string m_examine_remark = "";
        if (context.Request.Params["examine_remark"] != null)
        {
            m_examine_remark = context.Request.Params["examine_remark"].ToString();
        }
        string m_sort = "";
        if (context.Request.Params["sort"] != null)
        {
            m_sort = context.Request.Params["sort"].ToString();
        }
        string m_order = "";
        if (context.Request.Params["order"] != null)
        {
            m_order = context.Request.Params["order"].ToString();
        }
        return GJHF.Utility.WEBUI.EasyuiControl.GetGridReturn(mTSDQuery.GetExamineCount(m_request_type, m_examine_start, m_examine_end, m_examine_people, m_equip_code, m_examine_result, m_examine_remark),
            mTSDQuery.GetExamineData(m_page, m_rows, m_request_type, m_examine_start, m_examine_end, m_examine_people, m_equip_code, m_examine_result, m_examine_remark, m_sort, m_order));
    }
    public string GetFlowData(HttpContext context)
    {
        int m_page = 1;
        if (context.Request.Params["page"] != null)
        {
            if (int.TryParse(context.Request.Params["page"], out m_page) == false)
            {
                m_page = 1;
            }
        }
        int m_rows = 10;
        if (context.Request.Params["rows"] != null)
        {
            if (int.TryParse(context.Request.Params["rows"], out m_rows) == false)
            {
                m_rows = 10;
            }
        }
        string m_equip_code = "";
        if (context.Request.Params["equip_code"] != null)
        {
            m_equip_code = context.Request.Params["equip_code"].ToString(); 
        }
        int m_flow_status = -1;
        if (context.Request.Params["flow_status"] != null)
        {
            if (int.TryParse(context.Request.Params["flow_status"], out m_flow_status) == false)
            {
                m_flow_status = -1; 
            } 
        }
        int m_poweroff_branch = 0;
        if (context.Request.Params["poweroff_branch"] != null)
        {
            if (int.TryParse(context.Request.Params["poweroff_branch"], out m_poweroff_branch) == false)
            {
                m_poweroff_branch = 0; 
            }
        }
        string m_poweroff_employee = "";
        if (context.Request.Params["poweroff_employee"] != null)
        {
            m_poweroff_employee = context.Request.Params["poweroff_employee"].ToString();
        }
        DateTime m_poweroff_start = DateTime.Parse("1900-01-01 00:00");
        if (context.Request.Params["poweroff_start"] != null)
        {
            if (DateTime.TryParse(context.Request.Params["poweroff_start"], out m_poweroff_start) == false)
            {
                m_poweroff_start = DateTime.Parse("1900-01-01 00:00");
            }
        }
        DateTime m_poweroff_end = DateTime.Parse("1900-01-01 00:00");
        if (context.Request.Params["poweroff_end"] != null)
        {
            if (DateTime.TryParse(context.Request.Params["poweroff_end"], out m_poweroff_end) == false)
            {
                m_poweroff_end = DateTime.Parse("1900-01-01 00:00");
            }
        }
        int m_poweron_branch = 0;
        if (context.Request.Params["poweron_branch"] != null)
        {
            if (int.TryParse(context.Request.Params["poweron_branch"], out m_poweron_branch) == false)
            {
                m_poweron_branch = 0;
            }
        }
        string m_poweron_employee = "";
        if (context.Request.Params["poweron_employee"] != null)
        {
            m_poweron_employee = context.Request.Params["poweron_employee"].ToString();
        }
        DateTime m_poweron_start = DateTime.Parse("1900-01-01 00:00");
        if (context.Request.Params["poweron_start"] != null)
        {
            if (DateTime.TryParse(context.Request.Params["poweron_start"], out m_poweron_start) == false)
            {
                m_poweron_start = DateTime.Parse("1900-01-01 00:00");
            }
        }
        DateTime m_poweron_end = DateTime.Parse("1900-01-01 00:00");
        if (context.Request.Params["poweron_end"] != null)
        {
            if (DateTime.TryParse(context.Request.Params["poweron_end"], out m_poweron_end) == false)
            {
                m_poweron_end = DateTime.Parse("1900-01-01 00:00");
            }
        }
        float m_timespan_min = -1;
        if (context.Request.Params["timespan_min"] != null)
        {
            if (float.TryParse(context.Request.Params["timespan_min"], out m_timespan_min) == false)
            {
                m_timespan_min = -1;
            }
        }
        float m_timespan_max = -1;
        if (context.Request.Params["timespan_max"] != null)
        {
            if (float.TryParse(context.Request.Params["timespan_max"], out m_timespan_max) == false)
            {
                m_timespan_max = -1;
            }
        }
        string m_sort = "";
        if (context.Request.Params["sort"] != null)
        {
            m_sort = context.Request.Params["sort"].ToString();
        }
        string m_order = "";
        if (context.Request.Params["order"] != null)
        {
            m_order = context.Request.Params["order"].ToString();
        }
        return GJHF.Utility.WEBUI.EasyuiControl.GetGridReturn(mTSDQuery.GetTSDFlowCount(m_equip_code, m_flow_status, m_poweroff_branch, m_poweroff_employee, m_poweroff_start, m_poweroff_end, m_poweron_branch, m_poweron_employee, m_poweron_start, m_poweron_end, m_timespan_min, m_timespan_max),
            mTSDQuery.GetTSDFlowData(m_page, m_rows, m_equip_code, m_flow_status, m_poweroff_branch, m_poweroff_employee, m_poweroff_start, m_poweroff_end, m_poweron_branch, m_poweron_employee, m_poweron_start, m_poweron_end, m_timespan_min, m_timespan_max, m_sort, m_order));
    }
    public string GetFlowDetail(HttpContext context)
    {
        int m_page = 1;
        if (context.Request.Params["page"] != null)
        {
            if (int.TryParse(context.Request.Params["page"], out m_page) == false)
            {
                m_page = 1;
            }
        }
        int m_rows = 10;
        if (context.Request.Params["rows"] != null)
        {
            if (int.TryParse(context.Request.Params["rows"], out m_rows) == false)
            {
                m_rows = 10;
            }
        }
        string m_flow_id = "";
        if (context.Request.Params["flow_id"] != null)
        {
            m_flow_id = context.Request.Params["flow_id"].ToString();
        }
        if (m_flow_id == "") return GJHF.Utility.WEBUI.EasyuiControl.GetParamFailRetuen();
        string m_sort = "";
        if (context.Request.Params["sort"] != null)
        {
            m_sort = context.Request.Params["sort"].ToString();
        }
        string m_order = "";
        if (context.Request.Params["order"] != null)
        {
            m_order = context.Request.Params["order"].ToString();
        }
        return GJHF.Utility.WEBUI.EasyuiControl.GetGridReturn(mTSDQuery.GetTSDFlowDetailCount(m_flow_id), mTSDQuery.GetTSDFlowDetail(m_page, m_rows, m_flow_id, m_sort, m_order));
    }

    private string GetPowerOffDetailByID(HttpContext context)
    {
        string m_poweroff_id = "";
        if (context.Request.Params["poweroff_id"] != null)
        {
            m_poweroff_id = context.Request.Params["poweroff_id"].ToString();
        }
        if (m_poweroff_id == "") return GJHF.Utility.WEBUI.EasyuiControl.GetParamFailRetuen();
        return GJHF.Utility.WEBUI.EasyuiControl.GetPropReturn(mTSDQuery.GetPowerOffDetailByID(m_poweroff_id));
    }
    
    public bool IsReusable {
        get {
            return false;
        }
    }

}