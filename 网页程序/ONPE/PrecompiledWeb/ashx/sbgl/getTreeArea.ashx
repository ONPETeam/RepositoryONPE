<%@ WebHandler Language="C#" Class="getTreeArea" %>

using System;
using System.Web;
using System.Collections.Generic;
using System.Data.SqlClient;
using Newtonsoft.Json;
using NPE.UIDataClass;
using System.Data;

public class getTreeArea : IHttpHandler
{
    public void ProcessRequest (HttpContext context) {
        context.Response.ContentType = "text/plain";

        //根据节点选择，加载数据
        string area_id = context.Request.Params["areaID"];
        //System.Diagnostics.Debug.WriteLine(str);

        context.Response.Write(GetData(area_id));
    }

    public string GetData(string area_id)
    {
        string returnStr = "";
        returnStr = JsonConvert.SerializeObject(GetArea(null, area_id));
        return returnStr;
    }

    public List<TreeNode> GetArea(TreeNode node, string area_parent)
    {
        List<TreeNode> treeList = new List<TreeNode>();
        DataTable dt = null;
        string lStrSQL = "select area_id,area_name from t_EquipArea where area_parent = " + area_parent;
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

                    treeNodetmp.attributes = "area";
                    if (getCountById(treeNodetmp.id.ToString()) > 0)
                    {
                        treeNodetmp.state = "closed";
                    }
                    else
                    {
                        treeNodetmp.attributes = "lastArea";
                        if (getEquipCountById(treeNodetmp.id.ToString()) > 0)
                        {
                            treeNodetmp.state = "closed";
                        }
                    }
                    
                    //treeNodetmp.state = "closed";
                    treeNodetmp.iconCls = "icon-area";
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
    private int getCountById(string areaId)
    {
        int lIntCount = 0;
        string lStrSQL = "select count(*) from t_EquipArea where area_parent = " + areaId;
        SqlDataReader dr = null;
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
    /// <summary>
    /// 获取数据是否有子节点
    /// </summary>
    /// <param name="areaId"></param>
    /// <returns></returns>
    private int getEquipCountById(string areaId)
    {
        int lIntCount = 0;
        string lStrSQL = "select count(*) from t_equips where area_id = " + areaId;
        SqlDataReader dr = null;
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

    #region 刷全部数据加载
    public string GetAllData(string area_id)
    {
        string returnStr = "";
        returnStr = JsonConvert.SerializeObject(GetAllArea(null, area_id));
        return returnStr;
    }
    public List<TreeNode> GetAllArea(TreeNode node, string area_parent)
    {
        List<TreeNode> treeList = new List<TreeNode>();
        DataTable dt = null;
        string lStrSQL = "select area_id,area_name from t_EquipArea where area_parent = " + area_parent;
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
                    //treeNodetmp.state = "closed";
                    //treeNodetmp.iconCls = "icon-help";
                    treeNodetmp.children = GetArea(treeNodetmp, treeNodetmp.id.ToString());
                    treeList.Add(treeNodetmp);
                }
            }
        }
        return treeList;
    }
    #endregion

    public bool IsReusable {
        get {
            return false;
        }
    }

}