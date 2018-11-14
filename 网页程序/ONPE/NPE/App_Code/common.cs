using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data.SqlClient;
using System.Data;
using System.Runtime.Serialization.Json;
using System.IO;
using System.Text;

/// <summary>
///common 的摘要说明
/// </summary>
public class common
{
    public common()
    {
        //
        //TODO: 在此处添加构造函数逻辑
        //
    }

    public enum SeqType
    {
        PCRWGD,
        PCRWGP,

    }

    public static string GetRwdNum(string _SeqType)
    {
        string p0 = _SeqType.Substring(0, 2);
        string p1 = _SeqType.Substring(2, 2);
        string p2 = _SeqType.Substring(4, 2);
        string lRwgdNum = "";
        int intreturn = -1;
        SqlParameter[] _Parameter = new SqlParameter[7]
            {
                new SqlParameter("@viVchDatabaseCode",SqlDbType.VarChar,2),
                new SqlParameter("@viVchSubsystem",SqlDbType.VarChar,2),
                new SqlParameter("@viVchFunction",SqlDbType.VarChar,2),
                new SqlParameter("@viDmeTime",SqlDbType.DateTime,30),
                new SqlParameter("@viIntSerialNo",SqlDbType.Int,4),
                new SqlParameter("@voVchNumberValue",SqlDbType.VarChar,30),
                new SqlParameter("@voIntReturn",SqlDbType.Int),
            };
        _Parameter[0].Value = p0;
        _Parameter[1].Value = p1;
        _Parameter[2].Value = p2;
        _Parameter[3].Value = DateTime.Now;
        _Parameter[4].Value = 6;
        _Parameter[5].Direction = System.Data.ParameterDirection.Output;
        _Parameter[6].Direction = System.Data.ParameterDirection.Output;
        claSqlConnDB.ExecuteNonQuery(claSqlConnDB.gStrConnDefault, CommandType.StoredProcedure, "pPBGetNumberValue", _Parameter);
        intreturn = (int)_Parameter[6].Value;
        lRwgdNum = _Parameter[5].Value.ToString();
        return lRwgdNum;
    }

    public static T JsonDeserialize<T>(string jsonString)
    {
        DataContractJsonSerializer ser = new DataContractJsonSerializer(typeof(T));
        MemoryStream ms = new MemoryStream(Encoding.UTF8.GetBytes(jsonString));
        T obj = (T)ser.ReadObject(ms);
        return obj;
    }

    /// <summary>
    /// 把dataset数据转换成json的格式
    /// </summary>
    /// <param name="ds">dataset数据集</param>
    /// <returns>json格式的字符串</returns>
    public static string GetJsonByDataset(DataSet ds)
    {
        if (ds == null || ds.Tables.Count <= 0 || ds.Tables[0].Rows.Count <= 0)
        {
            //如果查询到的数据为空则返回标记ok:false
            return "{\"ok\":false}";
        }
        StringBuilder sb = new StringBuilder();
        sb.Append("{\"ok\":true,");
        foreach (DataTable dt in ds.Tables)
        {
            sb.Append(string.Format("\"{0}\":[", dt.TableName));

            foreach (DataRow dr in dt.Rows)
            {
                sb.Append("{");
                for (int i = 0; i < dr.Table.Columns.Count; i++)
                {
                    sb.AppendFormat("\"{0}\":\"{1}\",", dr.Table.Columns[i].ColumnName.Replace("\"", "\\\"").Replace("\'", "\\\'"), ObjToStr(dr[i]).Replace("\"", "\\\"").Replace("\'", "\\\'")).Replace(Convert.ToString((char)13), "\\r\\n").Replace(Convert.ToString((char)10), "\\r\\n");
                }
                sb.Remove(sb.ToString().LastIndexOf(','), 1);
                sb.Append("},");
            }

            sb.Remove(sb.ToString().LastIndexOf(','), 1);
            sb.Append("],");
        }
        sb.Remove(sb.ToString().LastIndexOf(','), 1);
        sb.Append("}");
        return sb.ToString();
    }
    public static string GetJsonByDataset1(DataSet ds)
    {
        if (ds == null || ds.Tables.Count <= 0 || ds.Tables[0].Rows.Count <= 0)
        {
            //如果查询到的数据为空则返回标记ok:false
            //return "{\"ok\":false}";
            return "";
        }
        StringBuilder sb = new StringBuilder();
        foreach (DataTable dt in ds.Tables)
        {
            foreach (DataRow dr in dt.Rows)
            {
                sb.Append("{");
                for (int i = 0; i < dr.Table.Columns.Count; i++)
                {
                    sb.AppendFormat("\"{0}\":\"{1}\",", dr.Table.Columns[i].ColumnName.Replace("\"", "\\\"").Replace("\'", "\\\'"), ObjToStr(dr[i]).Replace("\"", "\\\"").Replace("\'", "\\\'")).Replace(Convert.ToString((char)13), "\\r\\n").Replace(Convert.ToString((char)10), "\\r\\n");
                }
                sb.Remove(sb.ToString().LastIndexOf(','), 1);
                sb.Append("},");
            }

            sb.Remove(sb.ToString().LastIndexOf(','), 1);
        }
        return sb.ToString();
    }
    /// <summary>
    /// 将object转换成为string
    /// </summary>
    /// <param name="ob">obj对象</param>
    /// <returns></returns>
    public static string ObjToStr(object ob)
    {
        if (ob == null)
        {
            return string.Empty;
        }
        else
            return ob.ToString();
    }

    public static void SaveFile(string path, string filename, HttpPostedFile file)
    {
        if (!Directory.Exists(HttpContext.Current.Server.MapPath(path)))
        {
            Directory.CreateDirectory(HttpContext.Current.Server.MapPath(path));
        }
        file.SaveAs(HttpContext.Current.Server.MapPath(path + "/" + filename));
    }
}