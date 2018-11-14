using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace GJHF.Business.SSO
{
    public class SSOLogin
    {
        private static string mStrSSOURI = System.Configuration.ConfigurationSettings.AppSettings["sso_url"].ToString() + "ashx/admin/sso/ssohandler.ashx";
        private readonly static string mStrRightURI = System.Configuration.ConfigurationSettings.AppSettings["sso_url"].ToString() + "ashx/admin/rights/rightHandler.ashx";
        public static string LoginUser(string v_user_account, string v_user_pwd)
        {
            string mStrParam = string.Format("?action=login&user_account={0}&user_pwd={1}", v_user_account, v_user_pwd);
            string mStrToken = GJHF.Utility.HttpUtility.Get(mStrSSOURI, mStrParam);
            return mStrToken;
        }
        public static string GetUserID(string v_token)
        {
            string mStrParam = string.Format("?action=userid&token={0}", v_token);
            string mStrValidate = GJHF.Utility.HttpUtility.Get(mStrSSOURI, mStrParam);
            return mStrValidate;
        }
        public static string ValidateToken(string v_token)
        {
            string mStrParam = string.Format("?action=validatetoken&token={0}", v_token);
            string mStrValidate = GJHF.Utility.HttpUtility.Get(mStrSSOURI, mStrParam);
            return mStrValidate;
        }
        public static string GetUserInfo(string v_token)
        {
            string mStrParam = string.Format("?action=userinfo&token={0}", v_token);
            string mStrUserInfo = GJHF.Utility.HttpUtility.Get(mStrSSOURI, mStrParam);
            return mStrUserInfo;
        }
        public static string LogoutUser(string v_token)
        {
            string mStrParam = string.Format("?action=logout&token={0}", v_token);
            string mStrLogoutInfo = GJHF.Utility.HttpUtility.Get(mStrSSOURI, mStrParam);
            return mStrLogoutInfo;
        }
        public static string ValidateCookie(string v_token, string v_user_id, int v_appsite_id, int v_right_type)
        {
            string mStrParam = string.Format("?action=validatecookie&token={0}&user_id={1}&appsite_id={2}&right_type={3}", v_token, v_user_id, v_appsite_id, v_right_type);
            string mStrValidateResult = GJHF.Utility.HttpUtility.Get(mStrSSOURI, mStrParam);
            return mStrValidateResult;
        }
        public static string GetRegistratorID(string v_user_ids, string v_separator)
        {
            string mStrParam = string.Format("?action=getregid&user_ids={0}&separator={1}", v_user_ids, v_separator);
            string mStrGetRegistratorIDResult = GJHF.Utility.HttpUtility.Get(mStrSSOURI, mStrParam);
            return mStrGetRegistratorIDResult;
        }
        public static string GetVisitList(string v_token)
        {
            string mStrParam = string.Format("?action=visit&token={0}", v_token);
            string mStrVisitList = GJHF.Utility.HttpUtility.Get(mStrRightURI, mStrParam);
            return mStrVisitList;
        }
    }
}
