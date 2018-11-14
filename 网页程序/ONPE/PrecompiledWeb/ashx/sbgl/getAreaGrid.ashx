<%@ WebHandler Language="C#" Class="getAreaGrid" %>

using System;
using System.Web;
using NPE.UIDataClass;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using Newtonsoft.Json;
using ModelClass;

public class getAreaGrid : IHttpHandler {
    
    public void ProcessRequest (HttpContext context) {
        context.Response.ContentType = "text/plain";
        
        
        context.Response.Write(this.getGrid());
    }

    private string getGrid()
    {
        string returnStr = "";
        List<area> areaGrid = new List<area>();

        string lStrSql = "select area_id,area_name,area_parent,area_code,area_remark from t_EquipArea";
        DataTable dt = null;
        using (dt = claSqlConnDB.ExecuteDataset(claSqlConnDB.gStrConnDefault, CommandType.Text, lStrSql).Tables[0])
        {
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                area areatmp = new area();
                areatmp.area_id = (int)dt.Rows[i][0];
                areatmp.area_name = dt.Rows[i][1].ToString();
                areatmp.area_parent = (int)dt.Rows[i][2];
                areatmp.area_code = dt.Rows[i][3].ToString();
                areatmp.area_remark = dt.Rows[i][4].ToString();
                areaGrid.Add(areatmp);
            }
        }
        return returnStr = JsonConvert.SerializeObject(areaGrid);
    }
    
    public bool IsReusable {
        get {
            return false;
        }
    }

}