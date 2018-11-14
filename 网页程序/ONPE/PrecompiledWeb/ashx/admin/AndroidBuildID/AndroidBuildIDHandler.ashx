<%@ WebHandler Language="C#" Class="AndroidBuildIDHandler" %>

using System;
using System.Web;
using System.Data;

public class AndroidBuildIDHandler : IHttpHandler {

    private GJHF.Business.SYS.AndroidBuildID BAndroidBuildID;

    public AndroidBuildIDHandler()
    {
        this.BAndroidBuildID = new GJHF.Business.SYS.AndroidBuildID(); 
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
                mStrReturn = AddAndroidBuildID(context);
                break;
            case "edit":
                mStrReturn = EditAndroidBuildID(context);
                break;
            case "del":
                mStrReturn = DelAndroidBuildID(context);
                break;
            case "grid":
                mStrReturn = GetAndroidBuildIDData(context);
                break;
            case "combo":
                mStrReturn = GetAndroidBuildIDCombo(context);
                break;
            default:
                mStrReturn = GJHF.Utility.WEBUI.EasyuiControl.GetMissParamReturn();
                break;
        }
        context.Response.Write(mStrReturn);
    }

    private string AddAndroidBuildID(HttpContext context)
    {
        string m_add_build_name = "";
        if (context.Request.Params["build_name"] != null)
        {
            m_add_build_name = context.Request.Params["build_name"].ToString();
        }
        if (m_add_build_name == "") return GJHF.Utility.WEBUI.EasyuiControl.GetParamFailRetuen();
        int m_add_build_id = -1;
        if (context.Request.Params["build_id"] != null)
        {
            if (int.TryParse(context.Request.Params["build_id"], out m_add_build_id) == false)
            {
                m_add_build_id = 0;
            }
        }
        if (m_add_build_id == -1) return GJHF.Utility.WEBUI.EasyuiControl.GetParamFailRetuen();
        string m_add_build_remark = "";
        if (context.Request.Params["build_remark"] != null)
        {
            m_add_build_remark = context.Request.Params["build_remark"].ToString();
        }
        int mIntReturn = BAndroidBuildID.AddAndroidBuildID( m_add_build_name, m_add_build_id, m_add_build_remark);
        return GJHF.Utility.WEBUI.EasyuiControl.GetAddReturn(mIntReturn, 1);
    }
    private string EditAndroidBuildID(HttpContext context)
    {
        int m_edit_data_id = 0;
        if (context.Request.Params["data_id"] != null)
        {
            if (int.TryParse(context.Request.Params["data_id"], out m_edit_data_id) == false)
            {
                m_edit_data_id = 0;
            }
        }
        if (m_edit_data_id == 0) return GJHF.Utility.WEBUI.EasyuiControl.GetParamFailRetuen();
        string m_edit_build_name = "";
        if (context.Request.Params["build_name"] != null)
        {
            m_edit_build_name = context.Request.Params["build_name"].ToString(); 
        }
        if (m_edit_build_name == "") return GJHF.Utility.WEBUI.EasyuiControl.GetParamFailRetuen();
        int m_edit_build_id = -1;
        if (context.Request.Params["build_id"] != null)
        {
            if (int.TryParse(context.Request.Params["build_id"], out m_edit_build_id) == false)
            {
                m_edit_build_id = 0;
            }
        }
        if (m_edit_build_id == -1) return GJHF.Utility.WEBUI.EasyuiControl.GetParamFailRetuen();
        string m_edit_build_remark = "";
        if (context.Request.Params["build_remark"] != null)
        {
            m_edit_build_remark = context.Request.Params["build_remark"].ToString(); 
        }
        int mIntReturn = BAndroidBuildID.EditAndroidBuildID(m_edit_data_id, m_edit_build_name, m_edit_build_id, m_edit_build_remark);
        return GJHF.Utility.WEBUI.EasyuiControl.GetEditReturn(mIntReturn, 1);
    }
    private string DelAndroidBuildID(HttpContext context)
    {
        int m_del_data_id = 0;
        if (context.Request.Params["data_id"] != null)
        {
            if (int.TryParse(context.Request.Params["data_id"], out m_del_data_id) == false)
            {
                m_del_data_id = 0;
            }
        }
        if (m_del_data_id == 0) return GJHF.Utility.WEBUI.EasyuiControl.GetParamFailRetuen();
        int mIntReturn= BAndroidBuildID.DelAndroidBuildID(m_del_data_id);
        return GJHF.Utility.WEBUI.EasyuiControl.GetDelReturn(mIntReturn, 1);
    }
    private string GetAndroidBuildIDData(HttpContext context)
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
        string m_grid_build_name = "";
        if (context.Request.Params["build_name"] != null)
        {
            m_grid_build_name = context.Request.Params["build_name"].ToString(); 
        }
        string m_grid_build_remark = "";
        if (context.Request.Params["build_remark"] != null)
        {
            m_grid_build_remark = context.Request.Params["build_remark"].ToString();
        }
        int m_grid_build_id = -1;
        if (context.Request.Params["build_id"] != null)
        {
            if (int.TryParse(context.Request.Params["build_id"], out m_grid_build_id) == false)
            {
                m_grid_build_id = -1; 
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
        int mIntDataCount = BAndroidBuildID.GetAndroidBuildIDCount(m_grid_build_name, m_grid_build_remark, m_grid_build_id);
        DataTable dt = BAndroidBuildID.GetAndroidBuildIDData(m_grid_page, m_grid_rows, m_grid_build_name, m_grid_build_remark, m_grid_sort, m_grid_order, m_grid_build_id);
        return GJHF.Utility.WEBUI.EasyuiControl.GetGridReturn(mIntDataCount, dt);
    }
    private string GetAndroidBuildIDCombo(HttpContext context)
    {
        DataTable dt = BAndroidBuildID.GetAndroidBuildIDData("", "", -1);
        return GJHF.Utility.WEBUI.EasyuiControl.GetComboReturn(dt, "data_id", "build_name");
    }
    public bool IsReusable {
        get {
            return false;
        }
    }

}