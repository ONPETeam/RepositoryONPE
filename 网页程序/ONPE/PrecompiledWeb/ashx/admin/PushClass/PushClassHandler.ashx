<%@ WebHandler Language="C#" Class="PushClassHandler" %>

using System;
using System.Web;

public class PushClassHandler : IHttpHandler {
    private GJHF.Business.SYS.SysPushClass BSysPushClass;
    public PushClassHandler()
    {
        this.BSysPushClass = new GJHF.Business.SYS.SysPushClass(); 
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
                mStrReturn = AddPushClass(context);
                break;
            case "edit":
                mStrReturn = EditPushClass(context);
                break;
            case "del":
                mStrReturn = DelPushClass(context);
                break;
            case "grid":
                mStrReturn = GetPushClass(context);
                break; 
            case "combo":
                mStrReturn = GetPushClassCombo(context);
                break;
            default:
                mStrReturn = GJHF.Utility.WEBUI.EasyuiControl.GetMissParamReturn();
                break;
        }
        context.Response.Write(mStrReturn);
    }
    private string AddPushClass(HttpContext context)
    {
        string m_add_class_name = "";
        if (context.Request.Params["class_name"] != null)
        {
            m_add_class_name = context.Request.Params["class_name"].ToString(); 
        }
        if (m_add_class_name == "") return GJHF.Utility.WEBUI.EasyuiControl.GetParamFailRetuen();
        string m_add_class_remark = "";
        if (context.Request.Params["class_remark"] != null)
        {
            m_add_class_remark = context.Request.Params["class_remark"].ToString(); 
        }
        int m_add_android_buildid = 0;
        if (context.Request.Params["android_buildid"] != null)
        {
            if (int.TryParse(context.Request.Params["android_buildid"], out m_add_android_buildid) == false)
            {
                m_add_android_buildid = 0; 
            } 
        }
        //if (m_add_android_buildid == -1) return GJHF.Utility.WEBUI.EasyuiControl.GetParamFailRetuen();
        int m_add_ios_sound = 0;
        if (context.Request.Params["ios_sound"] != null)
        {
            if (int.TryParse(context.Request.Params["ios_sound"].ToString(), out m_add_ios_sound) == false)
            {
                m_add_ios_sound = 0;
            }
        }
        int mIntReturn = BSysPushClass.AddPushClass(m_add_class_name, m_add_class_remark, m_add_android_buildid, m_add_ios_sound);
        return GJHF.Utility.WEBUI.EasyuiControl.GetAddReturn(mIntReturn, 1);
    }
    private string EditPushClass(HttpContext context)
    {
        string m_edit_class_id = "";
        if (context.Request.Params["class_id"] != null)
        {
            m_edit_class_id = context.Request.Params["class_id"].ToString();
        }
        if (m_edit_class_id == "") return GJHF.Utility.WEBUI.EasyuiControl.GetParamFailRetuen();
        string m_edit_class_name = "";
        if (context.Request.Params["class_name"] != null)
        {
            m_edit_class_name = context.Request.Params["class_name"].ToString();
        }
        if (m_edit_class_name == "") return GJHF.Utility.WEBUI.EasyuiControl.GetParamFailRetuen();
        string m_edit_class_remark = "";
        if (context.Request.Params["class_remark"] != null)
        {
            m_edit_class_remark = context.Request.Params["class_remark"].ToString();
        }
        int m_edit_android_buildid = 0;
        if (context.Request.Params["android_buildid"] != null)
        {
            if (int.TryParse(context.Request.Params["android_buildid"], out m_edit_android_buildid) == false)
            {
                m_edit_android_buildid = 0;
            }
        }
        //if (m_edit_android_buildid == -1) return GJHF.Utility.WEBUI.EasyuiControl.GetParamFailRetuen();
        int m_edit_ios_sound = 0;
        if (context.Request.Params["ios_sound"] != null)
        {
            if (int.TryParse(context.Request.Params["ios_sound"].ToString(), out m_edit_ios_sound) == false)
            {
                m_edit_ios_sound = 0;
            }
        }
        int mIntReturn = BSysPushClass.EditPushClass(m_edit_class_id,m_edit_class_name, m_edit_class_remark, m_edit_android_buildid, m_edit_ios_sound);
        return GJHF.Utility.WEBUI.EasyuiControl.GetEditReturn(mIntReturn, 1);
    }
    private string DelPushClass(HttpContext context)
    {
        string m_del_class_id = "";
        if (context.Request.Params["class_id"] != null)
        {
            m_del_class_id = context.Request.Params["class_id"].ToString();
        }
        if (m_del_class_id == "") return GJHF.Utility.WEBUI.EasyuiControl.GetParamFailRetuen();
        int mIntReturn = BSysPushClass.DelPushClass(m_del_class_id);
        return GJHF.Utility.WEBUI.EasyuiControl.GetDelReturn(mIntReturn, 1);
    }
    private string GetPushClass(HttpContext context)
    {
        int m_grid_page = 1;
        if (context.Request.Params["page"] != null)
        {
            if (int.TryParse(context.Request.Params["page"], out m_grid_page) == false)
            {
                m_grid_page = 1; 
            } 
        }
        int m_grid_rows = 1;
        if (context.Request.Params["rows"] != null)
        {
            if (int.TryParse(context.Request.Params["rows"], out m_grid_rows) == false)
            {
                m_grid_rows = 1;
            }
        }
        string m_grid_class_name = "";
        if (context.Request.Params["class_name"] != null)
        {
            m_grid_class_name = context.Request.Params["class_name"].ToString();
        }
        string m_grid_class_remark = "";
        if (context.Request.Params["class_remark"] != null)
        {
            m_grid_class_remark = context.Request.Params["class_remark"].ToString();
        }
        int m_grid_android_buildid = -1;
        if (context.Request.Params["android_buildid"] != null)
        {
            if (int.TryParse(context.Request.Params["android_buildid"], out m_grid_android_buildid) == false)
            {
                m_grid_android_buildid = -1;
            }
        }
        //if (m_grid_android_buildid == -1) return GJHF.Utility.WEBUI.EasyuiControl.GetParamFailRetuen();
        int m_grid_ios_sound = -1;
        if (context.Request.Params["ios_sound"] != null)
        {
            if (int.TryParse(context.Request.Params["ios_sound"], out m_grid_ios_sound) == false)
            {
                m_grid_ios_sound = -1;
            }
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
        int mIntDataCount = BSysPushClass.GetPushClassCount(m_grid_class_name, m_grid_class_remark, m_grid_android_buildid, m_grid_ios_sound);
        System.Data.DataTable dt = BSysPushClass.GetPushClassData(m_grid_page, m_grid_rows, m_grid_class_name, m_grid_class_remark, m_grid_sort, m_grid_order, m_grid_android_buildid, m_grid_ios_sound);
        return GJHF.Utility.WEBUI.EasyuiControl.GetGridReturn(mIntDataCount, dt);
    }
    private string GetPushClassCombo(HttpContext context)
    {
        System.Data.DataTable dt = BSysPushClass.GetPushClassData("", "");
        return GJHF.Utility.WEBUI.EasyuiControl.GetComboReturn(dt, "class_id", "class_name");
    }
    public bool IsReusable {
        get {
            return false;
        }
    }

}