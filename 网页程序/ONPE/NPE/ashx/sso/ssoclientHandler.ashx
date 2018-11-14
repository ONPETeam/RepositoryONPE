<%@ WebHandler Language="C#" Class="ssoclientHandler" %>

using System;
using System.Web;
using System.Web.Security;
using System.Collections.Generic;

public class ssoclientHandler : IHttpHandler {
    private GJHF.Business.HR.Employee BEmployee;

    public ssoclientHandler()
    {
        this.BEmployee = new GJHF.Business.HR.Employee(); 
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
            case "login":
                mStrReturn=LoginCrossDomain(context);
                break;
            case "adduser":
                mStrReturn = AddNewUser(context);
                break;
            case "deluser":
                mStrReturn = DelUser(context);
                break;
            case "updateuser":
                mStrReturn = UpdateUserInfo(context);
                break;
            case "ssologin":
                LoginSSOUser(context);
                break;
            default:
                mStrReturn = GJHF.Utility.WEBUI.EasyuiControl.GetMissParamReturn();
                break; 
        }
        context.Response.Write(mStrReturn);
    }
    private void LoginSSOUser(HttpContext context)
    {
        string m_sso_user_id = "";
        string m_sso_token = "";
        int m_appsite_id = 0;
        int m_right_type = -1;
        if (context.Request.Params["token"] != null)
        {
            m_sso_token=context.Request.Params["token"].ToString();
        }
        if(context.Request.Params["user_id"]!=null)
        {
            m_sso_user_id=context.Request.Params["user_id"].ToString();
        }

        if (context.Request.Params["appsite_id"] != null)
        {
            if (int.TryParse(context.Request.Params["appsite_id"], out m_appsite_id) == false)
            {
                m_appsite_id = 0; 
            }
        }
        if (context.Request.Params["right_type"] != null)
        {
            if (int.TryParse(context.Request.Params["right_type"], out m_right_type) == false)
            {
                m_right_type = -1; 
            } 
        }
        Dictionary<string,object> mDicUserData=new Dictionary<string,object>();
        mDicUserData.Add("token",m_sso_token);
        mDicUserData.Add("user_id",m_sso_user_id);
        mDicUserData.Add("appsite_id",m_appsite_id);
        mDicUserData.Add("right_type",m_right_type);
        string mStrUserData = Newtonsoft.Json.JsonConvert.SerializeObject(mDicUserData);
        if (m_sso_token != "" && m_sso_user_id != "" && GJHF.Utility.EncryptionDes.Encrypt(m_sso_user_id) == m_sso_token)
        {
            DateTime mDtmNow = System.DateTime.Now;
            DateTime mDtmExpires = mDtmNow.AddDays(2);
            FormsAuthenticationTicket ticket = new FormsAuthenticationTicket(
                                2,
                                m_sso_user_id,
                                mDtmNow,
                                mDtmExpires,
                                false,
                                mStrUserData);
            string mStrTicket = FormsAuthentication.Encrypt(ticket);
            HttpCookie cookie = new HttpCookie(FormsAuthentication.FormsCookieName, mStrTicket);
            cookie.Expires = mDtmExpires;
            context.Response.Cookies.Add(cookie);
            context.Response.AddHeader("Access-Control-Allow-Origin", "*");
        }
    }
    
    private string UpdateUserInfo(HttpContext context)
    {
        string m_update_user_id = "";
        if (context.Request.Params["user_id"] != null)
        {
            m_update_user_id = context.Request.Params["user_id"].ToString();
        }
        if (m_update_user_id == "") return GJHF.Utility.WEBUI.EasyuiControl.GetParamFailRetuen();
        string m_update_user_name = "";
        if (context.Request.Params["user_name"] != null)
        {
            m_update_user_name = context.Request.Params["user_name"].ToString();
        }
        if (m_update_user_name == "") return GJHF.Utility.WEBUI.EasyuiControl.GetParamFailRetuen();
        string m_update_user_phone = "";
        if (context.Request.Params["user_phone"] != null)
        {
            m_update_user_phone = context.Request.Params["user_phone"].ToString();
        }
        if (m_update_user_phone == "") return GJHF.Utility.WEBUI.EasyuiControl.GetParamFailRetuen();
        string m_update_user_mail = "";
        if (context.Request.Params["user_mail"] != null)
        {
            m_update_user_mail = context.Request.Params["user_mail"].ToString();
        }
        return GJHF.Utility.WEBUI.EasyuiControl.GetEditReturn(BEmployee.UpdateEmployee(m_update_user_id, m_update_user_name, m_update_user_phone, m_update_user_mail), 1);
    }
    private string DelUser(HttpContext context)
    {
        string m_del_user_id = "";
        if (context.Request.Params["user_id"] != null)
        {
            m_del_user_id = context.Request.Params["user_id"].ToString();
        }
        if (m_del_user_id == "") return GJHF.Utility.WEBUI.EasyuiControl.GetParamFailRetuen();
        return GJHF.Utility.WEBUI.EasyuiControl.GetDelReturn(BEmployee.DelEmployee(m_del_user_id), 1);
    }
    private string AddNewUser(HttpContext context)
    {
        string m_add_user_id = "";
        if (context.Request.Params["user_id"] != null)
        {
            m_add_user_id = context.Request.Params["user_id"].ToString(); 
        }
        if (m_add_user_id == "") return GJHF.Utility.WEBUI.EasyuiControl.GetParamFailRetuen();
        string m_add_user_name = "";
        if (context.Request.Params["user_name"] != null)
        {
            m_add_user_name = context.Request.Params["user_name"].ToString(); 
        }
        if (m_add_user_name == "") return GJHF.Utility.WEBUI.EasyuiControl.GetParamFailRetuen();
        string m_add_user_phone = "";
        if (context.Request.Params["user_phone"] != null)
        {
            m_add_user_phone = context.Request.Params["user_phone"].ToString();
        }
        if (m_add_user_phone == "") return GJHF.Utility.WEBUI.EasyuiControl.GetParamFailRetuen();
        string m_add_user_mail = "";
        if (context.Request.Params["user_mail"] != null)
        {
            m_add_user_mail = context.Request.Params["user_mail"].ToString();
        }
        return GJHF.Utility.WEBUI.EasyuiControl.GetAddReturn(BEmployee.AddNewEmployee(m_add_user_name, m_add_user_id, m_add_user_phone, m_add_user_mail), 1);
    }
    
    private string LoginCrossDomain(HttpContext context)
    {
        int m_login_equip_type = 0;
        if (context.Request.Params["equip_type"] != null)
        {
            if (int.TryParse(context.Request.Params["equip_type"].ToString(), out m_login_equip_type) == false)
            {
                m_login_equip_type=0;
            }
        }
        if (m_login_equip_type == 0) return GJHF.Utility.WEBUI.EasyuiControl.GetParamFailRetuen();
        string m_login_equip_sign = "";
        if (context.Request.Params["equip_sign"] != null)
        {
            m_login_equip_sign = context.Request.Params["equip_sign"].ToString();
        }
        if (m_login_equip_sign == "") return GJHF.Utility.WEBUI.EasyuiControl.GetParamFailRetuen();
        int m_login_way_type = 0;
        if (context.Request.Params["way_type"] != null)
        {
            if (int.TryParse(context.Request.Params["way_type"].ToString(), out m_login_way_type) == false)
            {
                m_login_way_type=0;
            }
        }
        if (m_login_way_type == 0) return GJHF.Utility.WEBUI.EasyuiControl.GetParamFailRetuen();
        string m_login_way_sign = "";
        if (context.Request.Params["way_sign"] != null)
        {
            m_login_way_sign = context.Request.Params["way_sign"].ToString();
        }
        else
        {
            m_login_way_sign = "";
        }
        string m_login_user_name = "";
        if (context.Request.Params["user_name"] != null)
        {
            m_login_user_name = context.Request.Params["user_name"].ToString();
        }
        if (m_login_user_name == "") return GJHF.Utility.WEBUI.EasyuiControl.GetParamFailRetuen();
        string m_login_user_pwd = "";
        if (context.Request.Params["user_pwd"] != null)
        {
            m_login_user_pwd = context.Request.Params["user_pwd"].ToString();
        }
        if (m_login_user_pwd == "") return GJHF.Utility.WEBUI.EasyuiControl.GetParamFailRetuen();
        string m_login_remember_pwd = "";
        DateTime m_login_login_time = DateTime.Now;
        DateTime m_expiration_time;
        if (context.Request.Params["remember_pwd"] != null)
        {
            m_login_remember_pwd = context.Request.Params["remember_pwd"].ToString();
        }
        switch (m_login_remember_pwd)
        {
            case "0":
                m_expiration_time = m_login_login_time.AddMinutes(30);
                break;
            case "1":
                m_expiration_time = m_login_login_time.AddHours(3);
                break;
            case "2":
                m_expiration_time = m_login_login_time.AddDays(1);
                break;
            case "3":
                m_expiration_time = m_login_login_time.AddYears(99);
                break;
            default:
                m_expiration_time = m_login_login_time.AddMinutes(30);
                break;
        }
        string mStrLogin = GJHF.Business.SSO.SSOLogin.LoginUser(m_login_user_name, m_login_user_pwd);
        if (mStrLogin != null || mStrLogin != "")
        {
            try
            {
                Dictionary<string, object> mDic = (Dictionary<string, object>)Newtonsoft.Json.JsonConvert.DeserializeObject<Dictionary<string, object>>(mStrLogin);
                if (bool.Parse(mDic["success"].ToString()))
                {
                    FormsAuthenticationTicket ticket = new FormsAuthenticationTicket(
                                2,
                                m_login_user_name,
                                m_login_login_time,
                                m_expiration_time,
                                false,
                                mDic["msg"].ToString());
                    string mStrTicket = FormsAuthentication.Encrypt(ticket);
                    HttpCookie cookie = new HttpCookie(FormsAuthentication.FormsCookieName, mStrTicket);
                    cookie.Expires = m_expiration_time;
                    context.Response.Cookies.Add(cookie);
                }
            }
            catch (Exception e)
            {
                 
            }
        }
        return mStrLogin;
    }
    
    public bool IsReusable {
        get {
            return false;
        }
    }

}