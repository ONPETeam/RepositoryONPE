<%@ WebHandler Language="C#" Class="IOSSoundHandler" %>

using System;
using System.Web;
using System.Data;

public class IOSSoundHandler : IHttpHandler {
    
    private GJHF.Business.SYS.IOSSound BIOSSound;

    public IOSSoundHandler()
    {
        this.BIOSSound = new GJHF.Business.SYS.IOSSound(); 
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
            case "add":
                mStrReturn = AddIOSSound(context);
                break;
            case "edit":
                mStrReturn = EditIOSSound(context);
                break;
            case "del":
                mStrReturn = DelIOSSound(context);
                break;
            case "grid":
                mStrReturn = GetIOSSoundData(context);
                break;
            case "combo":
                mStrReturn = GetIOSSoundCombo(context);
                break;
            default:
                mStrReturn = GJHF.Utility.WEBUI.EasyuiControl.GetMissParamReturn();
                break;
        }
        context.Response.Write(mStrReturn);
    }

    private string AddIOSSound(HttpContext context)
    {
        string m_add_sound_name = "";
        if (context.Request.Params["sound_name"] != null)
        {
            m_add_sound_name = context.Request.Params["sound_name"].ToString();
        }
        if (m_add_sound_name == "") return GJHF.Utility.WEBUI.EasyuiControl.GetParamFailRetuen();
        string m_add_sound_code = "";
        if (context.Request.Params["sound_code"] != null)
        {
            m_add_sound_code = context.Request.Params["sound_code"].ToString();
        }
        if (m_add_sound_code == "") return GJHF.Utility.WEBUI.EasyuiControl.GetParamFailRetuen();
        string m_add_sound_remark = "";
        if (context.Request.Params["sound_remark"] != null)
        {
            m_add_sound_remark = context.Request.Params["sound_remark"].ToString();
        }
        int mIntReturn = BIOSSound.AddIOSSound(m_add_sound_name, m_add_sound_code, m_add_sound_remark);
        return GJHF.Utility.WEBUI.EasyuiControl.GetAddReturn(mIntReturn, 1);
    }
    private string EditIOSSound(HttpContext context)
    {
        int m_edit_sound_id = 0;
        if (context.Request.Params["sound_id"] != null)
        {
            if (int.TryParse(context.Request.Params["sound_id"], out m_edit_sound_id) == false)
            {
                m_edit_sound_id = 0;
            }
        }
        if (m_edit_sound_id == 0) return GJHF.Utility.WEBUI.EasyuiControl.GetParamFailRetuen();
        string m_edit_sound_name = "";
        if (context.Request.Params["sound_name"] != null)
        {
            m_edit_sound_name = context.Request.Params["sound_name"].ToString(); 
        }
        if (m_edit_sound_name == "") return GJHF.Utility.WEBUI.EasyuiControl.GetParamFailRetuen();
        string m_edit_sound_code = "";
        if (context.Request.Params["sound_code"] != null)
        {
            m_edit_sound_code = context.Request.Params["sound_code"].ToString();
        }
        if (m_edit_sound_code == "") return GJHF.Utility.WEBUI.EasyuiControl.GetParamFailRetuen();
        string m_edit_sound_remark = "";
        if (context.Request.Params["sound_remark"] != null)
        {
            m_edit_sound_remark = context.Request.Params["sound_remark"].ToString(); 
        }
        int mIntReturn = BIOSSound.EditIOSSound(m_edit_sound_id, m_edit_sound_name, m_edit_sound_code, m_edit_sound_remark);
        return GJHF.Utility.WEBUI.EasyuiControl.GetEditReturn(mIntReturn, 1);
    }
    private string DelIOSSound(HttpContext context)
    {
        int m_del_sound_id = 0;
        if (context.Request.Params["sound_id"] != null)
        {
            if (int.TryParse(context.Request.Params["sound_id"], out m_del_sound_id) == false)
            {
                m_del_sound_id = 0;
            }
        }
        if (m_del_sound_id == 0) return GJHF.Utility.WEBUI.EasyuiControl.GetParamFailRetuen();
        int mIntReturn =BIOSSound.DelIOSSound(m_del_sound_id);
        return GJHF.Utility.WEBUI.EasyuiControl.GetDelReturn(mIntReturn, 1);
    }
    private string GetIOSSoundData(HttpContext context)
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
        string m_grid_sound_name = "";
        if (context.Request.Params["sound_name"] != null)
        {
            m_grid_sound_name = context.Request.Params["sound_name"].ToString(); 
        }
        string m_grid_sound_code = "";
        if (context.Request.Params["sound_code"] != null)
        {
            m_grid_sound_code = context.Request.Params["sound_code"].ToString();
        }
        string m_grid_sound_remark = "";
        if (context.Request.Params["sound_remark"] != null)
        {
            m_grid_sound_remark = context.Request.Params["sound_remark"].ToString();
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
        int mIntDataCount = BIOSSound.GetIOSSoundCount(m_grid_sound_name, m_grid_sound_code, m_grid_sound_remark);
        DataTable dt = BIOSSound.GetIOSSoundData(m_grid_page, m_grid_rows, m_grid_sound_name, m_grid_sound_code, m_grid_sound_remark, m_grid_sort, m_grid_order);
        return GJHF.Utility.WEBUI.EasyuiControl.GetGridReturn(mIntDataCount, dt);
    }
    private string GetIOSSoundCombo(HttpContext context)
    {
        DataTable dt = BIOSSound.GetIOSSoundData("", "", "");
        return GJHF.Utility.WEBUI.EasyuiControl.GetComboReturn(dt, "sound_id", "sound_name");
    }
    public bool IsReusable {
        get {
            return false;
        }
    }

}