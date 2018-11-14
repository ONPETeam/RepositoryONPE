<%@ WebHandler Language="C#" Class="sysStateHandler" %>

using System;
using System.Web;
using System.Data;

public class sysStateHandler : IHttpHandler {

    private GJHF.Business.SYS.SysState _SysState;

    public sysStateHandler()
    {
        this._SysState = new GJHF.Business.SYS.SysState(); 
    }
    
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
            case "add":
                mStrReturn = AddSysState(context);
                break;
            case "edit":
                mStrReturn = EditSysState(context);
                break; 
            case "setvalue":
                mStrReturn = UpdateValue(context);
                break;
            case "getvalue":
                mStrReturn = GetValue(context);
                break;
            case "del":
                mStrReturn = DelSysState(context);
                break;
            case "grid":
                mStrReturn = GetSysStateGrid(context);
                break;
            default:
                mStrReturn = GJHF.Utility.WEBUI.EasyuiControl.GetMissParamReturn();
                break;
        }
        context.Response.Write(mStrReturn);
    }
    private string AddSysState(HttpContext context)
    {
        string m_add_sys_state_name = "";
        if (context.Request.Params["state_name"] != null)
        {
            m_add_sys_state_name = context.Request.Params["state_name"].ToString(); 
        }
        if (m_add_sys_state_name == "") return GJHF.Utility.WEBUI.EasyuiControl.GetParamFailRetuen();
        string m_add_sys_state_code = "";
        if (context.Request.Params["state_code"] != null)
        {
            m_add_sys_state_code = context.Request.Params["state_code"].ToString();
        }
        if (m_add_sys_state_code == "") return GJHF.Utility.WEBUI.EasyuiControl.GetParamFailRetuen();
        string m_add_sys_state_remark = "";
        if (context.Request.Params["state_remark"] != null)
        {
            m_add_sys_state_remark = context.Request.Params["state_remark"].ToString();
        }
        int mIntReturn = _SysState.AddSysState(m_add_sys_state_name, m_add_sys_state_code, m_add_sys_state_remark);
        return GJHF.Utility.WEBUI.EasyuiControl.GetAddReturn(mIntReturn, 1);
    }
    private string EditSysState(HttpContext context)
    {
        int m_edit_sys_state_id = 0;
        if (context.Request.Params["state_id"] != null)
        {
            if (int.TryParse(context.Request.Params["state_id"], out m_edit_sys_state_id) == false)
            {
                m_edit_sys_state_id = 0; 
            }
        }
        if (m_edit_sys_state_id == 0) return GJHF.Utility.WEBUI.EasyuiControl.GetParamFailRetuen();
        string m_edit_sys_state_name = "";
        if (context.Request.Params["state_name"] != null)
        {
            m_edit_sys_state_name = context.Request.Params["state_name"].ToString();
        }
        if (m_edit_sys_state_name == "") return GJHF.Utility.WEBUI.EasyuiControl.GetParamFailRetuen();
        string m_edit_sys_state_code = "";
        if (context.Request.Params["state_code"] != null)
        {
            m_edit_sys_state_code = context.Request.Params["state_code"].ToString();
        }
        if (m_edit_sys_state_code == "") return GJHF.Utility.WEBUI.EasyuiControl.GetParamFailRetuen();
        string m_edit_sys_state_remark = "";
        if (context.Request.Params["state_remark"] != null)
        {
            m_edit_sys_state_remark = context.Request.Params["state_remark"].ToString();
        }
        int mIntReturn = _SysState.UpdateSysState(m_edit_sys_state_id, m_edit_sys_state_name, m_edit_sys_state_code, m_edit_sys_state_remark);
        return GJHF.Utility.WEBUI.EasyuiControl.GetEditReturn(mIntReturn, 1);
    }
    private string UpdateValue(HttpContext context)
    {
        int m_set_sys_state_id = 0;
        if (context.Request.Params["state_id"] != null)
        {
            if (int.TryParse(context.Request.Params["state_id"], out m_set_sys_state_id) == false)
            {
                m_set_sys_state_id = 0;
            }
        }
        if (m_set_sys_state_id == 0) return GJHF.Utility.WEBUI.EasyuiControl.GetParamFailRetuen();
        int m_set_sys_state_value = -100;
        if (context.Request.Params["state_value"] != null)
        {
            if (int.TryParse(context.Request.Params["state_value"], out m_set_sys_state_value) == false)
            {
                m_set_sys_state_value = -100;
            }
        }
        if (m_set_sys_state_value == -100) return GJHF.Utility.WEBUI.EasyuiControl.GetParamFailRetuen();
        int mIntReturn = _SysState.UpdateSysState(m_set_sys_state_id, m_set_sys_state_value);
        if (mIntReturn == 1)
        {
            return GJHF.Utility.WEBUI.EasyuiControl.GetReturn(true, "设定状态值成功", false);
        }
        else
        {
            return GJHF.Utility.WEBUI.EasyuiControl.GetReturn(true, "设定状态值失败", false);
        }
    }
    private string GetValue(HttpContext context)
    {
        int m_get_sys_state_id = 0;
        if (context.Request.Params["state_id"] != null)
        {
            if (int.TryParse(context.Request.Params["state_id"], out m_get_sys_state_id) == false)
            {
                m_get_sys_state_id = 0;
            }
        }
        if (m_get_sys_state_id == 0) return GJHF.Utility.WEBUI.EasyuiControl.GetParamFailRetuen();
        return _SysState.GetSysStateValue(m_get_sys_state_id).ToString();
    }
    private string DelSysState(HttpContext context)
    {
        int m_del_sys_state_id = 0;
        if (context.Request.Params["state_id"] != null)
        {
            if (int.TryParse(context.Request.Params["state_id"], out m_del_sys_state_id) == false)
            {
                m_del_sys_state_id = 0;
            }
        }
        if (m_del_sys_state_id == 0) return GJHF.Utility.WEBUI.EasyuiControl.GetParamFailRetuen();
        int mIntReturn = _SysState.DelSysState(m_del_sys_state_id);
        return GJHF.Utility.WEBUI.EasyuiControl.GetDelReturn(mIntReturn, 1);
    }
    private string GetSysStateGrid(HttpContext context)
    {
        int m_grid_page = 1;
        if (context.Request.Params["page"] != null)
        {
            if (int.TryParse(context.Request.Params["page"], out m_grid_page) == false)
            {
                m_grid_page = 1;
            }
        }
        int m_grid_rows = 10;
        if (context.Request.Params["rows"] != null)
        {
            if (int.TryParse(context.Request.Params["rows"], out m_grid_rows) == false)
            {
                m_grid_rows = 10;
            }
        }
        string m_grid_sys_state_name = "";
        if (context.Request.Params["state_name"] != null)
        {
            m_grid_sys_state_name = context.Request.Params["state_name"].ToString();
        }
        string m_grid_sys_state_code = "";
        if (context.Request.Params["state_code"] != null)
        {
            m_grid_sys_state_code = context.Request.Params["state_name"].ToString();
        }
        string m_grid_sort = "";
        if (context.Request.Params["sort"] != null)
        {
            m_grid_sort = context.Request.Params["sort"].ToString();
        }
        string m_grid_order = "";
        if (context.Request.Params["order"] != null)
        {
            m_grid_order = context.Request.Params["order"].ToString();
        }
        int mIntCount = _SysState.GetSysStateCount(m_grid_sys_state_name, m_grid_sys_state_code);
        DataTable dt = _SysState.GetSysState(m_grid_page, m_grid_rows, m_grid_sys_state_name, m_grid_sys_state_code, m_grid_sort, m_grid_order);
        return GJHF.Utility.WEBUI.EasyuiControl.GetGridReturn(mIntCount, dt);
    }
    public bool IsReusable {
        get {
            return false;
        }
    }

}