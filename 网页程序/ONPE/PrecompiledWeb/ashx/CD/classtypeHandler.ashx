<%@ WebHandler Language="C#" Class="classtypeHandler" %>

using System;
using System.Web;
using ModelClass;
using Newtonsoft.Json;
using NPE.UIDataClass;
using System.Data;
using System.Collections.Generic;

public class classtypeHandler : IHttpHandler {

    string branch_id = "";
    string classtype_code = "";
    public void ProcessRequest (HttpContext context) {
        string action = "";
        context.Response.ContentType = "text/plain";
        if (context.Request.Params["action"] != null)
        {
            action = context.Request.Params["action"];
        }
        if (context.Request.Params["branch_id"] != null)
        {
            branch_id = context.Request.Params["branch_id"];
        }
        if (context.Request.Params["classtype_code"] != null)
        {
            classtype_code = context.Request.Params["classtype_code"];
        }
        switch (action)
        {
            case "combo":
                context.Response.Write(GetComboData());
                break;
            case "classtypeEmplpyee":
                context.Response.Write(GetClassTypeEmployee());
                break;
            default:
                context.Response.Write("");
                break; 
        }
    }
    private string GetClassTypeEmployee()
    {
        List<combobox> listCombo = new List<combobox>();
        string mStrSQL = @"SELECT     t_Employee.employee_code, t_Employee.employee_Name
                            FROM         tCDEmpType LEFT OUTER JOIN
                                                  t_Employee ON tCDEmpType.employee_code = t_Employee.employee_code
                            WHERE     tCDEmpType.dVchTypeID = '" + classtype_code + "'";
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
    private string GetComboData()
    {
        List<combobox> listCombo=new List<combobox>();
        string mStrSQL = @"SELECT     tCDType.dVchTypeID, tCDType.dVchTypeName
                           FROM     tCDType LEFT OUTER JOIN
                                    tHRBranchInfo ON tCDType.dIntBranchID = tHRBranchInfo.dIntBranchID
                          WHERE     tCDType.dIntBranchID = " + branch_id ;
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
    public bool IsReusable {
        get {
            return false;
        }
    }

}