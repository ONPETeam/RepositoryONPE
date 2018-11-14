<%@ WebHandler Language="C#" Class="fileclassHandler" %>

using System;
using System.Web;
using ModelClass;
using Newtonsoft.Json;
using NPE.UIDataClass;
using System.Data;
using System.Collections.Generic;

public class fileclassHandler : IHttpHandler {
        
    string sort = "";
    string order = "";

    int rows = 10;
    int page = 1;

    string fileclass_code = "";
    string fileclass_name = "";
    string fileclass_parent = "";
    
    public void ProcessRequest (HttpContext context) {
        context.Response.ContentType = "text/plain";
        string action = "";
        if (context.Request.Params["fileclass_code"] != null)
        {
            fileclass_code = context.Request.Params["fileclass_code"];
        }
        if (context.Request.Params["fileclass_name"] != null)
        {
            fileclass_name = context.Request.Params["fileclass_name"];
        }
        if (context.Request.Params["fileclass_parent"] != null)
        {
            fileclass_parent = context.Request.Params["fileclass_parent"];
        }
        if (context.Request.Params["sort"] != null)
        {
            sort = context.Request.Params["sort"];
        }
        if (context.Request.Params["order"] != null)
        {
            order = context.Request.Params["order"];
        }
        if (context.Request.Params["rows"] != null)
        {
            rows = int.Parse(context.Request.Params["rows"]);
        }
        if (context.Request.Params["page"] != null)
        {
            page = int.Parse(context.Request.Params["page"]);
        }
        if (context.Request.Params["action"] != null)
        {
            action = context.Request.Params["action"];
        }
         switch (action)
        {
            case "add":
                context.Response.Write(addFileClass());
                break;
            case "edit":

                break;
            case "del":
                context.Response.Write(delFileClass());
                break;
            case "grid":
                System.Text.StringBuilder sb = new System.Text.StringBuilder();
                sb.Append("{ ");
                sb.Append(string.Format("\"total\":{0},\"rows\":", GetFileClassPageCount()));
                string s = ShowFilClassGird();
                sb.Append(s);
                sb.Append("}");
                context.Response.Write(sb.ToString());
                break;
            
            case "combo":
                context.Response.Write(GetFileClassComboJson());
                break;
            //case "prop":
            //    context.Response.Write(GetProperty());
            //    break;
            //case "detail":
            //    context.Response.Write(GetAreaDetail());
            //    break;
            default:

                break;
        }
    }
    private string addFileClass()
    {
        global mGlobal = new global();
        fileclass_code = mGlobal.GetIdentityID("PC", "ZL", "LX", System.DateTime.Now, 6);
        string mStrSQL = @"insert into t_FileClass(fileclass_code,fileclass_name,fileclass_parent) values(
                        '" + fileclass_code + "','" + fileclass_name + "','" + fileclass_parent + "')";
        int i = claSqlConnDB.ExecuteNonQuery(claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL);

        return i.ToString();
    }
    private string delFileClass()
    {
        string mStrSQL = @"delete from t_FileClass where fileclass_code='" + fileclass_code + "'";
        int i = claSqlConnDB.ExecuteNonQuery(claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL);

        return i.ToString();
    }
    private string GetFileClassPageCount()
    {
        string mStrSQL = @" select count(0) from t_FileClass " + GetWhere();
        int i = claSqlConnDB.GetRecordCount(claSqlConnDB.gStrConnDefault, mStrSQL);
        return i.ToString(); 
    }
    private string ShowFilClassGird()
    {
        string mStrReturn = "";
        List<fileclass> listFileClass = new List<fileclass>();
        DataTable dt = null;
        string mStrSQL = @" SELECT     t_FileClass.fileclass_code, t_FileClass.fileclass_name, t_FileClass_1.fileclass_code AS fileclass_parent_code, t_FileClass_1.fileclass_name AS fileclass_parent_name
                            FROM       t_FileClass left outer JOIN
                                       t_FileClass AS t_FileClass_1 ON t_FileClass.fileclass_parent = t_FileClass_1.fileclass_code " + GetWhere() + GetOrder();
        using (dt = claSqlConnDB.ExecuteDataset(rows, page, claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL).Tables[0])
        {
            if (dt.Rows.Count > 0)
            {
                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    fileclass fileclassTemp = new fileclass();
                    fileclassTemp.fileclass_code = dt.Rows[i][0].ToString();
                    fileclassTemp.fileclass_name = dt.Rows[i][1].ToString();
                    fileclassTemp.fileclass_parent_code = dt.Rows[i][2].ToString();
                    fileclassTemp.fileclass_parent_name = dt.Rows[i][3].ToString();
                    listFileClass.Add(fileclassTemp);
                }
            }
            mStrReturn = JsonConvert.SerializeObject(listFileClass);
        }

        return mStrReturn;
    }
    private string GetFileClassComboJson()
    {
        string mStrReturn = "";
        mStrReturn = JsonConvert.SerializeObject(GetFileClassCombo(fileclass_parent));
        return mStrReturn;
    }
    private List<combotree> GetFileClassCombo(string fileclassParent)
    {
        List<combotree> listCombo = new List<combotree>();
        DataTable dt = null;
        string lStrSQL = "select fileclass_code,fileclass_name from t_FileClass where fileclass_parent ='" + fileclassParent +"'";
        using (dt = claSqlConnDB.ExecuteDataset(claSqlConnDB.gStrConnDefault, System.Data.CommandType.Text, lStrSQL).Tables[0])
        {
            if (dt.Rows.Count > 0)
            {
                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    combotree comboNodetmp = new combotree();
                    comboNodetmp.id = dt.Rows[i][0].ToString();
                    comboNodetmp.text = dt.Rows[i][1].ToString();
                    if (GetFileClassTreeNum(dt.Rows[i][0].ToString()) > 0)
                    {
                        
                            comboNodetmp.state = "closed";
                    }
                    else
                    {
                        comboNodetmp.state = "open";
                    }
                    listCombo.Add(comboNodetmp);
                }
            }
        }
        return listCombo;
    }
    private int GetFileClassTreeNum(string fileclassCode)
    {
        string mStrSQL = " select count(0) from t_FileClass where fileclass_parent ='" + fileclassCode + "'";
        int i = claSqlConnDB.GetRecordCount(claSqlConnDB.gStrConnDefault, mStrSQL);
        return i;
    }
    
    public bool IsReusable {
        get {
            return false;
        }
    }
    private string GetWhere()
    {
        string mStrWhere = "";

        return mStrWhere;
    }
    private string GetOrder()
    {
        string mStrOrder = "";
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
}