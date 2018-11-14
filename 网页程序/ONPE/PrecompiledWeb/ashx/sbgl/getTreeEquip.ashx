<%@ WebHandler Language="C#" Class="getTreeEquip" %>

using System;
using System.Web;
using Newtonsoft.Json;
using NPE.UIDataClass;
using System.Data;
using System.Collections.Generic;

public class getTreeEquip : IHttpHandler
{
    List<TreeNode> treeList = new List<TreeNode>();
    public void ProcessRequest (HttpContext context) {
        context.Response.ContentType = "text/plain";
        string area_id = context.Request.Params["nodeID"];
        string type = context.Request.Params["type"];
        switch (type)
        {
            //刷最底层区域的最顶层设备
            case "1":
                context.Response.Write(GetData(area_id));     
                break;
            //设备递归
            case "2":
                context.Response.Write(GetEquipData(area_id));     
                break;     
            default:
                break;
        }
    }

    public string GetData(string areaId)
    {
        string returnStr = "";
        returnStr = JsonConvert.SerializeObject(GetEquip(null, areaId,""));
        return returnStr;
    }
    public string GetEquipData(string equipId)
    {
        string returnStr = "";
        returnStr = JsonConvert.SerializeObject(GetEquipNode(null, equipId));
        return returnStr;
    }
    public List<TreeNode> GetEquip(TreeNode node, string area_id,string equip_parent)
    {

        DataTable dt = null;
        string lStrSQL = "select equip_code,equip_name from t_equips where equip_parent = '"+equip_parent+"' and area_id = '" + area_id +"'";
        using (dt = claSqlConnDB.ExecuteDataset(claSqlConnDB.gStrConnDefault, System.Data.CommandType.Text, lStrSQL).Tables[0])
        {
            if (dt.Rows.Count > 0)
            {
                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    TreeNode treeNodetmp = new TreeNode();
                    treeNodetmp.id = dt.Rows[i][0].ToString();
                    treeNodetmp.text = dt.Rows[i][1].ToString();
                    treeNodetmp.ischecked = true;
                    treeNodetmp.iconCls = "icon-equip";
                    treeNodetmp.attributes = "equip";
                    if (getEquipCountById(treeNodetmp.id.ToString()) > 0)
                    {
                        treeNodetmp.state = "closed";
                    }
                    else
                    {
                        treeNodetmp.state = "open";
                        treeNodetmp.attributes = "lastEquip";
                    }
                    //treeNodetmp.children = GetEquipNode(treeNodetmp, treeNodetmp.id.ToString());
                    treeList.Add(treeNodetmp);
                }
            }
        }
        return treeList;
    }

    private List<TreeNode> GetEquipNode(TreeNode node, string equip_parent)
    {
        List<TreeNode> treeList = new List<TreeNode>();
        DataTable dt = null;
        string lStrSQL = "select equip_code,equip_name from t_equips where equip_parent = '" + equip_parent +"'";
        using (dt = claSqlConnDB.ExecuteDataset(claSqlConnDB.gStrConnDefault, System.Data.CommandType.Text, lStrSQL).Tables[0])
        {
            if (dt.Rows.Count > 0)
            {
                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    TreeNode treeNodetmp = new TreeNode();
                    treeNodetmp.id = dt.Rows[i][0].ToString();
                    treeNodetmp.text = dt.Rows[i][1].ToString();
                    treeNodetmp.ischecked = true;
                    treeNodetmp.iconCls = "icon-equip";
                    treeNodetmp.attributes = "equip";
                    if(getEquipCountById(treeNodetmp.id.ToString())>0)
                    {
                        treeNodetmp.state = "closed";
                    }
                    else
                    {
                        treeNodetmp.state = "open";
                        treeNodetmp.attributes = "lastEquip";
                    }
                    //treeNodetmp.children = GetEquipNode(treeNodetmp, treeNodetmp.id.ToString());//可修改为点击加载
                    treeList.Add(treeNodetmp);
                }
            }
        }
        return treeList;
    }
    /// <summary>
    /// 获取数据是否有子节点
    /// </summary>
    /// <param name="areaId"></param>
    /// <returns></returns>
    private int getEquipCountById(string equipId)
    {
        int lIntCount = 0;
        string lStrSQL = "select count(*) from t_equips where equip_parent = '" + equipId +"'";
        System.Data.SqlClient.SqlDataReader dr = null;
        using (dr = claSqlConnDB.ExecuteReader(claSqlConnDB.gStrConnDefault, CommandType.Text, lStrSQL))
        {
            if (dr.Read())
            {
                lIntCount = dr.GetInt32(0);
            }
            dr.Close();
        }
        return lIntCount;
    }
    public bool IsReusable {
        get {
            return false;
        }
    }

}