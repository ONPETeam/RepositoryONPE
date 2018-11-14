<%@ WebHandler Language="C#" Class="publicHandler" %>

using System;
using System.Web;
using ModelClass;
using Newtonsoft.Json;
using NPE.UIDataClass;
using System.Data;
using System.Collections.Generic;

public class publicHandler : IHttpHandler {

    
    
    public void ProcessRequest (HttpContext context) {
        string name = "";
        string action = "";
        string parent_id="";
        context.Response.ContentType = "text/plain";
        if (context.Request.Params["name"] != null)
        {
            name = context.Request.Params["name"].ToString();
        }
        if (context.Request.Params["action"] != null)
        {
            action = context.Request.Params["action"].ToString();
        }
        if (context.Request.Params["parent_id"] != null)
        {
            parent_id = context.Request.Params["parent_id"].ToString();
        }
        switch (action)
        {
            case "grid":

                break;
            case "combo":
                context.Response.Write(GetComboJson(name));
                break;
            case "combotree":
                context.Response.Write(GetComboTreeJson(name, parent_id));
                break;
            default:
                
                break; 
        }
    }
    private string GetComboTreeJson(string name, string parentID)
    {
        string mStrReturn = "";
        mStrReturn = JsonConvert.SerializeObject(GetComboTree(name, parentID));
        return mStrReturn;
    }
    private List<combotree> GetComboTree(string name,string parentID)
    {
        List<combotree> listTemp = new List<combotree>();
        string mStrSQL = " Select " + name + "_id ," + name + "_name from t_" + name + " where " + name + "_parent =" + parentID;
        DataTable dt = null;
        using (dt = claSqlConnDB.ExecuteDataset(claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL).Tables[0])
        {
            if (dt.Rows.Count > 0)
            {
                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    combotree combotreeTemp = new combotree();
                    combotreeTemp.id = dt.Rows[i][0].ToString();
                    combotreeTemp.text = dt.Rows[i][1].ToString();
                    if (GetComboCount(name, dt.Rows[i][0].ToString()) > 0)
                    {
                        combotreeTemp.state = "closed";
                    }
                    else
                    {
                        combotreeTemp.state = "open"; 
                    }
                    listTemp.Add(combotreeTemp);
                } 
            } 
        }
        return listTemp;
    }
    private int GetComboCount(string name,string parentID)
    {
        string mStrSQL = " Select count(0) from t_" + name + " where " + name + "_parent =" + parentID;
        int i = claSqlConnDB.GetRecordCount(claSqlConnDB.gStrConnDefault, mStrSQL);
        return i;
    }
    private string GetComboJson(string name)
    {
        string mStrReturn="";
        mStrReturn = JsonConvert.SerializeObject(GetComboBox(name));
        return mStrReturn; 
    }
    private List<combobox> GetComboBox(string name)
    {
        List<combobox> listCombo = new List<combobox>();
        string mStrSQL = " Select " + name + "_id ," + name + "_name from t_" + name;
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
        return listCombo;
    }
    public bool IsReusable {
        get {
            return false;
        }
    }

}