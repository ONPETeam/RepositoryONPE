<%@ WebHandler Language="C#" Class="carouselHandler" %>

using System;
using System.Web;
using System.Data;

public class carouselHandler : IHttpHandler {

    private GJHF.Business.SYS.SysCarousel _SysCarousel;
    public carouselHandler()
    {
        this._SysCarousel = new GJHF.Business.SYS.SysCarousel(); 
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
                mStrReturn = AddImage(context);
                break;
            case "edit":
                mStrReturn = EditImage(context);
                break;
            case "del":
                mStrReturn = DelImage(context);
                break;
            case "state":
                mStrReturn = UpdateState(context);
                break;
            case "grid":
                mStrReturn = GetImageGrid(context);
                break;
            default:
                mStrReturn = GJHF.Utility.WEBUI.EasyuiControl.GetMissParamReturn();
                break; 
        }
        context.Response.Write(mStrReturn);
    }
    private string AddImage(HttpContext context)
    {
        HttpPostedFile file = null;
        HttpFileCollection httpFileCollection = context.Request.Files;
        if (httpFileCollection.Count > 0)
        {
            file = httpFileCollection[0];
        }
        if (file == null) return GJHF.Utility.WEBUI.EasyuiControl.GetParamFailRetuen();
        int m_image_state = 1;
        if (context.Request.Params["image_state"] != null)
        {
            if (int.TryParse(context.Request.Params["image_state"], out m_image_state) == false)
            {
                m_image_state = 1; 
            } 
        }
        int mIntReturn = _SysCarousel.AddSysCarousel(file, m_image_state);
        return GJHF.Utility.WEBUI.EasyuiControl.GetAddReturn(mIntReturn, 1);
    }
    private string EditImage(HttpContext context)
    {
        HttpPostedFile file = null;
        HttpFileCollection httpFileCollection = context.Request.Files;
        if (httpFileCollection.Count > 0)
        {
            file = httpFileCollection[0];
        }
        if (file == null) return GJHF.Utility.WEBUI.EasyuiControl.GetParamFailRetuen();
        int m_edit_data_id = 0;
        if (context.Request.Params["data_id"] != null)
        {
            if (int.TryParse(context.Request.Params["data_id"], out m_edit_data_id) == false)
            {
                m_edit_data_id = 0; 
            }
        }
        if (m_edit_data_id == 0) return GJHF.Utility.WEBUI.EasyuiControl.GetParamFailRetuen();
        int m_image_state = 1;
        if (context.Request.Params["image_state"] != null)
        {
            if (int.TryParse(context.Request.Params["image_state"], out m_image_state) == false)
            {
                m_image_state = 1;
            }
        }
        int mIntReturn = _SysCarousel.EditSysCarousel(m_edit_data_id, file, m_image_state);
        return GJHF.Utility.WEBUI.EasyuiControl.GetEditReturn(mIntReturn, 1);
    }
    private string DelImage(HttpContext context)
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
        int mIntReturn = _SysCarousel.DelSysCarousel(m_del_data_id);
        return GJHF.Utility.WEBUI.EasyuiControl.GetDelReturn(mIntReturn, 1);
    }
    private string UpdateState(HttpContext context)
    {
        int m_update_data_id = 0;
        if (context.Request.Params["data_id"] != null)
        {
            if (int.TryParse(context.Request.Params["data_id"], out m_update_data_id) == false)
            {
                m_update_data_id = 0;
            }
        }
        if (m_update_data_id == 0) return GJHF.Utility.WEBUI.EasyuiControl.GetParamFailRetuen();
        int m_update_image_state = 1;
        if (context.Request.Params["image_state"] != null)
        {
            if (int.TryParse(context.Request.Params["image_state"], out m_update_image_state) == false)
            {
                m_update_image_state = 1;
            }
        }
        int mIntReturn = _SysCarousel.UpdateSysCarouselState(m_update_data_id, m_update_image_state);
        if (mIntReturn == 1)
        {
            return GJHF.Utility.WEBUI.EasyuiControl.GetReturn(true, "修改状态成功！", false);
        }
        else
        {
            return GJHF.Utility.WEBUI.EasyuiControl.GetReturn(false, "修改状态失败！", false); 
        }
    }
    private string GetImageGrid(HttpContext context)
    {
        int m_grid_image_state = -100;
        if (context.Request.Params["image_state"] != null)
        {
            if (int.TryParse(context.Request.Params["image_state"], out m_grid_image_state) == false)
            {
                m_grid_image_state = -100;
            }
        }
        int mIntCount = _SysCarousel.GetSysCarouselCount(m_grid_image_state);
        DataTable dt = _SysCarousel.GetSysCarousel(m_grid_image_state);
        return GJHF.Utility.WEBUI.EasyuiControl.GetGridReturn(mIntCount, dt);
    }
    public bool IsReusable {
        get {
            return false;
        }
    }

}