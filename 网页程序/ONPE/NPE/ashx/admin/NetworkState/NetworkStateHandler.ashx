<%@ WebHandler Language="C#" Class="NetworkStateHandler" %>

using System;
using System.Web;

public class NetworkStateHandler : IHttpHandler {

    private GJHF.Business.SYS.NetworkState _NetworkState;

    public NetworkStateHandler()
    {
        this._NetworkState = new GJHF.Business.SYS.NetworkState(); 
    }
    
    public void ProcessRequest (HttpContext context) {
        context.Response.ContentType = "text/plain";
        string mStrReturn = "";
        string action = "";
        if (context.Request.Params["action"] != null)
        {
            action = context.Request.Params["action"].ToString(); 
        }
        switch (action.ToLower())
        {
            case "get":
                mStrReturn = GetNetworkSet(context);
                break;
            case "set":
                mStrReturn = SaveNetworkSet(context);
                break;
            default:

                break;    
               
        }
        context.Response.Write(mStrReturn);
    }
    private string GetNetworkSet(HttpContext context)
    {
        return _NetworkState.GetNetworkSet();
    }
    private string SaveNetworkSet(HttpContext context)
    {
        int m_alarm_when_disconnect = -1;
        if (context.Request.Params["alarm_when_disconnect"] != null)
        {
            if (int.TryParse(context.Request.Params["alarm_when_disconnect"], out m_alarm_when_disconnect) == false)
            {
                m_alarm_when_disconnect = -1;
            }
        }
        if (m_alarm_when_disconnect == -1) return GJHF.Utility.WEBUI.EasyuiControl.GetParamFailRetuen();
        long m_alarm_time_span = 0;
        {
            if (context.Request.Params["alarm_time_span"] != null)
            {
                if (long.TryParse(context.Request.Params["alarm_time_span"], out m_alarm_time_span) == false)
                {
                    m_alarm_time_span = 0; 
                }
            }
        }
        string m_disconnect_employee_code = "";
        if (m_alarm_when_disconnect == 1)
        {
            if (context.Request.Params["disconnect_employee_code"] != null)
            {
                m_disconnect_employee_code = context.Request.Params["disconnect_employee_code"].ToString();
            }
            if (m_disconnect_employee_code == "") return GJHF.Utility.WEBUI.EasyuiControl.GetParamFailRetuen();
        }
        string m_disconnect_employee_name = "";
        {
            if (context.Request.Params["disconnect_employee_name"] != null)
            {
                m_disconnect_employee_name = context.Request.Params["disconnect_employee_name"].ToString();
            }
        }
        int m_alarm_when_connect = -1;
        if (context.Request.Params["alarm_when_connect"] != null)
        {
            if (int.TryParse(context.Request.Params["alarm_when_connect"], out m_alarm_when_connect) == false)
            {
                m_alarm_when_connect = -1;
            }
        }
        if (m_alarm_when_connect == -1) return GJHF.Utility.WEBUI.EasyuiControl.GetParamFailRetuen();
        string m_connect_employee_code = "";
        if (m_alarm_when_connect == 1)
        {
            if (context.Request.Params["connect_employee_code"] != null)
            {
                m_connect_employee_code = context.Request.Params["connect_employee_code"].ToString();
            }
            if (m_connect_employee_code == "") return GJHF.Utility.WEBUI.EasyuiControl.GetParamFailRetuen();
        }
        string m_connect_employee_name = "";
        {
            if (context.Request.Params["connect_employee_name"] != null)
            {
                m_connect_employee_name = context.Request.Params["connect_employee_name"].ToString();
            }
        }
        int mIntReturn = _NetworkState.SaveNetworkSet(m_alarm_when_disconnect,m_alarm_time_span, m_disconnect_employee_code, m_disconnect_employee_name, m_alarm_when_connect, m_connect_employee_code, m_connect_employee_name);
        if (mIntReturn == 1)
        {
            return GJHF.Utility.WEBUI.EasyuiControl.GetReturn(true, "保存配置成功！", false);
        }
        else
        {
            return GJHF.Utility.WEBUI.EasyuiControl.GetReturn(false, "保存配置失败！", false);
        }
    }
    public bool IsReusable {
        get {
            return false;
        }
    }

}