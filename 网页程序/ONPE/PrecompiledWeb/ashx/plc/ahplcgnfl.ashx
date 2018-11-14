<%@ WebHandler Language="C#" Class="ahplcgnfl" %>

using System;
using System.Web;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using Newtonsoft.Json;
using ModelClass;
using System.Text;
using NPE.UIDataClass;
using System.IO;

public class ahplcgnfl : IHttpHandler {

    public HttpRequest Request
    {
        get
        {
            return HttpContext.Current.Request;
        }
    }
    private HttpResponse Response
    {
        get { return HttpContext.Current.Response; }
    }
    int pages = 1;
    int rows = 10;

    string strBT = "";
    string strET = "";
    string strCjdz = "";
    int intMsg = 0;
    public void ProcessRequest (HttpContext context) {
        context.Response.ContentType = "text/plain";
        string type = Request.Params["type"];
        
        switch (type)
        {
            case "cbox": context.Response.Write(this.GetCombobox()); break;
            //case "delete": Delete(context); break;
            //case "edit": Edit(context); break;
            case"jsnr":
                //string mStrConent = "";
                //mStrConent = System.Web.HttpUtility.UrlDecode(Request.Params["vct"].ToString(), Encoding.GetEncoding("GB2312"));
                //string mStrPATH = GetRootPath() + "\\gjson.txt";
                //FileStream fs = null;
                //if (!System.IO.File.Exists(mStrPATH))
                //{
                //    fs = File.Create(mStrPATH);
                //}
                //else
                //{
                //    fs = File.Open(mStrPATH, FileMode.Open);
                //}
                //StreamWriter sw = new StreamWriter(fs);
                //sw.WriteLine(mStrConent);
                //sw.Close();
                //fs.Close();
                Response.Write(GetCjData());
                break;
            case"AlermData":
                if (int.TryParse(Request.Params["vpages"], out intMsg))
                {
                    pages = Int32.Parse(Request.Params["vpages"]);
                }
                if(int.TryParse(Request.Params["vrows"],out intMsg))
                {
                    rows = Int32.Parse(Request.Params["vrows"]);
                }
                strBT = Request.Params["vstrBT"];
                strET = Request.Params["vstrET"];
                strCjdz = Request.Params["vstrCjdz"];
                GetPushData();
                break;
        }
        
    }

    //获取数据中二进制流数据
    //把二进制流转换为json字符串
    public string GetCjData()
    {
        byte[] byte_data = null;
        DataTable dt = null;
        string mStrcontent = "";
        dt = GJHF.Business.PLC.BPlcDtTemp.GetCjData();
        if (dt.Rows.Count > 0)
        {
            byte_data = (byte[])dt.Rows[0]["dImgContent"];
        }
        mStrcontent = System.Text.Encoding.Default.GetString(byte_data);
        return mStrcontent;
    }
    
    /// <summary>
    /// 把文件写入网站系统根目录
    /// </summary>
    /// <param name="vStrContent">写入内容</param>
    /// <returns></returns>
    public bool SetWriteFile(string vStrContent)
    {
        try
        {
            FileStream fs = null;
            string mStrPath = GetRootPath() + "\\gjson.txt";
            if (!System.IO.File.Exists(mStrPath))
            {
                fs = File.Create(mStrPath);
            }
            else
            {
                fs = File.Open(mStrPath, FileMode.Open); 
            }

            StreamWriter sw = new StreamWriter(fs);
            sw.WriteLine(vStrContent);
            sw.Close();
            fs.Close();
            return true;
            
        }
        catch (Exception eee)
        {
            return false;
        }
    }
    //public string ChangeLan(string text)
    //{
    //    byte[] bs = Encoding.GetEncoding("UTF-8").GetBytes(text);
    //    bs = Encoding.Convert(Encoding.GetEncoding("UTF-8"), Encoding.GetEncoding("GB2312"), bs);
        
    //    return Encoding.GetEncoding("GB2312").GetString(bs);
    //}  
    /// <summary>
    /// 取得网站根目录的物理路径
    /// </summary>
    /// <returns></returns>
    public static string GetRootPath()
    {
        string AppPath = "";
        HttpContext HttpCurrent = HttpContext.Current;
        if (HttpCurrent != null)
        {
            AppPath = HttpCurrent.Server.MapPath("~");
        }
        else
        {
            AppPath = AppDomain.CurrentDomain.BaseDirectory;
            if (System.Text.RegularExpressions.Regex.Match(AppPath, @"\\$", System.Text.RegularExpressions.RegexOptions.Compiled).Success)
                AppPath = AppPath.Substring(0, AppPath.Length - 1);
        }
        return AppPath;
    }
    public string GetCombobox()
    {
        string result;
        StringBuilder sb = new StringBuilder();
        List<plcgnfl> mList = new List<plcgnfl>();
        string sql = string.Format(@"select dIntGongNengID,dVchGongNengName from tNGongNengType ", "", null);

        DataTable dt;
        using(dt=claSqlConnDB.ExecuteDataset(claSqlConnDB.gStrConnDefault,CommandType.Text,sql).Tables[0])
        {
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                plcgnfl mModel = new plcgnfl();
                mModel.dIntGongNengID = (int)dt.Rows[i][0];
                mModel.dVchGongNengName = dt.Rows[i][1].ToString();
                mList.Add(mModel);
            }
        }
        result = JsonConvert.SerializeObject(mList);
        return JsonConvert.SerializeObject(mList);
    }

    public void  GetPushData()
    {
        string result = "";
        DataTable dt = null;
        dt = GJHF.Business.PLC.BPlcPushTemp.GetAlermAndPushData(rows, pages, strBT, strET,strCjdz);
        result = GJHF.Utility.WEBUI.EasyuiControl.GetGridReturn(dt.Rows.Count,dt);
        Response.Write(result);
    }
    public bool IsReusable {
        get {
            return false;
        }
    }

}