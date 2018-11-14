<%@ WebHandler Language="C#" Class="munugroupmenuHandler" %>

using System;
using System.Web;
using Newtonsoft.Json;
using NPE.UIDataClass;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Generic;
using ModelClass;
using System.Text;


public class munugroupmenuHandler : IHttpHandler
{
    int page = 1;
    int rows = 10;
    string order = "";
    string sort = "";
    RequestReturn mRequestReturn = new RequestReturn();
    public void ProcessRequest(HttpContext context)
    {
        string action = "";
        string mStrReturn = "";
        object mObjDetial = null;
        string mStrMsg = "";
        int mIntParamNullable = 0;
        context.Response.ContentType = "text/plain";
        action = context.Request.Params["action"];
        switch (action)
        {
            case "grid":
                order = context.Request.Params["order"];
                sort = context.Request.Params["sort"];
                if (int.TryParse(context.Request.Params["page"], out page) == false)
                {
                    page = 1;
                }
                if (int.TryParse(context.Request.Params["rows"], out rows) == false)
                {
                    rows = 10;
                }
                string m_grid_menu_id = "";
                if (context.Request.Params["menu_id"] != null)
                {
                    m_grid_menu_id = context.Request.Params["menu_id"];
                }
                string m_grid_menugroup_id = "";
                if (context.Request.Params["menugroup_id"] != null)
                {
                    m_grid_menugroup_id = context.Request.Params["menugroup_id"];
                }
                mObjDetial = GetMenugroupMenuGrid(m_grid_menu_id, m_grid_menugroup_id, sort, order);
                mStrMsg = string.Format("\"total\":{0},\"rows\":", GetMenugroupMenuCount(m_grid_menu_id, m_grid_menugroup_id));
                mStrReturn = "{" + mStrMsg + JsonConvert.SerializeObject(mObjDetial) + "}";
                break;
            case "menutree":
                string m_menutree_menugroup_id = "";
                if (context.Request.Params["menugroup_id"] != null)
                {
                    m_menutree_menugroup_id = context.Request.Params["menugroup_id"];
                }
                int m_menutree_menu_class = 0;
                if (context.Request.Params["menu_class"] != null)
                {
                    if (int.TryParse(context.Request.Params["menu_class"], out m_menutree_menu_class) == false)
                    {
                        m_menutree_menu_class = 0;
                    }
                }
                mObjDetial = GetMenuTreeByMenugroupID(m_menutree_menugroup_id, m_menutree_menu_class);
                mStrReturn = JsonConvert.SerializeObject(mObjDetial).Replace("ischecked", "checked");
                break;
            case "menugrid":
                order = context.Request.Params["order"];
                sort = context.Request.Params["sort"];
                if (int.TryParse(context.Request.Params["page"], out page) == false)
                {
                    page = 1;
                }
                if (int.TryParse(context.Request.Params["rows"], out rows) == false)
                {
                    rows = 10;
                }
                string m_menugrid_menugroup_id = "";
                if (context.Request.Params["menugroup_id"] != null)
                {
                    m_menugrid_menugroup_id = context.Request.Params["menugroup_id"];
                }
                mObjDetial = GetMenuGridByMenugroupID(m_menugrid_menugroup_id, page, rows, sort, order);
                mStrMsg = string.Format("\"total\":{0},\"rows\":", GetMenuGridCount(m_menugrid_menugroup_id));
                mStrReturn = "{" + mStrMsg + JsonConvert.SerializeObject(mObjDetial) + "}";
                break;
            case "setmenu":
                string m_set_menugroup_id = "";
                string m_set_menu_select = "";
                if (context.Request.Params["menugroup_id"] != null)
                {
                    m_set_menugroup_id = context.Request.Params["menugroup_id"];
                }
                else
                {
                    mIntParamNullable += 1;
                }
                if (context.Request.Params["menu_select"] != null)
                {
                    m_set_menu_select = context.Request.Params["menu_select"];
                    List<menugroupmenu> mLstMenuGroupMenu=new List<menugroupmenu>();
                    try
                    {
                        mLstMenuGroupMenu = JsonConvert.DeserializeObject<List<menugroupmenu>>(m_set_menu_select);
                    }
                    catch (Exception e)
                    {
                        mLstMenuGroupMenu = null; 
                    }
                    m_set_menu_select = "";
                    for (int i = 0; i < mLstMenuGroupMenu.Count; i++)
                    {
                        m_set_menu_select += mLstMenuGroupMenu[i].menu_id.ToString()
                            + "-"
                            + mLstMenuGroupMenu[i].menu_no.ToString()
                            + "-"
                            + mLstMenuGroupMenu[i].menu_sort.ToString()+",";
                    }
                }
                else
                {
                    mIntParamNullable += 1;
                }
                if (mIntParamNullable == 0)
                {
                    int mIntSetMenuReturn = SetMenu(m_set_menugroup_id, m_set_menu_select);
                    if (mIntSetMenuReturn == 0)
                    {
                        mStrReturn = "{'success':'true','msg':'设置菜单成功！'}";
                    }
                    else
                    {
                        mStrReturn = "{'success':'false','msg':'设置菜单失败！'}";
                    }
                }
                else
                {
                    mStrReturn = "{'success':'false','msg':'缺少必要参数'}";
                }
                break;
            default:
                break;
        }
        context.Response.Write(mStrReturn);
    }
    private int SetMenu(string v_menugroup_id, string v_menu_select)
    {
        SqlParameter[] _Parameter = new SqlParameter[3]
            {
                new SqlParameter("@viVchMenuGroupID",SqlDbType.VarChar,30),
                new SqlParameter("@viVchMenuSelect",SqlDbType.VarChar,8000),
                new SqlParameter("@voIntReturn",SqlDbType.Int),
            };
        _Parameter[0].Value = v_menugroup_id;
        _Parameter[1].Value = v_menu_select;
        _Parameter[2].Direction = System.Data.ParameterDirection.Output;
        claSqlConnDB.ExecuteNonQuery(claSqlConnDB.gStrConnDefault, CommandType.StoredProcedure, "p_menugroup_menu_set", _Parameter);
        int i = (int)_Parameter[2].Value;
        return i;
    }
    private int GetMenuGridCount(string v_menugroup_id)
    {
        string mStrSQL = @" select count(0) FROM t_menu ";
        int i = claSqlConnDB.GetRecordCount(claSqlConnDB.gStrConnDefault, mStrSQL);
        return i;
    }
    private List<menugroupmenu> GetMenuGridByMenugroupID(string v_menugroup_id, int page, int rows, string v_sort, string v_order)
    {
        List<menugroupmenu> mLstMenugroupMenu = new List<menugroupmenu>();
        string mStrSQL = @"SELECT   t_menu.menu_id,  
                                    t_menu.menu_title, 
                                    t_menugroup_menu.menu_no, 
                                    t_menugroup_menu.menu_sort, 
                                    case when not t_menugroup_menu.menugroup_id IS null then 1 else 0 end
                           FROM     t_menugroup_menu right OUTER JOIN
                                    t_menu ON t_menugroup_menu.menu_id = t_menu.menu_id 
                                           and t_menugroup_menu.menugroup_id=@menugroup_id"
                                            + GetSort(v_sort, v_order);
        SqlParameter[] parameter = new SqlParameter[]{
            new SqlParameter("@menugroup_id",SqlDbType.VarChar,30)
        };
        DataTable dt = null;
        using (dt = claSqlConnDB.ExecuteDataset(rows, page, claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL, parameter).Tables[0])
        {
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                menugroupmenu mMenugroupMenu = new menugroupmenu();
                mMenugroupMenu.menu_id = dt.Rows[i][0].ToString();
                mMenugroupMenu.menu_title = dt.Rows[i][1].ToString();
                mMenugroupMenu.menu_no = dt.Rows[i][2].ToString();
                mMenugroupMenu.menu_sort = dt.Rows[i][3].ToString();
                mMenugroupMenu.menugroup_id = dt.Rows[i][4].ToString();
                mLstMenugroupMenu.Add(mMenugroupMenu);
            }
        }
        return mLstMenugroupMenu;
    }
    private List<TreeNode> GetMenuTreeByMenugroupID(string v_menugroup_id ,int v_menu_class)
    {
        List<TreeNode> mLstTreeNode = new List<TreeNode>();
        string mStrSQL = @"select t_menu.menu_id,t_menu.menu_title, 
                            case 
                                when not t_menugroup_menu.menugroup_id IS null 
                                then 1 
                                else 0 
                                end,t_menu.menu_iconcls
		                    from t_menu left outer join
		                    t_menugroup_menu on (t_menugroup_menu.menu_id=t_menu.menu_id 
			                    and t_menugroup_menu.menugroup_id='" + v_menugroup_id +
                         @"') where t_menu.menu_class=" + v_menu_class;

        DataTable dt = null;
        using (dt = claSqlConnDB.ExecuteDataset(claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL).Tables[0])
        {
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                TreeNode mTreeNode = new TreeNode();
                mTreeNode.id = dt.Rows[i][0].ToString();
                mTreeNode.text = dt.Rows[i][1].ToString();
                mTreeNode.ischecked = dt.Rows[i][2].ToString() == "0" ? false : true;
                mTreeNode.attributes = dt.Rows[i][0].ToString();
                mTreeNode.iconCls = dt.Rows[i][3].ToString();
                mLstTreeNode.Add(mTreeNode);
            }
        }
        return mLstTreeNode;
    }
    private int GetMenugroupMenuCount(string v_menu_id, string v_menugroup_id)
    {
        string mStrSQL = @" select count(0) FROM     t_menugroup_menu LEFT OUTER JOIN
                                    t_menu ON t_menugroup_menu.menu_id = t_menu.menu_id " + GetWhere(v_menu_id, v_menugroup_id);
        int i = claSqlConnDB.GetRecordCount(claSqlConnDB.gStrConnDefault, mStrSQL);
        return i;
    }
    private List<menugroupmenu> GetMenugroupMenuGrid(string v_menu_id, string v_menugroup_id, string v_sort, string v_order)
    {
        List<menugroupmenu> mLstMenugroupMenu = new List<menugroupmenu>();
        string mStrSQL = @"SELECT     t_menu.menu_id, t_menu.menu_name, t_menu.menu_title, t_menu.menu_link, t_menugroup_menu.menu_no, t_menugroup_menu.menu_sort,
                                    t_menu.menu_iconcls
                           FROM     t_menugroup_menu LEFT OUTER JOIN
                                    t_menu ON t_menugroup_menu.menu_id = t_menu.menu_id " + GetWhere(v_menu_id, v_menugroup_id) + " order by t_menugroup_menu.menu_no,t_menugroup_menu.menu_sort";
        DataTable dt = null;
        using (dt = claSqlConnDB.ExecuteDataset(claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL).Tables[0])
        {
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                menugroupmenu mMenugroupMenu = new menugroupmenu();
                mMenugroupMenu.menu_id = dt.Rows[i][0].ToString();
                mMenugroupMenu.menu_name = dt.Rows[i][1].ToString();
                mMenugroupMenu.menu_title = dt.Rows[i][2].ToString();
                mMenugroupMenu.menu_link = dt.Rows[i][3].ToString();
                mMenugroupMenu.menu_no = dt.Rows[i][4].ToString();
                mMenugroupMenu.menu_sort = dt.Rows[i][5].ToString();
                mMenugroupMenu.menu_iconcls = dt.Rows[i][6].ToString();
                mLstMenugroupMenu.Add(mMenugroupMenu);
            }
        }
        return mLstMenugroupMenu;
    }

    private string GetWhere(string v_menu_id, string v_menugroup_id)
    {
        string mStrWhere = "";
        if (v_menu_id != "")
        {
            if (mStrWhere != "")
            {
                mStrWhere = mStrWhere + " AND t_menugroup_menu.menu_id ='" + v_menu_id + "'";
            }
            else
            {
                mStrWhere = " WHERE t_menugroup_menu.menu_id ='" + v_menu_id + "'";
            }
        }
        if (v_menugroup_id != "")
        {
            if (mStrWhere != "")
            {
                mStrWhere = mStrWhere + " AND t_menugroup_menu.menugroup_id ='" + v_menugroup_id + "'";
            }
            else
            {
                mStrWhere = " WHERE t_menugroup_menu.menugroup_id ='" + v_menugroup_id + "'";
            }
        }
        return mStrWhere;
    }
    private string GetSort(string v_grid_sort, string v_grid_order)
    {
        string mStrSort = "";
        if (v_grid_sort != "" && v_grid_sort != null)
        {
            mStrSort = " order by t_menu." + v_grid_sort;
            if (v_grid_order != "" && v_grid_order != null)
            {
                mStrSort = mStrSort + " " + v_grid_order;
            }
        }
        return mStrSort;
    }
    public bool IsReusable
    {
        get
        {
            return false;
        }
    }

}