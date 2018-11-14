<%@ WebHandler Language="C#" Class="rolerightHandler" %>

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

public class rolerightHandler : IHttpHandler
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
                string m_grid_role_code = "";
                if (context.Request.Params["role_code"] != null)
                {
                    m_grid_role_code = context.Request.Params["role_code"];
                }
                FormsIdentity id = (FormsIdentity)context.User.Identity;
                FormsAuthenticationTicket ticket = id.Ticket;
                string mStrUerRight = GJHF.Business.User.User.GetUserRight(ticket.UserData, right_class, 3, ",");
                if (mStrUerRight.Length > 1)
                {
                    mStrUerRight = mStrUerRight.Substring(0, mStrUerRight.Length - 1);
                }
                mObjReturn = GetRoleRightGrid(page, rows, m_grid_role_code, mStrUerRight);
                mStrReturn = "{\"total\":" + GetRoleRightCount(m_grid_role_code, mStrUerRight).ToString() + ",\"rows\":" + JsonConvert.SerializeObject(mObjReturn) + "}";
                break;
            case "set":
                string m_set_role_code = "";
                if (context.Request.Params["role_code"] != null)
                {
                    m_set_role_code = context.Request.Params["role_code"];
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
                    int mIntSetReturn = SaveRoleRightSet(m_set_role_code, m_set_right_type, m_set_author_end, m_set_right_set);
                    if (mIntSetReturn == 0)
                    {
                        mStrReturn = "{\"success\":true,\"msg\":\"保存权限组设置成功！\"}";
                    }
                    else
                    {
                        mStrReturn = "{\"success\":false,\"msg\":\"保存权限组设置失败！\"}";
                    }
                }
                else
                {
                    mStrReturn = "{\"success\":false,\"msg\":\"缺少必要参数！\"}";
                }
                break;
            default:
                mStrReturn = "{\"success\":false,\"msg\":\"缺少必要参数！\"}";
                break;
        }
        context.Response.Write(mStrReturn);
    }
    private int SaveRoleRightSet(string v_Role_code, string v_right_type, string v_author_end, string v_right_set)
    {
        SqlParameter[] parameter = new SqlParameter[]{
            new SqlParameter("@viVchRoleCode",SqlDbType.VarChar,30),
            new SqlParameter("@viIntRightType",SqlDbType.Int,4),
            new SqlParameter("@viVchAuthorEnd",SqlDbType.VarChar,30),
            new SqlParameter("@viVchRightSet",SqlDbType.VarChar,8000),
            new SqlParameter("@voIntReturn",SqlDbType.Int) 
        };
        parameter[0].Value = v_Role_code;
        parameter[1].Value = v_right_type;
        parameter[2].Value = v_author_end;
        parameter[3].Value = v_right_set;
        parameter[4].Direction = System.Data.ParameterDirection.Output;
        claSqlConnDB.ExecuteNonQuery(claSqlConnDB.gStrConnDefault, CommandType.StoredProcedure, "p_role_right_set", parameter);
        int i = (int)parameter[4].Value;
        return i;
    }

    private List<roleright> GetRoleRightGrid(int v_page, int v_rows, string v_role_code, string v_user_right)
    {
        List<roleright> mLstRoleRight = new List<roleright>();
        string mStrSQL = @"SELECT     t_rights.right_code, t_rights.right_name, t_rights.right_menugroup, t_menugroup.menugroup_name AS right_menugroup_name, t_rights.right_menu, t_menu.menu_title AS right_menu_title, 
                                    t_rights.right_item, t_menuitem.item_title AS right_item_title, t_roleright.right_type, t_roleright.author_user, t_roleright.author_start, t_roleright.author_end
                           FROM     t_menuitem RIGHT OUTER JOIN
                                    t_rights LEFT OUTER JOIN
                                    t_menugroup ON t_rights.right_menugroup = t_menugroup.menugroup_id LEFT OUTER JOIN
                                    t_menu ON t_rights.right_menu = t_menu.menu_id ON t_menuitem.item_id = t_rights.right_item LEFT OUTER JOIN
                                    t_roleright ON t_rights.right_code = t_roleright.right_code 
                                    and t_roleright.role_code=@role_code
                            Where   t_rights.right_code in ('" + v_user_right.Replace(",", "','") + "')";
        SqlParameter[] parameter = new SqlParameter[]{
            new SqlParameter("@role_code",SqlDbType.VarChar,30)
        };
        parameter[0].Value = v_role_code;
        DataTable dt = null;
        using (dt = claSqlConnDB.ExecuteDataset(v_rows, v_page, claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL, parameter).Tables[0])
        {
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                roleright mRoleRight = new roleright();
                mRoleRight.right_code = dt.Rows[i][0].ToString();
                mRoleRight.right_name = dt.Rows[i][1].ToString();
                mRoleRight.right_menugroup = dt.Rows[i][2].ToString();
                mRoleRight.right_menugroup_name = dt.Rows[i][3].ToString();
                mRoleRight.right_menu = dt.Rows[i][4].ToString();
                mRoleRight.right_menu_title = dt.Rows[i][5].ToString();
                mRoleRight.right_item = dt.Rows[i][6].ToString();
                mRoleRight.right_item_title = dt.Rows[i][7].ToString();
                mRoleRight.right_type = dt.Rows[i][8].ToString();
                mRoleRight.author_user = dt.Rows[i][9].ToString();
                mRoleRight.author_start = dt.Rows[i][10].ToString();
                mRoleRight.author_end = dt.Rows[i][11].ToString();
                mLstRoleRight.Add(mRoleRight);
            }
        }
        return mLstRoleRight;
    }
    private int GetRoleRightCount(string v_role_code, string v_user_right)
    {
        string mStrSQL = @"SELECT COUNT(0) FROM     
                                    t_rights LEFT OUTER JOIN
                                    t_roleright ON t_rights.right_code = t_roleright.right_code 
                                    and t_roleright.role_code=@role_code 
                            Where   t_rights.right_code in ('" + v_user_right.Replace(",", "','") + "')";
        SqlParameter[] parameters ={
            new SqlParameter("@role_code",SqlDbType.VarChar,30)
        };
        parameters[0].Value = v_role_code;
        int i = claSqlConnDB.GetRecordCount(claSqlConnDB.gStrConnDefault, mStrSQL, parameters);
        return i;
    }
    public bool IsReusable
    {
        get
        {
            return false;
        }
    }

}