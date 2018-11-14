<%@ WebHandler Language="C#" Class="Company" %>

using System;
using System.Web;
using Newtonsoft.Json;
using NPE.UIDataClass;
using System.Data;
using System.Collections.Generic;

public class Company : IHttpHandler {
    
    public void ProcessRequest (HttpContext context) {
        context.Response.ContentType = "text/plain";
        context.Response.Write(JsonConvert.SerializeObject(GetCompany()));
    }

    public List<combotree> GetCompany() {
        List<combotree> treelist = new List<combotree>();
        DataTable dt = null;
        string mStrSql = " select dIntCompanyID,dVchCompanyName from tHRCompany";
        using (dt = claSqlConnDB.ExecuteDataset(claSqlConnDB.gStrConnDefault, System.Data.CommandType.Text, mStrSql).Tables[0])
        {
            if (dt.Rows.Count > 0)
            {
                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    combotree treeNodetemp = new combotree();
                    treeNodetemp.id = dt.Rows[i][0].ToString();
                    treeNodetemp.text = dt.Rows[i][1].ToString();
                    treelist.Add(treeNodetemp);
                } 
            } 
        }
        return treelist;
    }
    
    public bool IsReusable {
        get {
            return false;
        }
    }

}