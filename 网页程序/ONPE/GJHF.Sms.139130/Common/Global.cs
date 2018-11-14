using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Net;
using System.IO;
using System.Security.Cryptography;

namespace GJHF.Sms._139130.Common
{
    public class Global
    {
        public  static string GenerateTimeStamp(DateTime dt)
        {
            TimeSpan ts = (dt.ToUniversalTime() - new DateTime(1970, 1, 1, 0, 0, 0, DateTimeKind.Utc));
            return Convert.ToInt64(ts.TotalMilliseconds).ToString(); 
        }
        public static string FormatDate(DateTime dt)
        {
            return dt.ToString("yyyyMMddHHmmss");
        }


        /// <summary>
        /// SHA1 加密，返回大写字符串
        /// </summary>
        /// <param name="content">需要加密字符串</param>
        /// <returns>返回40位UTF8 大写</returns>
        public static string SHA1(string content)
        {
            return SHA1(content, Encoding.UTF8);
        }
        /// <summary>
        /// SHA1 加密，返回大写字符串
        /// </summary>
        /// <param name="content">需要加密字符串</param>
        /// <param name="encode">指定加密编码</param>
        /// <returns>返回40位大写字符串</returns>
        private static string SHA1(string content, Encoding encode)
        {
            try
            {
                SHA1 sha1 = new SHA1CryptoServiceProvider();
                byte[] bytes_in = encode.GetBytes(content);
                byte[] bytes_out = sha1.ComputeHash(bytes_in);
                sha1.Dispose();
                string result = BitConverter.ToString(bytes_out);
                result = result.Replace("-", "");
                return result;
            }
            catch (Exception ex)
            {
                throw new Exception("SHA1加密出错：" + ex.Message);
            }
        }


        /// <summary>
        /// Base64加密
        /// </summary>
        /// <param name="Message"></param>
        /// <returns></returns>
        public static string Base64Code(string Message)
        {
            byte[] bytes = Encoding.Default.GetBytes(Message);
            return Convert.ToBase64String(bytes);
        }
        /// <summary>
        /// Base64解密
        /// </summary>
        /// <param name="Message"></param>
        /// <returns></returns>
        public static string Base64Decode(string Message)
        {
            byte[] bytes = Convert.FromBase64String(Message);
            return Encoding.Default.GetString(bytes);
        }

        public static string PostURL(string v_url, Dictionary<string, string> v_header_param,string v_request_content)
        {
            string mStrResponse="";
            HttpWebRequest request = (HttpWebRequest)WebRequest.Create(v_url);
            request.Method = "post";
            foreach (KeyValuePair<string,string> kv in v_header_param)
            {
                if (kv.Key.ToLower() == "accept")
                {
                    request.Accept = kv.Value;
                    continue;
                }
                if (kv.Key.ToLower() == "content-type")
                {
                    request.ContentType = kv.Value;
                    continue;
                }
                if (kv.Key.ToLower() == "content-length")
                {
                    request.ContentLength = long.Parse(kv.Value);
                    continue;
                }
                request.Headers.Add(kv.Key, kv.Value);
                
            }
            Encoding encoding = Encoding.UTF8;
            byte[] buffer = encoding.GetBytes(v_request_content.ToString());
            request.GetRequestStream().Write(buffer, 0, buffer.Length);
            HttpWebResponse response = (HttpWebResponse)request.GetResponse();
            using(StreamReader reader=new StreamReader(response.GetResponseStream(),Encoding.UTF8))
            {
                mStrResponse = reader.ReadToEnd();
            }
            return mStrResponse;
        }
    }
}
