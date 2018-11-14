<%@ WebHandler Language="C#" Class="majorHandler" %>

using System;
using System.Web;
using Newtonsoft.Json;
using NPE.UIDataClass;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Generic;
using ModelClass;
using System.Text;

public class majorHandler : IHttpHandler {

    public void ProcessRequest (HttpContext context) {

        string action = "";
        string mStrReturn = "";
        object mObjDetial = null;
        
        context.Response.ContentType = "text/plain";
        action = context.Request.Params["action"];
        switch(action)
        {
            case "combobox":
                string m_combobox_major_name = "";
                if (context.Request.Params["major_name"] != null)
                {
                    m_combobox_major_name = context.Request.Params["major_name"]; 
                }
                string m_combobox_major_innum = "";
                if (context.Request.Params["major_innum"] != null)
                {
                    m_combobox_major_innum = context.Request.Params["major_innum"];
                }
                mObjDetial = GetMajorComboboxData(m_combobox_major_name, m_combobox_major_innum);
                mStrReturn = JsonConvert.SerializeObject(mObjDetial);
                break;
            default:
                mStrReturn = "{'success':false,'msg':'缺少必要参数'}";
                break;            
        }
        context.Response.Write(mStrReturn);
    }
    public List<combobox> GetMajorComboboxData(string v_major_name, string v_major_innum)
    {
        List<combobox> mLstCombobox = new List<combobox>();
        string mStrSQL = @"SELECT major_code,major_name FROM t_major " +GetWhere(v_major_name,v_major_innum);
        DataTable dt = null;
        using (dt = claSqlConnDB.ExecuteDataset(claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL).Tables[0])
        {
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                combobox mCombo = new combobox();
                mCombo.id = dt.Rows[i][0].ToString();
                mCombo.text = dt.Rows[i][1].ToString();
                mLstCombobox.Add(mCombo); 
            } 
        }
        return mLstCombobox;
    }
    public string GetWhere(string v_major_name, string v_major_innum)
    {
        string mStrWhere = "";
        if (v_major_name != "")
        {
            if (mStrWhere != "")
            {
                mStrWhere = " AND major_name like '" + v_major_name + "'";
            }
            else
            {
                mStrWhere = " WHERE major_name like '" + v_major_name + "'";
            }
        }
        if (v_major_innum != "")
        {
            if (mStrWhere != "")
            {
                mStrWhere = " AND major_innum like '" + v_major_innum + "'";
            }
            else
            {
                mStrWhere = " WHERE major_innum like '" + v_major_innum + "'";
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