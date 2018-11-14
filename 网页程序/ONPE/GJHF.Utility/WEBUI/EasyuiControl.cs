using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using Newtonsoft.Json;
using System.Reflection;

namespace GJHF.Utility.WEBUI
{
    public class TreeNode
    {
        public string id { get; set; }
        public string text { get; set; }
        /// <summary>
        /// 'open' 或 'closed'，默认是 'open'。
        /// 如果为'closed'的时候，将不自动展开该节点。
        /// </summary>
        public string state { get; set; }
        public bool ischecked { get; set; }// replace checked
        public object attributes { get; set; }
        public string iconCls { get; set; }
        public List<TreeNode> children { get; set; }
    }
    public class PropertyGrid
    {
        public int total { get; set; }
        public List<PropertyGridNode> rows { get; set; }
    }
    public class PropertyGridNode
    {
        public string name { get; set; }
        public string value { get; set; }

        public string group { get; set; }
        public object editor { get; set; }
    }
    public class Editror
    {
        public string type { get; set; }
        public List<object> options { get; set; }
    }
    public class combotree
    {
        public string id { get; set; }
        public string text { get; set; }
        public string state { get; set; }
        public object attributes { get; set; }
        public List<combotree> children { get; set; }
    }
    public class combobox
    {
        public string id { get; set; }
        public string text { get; set; }
    }
    public class EasyuiControl
    {
        public static string GetReturn(bool is_success, string v_msg, bool isObj)
        {
            if (isObj)
            {
                return string.Format("{{\"success\":\"{0}\",\"msg\":{1}}}", is_success.ToString().ToLower(), v_msg);
            }
            else
            {
                return string.Format("{{\"success\":\"{0}\",\"msg\":\"{1}\"}}", is_success.ToString().ToLower(), v_msg);
            }
        }
        public static string GetAddReturn(int v_return,int v_success)
        {
            string mStrReturn = "";
            if (v_return == v_success)
            {
                mStrReturn = "{\"success\":true,\"msg\":\"添加数据成功！\"}";
            }
            else
            {
                mStrReturn = "{\"success\":false,\"msg\":\"添加数据失败！\"}";
            }
            return mStrReturn;
        }
        public static string GetEditReturn(int v_return, int v_success)
        {
            string mStrReturn = "";
            if (v_return == v_success)
            {
                mStrReturn = "{\"success\":true,\"msg\":\"编辑数据成功！\"}";
            }
            else
            {
                mStrReturn = "{\"success\":false,\"msg\":\"编辑数据失败！\"}";
            }
            return mStrReturn;
        }
        public static string GetDelReturn(int v_return, int v_success)
        {
            string mStrReturn = "";
            if (v_return == v_success)
            {
                mStrReturn = "{\"success\":true,\"msg\":\"删除数据成功！\"}";
            }
            else
            {
                mStrReturn = "{\"success\":false,\"msg\":\"删除数据失败！\"}";
            }
            return mStrReturn;
        }
        public static string GetGridReturn(int v_total, DataTable v_data)
        {
            string mStrReturn = string.Format("{{ \"total\":{0},\"rows\":{1}}}", v_total, JsonConvert.SerializeObject(v_data));
            return mStrReturn;
        }
        public static string GetGridReturn<T>(int v_total, List<T> v_data)
        {
            string mStrReturn = string.Format("{{ \"total\":{0},\"rows\":{1}}}", v_total, JsonConvert.SerializeObject(v_data));
            return mStrReturn;
        }
        public static string GetComboReturn(DataTable v_data,string v_idFiled, string v_textFiled)
        {
            List<combobox> mLstCombo = new List<combobox>();
            for (int i = 0; i < v_data.Rows.Count; i++)
            {
                combobox mComboTemp = new combobox();
                mComboTemp.id = v_data.Rows[i][v_idFiled].ToString();
                mComboTemp.text = v_data.Rows[i][v_textFiled].ToString();
                mLstCombo.Add(mComboTemp);
            }
            return JsonConvert.SerializeObject(mLstCombo);
        }
        public static string GetPropReturn(DataTable v_data)
        {
            PropertyGrid mPropData = new PropertyGrid();
            mPropData.total = v_data.Columns.Count;
            mPropData.rows = new List<PropertyGridNode>();
            for(int i=0;i<v_data.Columns.Count;i++)
            {
                PropertyGridNode mPropertyGridNode = new PropertyGridNode();
                mPropertyGridNode.name = v_data.Columns[i].Caption;
                mPropertyGridNode.value = v_data.Rows[0][i].ToString();
                mPropData.rows.Add(mPropertyGridNode);
            }
            return JsonConvert.SerializeObject(mPropData);
        }
        public static string GetPropReturn(Dictionary<string, object> v_data)
        {
            return JsonConvert.SerializeObject(v_data);
        }
        /// <summary>    
        /// DataTable 转换为List 集合    
        /// </summary>    
        /// <typeparam name="TResult">类型</typeparam>    
        /// <param name="dt">DataTable</param>    
        /// <returns></returns>    
        public static List<T> ToList<T>(DataTable dt) where T : class, new()
        {
            //创建一个属性的列表    
            List<PropertyInfo> prlist = new List<PropertyInfo>();
            //获取TResult的类型实例  反射的入口    

            Type t = typeof(T);

            //获得TResult 的所有的Public 属性 并找出TResult属性和DataTable的列名称相同的属性(PropertyInfo) 并加入到属性列表     
            Array.ForEach<PropertyInfo>(t.GetProperties(), p => { if (dt.Columns.IndexOf(p.Name) != -1) prlist.Add(p); });

            //创建返回的集合    

            List<T> oblist = new List<T>();

            foreach (DataRow row in dt.Rows)
            {
                //创建TResult的实例    
                T ob = new T();
                //找到对应的数据  并赋值    
                prlist.ForEach(p => { if (row[p.Name] != DBNull.Value) p.SetValue(ob, row[p.Name], null); });
                //放入到返回的集合中.    
                oblist.Add(ob);
            }
            return oblist;
        }
        public static string GetMissParamReturn()
        {
            return "{\"success\":false,\"msg\":\"缺少必要参数！\"}";
        }
        public static string GetParamFailRetuen()
        {
            return "{\"success\":false,\"msg\":\"参数错误！\"}";
        }
    }
}
