<%@ WebHandler Language="C#" Class="getAreaProperty" %>

using System;
using System.Web;
using NPE.UIDataClass;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using Newtonsoft.Json;

public class getAreaProperty : IHttpHandler {
    
    public void ProcessRequest (HttpContext context) {
        context.Response.ContentType = "text/plain";

        string nodeId = context.Request.Params["nodeId"];

        context.Response.Write(this.getProperty(nodeId));
    }
 
    private string getProperty(string nodeId)
    {
        string returnStr = "";
        PropertyGrid property = new PropertyGrid();
        List<PropertyGridNode> propertyNode = new List<PropertyGridNode>();

        string lStrSql = @"SELECT     t_EquipArea.area_id AS 区域编号, t_EquipArea.area_name AS 区域名称, t_EquipArea_1.area_name AS 上级区域, t_EquipArea.area_code AS 区域编码
                            FROM         t_EquipArea LEFT OUTER JOIN
                                                  t_EquipArea AS t_EquipArea_1 ON t_EquipArea.area_parent = t_EquipArea_1.area_id
                            WHERE     t_EquipArea.area_id =  " + nodeId;
        DataTable dt = null;
        using(dt = claSqlConnDB.ExecuteDataset(claSqlConnDB.gStrConnDefault,CommandType.Text,lStrSql).Tables[0])
        {
            property.total = dt.Columns.Count;
            for(int i=0;i<dt.Columns.Count;i++)
            {
                PropertyGridNode propertytmp = new PropertyGridNode();
                propertytmp.name = dt.Columns[i].ColumnName;
                propertytmp.value = dt.Rows[0][i].ToString();
                propertytmp.group = "区域";
                propertytmp.editor = "text";
                propertyNode.Add(propertytmp);
            }
            property.rows = propertyNode;
        }
        return returnStr = JsonConvert.SerializeObject(property);
    }

    public bool IsReusable {
        get {
            return false;
        }
    }

}