<%@ WebHandler Language="C#" Class="corrEquipHandler" %>

using System;
using System.Web;
using ModelClass;
using Newtonsoft.Json;
using NPE.UIDataClass;
using System.Data;
using System.Collections.Generic;

public class corrEquipHandler : IHttpHandler {
    string sort = "";
    string order = "";

    int rows = 10;
    int page = 1;

    string correlation_id = "";
    string correlation_equip_master_id = "";
    string correlation_equip_servant_id = "";
    public void ProcessRequest (HttpContext context) {
        string action = "";
        context.Response.ContentType = "text/plain";
        if (context.Request.Params["correlation_id"] != null)
        {
            correlation_id = context.Request.Params["correlation_id"];
        }
        if (context.Request.Params["correlation_equip_master_id"] != null)
        {
            correlation_equip_master_id = context.Request.Params["correlation_equip_master_id"];
        }
        if (context.Request.Params["correlation_equip_servant_id"] != null)
        {
            correlation_equip_servant_id = context.Request.Params["correlation_equip_servant_id"];
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
                context.Response.Write(addCorrEquip());
                break;
            case "edit":

                break;
            case "del":
                context.Response.Write(delCorrEquip());
                break;
            case "grid":
                System.Text.StringBuilder sb = new System.Text.StringBuilder();
                sb.Append("{ ");
                sb.Append(string.Format("\"total\":{0},\"rows\":", GeCorrtEquipPageCount()));
                string s = ShowCorrEquipGird();
                sb.Append(s);
                sb.Append("}");
                context.Response.Write(sb.ToString());
                break;
            case "tree":
                context.Response.Write(GetCorrEquipTreeJson());
                break;
            //case "combo":
            //    context.Response.Write(GetCorrEquipComboJson());
            //    break;
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
    private string addCorrEquip() {
        global mGlobal = new global();
        correlation_id=mGlobal.GetIdentityID("PC","SB","GL",System.DateTime.Now,6);
        string mStrSQL = @"insert into t_EquipsCorrelation(correlation_id,correlation_equip_master_id,correlation_equip_servant_id)
                        values('" + correlation_id + "','" + correlation_equip_master_id + "','" + correlation_equip_servant_id + "')";
        int i = claSqlConnDB.ExecuteNonQuery(claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL);
        return i.ToString();
    }
    private string delCorrEquip() {
        string mStrSQL = @"delete from t_EquipsCorrelation where correlation_id='" + correlation_id + "'";
        int i = claSqlConnDB.ExecuteNonQuery(claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL);
        return i.ToString();
    }
    private string GeCorrtEquipPageCount()
    {
        string mStrSQL = @"select count(0) from t_EquipsCorrelation " + GetWhere();
        int i = claSqlConnDB.GetRecordCount(claSqlConnDB.gStrConnDefault, mStrSQL);
        return i.ToString();
    }
    private string ShowCorrEquipGird()
    {
        string mStrReturn = "";
        List<correquip> correquipTemp = new List<correquip>();
        DataTable dt = null;
        string mStrSQL = @"SELECT     t_EquipsCorrelation.correlation_id, t_EquipsCorrelation.correlation_equip_master_id, t_Equips.equip_name AS correlation_equip_master_name, 
                                      t_Equips_1.equip_code AS correlation_equip_master_parent_code, t_Equips_1.equip_name AS correlation_equip_master_parent_name, t_EquipArea.area_id AS correlation_equip_master_area_id, 
                                      t_EquipArea.area_name AS correlation_equip_master_area_name, t_EquipsCorrelation.correlation_equip_servant_id, t_Equips_2.equip_name AS correlation_equip_servant_name, 
                                      t_Equips_3.equip_code AS correlation_equip_servant_parent_code, t_Equips_3.equip_name AS correlation_equip_servant_parent_name, 
                                      t_EquipArea_1.area_id AS correlation_equip_servant_area_id, t_EquipArea_1.area_name AS correlation_equip_servant_area_name
                         FROM         t_Equips AS t_Equips_1 RIGHT OUTER JOIN
                                      t_EquipsCorrelation LEFT OUTER JOIN
                                      t_Equips AS t_Equips_2 LEFT OUTER JOIN
                                      t_EquipArea AS t_EquipArea_1 ON t_Equips_2.area_id = t_EquipArea_1.area_id LEFT OUTER JOIN
                                      t_Equips AS t_Equips_3 ON t_Equips_2.equip_parent = t_Equips_3.equip_code ON t_EquipsCorrelation.correlation_equip_servant_id = t_Equips_2.equip_code LEFT OUTER JOIN
                                      t_Equips ON t_EquipsCorrelation.correlation_equip_master_id = t_Equips.equip_code ON t_Equips_1.equip_code = t_Equips.equip_parent LEFT OUTER JOIN
                                      t_EquipArea ON t_Equips.area_id = t_EquipArea.area_id "
                        + GetWhere() + GetOrder();
        using (dt = claSqlConnDB.ExecuteDataset(rows,page,claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL).Tables[0])
        {
            if (dt.Rows.Count > 0)
            {
                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    correquip mCorrEquip = new correquip();
                    mCorrEquip.correlation_id = dt.Rows[i][0].ToString();
                    mCorrEquip.correlation_equip_master_id = dt.Rows[i][1].ToString();
                    mCorrEquip.correlation_equip_master_name = dt.Rows[i][2].ToString();
                    mCorrEquip.correlation_equip_master_parent_code = dt.Rows[i][3].ToString();
                    mCorrEquip.correlation_equip_master_parent_name = dt.Rows[i][4].ToString();
                    mCorrEquip.correlation_equip_master_area_id = dt.Rows[i][5].ToString();
                    mCorrEquip.correlation_equip_master_area_name = dt.Rows[i][6].ToString();
                    mCorrEquip.correlation_equip_servant_id = dt.Rows[i][7].ToString();
                    mCorrEquip.correlation_equip_servant_name = dt.Rows[i][8].ToString();
                    mCorrEquip.correlation_equip_servant_parent_code = dt.Rows[i][9].ToString();
                    mCorrEquip.correlation_equip_servant_parent_name = dt.Rows[i][10].ToString();
                    mCorrEquip.correlation_equip_servant_area_id = dt.Rows[i][11].ToString();
                    mCorrEquip.correlation_equip_servant_area_name = dt.Rows[i][12].ToString();
                    correquipTemp.Add(mCorrEquip);
                } 
            } 
        }
        mStrReturn = JsonConvert.SerializeObject(correquipTemp);
        return mStrReturn; 
    }
    private string GetCorrEquipTreeJson()
    {
        return JsonConvert.SerializeObject(GetCorrEquipJson(correlation_id));
    }
    private List<TreeNode> GetCorrEquipJson(string vStrCorrelationID) {
        List<TreeNode> mTree = new List<TreeNode>();
        DataTable dt = null;
        string mStrSQL = @"select correlation_id,correlation_equip_master_id,correlation_equip_servant_id from t_EquipsCorrelation";
        using (dt = claSqlConnDB.ExecuteDataset(claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL).Tables[0])
        {
            if (dt.Rows.Count > 0)
            {
                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    TreeNode treeTemp = new TreeNode();
                    treeTemp.id = dt.Rows[i][0].ToString();
                    treeTemp.text = dt.Rows[i][1].ToString();
                    treeTemp.iconCls = "icon-equip";
                    mTree.Add(treeTemp);
                } 
            }
        }
        return mTree;
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