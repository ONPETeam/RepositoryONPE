<%@ WebHandler Language="C#" Class="getEquipProperty" %>

using System;
using System.Web;
using NPE.UIDataClass;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using Newtonsoft.Json;

public class getEquipProperty : IHttpHandler {
    
    public void ProcessRequest (HttpContext context) {
        context.Response.ContentType = "text/plain";
        string nodeId = context.Request.Params["nodeId"];
        context.Response.Write(this.getProperty(nodeId));
    }
    private string getProperty(string nodeId)
    {
        string mStrReturn = "";
        PropertyGrid property = new PropertyGrid();
        List<PropertyGridNode> propertyNode = new List<PropertyGridNode>();

        string lStrSql = @"SELECT     t_Equips.equip_code AS 设备编号, t_Equips.equip_innum AS 设备编码, t_Equips.equip_name AS 设备名称, t_Equips.equip_mark AS 设备符号, t_Equips.equip_type AS 设备型号, 
                                                  t_Equips_1.equip_name AS 上级设备名称, t_EquipArea.area_name AS 区域名称, tHRBranchInfo.dVchBranchName AS 管理部门, tHRBranchInfo_1.dVchBranchName AS 维护部门, 
                                                  t_Equips.equip_header AS 负责人
                            FROM         t_EquipArea RIGHT OUTER JOIN
                                                  t_Equips LEFT OUTER JOIN
                                                  tHRBranchInfo AS tHRBranchInfo_1 ON t_Equips.equip_checkDep = tHRBranchInfo_1.dIntBranchID LEFT OUTER JOIN
                                                  tHRBranchInfo ON t_Equips.equip_manageDep = tHRBranchInfo.dIntBranchID ON t_EquipArea.area_id = t_Equips.area_id LEFT OUTER JOIN
                                                  t_Equips AS t_Equips_1 ON t_Equips.equip_parent = t_Equips_1.equip_code
                            WHERE     t_Equips.equip_code = '" + nodeId + "'";
        DataTable dt = null;
        using (dt = claSqlConnDB.ExecuteDataset(claSqlConnDB.gStrConnDefault, CommandType.Text, lStrSql).Tables[0])
        {
            property.total = dt.Columns.Count;
            for (int i = 0; i < dt.Columns.Count; i++)
            {
                PropertyGridNode propertytmp = new PropertyGridNode();
                propertytmp.name = dt.Columns[i].ColumnName;
                propertytmp.value = dt.Rows[0][i].ToString();
                propertytmp.group = "设备";
                propertytmp.editor = "text";
                propertyNode.Add(propertytmp);
            }
            property.rows = propertyNode;
        }
         return mStrReturn = JsonConvert.SerializeObject(property);
       
    }
    public bool IsReusable {
        get {
            return false;
        }
    }

}