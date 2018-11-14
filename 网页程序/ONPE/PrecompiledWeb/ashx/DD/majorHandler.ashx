<%@ WebHandler Language="C#" Class="majorHandler" %>
using System;
using System.Web;
using ModelClass;
using Newtonsoft.Json;
using NPE.UIDataClass;
using System.Data;
using System.Collections.Generic;
public class majorHandler : IHttpHandler {

    string major_code = "";
    string major_name = "";
    string major_innum = "";
    public void ProcessRequest (HttpContext context) {
        string action = "";
        context.Response.ContentType = "text/plain";

        if (context.Request.Params["action"] != null)
        {
            action = context.Request.Params["action"];
        }
        if (context.Request.Params["major_code"] != null)
        {
            major_code = context.Request.Params["major_code"];
        }
        if (context.Request.Params["major_name"] != null)
        {
            major_name = context.Request.Params["major_name"];
        }
        if (context.Request.Params["major_innum"] != null)
        {
            major_innum = context.Request.Params["major_innum"];
        }
        switch (action)
        {
            case "combo":
                context.Response.Write(GetComboJsonData());
                break;
            default:

                break; 
        }
    }
    private string GetComboJsonData()
    {
        List<combobox> listCombo = new List<combobox>();
        string mStrSQL=@"select major_code,major_name from t_major " + GetWhere();
        DataTable dt = null;
        using (dt = claSqlConnDB.ExecuteDataset(claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL).Tables[0])
        {
            if (dt.Rows.Count > 0)
            {
                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    combobox comboTemp = new combobox();
                    comboTemp.id = dt.Rows[i][0].ToString();
                    comboTemp.text = dt.Rows[i][1].ToString();
                    listCombo.Add(comboTemp); 
                } 
            } 
        }
        return JsonConvert.SerializeObject(listCombo);
    }
    private string GetWhere()
    {
        string mStrWhere = "";
        if (major_code != "")
        {
            if (mStrWhere != "")
            {
                mStrWhere =mStrWhere+ " and t_major.major_code='" + major_code + "' ";
            }
            else
            {
                mStrWhere = " WHERE t_major.major_code='" + major_code + "' ";
            }
        }
        if (major_innum != "")
        {
            if (mStrWhere != "")
            {
                mStrWhere = mStrWhere + " and t_major.major_innum like'%" + major_innum + "'% ";
            }
            else
            {
                mStrWhere = " WHERE t_major.major_innum like'%" + major_innum + "'% ";
            }
        }
        if (major_name != "")
        {
            if (mStrWhere != "")
            {
                mStrWhere = mStrWhere + " and t_major.major_name like'%" + major_name + "'% ";
            }
            else
            {
                mStrWhere = " WHERE t_major.major_name like'%" + major_name + "'% ";
            }
        }
        return mStrWhere;
    }
    public bool IsReusable {
        get {
            return false;
        }
    }

}