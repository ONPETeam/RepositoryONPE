<%@ WebHandler Language="C#" Class="areaHandler" %>

using System;
using System.Web;
using ModelClass;
using Newtonsoft.Json;
using NPE.UIDataClass;
using System.Data;
using System.Collections.Generic;
using System.Data.SqlClient;

public class areaHandler : IHttpHandler
{
    string area_id = "";
    string area_name = "";
    string area_parent = "";
    string area_code = "";
    string area_remark = "";

    string sort = "";
    string order = "";

    int rows = 10;
    int page = 1;
    int type = 0;

    int mIntNullableParam = 0;
    string mStrReturn = "";
    object mObjReturn = "";
    public void ProcessRequest(HttpContext context)
    {
        context.Response.ContentType = "text/plain";
        string action = "";
        if (context.Request.Params["action"] != null)
        {
            action = context.Request.Params["action"];
        }
        switch (action.ToLower())
        {
            case "add":
                string m_add_area_name = "";
                if (context.Request.Params["area_name"] != null)
                {
                    m_add_area_name = context.Request.Params["area_name"].ToString();
                    if (m_add_area_name == "")
                    {
                        mIntNullableParam = mIntNullableParam + 1;
                    }
                }
                else
                {
                    mIntNullableParam = mIntNullableParam + 1;
                }
                int m_add_area_parent = 0;
                if (context.Request.Params["area_parent"] != null)
                {
                    if (int.TryParse(context.Request.Params["area_parent"].ToString(), out m_add_area_parent) == false)
                    {
                        m_add_area_parent = 0;
                    }
                }
                string m_add_area_code = "";
                if (context.Request.Params["area_code"] != null)
                {
                    m_add_area_code = context.Request.Params["area_code"].ToString();
                }
                string m_add_area_remark = "";
                if (context.Request.Params["area_remark"] != null)
                {
                    m_add_area_remark = context.Request.Params["area_remark"].ToString();
                }
                if (mIntNullableParam == 0)
                {
                    mObjReturn = AddAreaData(m_add_area_name, m_add_area_parent, m_add_area_code, m_add_area_remark);
                    if (mObjReturn.ToString() == "1")
                    {
                        mStrReturn = "{'success':true,'msg':'添加数据成功！'}";
                    }
                    else
                    {
                        mStrReturn = "{'success':false,'msg':'添加数据失败！'}";
                    }
                }
                else
                {
                    mStrReturn = "{'success':false,'msg':'缺少必要参数！'}";
                }
                break;
            case "edit":
                int m_edit_area_id = 0;
                if (context.Request.Params["area_id"] != null)
                {
                    if (int.TryParse(context.Request.Params["area_id"], out m_edit_area_id) == false)
                    {
                        mIntNullableParam = mIntNullableParam + 1;
                    }
                }
                else
                {
                    mIntNullableParam = mIntNullableParam + 1;
                }
                string m_edit_area_name = "";
                if (context.Request.Params["area_name"] != null)
                {
                    m_edit_area_name = context.Request.Params["area_name"].ToString();
                    if (m_edit_area_name == "")
                    {
                        mIntNullableParam = mIntNullableParam + 1;
                    }
                }
                else
                {
                    mIntNullableParam = mIntNullableParam + 1;
                }
                int m_edit_area_parent = 0;
                if (context.Request.Params["area_parent"] != null)
                {
                    if (int.TryParse(context.Request.Params["area_parent"].ToString(), out m_edit_area_parent) == false)
                    {
                        m_edit_area_parent = 0;
                    }
                }
                string m_edit_area_code = "";
                if (context.Request.Params["area_code"] != null)
                {
                    m_edit_area_code = context.Request.Params["area_code"].ToString();
                }
                string m_edit_area_remark = "";
                if (context.Request.Params["area_remark"] != null)
                {
                    m_edit_area_remark = context.Request.Params["area_remark"].ToString();
                }
                if (mIntNullableParam == 0)
                {
                    mObjReturn = EditAreaData(m_edit_area_id, m_edit_area_name, m_edit_area_parent, m_edit_area_code, m_edit_area_remark);
                    if (mObjReturn.ToString() == "1")
                    {
                        mStrReturn = "{'success':true,'msg':'编辑数据成功！'}";
                    }
                    else
                    {
                        mStrReturn = "{'success':false,'msg':'编辑数据失败！'}";
                    }
                }
                else
                {
                    mStrReturn = "{'success':false,'msg':'缺少必要参数！'}";
                }
                break;
            case "del":
                int m_del_area_id = 0;
                if (context.Request.Params["area_id"] != null)
                {
                    if (int.TryParse(context.Request.Params["area_id"], out m_del_area_id) == false)
                    {
                        mIntNullableParam = mIntNullableParam + 1;
                    }
                }
                else
                {
                    mIntNullableParam = mIntNullableParam + 1;
                }
                if (mIntNullableParam == 0)
                {
                    mObjReturn = DelAreaData(m_del_area_id);
                    if (mObjReturn.ToString() == "1")
                    {
                        mStrReturn = "{'success':true,'msg':'删除数据成功！'}";
                    }
                    else
                    {
                        mStrReturn = "{'success':false,'msg':'删除数据失败！'}";
                    }
                }
                else
                {
                    mStrReturn = "{'success':false,'msg':'缺少必要参数！'}";
                }
                break;
            case "show"://grid
                int m_grid_page = 1;
                if (context.Request.Params["page"] != null)
                {
                    if (int.TryParse(context.Request.Params["page"], out m_grid_page) == false)
                    {
                        m_grid_page = 1;
                    }
                }
                int m_grid_row = 10;
                if (context.Request.Params["rows"] != null)
                {
                    if (int.TryParse(context.Request.Params["rows"], out m_grid_row) == false)
                    {
                        m_grid_row = 10;
                    }
                }
                string m_grid_area_name = "";
                if (context.Request.Params["area_name"] != null)
                {
                    m_grid_area_name = context.Request.Params["area_name"].ToString();
                }
                int m_grid_area_parent = -1;
                if (context.Request.Params["area_parent"] != null)
                {
                    if (int.TryParse(context.Request.Params["area_parent"], out m_grid_area_parent) == false)
                    {
                        m_grid_area_parent = -1;
                    }
                }
                string m_grid_area_code = "";
                if (context.Request.Params["area_code"] != null)
                {
                    m_grid_area_code = context.Request.Params["area_code"].ToString();
                }
                string m_grid_sort = "";
                if (context.Request.Params["sort"] != null)
                {
                    m_grid_sort = context.Request.Params["sort"].ToString();
                }
                string m_grid_order = "";
                if (context.Request.Params["order"] != null)
                {
                    m_grid_order = context.Request.Params["order"].ToString();
                }
                mObjReturn = GetAreaGridData(m_grid_page, m_grid_row, m_grid_area_name, m_grid_area_parent, m_grid_area_code, m_grid_sort, m_grid_order);
                mStrReturn = "{\"total\":" + GetAreaNum(m_grid_area_name, m_grid_area_parent, m_grid_area_code) + ",\"rows\":" + JsonConvert.SerializeObject(mObjReturn) + "}";
                break;
            case "tree":
                int m_tree_area_parent = -1;
                if (context.Request.Params["area_parent"] != null)
                {
                    if (int.TryParse(context.Request.Params["area_parent"], out m_tree_area_parent) == false)
                    {
                        m_tree_area_parent = -1;
                    }
                }
                mObjReturn = GetAreaTree(m_tree_area_parent);
                mStrReturn = JsonConvert.SerializeObject(mObjReturn);
                break;
            case "combo":
                int m_combo_area_parent = -1;
                if (context.Request.Params["area_parent"] != null)
                {
                    if (int.TryParse(context.Request.Params["area_parent"], out m_combo_area_parent) == false)
                    {
                        m_combo_area_parent = -1;
                    }
                }
                int m_combo_type = 0;
                if (context.Request.Params["type"] != null)
                {
                    if (int.TryParse(context.Request.Params["type"], out m_combo_type) == false)
                    {
                        m_combo_type = 0;
                    }
                }
                mObjReturn = GetAreaCombo(m_combo_area_parent, m_combo_type);
                mStrReturn = JsonConvert.SerializeObject(mObjReturn);
                break;
            case "prop":
                int m_prop_area_id = 0;
                if (context.Request.Params["area_id"] != null)
                {
                    if (int.TryParse(context.Request.Params["area_id"], out m_prop_area_id) == false)
                    {
                        m_prop_area_id = 0;
                    }
                }
                string m_prop_path_separa = ",";
                if (context.Request.Params["path_separa"] != null)
                {
                    m_prop_path_separa = context.Request.Params["path_separa"].ToString(); 
                }
                mObjReturn = GetProperty(m_prop_area_id, m_prop_path_separa);
                mStrReturn = JsonConvert.SerializeObject(mObjReturn); ;
                break;
            case "detail":
                int m_detail_area_id = 0;
                if (context.Request.Params["area_id"] != null)
                {
                    if (int.TryParse(context.Request.Params["area_id"], out m_detail_area_id) == false)
                    {
                        m_detail_area_id = 0;
                    }
                }
                mObjReturn = GetAreaDetail(m_detail_area_id);
                mStrReturn = JsonConvert.SerializeObject(mObjReturn); ;
                break;
            default:
                mStrReturn = "{'success':false,'msg':'缺少必要参数！'}";
                break;

        }
        context.Response.Write(mStrReturn);
    }
    private int AddAreaData(string v_area_name, int v_area_parent, string v_area_code, string v_area_remark)
    {
        int mIntReturn = 0;
        string mStrSQL = @"insert into t_EquipArea(area_name,area_parent,area_code,area_remark) 
                            values(@area_name,@area_parent,@area_code,@area_remark)";
        SqlParameter[] paramerers = new SqlParameter[]{
            new SqlParameter("@area_name",SqlDbType.VarChar,50),
            new SqlParameter("@area_parent",SqlDbType.Int,4),
            new SqlParameter("@area_code",SqlDbType.VarChar,30),
            new SqlParameter("@area_remark",SqlDbType.VarChar,50),
        };
        paramerers[0].Value = v_area_name;
        paramerers[1].Value = v_area_parent;
        paramerers[2].Value = v_area_code;
        paramerers[3].Value = v_area_remark;
        mIntReturn = claSqlConnDB.ExecuteNonQuery(claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL, paramerers);
        return mIntReturn;
    }
    private int EditAreaData(int v_area_id, string v_area_name, int v_area_parent, string v_area_code, string v_area_remark)
    {
        int mIntReturn = 0;
        string mStrSQL = @"update t_EquipArea set 
                        area_name=@area_name,
                        area_parent=@area_parent,
                        area_code=@area_code,
                        area_remark=@area_remark
                            where (area_id=@area_id)";
        SqlParameter[] paramerers = new SqlParameter[]{
            new SqlParameter("@area_id",SqlDbType.Int,4),
            new SqlParameter("@area_name",SqlDbType.VarChar,50),
            new SqlParameter("@area_parent",SqlDbType.Int,4),
            new SqlParameter("@area_code",SqlDbType.VarChar,30),
            new SqlParameter("@area_remark",SqlDbType.VarChar,50),
        };
        paramerers[0].Value = v_area_id;
        paramerers[1].Value = v_area_name;
        paramerers[2].Value = v_area_parent;
        paramerers[3].Value = v_area_code;
        paramerers[4].Value = v_area_remark;
        mIntReturn = claSqlConnDB.ExecuteNonQuery(claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL, paramerers);
        return mIntReturn;
    }
    private int DelAreaData(int v_area_id)
    {
        int mIntReturn = 0;
        string mStrSQL = @"delete from  t_EquipArea 
                            where (area_id=@area_id)";
        SqlParameter[] paramerers = new SqlParameter[]{
            new SqlParameter("@area_id",SqlDbType.Int,4),
        };
        paramerers[0].Value = v_area_id;
        mIntReturn = claSqlConnDB.ExecuteNonQuery(claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL, paramerers);
        return mIntReturn;
    }
    private int GetAreaNum(string v_area_name, int v_area_parent, string v_area_code)
    {
        string mStrSQL = " select count(0) from t_EquipArea " + GetWhere(v_area_name, v_area_parent, v_area_code);
        int i = claSqlConnDB.GetRecordCount(claSqlConnDB.gStrConnDefault, mStrSQL);
        return i;
    }
    private List<area> GetAreaGridData(int v_page, int v_rows, string v_area_name, int v_area_parent, string v_area_code, string v_sort, string v_order)
    {
        List<area> mLstArea = new List<area>();
        string mStrSQL = @"SELECT     t_EquipArea.area_id, t_EquipArea.area_name, t_EquipArea.area_parent, t_EquipArea_1.area_name AS area_parent_name, t_EquipArea.area_code, t_EquipArea.area_remark
                            FROM      t_EquipArea LEFT OUTER JOIN
                                      t_EquipArea AS t_EquipArea_1 ON t_EquipArea.area_parent = t_EquipArea_1.area_id "
                + GetWhere(v_area_name, v_area_parent, v_area_code)
                + GetOrder(v_sort, v_order);
        DataTable dt = null;
        using (dt = claSqlConnDB.ExecuteDataset(v_rows,v_page,claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL).Tables[0])
        {
            if (dt.Rows.Count > 0)
            {
                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    area mAreaTemp = new area();
                    if (dt.Rows[i][0] != null)
                    {
                        mAreaTemp.area_id = int.Parse(dt.Rows[i][0].ToString());
                    }
                    mAreaTemp.area_name = dt.Rows[i][1].ToString();
                    if (dt.Rows[i][2] != null)
                    {
                        mAreaTemp.area_parent = int.Parse(dt.Rows[i][2].ToString());
                        mAreaTemp.area_parent_name = dt.Rows[i][3].ToString();
                    }
                    mAreaTemp.area_code = dt.Rows[i][4].ToString();
                    mAreaTemp.area_remark = dt.Rows[i][5].ToString();
                    mLstArea.Add(mAreaTemp);
                }
            }
        }
        return mLstArea;
    }

    private string GetWhere(string v_area_name, int v_area_parent, string v_area_code)
    {
        string mStrWhere = "";
        if (v_area_name != "")
        {
            if (mStrWhere != "")
            {
                mStrWhere = mStrWhere + " and t_EquipArea.area_name like '%" + v_area_name + "%'";
            }
            else
            {
                mStrWhere = " where t_EquipArea.area_name like '%" + v_area_name + "%'";
            }
        }
        if (v_area_parent != -1)
        {
            if (mStrWhere != "")
            {
                mStrWhere = mStrWhere + " and t_EquipArea.area_parent = " + v_area_parent;
            }
            else
            {
                mStrWhere = " where t_EquipArea.area_parent = " + v_area_parent;
            }
        }
        if (v_area_code != "")
        {
            if (mStrWhere != "")
            {
                mStrWhere = mStrWhere + " and t_EquipArea.area_code like '%" + v_area_code + "%'";
            }
            else
            {
                mStrWhere = " where t_EquipArea.area_code like '%" + v_area_code + "%'";
            }
        }
        return mStrWhere;
    }
    private string GetOrder(string v_sort, string v_order)
    {
        string mStrOrder = "";
        if (v_sort != "")
        {
            mStrOrder = " order by " + v_sort;
            if (v_order != "")
            {
                mStrOrder = mStrOrder + " " + v_order;
            }
        }
        return mStrOrder;
    }

    private int GetAreaTreeNum(int v_area_parent)
    {
        string mStrSQL = " select count(0) from t_EquipArea" + GetWhere("", v_area_parent, "");
        int i = claSqlConnDB.GetRecordCount(claSqlConnDB.gStrConnDefault, mStrSQL);
        return i;
    }
    private int GetTopEquipNum(int v_area_id)
    {
        string mStrSQL = " select count(0) from t_Equips where equip_parent='' and area_id =" + v_area_id;
        int i = claSqlConnDB.GetRecordCount(claSqlConnDB.gStrConnDefault, mStrSQL);
        return i;
    }
    private List<TreeNode> GetAreaTree(int v_area_parent)
    {
        List<TreeNode> mLstTreeNode = new List<TreeNode>();
        DataTable dt = null;
        string mStrSQL = " SELECT  area_id, area_name, area_parent from t_EquipArea "
                        + GetWhere("", v_area_parent, "")
                        + GetOrder("area_name", "");
        using (dt = claSqlConnDB.ExecuteDataset(claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL).Tables[0])
        {
            if (dt.Rows.Count > 0)
            {
                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    TreeNode mTreeNodeTemp = new TreeNode();
                    mTreeNodeTemp.id = dt.Rows[i][0].ToString();
                    mTreeNodeTemp.text = dt.Rows[i][1].ToString();
                    if (GetAreaTreeNum(int.Parse(dt.Rows[i][0].ToString())) > 0)
                    {
                        mTreeNodeTemp.state = "closed";
                        mTreeNodeTemp.attributes = "area";
                    }
                    else
                    {
                        mTreeNodeTemp.attributes = "lastArea";
                        if (GetTopEquipNum(int.Parse(dt.Rows[i][0].ToString())) > 0)
                        {
                            mTreeNodeTemp.state = "closed";
                        }
                        else
                        {
                            mTreeNodeTemp.state = "open";
                        }
                    }
                    mTreeNodeTemp.iconCls = "icon-area";
                    mLstTreeNode.Add(mTreeNodeTemp);
                }
            }
        }
        return mLstTreeNode;
    }
    /// <summary>
    /// 获取区域表ComboTree数据
    /// </summary>
    /// <param name="v_area_parent">上级区域编码</param>
    /// <param name="v_type">为1时，联合搜索区域下是否存在设备</param>
    /// <returns></returns>
    private List<combotree> GetAreaCombo(int v_area_parent, int v_type)
    {
        List<combotree> mLstComboTree = new List<combotree>();
        DataTable dt = null;
        string lStrSQL = "select area_id,area_name from t_EquipArea where area_parent =" + v_area_parent;
        using (dt = claSqlConnDB.ExecuteDataset(claSqlConnDB.gStrConnDefault, System.Data.CommandType.Text, lStrSQL).Tables[0])
        {
            if (dt.Rows.Count > 0)
            {
                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    combotree mComboTreeTemp = new combotree();
                    mComboTreeTemp.id = dt.Rows[i][0].ToString();
                    mComboTreeTemp.text = dt.Rows[i][1].ToString();
                    if (GetAreaTreeNum(int.Parse(dt.Rows[i][0].ToString())) > 0)
                    {
                        mComboTreeTemp.state = "closed";
                        mComboTreeTemp.attributes = "area";
                    }
                    else
                    {
                        mComboTreeTemp.attributes = "lastarea";
                        if (v_type == 1)
                        {
                            if (GetTopEquipNum(int.Parse(dt.Rows[i][0].ToString())) > 0)
                            {
                                mComboTreeTemp.state = "closed";
                            }
                            else
                            {
                                mComboTreeTemp.state = "open";
                            }
                        }
                    }
                    mLstComboTree.Add(mComboTreeTemp);
                }
            }
        }
        return mLstComboTree;
    }


    private area GetAreaDetail(int v_area_id)
    {
        area mArea = new area();
        string mStrSQL = @"SELECT area_id, area_name, area_parent, area_code, area_remark FROM t_EquipArea where area_id=" + v_area_id;
        mArea = (area)claSqlConnDB.GetDetail(claSqlConnDB.gStrConnDefault, mStrSQL, "ModelClass.area", null);
        return mArea;
    }
    private PropertyGrid GetProperty(int v_area_id,string v_path_separa)
    {
        PropertyGrid property = new PropertyGrid();
        List<PropertyGridNode> propertyNode = new List<PropertyGridNode>();

        string lStrSql = @"SELECT     t_EquipArea.area_id AS 区域编号, t_EquipArea.area_name AS 区域名称, t_EquipArea_1.area_name AS 上级区域, t_EquipArea.area_code AS 区域编码,
                            (SELECT path_name + @path_separa FROM f_get_area_full_path(t_EquipArea.area_id) order by path_type,path_level desc  FOR XML PATH('')) as 区域路径
                            FROM         t_EquipArea LEFT OUTER JOIN
                                                  t_EquipArea AS t_EquipArea_1 ON t_EquipArea.area_parent = t_EquipArea_1.area_id
                            WHERE     t_EquipArea.area_id =  @area_id";
        SqlParameter[] parameters = new SqlParameter[]{
            new SqlParameter("@area_id",SqlDbType.Int,4),
            new SqlParameter("@path_separa",SqlDbType.VarChar,10),
        };
        parameters[0].Value = v_area_id;
        parameters[1].Value = v_path_separa;
        DataTable dt = null;
        using (dt = claSqlConnDB.ExecuteDataset(claSqlConnDB.gStrConnDefault, CommandType.Text, lStrSql,parameters).Tables[0])
        {
            property.total = dt.Columns.Count;
            for (int i = 0; i < dt.Columns.Count; i++)
            {
                PropertyGridNode propertytmp = new PropertyGridNode();
                propertytmp.name = dt.Columns[i].ColumnName;
                propertytmp.value = dt.Rows[0][i].ToString();
                propertytmp.group = "区域";
                if (i != 2 && i != 0)
                {
                    propertytmp.editor = "text";
                }

                propertyNode.Add(propertytmp);
            }
            property.rows = propertyNode;
        }
        return property;
    }
    public bool IsReusable
    {
        get
        {
            return false;
        }
    }
}