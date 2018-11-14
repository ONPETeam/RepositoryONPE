<%@ WebHandler Language="C#" Class="grouprightHandler" %>

using System;
using System.Web;
using Newtonsoft.Json;
using NPE.UIDataClass;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Generic;
using ModelClass;
using System.Text;
using System.Web.Security;
using System.Web.Script.Serialization;

public class grouprightHandler : IHttpHandler
{

    public void ProcessRequest(HttpContext context)
    {
        context.Response.ContentType = "text/plain";
        string action = "";
        string mStrReturn = "";
        int mIntParamNullable = 0;
        object mObjReturn = null;

        if (context.Request.Params["action"] != null)
        {
            action = context.Request.Params["action"];
        }
        switch (action)
        {
            case "tree":
                string m_tree_group_code = "";
                if (context.Request.Params["group_code"] != null)
                {
                    m_tree_group_code = context.Request.Params["group_code"];
                }
                mObjReturn = GetGroupTree(m_tree_group_code);
                mStrReturn = JsonConvert.SerializeObject(mObjReturn);
                break;
            case "grid":
                int page = 1;
                if (context.Request.Params["page"] != null)
                {
                    if (int.TryParse(context.Request.Params["page"], out page) == false)
                    {
                        page = 1;
                    }
                }
                int rows = 10;
                if (context.Request.Params["rows"] != null)
                {
                    if (int.TryParse(context.Request.Params["rows"], out rows) == false)
                    {
                        rows = 10;
                    }
                }
                int right_class = 1;
                if (context.Request.Params["right_class"] != null)
                {
                    if (int.TryParse(context.Request.Params["right_class"], out right_class) == false)
                    {
                        right_class = 1;
                    }
                }
                string m_grid_group_code = "";
                FormsIdentity id = (FormsIdentity)context.User.Identity;
                FormsAuthenticationTicket ticket = id.Ticket;
                string mStrUerRight = GJHF.Business.User.User.GetUserRight(ticket.UserData, right_class, 3, ",");
                if (mStrUerRight.Length > 1)
                {
                    mStrUerRight = mStrUerRight.Substring(0, mStrUerRight.Length - 1);
                }
                if (context.Request.Params["group_code"] != null)
                {
                    m_grid_group_code = context.Request.Params["group_code"];
                }
                mObjReturn = GetGroupRightGrid(page, rows, m_grid_group_code, mStrUerRight);
                mStrReturn = "{\"total\":" + GetGroupRightCount(m_grid_group_code, mStrUerRight).ToString() + ",\"rows\":" + JsonConvert.SerializeObject(mObjReturn) + "}";
                break;
            case "set":
                string m_set_group_code = "";
                if (context.Request.Params["group_code"] != null)
                {
                    m_set_group_code = context.Request.Params["group_code"];
                }
                else
                {
                    mIntParamNullable = mIntParamNullable + 1;
                }
                string m_set_right_type = "";
                if (context.Request.Params["right_type"] != null)
                {
                    m_set_right_type = context.Request.Params["right_type"];
                }
                else
                {
                    mIntParamNullable = mIntParamNullable + 1;
                }
                string m_set_author_end = "";
                if (context.Request.Params["author_end"] != null)
                {
                    m_set_author_end = context.Request.Params["author_end"];
                }
                string m_set_right_set = "";
                if (context.Request.Params["right_set"] != null)
                {
                    m_set_right_set = context.Request.Params["right_set"];
                }
                if (mIntParamNullable == 0)
                {
                    int mIntSetReturn = SaveGroupRightSet(m_set_group_code, m_set_right_type, m_set_author_end, m_set_right_set);
                    if (mIntSetReturn == 0)
                    {
                        mStrReturn = "{'success':true,'msg':'保存权限组设置成功！'}";
                    }
                    else
                    {
                        mStrReturn = "{'success':false,'msg':'保存权限组设置失败！'}";
                    }
                }
                else
                {
                    mStrReturn = "{'success':false,'msg':'缺少必要参数！'}";
                }
                break;
            default:
                mStrReturn = "{'success':false,'msg':'缺少必要参数！'}";
                break;
        }
        context.Response.Write(mStrReturn);
    }
    private int SaveGroupRightSet(string v_group_code, string v_right_type, string v_author_end, string v_right_set)
    {
        SqlParameter[] parameter = new SqlParameter[]{
            new SqlParameter("@viVchGroupCode",SqlDbType.VarChar,30),
            new SqlParameter("@viIntRightType",SqlDbType.Int,4),
            new SqlParameter("@viVchAuthorEnd",SqlDbType.VarChar,30),
            new SqlParameter("@viVchRightSet",SqlDbType.VarChar,8000),
            new SqlParameter("@voIntReturn",SqlDbType.Int) 
        };
        parameter[0].Value = v_group_code;
        parameter[1].Value = v_right_type;
        parameter[2].Value = v_author_end;
        parameter[3].Value = v_right_set;
        parameter[4].Direction = System.Data.ParameterDirection.Output;
        claSqlConnDB.ExecuteNonQuery(claSqlConnDB.gStrConnDefault, CommandType.StoredProcedure, "p_group_right_set", parameter);
        int i = (int)parameter[4].Value;
        return i;
    }

    private List<groupright> GetGroupRightGrid(int v_page, int v_rows, string v_group_code, string v_user_right)
    {
        List<groupright> mLstGroupRight = new List<groupright>();
        string mStrSQL = @"SELECT   t_rights.right_code, t_rights.right_name, t_rights.right_menugroup, t_menugroup.menugroup_name AS right_menugroup_name, t_rights.right_menu, t_menu.menu_title AS right_menu_title, 
                                    t_rights.right_item, t_menuitem.item_title AS right_item_title, t_groupright.right_type, t_groupright.author_user, t_groupright.author_start, t_groupright.author_end
                           FROM     t_menuitem RIGHT OUTER JOIN
                                    t_rights LEFT OUTER JOIN
                                    t_menugroup ON t_rights.right_menugroup = t_menugroup.menugroup_id LEFT OUTER JOIN
                                    t_menu ON t_rights.right_menu = t_menu.menu_id ON t_menuitem.item_id = t_rights.right_item LEFT OUTER JOIN
                                    t_groupright ON t_rights.right_code = t_groupright.right_code 
                                    and t_groupright.group_code=@group_code
                            Where  t_rights.right_code in ('" + v_user_right.Replace(",", "','") + "')";
        SqlParameter[] parameter = new SqlParameter[]{
            new SqlParameter("@group_code",SqlDbType.VarChar,30)
        };
        parameter[0].Value = v_group_code;
        DataTable dt = null;
        using (dt = claSqlConnDB.ExecuteDataset(v_rows, v_page, claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL, parameter).Tables[0])
        {
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                groupright mGroupRight = new groupright();
                mGroupRight.right_code = dt.Rows[i][0].ToString();
                mGroupRight.right_name = dt.Rows[i][1].ToString();
                mGroupRight.right_menugroup = dt.Rows[i][2].ToString();
                mGroupRight.right_menugroup_name = dt.Rows[i][3].ToString();
                mGroupRight.right_menu = dt.Rows[i][4].ToString();
                mGroupRight.right_menu_title = dt.Rows[i][5].ToString();
                mGroupRight.right_item = dt.Rows[i][6].ToString();
                mGroupRight.right_item_title = dt.Rows[i][7].ToString();
                mGroupRight.right_type = dt.Rows[i][8].ToString();
                mGroupRight.author_user = dt.Rows[i][9].ToString();
                mGroupRight.author_start = dt.Rows[i][10].ToString();
                mGroupRight.author_end = dt.Rows[i][11].ToString();
                mLstGroupRight.Add(mGroupRight);
            }
        }
        return mLstGroupRight;
    }
    private int GetGroupRightCount(string v_group_code, string v_user_right)
    {
        string mStrSQL = @"SELECT COUNT(0) FROM     
                                    t_rights LEFT OUTER JOIN
                                    t_groupright ON t_rights.right_code = t_groupright.right_code 
                                    and t_groupright.group_code=@group_code 
                                    Where  t_rights.right_code in ('" + v_user_right.Replace(",", "','") + "')";
        SqlParameter[] parameters ={
            new SqlParameter("@group_code",SqlDbType.VarChar,30)
        };
        parameters[0].Value = v_group_code;
        int i = claSqlConnDB.GetRecordCount(claSqlConnDB.gStrConnDefault, mStrSQL, parameters);
        return i;
    }

    private List<TreeNode> GetGroupTree(string v_group_code)
    {
        List<TreeNode> mLstTreeNode = new List<TreeNode>();
        mLstTreeNode = GetMenuGroupTree(v_group_code);
        return mLstTreeNode;
    }
    private List<TreeNode> GetMenuGroupTree(string v_group_code)
    {
        List<TreeNode> mLstTreeNode = new List<TreeNode>();
        string mStrSQL = @"SELECT    distinct  t_rights.right_menugroup,t_menugroup.menugroup_name
                            FROM       t_rights left outer join t_menugroup 
                                       on t_menugroup.menugroup_id=t_rights.right_menugroup
                            WHERE     (t_rights.right_class = 1)";
        DataTable dt = null;
        using (dt = claSqlConnDB.ExecuteDataset(claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL).Tables[0])
        {
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                TreeNode mTreeNode = new TreeNode();

                mTreeNode.attributes = dt.Rows[i][0].ToString();
                mTreeNode.id = dt.Rows[i][0].ToString();
                mTreeNode.text = dt.Rows[i][1].ToString();
                mTreeNode.state = "open";
                mTreeNode.ischecked = dt.Rows[i][1].ToString() == "1" ? true : false;
                mTreeNode.children = GetMenuGroupChildTreeNode(v_group_code, dt.Rows[i][0].ToString());
                mLstTreeNode.Add(mTreeNode);
            }
        }
        return mLstTreeNode;
    }
    private int GetMenuTreeNodeCount(string v_menugroup_code)
    {
        string mStrSQL = @"select COUNT(0) 
                            from t_rights 
                            where  t_rights.right_menu <>''
                            and t_rights.right_menugroup=@right_menugroup";
        SqlParameter[] parameters ={
            new SqlParameter("@right_menugroup",SqlDbType.VarChar,30)
        };
        parameters[0].Value = v_menugroup_code;
        int i = claSqlConnDB.GetRecordCount(claSqlConnDB.gStrConnDefault, mStrSQL, parameters);
        return i;
    }
    private List<TreeNode> GetMenuGroupChildTreeNode(string v_group_code, string v_menugroup_code)
    {
        List<TreeNode> mLstTreeNode = new List<TreeNode>();
        DataTable dt = null;
        string mStrSQL = @"select t_rights.right_code, t_rights.right_item,t_menuitem.item_title
                            from t_rights left outer join t_menuitem on t_menuitem.item_id=t_rights.right_item
                            where t_rights.right_menu =''
                            and t_rights.right_menugroup=@right_menugroup";
        SqlParameter[] parameters = new SqlParameter[]{
            new SqlParameter("@right_menugroup",SqlDbType.VarChar,30)
        };
        parameters[0].Value = v_menugroup_code;
        using (dt = claSqlConnDB.ExecuteDataset(claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL, parameters).Tables[0])
        {
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                TreeNode mTreeNode = new TreeNode();

                mTreeNode.attributes = dt.Rows[i][0].ToString();
                mTreeNode.id = dt.Rows[i][1].ToString();
                mTreeNode.text = dt.Rows[i][2].ToString();
                mTreeNode.state = "open";
                mTreeNode.ischecked = dt.Rows[i][2].ToString() == "1" ? true : false;
                mLstTreeNode.Add(mTreeNode);
            }
        }
        mStrSQL = @"select t_rights.right_code, t_rights.right_menu,t_menu.menu_title
                            from t_rights left outer join t_menu on t_menu.menu_id=t_rights.right_menu
                            where  t_rights.right_menu <>'' 
                            and t_rights.right_menugroup=@right_menugroup";
        parameters = new SqlParameter[]{
            new SqlParameter("@right_menugroup",SqlDbType.VarChar,30)
        };
        parameters[0].Value = v_menugroup_code;

        using (dt = claSqlConnDB.ExecuteDataset(claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL, parameters).Tables[0])
        {
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                TreeNode mTreeNode = new TreeNode();

                mTreeNode.attributes = dt.Rows[i][0].ToString();
                mTreeNode.id = dt.Rows[i][1].ToString();
                mTreeNode.text = dt.Rows[i][2].ToString();
                mTreeNode.state = "open";
                mTreeNode.ischecked = dt.Rows[i][2].ToString() == "1" ? true : false;
                mTreeNode.children = GetMenuChildTreeNode(v_group_code, dt.Rows[i][1].ToString()); ;
                mLstTreeNode.Add(mTreeNode);
            }
        }

        return mLstTreeNode;
    }
    private List<TreeNode> GetMenuChildTreeNode(string v_group_code, string v_menu_code)
    {
        List<TreeNode> mLstTreeNode = new List<TreeNode>();
        string mStrSQL = @"select t_rights.right_code, t_rights.right_item,t_menuitem.item_title
                            from t_rights left outer join t_menuitem on t_menuitem.item_id=t_rights.right_item
                            where  t_rights.right_menu=@right_menu";
        SqlParameter[] parameters ={
            new SqlParameter("@right_menu",SqlDbType.VarChar,30)
        };
        parameters[0].Value = v_menu_code;
        DataTable dt = null;
        using (dt = claSqlConnDB.ExecuteDataset(claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL, parameters).Tables[0])
        {
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                TreeNode mTreeNode = new TreeNode();

                mTreeNode.attributes = dt.Rows[i][0].ToString();
                mTreeNode.id = dt.Rows[i][1].ToString();
                mTreeNode.text = dt.Rows[i][2].ToString();
                mTreeNode.state = "open";
                mTreeNode.ischecked = dt.Rows[i][2].ToString() == "1" ? true : false;
                mLstTreeNode.Add(mTreeNode);
            }
        }
        return mLstTreeNode;
    }
    public bool IsReusable
    {
        get
        {
            return false;
        }
    }

}