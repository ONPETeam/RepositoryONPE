using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Newtonsoft.Json;
using System.Reflection;
using System.Globalization;
using System.Threading;


namespace GJHF.Utility
{
    public class Convert
    {
        public static Dictionary<string, string> ConvertJsonToDic(string v_json)
        {
            Dictionary<string, string> mDic = new Dictionary<string, string>();
            mDic = (Dictionary<string, string>)JsonConvert.DeserializeObject<Dictionary<string, string>>(v_json);
            return mDic;
        }
        public static HashSet<string> ConvertStringToHashSet(string v_string, char v_separator)
        {
            HashSet<string> mHashSet = new HashSet<string>();
            string[] mStrSplt = v_string.Split( new char[]{ v_separator });
            foreach (string mStrString in mStrSplt)
            {
                mHashSet.Add(mStrString);
            }
            return mHashSet;
        }
        public static string ConvertHashSetToString(HashSet<string> v_hash_set, string v_separator)
        {
            string mStrReturn = "";
            foreach (string m in v_hash_set)
            {
                mStrReturn += m + "" + v_separator;
            }
            return mStrReturn;
        }
        public static string ConvertListToString(List<string> v_list_object, string v_separator)
        {
            string mStrReturn = "";
            foreach (string m in v_list_object)
            {
                mStrReturn += m + "" + v_separator;
            }
            return mStrReturn;
        }
        public static Dictionary<string, object> ConvertModelToDictionary(object v_model_data)
        {
            Dictionary<String, Object> map = new Dictionary<string, object>();
            Type t = v_model_data.GetType();
            PropertyInfo[] pi = t.GetProperties(BindingFlags.Public | BindingFlags.Instance);
            foreach (PropertyInfo p in pi)
            {
                MethodInfo mi = p.GetGetMethod();
                if (mi != null && mi.IsPublic)
                {
                    map.Add(p.Name, mi.Invoke(v_model_data, new Object[] { }));
                }
            }
            return map;
        }
        public T DicToObject<T>(Dictionary<string, object> dic) where T : new()
        {
            var md = new T();
            CultureInfo cultureInfo = Thread.CurrentThread.CurrentCulture;
            TextInfo textInfo = cultureInfo.TextInfo;
            foreach (var d in dic)
            {
                var filed = textInfo.ToTitleCase(d.Key);
                try
                {
                    var value = d.Value;
                    md.GetType().GetProperty(filed).SetValue(md, value, null);
                }
                catch (Exception e)
                {

                }
            }
            return md;
        }
        public static string ConvertByteToString(byte[] v_byte_array)
        {
            if (v_byte_array == null) return "";
            if (v_byte_array.Length > 0)
            {
                return System.Text.Encoding.Default.GetString(v_byte_array);
            }
            else
            {
                return "";
            }
        }
        public static byte[] ConvertStringToByte(string v_string)
        {
            return System.Text.Encoding.Default.GetBytes(v_string);
        }
    }
}
