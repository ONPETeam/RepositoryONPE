using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Compilation;
using System.Web.Security;
using System.Web.Script.Serialization;
using System.Reflection;
using System.Data;
using Newtonsoft.Json;
using ModelClass;
using System.Data.SqlClient;

namespace ONPE
{
    /// <summary>
    ///MyHttpHandler 的摘要说明
    /// </summary>
    public class MyHttpHandler : IHttpHandlerFactory
    {
        private Dictionary<string, IHttpHandler> _cache
            = new Dictionary<string, IHttpHandler>(200, StringComparer.OrdinalIgnoreCase);

        public IHttpHandler GetHandler(HttpContext context, string requestType, string url, string pathTranslated)
        {

            IHttpHandler handler = null;
            handler = GetMapHttpHandler(context, requestType, url, pathTranslated);
            if (context.Request.Params["action"] != "updateuser" && context.Request.Params["action"] != "ssologin" && context.Request.Params["action"] != "adduser")
            {
                if (context.Request.IsAuthenticated)
                {
                    FormsIdentity id = (FormsIdentity)context.User.Identity;
                    FormsAuthenticationTicket ticket = id.Ticket;
                    string mStrUserData = ticket.UserData;
                    if (ValidateCookies(mStrUserData))
                    {
                        return handler;
                    }
                    else
                    {
                        FormsAuthentication.SignOut();
                        context.Response.Write(JsonConvert.SerializeObject("{\"msg\":\"登陆失效\",\"success\",\"false\"}"));
                        return null;
                    }
                }
                else
                {
                    context.Response.Write(JsonConvert.SerializeObject("{\"msg\":\"未登陆\",\"success\",\"false\"}"));
                    return null;
                }
            }
            else
            {
                return handler;
            }

        }

        public void ReleaseHandler(IHttpHandler handler)
        {

        }

        private IHttpHandler GetMapHttpHandler(HttpContext context, string requestType, string url, string pathTranslated)
        {
            IHttpHandler handler = null;
            string cacheKey = requestType + url;
            if (_cache.TryGetValue(cacheKey, out handler) == false)
            {
                Type handlerType = BuildManager.GetCompiledType(url);
                if (typeof(IHttpHandler).IsAssignableFrom(handlerType) == false)
                    throw new HttpException("要访问的资源没有实现IHttpHandler接口。");
                handler = (IHttpHandler)Activator.CreateInstance(handlerType, true);
                if (handler.IsReusable)
                    _cache[cacheKey] = handler;
            }
            return handler;
        }
        private bool ValidateCookies(string v_user_data)
        {
            try
            {
                Dictionary<string, object> mDicUserData = (Dictionary<string, object>)Newtonsoft.Json.JsonConvert.DeserializeObject<Dictionary<string, object>>(v_user_data);
                string mStrToken = mDicUserData["token"].ToString();
                string mStrUserId = mDicUserData["user_id"].ToString();
                int mIntAppsiteId = int.Parse(mDicUserData["appsite_id"].ToString());
                int mIntRightType = int.Parse(mDicUserData["right_type"].ToString());
                if (!ValidateCookiesLocal(mStrToken, mStrUserId, mIntAppsiteId, mIntRightType))
                {
                    return false;
                }
                if (!ValidataCookiesServer(mStrToken, mStrUserId, mIntAppsiteId, mIntRightType))
                {
                    return false;
                }
                return true;
            }
            catch (Exception e)
            {
                return false;
            }
        }

        private bool ValidateCookiesLocal(string v_token, string v_user_id, int v_appsite_id, int v_right_type)
        {
            if (v_token == null || v_token == "")
            {
                return false;
            }
            if (v_user_id == null || v_user_id == "")
            {
                return false;
            }
            if (GJHF.Utility.EncryptionDes.Encrypt(v_user_id) != v_token)
            {
                return false;
            }
            if (v_right_type == -1)
            {
                return false;
            }
            if (v_appsite_id == 0)
            {
                return false;
            }
            return true;
        }

        private bool ValidataCookiesServer(string v_token, string v_user_id, int v_appsite_id, int v_right_type)
        {
            try
            {
                string mStrValidateCookiesResult = GJHF.Business.SSO.SSOLogin.ValidateCookie(v_token, v_user_id, v_appsite_id, v_right_type);
                Dictionary<string, object> mDicValidateResult = (Dictionary<string, object>)Newtonsoft.Json.JsonConvert.DeserializeObject<Dictionary<string, object>>(mStrValidateCookiesResult);
                if (!bool.Parse(mDicValidateResult["success"].ToString()))
                {
                    return false;
                }
                return true;
            }
            catch (Exception e)
            {
                return false;
            }
        }

        private int insertUserOperateRecord(string v_user_info, string v_operate_page, string v_operate_content, string v_operate_way, int v_operate_result)
        {
            int mIntReturn = 0;
            string mStrSQL = @"INSERT INTO t_user_operate_record(user_info,operate_page,operate_content,operate_way,operate_result)
                            VALUES(@user_info,@operate_page,@operate_content,@operate_way,@operate_result)";
            SqlParameter[] parameters = new SqlParameter[]{
                new SqlParameter("@user_info",SqlDbType.VarChar,500),
                new SqlParameter("@operate_page",SqlDbType.VarChar,200),
                new SqlParameter("@operate_content",SqlDbType.VarChar,8000),
                new SqlParameter("@operate_way",SqlDbType.VarChar,50),
                new SqlParameter("@operate_result",SqlDbType.Int,4)
            };
            parameters[0].Value = v_user_info.Replace("\"", "").Replace("'", "");
            parameters[1].Value = v_operate_page.Replace("\"", "").Replace("'", "");
            parameters[2].Value = v_operate_content.Replace("\"", "").Replace("'", "");
            parameters[3].Value = v_operate_way.Replace("\"", "").Replace("'", "");
            parameters[4].Value = v_operate_result;
            mIntReturn = claSqlConnDB.ExecuteNonQuery(claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL, parameters);
            return mIntReturn;
        }
    }
}