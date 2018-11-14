<%@ WebHandler Language="C#" Class="ahplcgzdc" %>

using System;
using System.Web;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using Newtonsoft.Json;
using ModelClass;
using System.Text;
using NPE.UIDataClass;

public class ahplcgzdc : IHttpHandler {
    string sort = "";
    string order = "";

    int page = 1;
    int rows = 10;
    
    
    public void ProcessRequest (HttpContext context) {
        string action = "";

        context.Response.ContentType = "text/plain";
        if (context.Request.Params["sort"] != null)
        {
            sort = context.Request.Params["sort"];
        }
        if (context.Request.Params["order"] != null)
        {
            order = context.Request.Params["order"];
        }
        if (context.Request.Form["page"] != null)
        {
            page = int.Parse(context.Request.Form["page"]);//页码
        }
        if (context.Request.Form["rows"] != null)
        {
            rows = int.Parse(context.Request.Form["rows"]);//页容量
        }

        if (context.Request.Params["action"] != null)
        {
            action = context.Request.Params["action"];
        }
        string mstrresult = "";
        string mstrcondition = "";
        switch (action)
        {
            case "grid":
                mstrcondition = GetWhere() + GetOrder();
                mstrresult = GJHF.Utility.WEBUI.EasyuiControl.GetGridReturn(GJHF.Business.PLC.Bplcdc.GetRecordCount(GetWhere()), GJHF.Business.PLC.Bplcdc.GetData(rows, page, mstrcondition));
                context.Response.Write(mstrresult);
                break;
            case"cbox":
                mstrresult = JsonConvert.SerializeObject(GJHF.Business.PLC.Bplcdc.GetComboData(""));
                context.Response.Write(mstrresult);
                break;
            case"cboxgzfl":
                context.Response.Write(this.GetComboboxGzfl());
                break;
            case"add":
                Add(context);
                break;
            case"Edit":
                Edit(context);
                break;
            case"Del":
                Del(context);
                break;
            default:
                break;
        }
    }
    
    private string GetWhere()
    {
        string mStrWhere = "";
        return mStrWhere;
    }
    private string GetOrder()
    {
        string mStrOrder = " order by dIntGzID desc ";
        if (sort != "")
        {
            mStrOrder = " order by " + sort;
            if (order != "")
            {
                mStrOrder = mStrOrder + " " + order;
            }
        }
        return mStrOrder;
    }

    //combobox故障分类
    public string GetComboboxGzfl()
    {
        StringBuilder sb = new StringBuilder();
        List<plcgzfl> mList = new List<plcgzfl>();
        string sql = string.Format("select dIntGzType,dVchGzTypeName from tZPLCGzFl order by dIntGzType", "", null);

        DataTable dt;
        using (dt = claSqlConnDB.ExecuteDataset(claSqlConnDB.gStrConnDefault, CommandType.Text, sql).Tables[0])
        {
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                plcgzfl mModel = new plcgzfl();
                mModel.dIntGzType = (int)dt.Rows[i][0];
                mModel.dVchGzTypeName = dt.Rows[i][1].ToString();
                mList.Add(mModel);
            } 
        }

        return JsonConvert.SerializeObject(mList);
    }
    
    //添加
    private void Add(HttpContext context)
    {
        string mStrGzName = context.Request.Form["nGzName"];
        string mStrGzXx = context.Request.Form["nGzxx"];
        string mStrGzyy = context.Request.Form["nGzyy"];
        string mStrGzCL = context.Request.Form["nGzclbf"];
        int mIntGzType = 0;
        if (string.IsNullOrEmpty(context.Request.Form["nGzfl"]) == false)
        {
            mIntGzType = Int32.Parse(context.Request.Form["nGzfl"]);
        }
        int voIntReturn;
        GJHF.Business.PLC.Bplcdc.AddData(mStrGzName, mStrGzXx, mStrGzyy, mStrGzCL, mIntGzType,out voIntReturn);
        if (voIntReturn == 0)
        {
            context.Response.Write("成功");
        }
        else
        {
            context.Response.Write("失败");
        }
        
    }
    
    //编辑
    private void Edit(HttpContext  context)
    {
        int mIntGzID = 0;
        if (string.IsNullOrEmpty(context.Request.QueryString["vID"]) == false)
        {
             mIntGzID = Int32.Parse(context.Request.QueryString["vID"]);
        }
        string mStrGzName = context.Request.Form["nGzName"];
        string mStrGzXx = context.Request.Form["nGzxx"];
        string mStrGzyy = context.Request.Form["nGzyy"];
        string mStrGzCL = context.Request.Form["nGzclbf"];
        int mIntGzType = 0;
        if (string.IsNullOrEmpty(context.Request.Form["nGzfl"]) == false)
        {
            mIntGzType = Int32.Parse(context.Request.Form["nGzfl"]);
        }

        int voIntReturn;
        GJHF.Business.PLC.Bplcdc.EditData(mIntGzID, mStrGzName, mStrGzXx, mStrGzyy, mStrGzCL, mIntGzType,out voIntReturn);
        if (voIntReturn == 0)
        {
            context.Response.Write("成功");
        }
        else
        {
            context.Response.Write("失败");
        }
    }
    
    //删除
    private void Del(HttpContext context)
    {
        int mIntGzID = 0;
        if (string.IsNullOrEmpty(context.Request.QueryString["vID"]) == false)
        {
             mIntGzID = Int32.Parse(context.Request.QueryString["vID"]);
        }
        int voIntReturn;

        GJHF.Business.PLC.Bplcdc.DelData(mIntGzID, out voIntReturn);
        if (voIntReturn == 0)
        {
            context.Response.Write("成功");
        }
        else
        {
            context.Response.Write("失败");
        }
    }
    
    public bool IsReusable {
        get {
            return false;
        }
    }

}