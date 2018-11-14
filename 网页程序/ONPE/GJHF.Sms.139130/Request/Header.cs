using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace GJHF.Sms._139130.Request
{
    public class Header
    {
        public static string GetContentType(ContentType v_content_type)
        {
            string mStrReturn = "";
            switch (v_content_type)
            {
                case ContentType.JSON:
                    mStrReturn = "application/json;charset=utf-8";
                    break;
                case ContentType.XML:
                    mStrReturn = "application/xml;charset=utf-8";
                    break;
                default:
                    mStrReturn = "application/json;charset=utf-8";
                    break;
            }
            return mStrReturn;
        }
        public static string GetAcceptType(AcceptType v_accept_type)
        {
            string mStrReturn = "";
            switch (v_accept_type)
            {
                case AcceptType.JSON:
                    mStrReturn = "application/json";
                    break;
                case AcceptType.XML:
                    mStrReturn = "application/xml";
                    break;
                default:
                    mStrReturn = "application/json";
                    break;
            }
            return mStrReturn;
        }

        /// <summary>
        /// 1. 认证参数，编码方法Base64(accountSid + 英文冒号 + timestamp)。
        /// 2. 其中accountSid为账户ID，和sig中的accountSid一致；timestamp为时间戳也和sig中的timestamp一致。
        /// 3.示例：
        /// Base64编码前内容:174b616bad34b51b4c7583980032f5ad:20161110124757
        /// 编码后:MTc0YjYxNmJhZDM0YjUxYjRjNzU4Mzk4MDAzMmY1YWQ6MjAxNjExMTAxMjQ3NTc=
        /// </summary>
        /// <param name="dt"></param>
        /// <returns></returns>
        public static string GetHeaderAuthorization(DateTime dt)
        {
            string mStrAccountSid = AppSecret.GetAccountSid;
            string mStrSepara = ":";
            string mStrTimeStamp = Common.Global.FormatDate(dt);

            return Common.Global.Base64Code(mStrAccountSid + mStrSepara + mStrTimeStamp);
        }

        public static string GetSig(DateTime dt)
        {
            string mStrReturn = "";
            string mStrContent = Request.AppSecret.GetAccountSid + Request.AppSecret.GetAuthToken + Common.Global.FormatDate(dt);
            mStrContent = mStrContent.ToLower();
            mStrReturn = Common.Global.SHA1(mStrContent);
            return mStrReturn.ToLower();
        }

    }
    /// <summary>
    /// 客户端响应接收数据格式，目前支持XML和JSON两种： application/xml、application/json
    /// </summary>
    public enum AcceptType
    {
        XML,
        JSON
    }

    /// <summary>
    /// 消息内容格式，目前服务器支持XML和JSON两种格式解析:
    /// application/xml;charset=utf-8 application/json;charset=utf-8
    /// </summary>
    public enum ContentType
    {
        XML,
        JSON
    }
}
