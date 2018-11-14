<%@ WebHandler Language="C#" Class="rightsHandler" %>

using System;
using System.Web;
using Newtonsoft.Json;
using NPE.UIDataClass;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Generic;
using ModelClass;
using System.Text;

public class rightsHandler : IHttpHandler
{

    int page = 1;
    int rows = 100;
    string order = "";
    string sort = "";
    public void ProcessRequest(HttpContext context)
    {
        string action = "";
        string mStrReturn = "";
        object mObjDetial = null;
        string mStrMsg = "";
        int mIntParamNullable = 0;
        RequestReturn mRequestReturn = new RequestReturn();
        context.Response.ContentType = "text/plain";
        action = context.Request.Params["action"];
        switch (action)
        {
            case "add":

                string m_add_right_name = "";
                if (context.Request.Params["right_name"] != null)
                {
                    m_add_right_name = context.Request.Params["right_name"];
                }
                else
                {
                    mIntParamNullable = mIntParamNullable + 1;
                }
                string m_add_right_class = "";
                if (context.Request.Params["right_class"] != null)
                {
                    m_add_right_class = context.Request.Params["right_class"];
                }
                else
                {
                    mIntParamNullable = mIntParamNullable + 1;
                }
                string m_add_right_remark = "";
                if (context.Request.Params["right_remark"] != null)
                {
                    m_add_right_remark = context.Request.Params["right_remark"];
                }

                if (mIntParamNullable == 0)
                {
                    mObjDetial = AddRightsData(m_add_right_name, m_add_right_class, m_add_right_remark);
                    if (mObjDetial.ToString() == "2")
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
                string m_edit_right_code = "";
                if (context.Request.Params["right_code"] != null)
                {
                    m_edit_right_code = context.Request.Params["right_code"];
                }
                else
                {
                    mIntParamNullable = mIntParamNullable + 1;
                }
                string m_edit_right_name = "";
                if (context.Request.Params["right_name"] != null)
                {
                    m_edit_right_name = context.Request.Params["right_name"];
                }
                else
                {
                    mIntParamNullable = mIntParamNullable + 1;
                }

                string m_edit_right_class = "";
                if (context.Request.Params["right_class"] != null)
                {
                    m_edit_right_class = context.Request.Params["right_class"];
                }
                else
                {
                    mIntParamNullable = mIntParamNullable + 1;
                }
                string m_edit_right_remark = "";
                if (context.Request.Params["right_remark"] != null)
                {
                    m_edit_right_remark = context.Request.Params["right_remark"];
                }

                if (mIntParamNullable == 0)
                {
                    mObjDetial = EditRightsData(m_edit_right_code, m_edit_right_name, m_edit_right_class, m_edit_right_remark);
                    if (mObjDetial.ToString() == "1")
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
                string m_del_right_code = "";
                if (context.Request.Params["right_code"] != null)
                {
                    m_del_right_code = context.Request.Params["right_code"];
                }
                else
                {
                    mIntParamNullable = mIntParamNullable + 1;
                }
                if (mIntParamNullable == 0)
                {
                    mObjDetial = DelRightsData(m_del_right_code);
                    if (mObjDetial.ToString() == "1")
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
            case "count":
                string m_count_right_code = "";
                if (context.Request.Params["right_code"] != null)
                {
                    m_count_right_code = context.Request.Params["right_code"];
                }
                string m_count_right_name = "";
                if (context.Request.Params["right_name"] != null)
                {
                    m_count_right_name = context.Request.Params["right_name"];
                }
                string m_count_right_menu = "";
                if (context.Request.Params["right_menu"] != null)
                {
                    m_count_right_menu = context.Request.Params["right_menu"];
                }
                string m_count_right_item = "";
                if (context.Request.Params["right_item"] != null)
                {
                    m_count_right_item = context.Request.Params["right_item"];
                }
                string m_count_item_group = "";
                if (context.Request.Params["item_group"] != null)
                {
                    m_count_item_group = context.Request.Params["item_group"];
                }
                string m_count_item_sort = "";
                if (context.Request.Params["item_sort"] != null)
                {
                    m_count_item_sort = context.Request.Params["item_sort"];
                }
                string m_count_right_class = "";
                if (context.Request.Params["right_class"] != null)
                {
                    m_count_right_class = context.Request.Params["right_class"];
                }
                string m_count_right_remark = "";
                if (context.Request.Params["right_remark"] != null)
                {
                    m_count_right_remark = context.Request.Params["right_remark"];
                }
                mObjDetial = GetRightsCount(m_count_right_code, m_count_right_name, m_count_right_menu, m_count_right_item, m_count_right_class, m_count_right_remark);

                mStrReturn = JsonConvert.SerializeObject(mObjDetial);
                break;
            case "grid":
                order = context.Request.Params["order"];
                sort = context.Request.Params["sort"];
                if (int.TryParse(context.Request.Params["page"], out page) == false)
                {
                    page = 1;
                }
                if (int.TryParse(context.Request.Params["rows"], out rows) == false)
                {
                    rows = 100;
                }
                string m_grid_right_code = "";
                if (context.Request.Params["right_code"] != null)
                {
                    m_grid_right_code = context.Request.Params["right_code"];
                }
                string m_grid_right_name = "";
                if (context.Request.Params["right_name"] != null)
                {
                    m_grid_right_name = context.Request.Params["right_name"];
                }
                string m_grid_right_menu = "";
                if (context.Request.Params["right_menu"] != null)
                {
                    m_grid_right_menu = context.Request.Params["right_menu"];
                }
                string m_grid_right_item = "";
                if (context.Request.Params["right_item"] != null)
                {
                    m_grid_right_item = context.Request.Params["right_item"];
                }

                string m_grid_right_class = "";
                if (context.Request.Params["right_class"] != null)
                {
                    m_grid_right_class = context.Request.Params["right_class"];
                }
                string m_grid_right_remark = "";
                if (context.Request.Params["right_remark"] != null)
                {
                    m_grid_right_remark = context.Request.Params["right_remark"];
                }
                mObjDetial = GetRightsData(m_grid_right_code, m_grid_right_name, m_grid_right_menu, m_grid_right_item, m_grid_right_class, m_grid_right_remark, sort, order);
                mStrMsg = string.Format("\"total\":{0},\"rows\":", GetRightsCount(m_grid_right_code, m_grid_right_name, m_grid_right_menu, m_grid_right_item, m_grid_right_class, m_grid_right_remark));
                mStrReturn = "{" + mStrMsg + JsonConvert.SerializeObject(mObjDetial) + "}";
                break;
            case "setfunction":
                string m_set_right_code = "";
                if (context.Request.Params["right_code"] != null)
                {
                    m_set_right_code = context.Request.Params["right_code"];
                }
                else
                {
                    mIntParamNullable = mIntParamNullable + 1;
                }
                string m_set_right_menugroup = "";
                if (context.Request.Params["right_menugroup"] != null)
                {
                    m_set_right_menugroup = context.Request.Params["right_menugroup"];
                }
                else
                {
                    mIntParamNullable = mIntParamNullable + 1;
                }
                string m_set_right_menu = "";
                if (context.Request.Params["right_menu"] != null)
                {
                    m_set_right_menu = context.Request.Params["right_menu"];
                }
                string m_set_right_item = "";
                if (context.Request.Params["right_item"] != null)
                {
                    m_set_right_item = context.Request.Params["right_item"];
                }
                else
                {
                    mIntParamNullable = mIntParamNullable + 1;
                }
                if (mIntParamNullable == 0)
                {
                    int mIntSetReturn = SaveFunctionSet(m_set_right_code, m_set_right_menugroup, m_set_right_menu, m_set_right_item);
                    if (mIntSetReturn == 1)
                    {
                        mStrReturn = "{'success':true,'msg':'设定功能成功！'}";
                    }
                    else
                    {
                        mStrReturn = "{'success':false,'msg':'设定功能失败！'}";
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
    private int SaveFunctionSet(string v_right_code, string v_right_menugroup, string v_right_menu, string v_right_item)
    {
        StringBuilder strSql = new StringBuilder();
        strSql.Append(" UPDATE t_rights set");
        strSql.Append(" right_menugroup=@right_menugroup,");
        strSql.Append(" right_menu=@right_menu,");
        strSql.Append(" right_item=@right_item");
        strSql.Append(" Where right_code=@right_code");
        SqlParameter[] parameters = {
	              new SqlParameter("@right_code", SqlDbType.VarChar,30) ,            
                       new SqlParameter("@right_menugroup", SqlDbType.VarChar,30) ,           
                       new SqlParameter("@right_menu", SqlDbType.VarChar,30) ,            
                       new SqlParameter("@right_item", SqlDbType.VarChar,30)    
            };
        parameters[0].Value = v_right_code;
        parameters[1].Value = v_right_menugroup;
        parameters[2].Value = v_right_menu;
        parameters[3].Value = v_right_item;
        int i = claSqlConnDB.ExecuteNonQuery(claSqlConnDB.gStrConnDefault, CommandType.Text, strSql.ToString(), parameters);
        return i;
    }
    private int AddRightsData(string v_right_name, string v_right_class, string v_right_remark)
    {
        string v_right_code = "";
        global mglobal = new global();
        v_right_code = mglobal.GetIdentityID("PC", "QX", "QX", System.DateTime.Now, 4);
        StringBuilder strSql = new StringBuilder();
        strSql.Append("insert into t_rights(");
        strSql.Append("right_code,right_name,right_class,right_remark");
        strSql.Append(") values (");
        strSql.Append("@right_code,@right_name,@right_class,@right_remark");
        strSql.Append(");");
        strSql.Append(" insert into t_groupright (group_code,right_code,right_type,author_start,author_end)");
        strSql.Append(" values (@group_code,@right_code,5,@author_start,convert(datetime,'1900-01-01 00:00:00',102))");
        SqlParameter[] parameters = {
			             new SqlParameter("@right_code", SqlDbType.VarChar,30) ,            
                         new SqlParameter("@right_name", SqlDbType.VarChar,50) ,
                         new SqlParameter("@right_class", SqlDbType.Int,4) ,            
                         new SqlParameter("@right_remark", SqlDbType.VarChar,100),
                         new SqlParameter("@group_code",SqlDbType.VarChar,30),
                         new SqlParameter("@author_start",SqlDbType.DateTime,12)
            };
        parameters[0].Value = v_right_code;
        parameters[1].Value = v_right_name;
        parameters[2].Value = v_right_class;
        parameters[3].Value = v_right_remark;
        parameters[4].Value = "PCQXRG9999999999";
        parameters[5].Value = System.DateTime.Now;
        int i = claSqlConnDB.ExecuteNonQuery(claSqlConnDB.gStrConnDefault, CommandType.Text, strSql.ToString(), parameters);
        return i;
    }
    private int EditRightsData(string v_right_code, string v_right_name, string v_right_class, string v_right_remark)
    {
        StringBuilder strSql = new StringBuilder();
        strSql.Append(" UPDATE t_rights set");
        strSql.Append(" right_name=@right_name,");
        strSql.Append(" right_class=@right_class,");
        strSql.Append(" right_remark=@right_remark");
        strSql.Append(" Where right_code=@right_code");
        SqlParameter[] parameters = {
	              new SqlParameter("@right_code", SqlDbType.VarChar,30) ,            
                       new SqlParameter("@right_name", SqlDbType.VarChar,50) ,           
                       new SqlParameter("@right_class", SqlDbType.Int,4) ,            
                       new SqlParameter("@right_remark", SqlDbType.VarChar,100)             
             
            };

        parameters[0].Value = v_right_code;
        parameters[1].Value = v_right_name;
        parameters[2].Value = v_right_class;
        parameters[3].Value = v_right_remark;
        int i = claSqlConnDB.ExecuteNonQuery(claSqlConnDB.gStrConnDefault, CommandType.Text, strSql.ToString(), parameters);
        return i;
    }
    private int DelRightsData(string v_right_code)
    {
        StringBuilder strSql = new StringBuilder();
        strSql.Append("DELETE FROM t_rights WHERE ");
        strSql.Append("right_code=@right_code");
        
        SqlParameter[] parameters = {
			           new SqlParameter("@right_code", SqlDbType.VarChar,30)             
             
            };

        parameters[0].Value = v_right_code;
        int i = claSqlConnDB.ExecuteNonQuery(claSqlConnDB.gStrConnDefault, CommandType.Text, strSql.ToString(), parameters);
        return i;
    }

    private int GetRightsCount(string v_right_code, string v_right_name, string v_right_menu, string v_right_item, string v_right_class, string v_right_remark)
    {

        string mStrSQL = @" select count(0) from t_rights " + GetWhere(v_right_code, v_right_name, v_right_menu, v_right_item, v_right_class);
        int i = claSqlConnDB.GetRecordCount(claSqlConnDB.gStrConnDefault, mStrSQL);
        return i;
    }
    private List<rights> GetRightsData(string v_right_code, string v_right_name, string v_right_menu, string v_right_item, string v_right_class, string v_right_remark, string v_grid_sort, string v_grid_order)
    {
        List<rights> mLstRight = new List<rights>();
        string lStrSQL = @"SELECT     t_rights.right_code, t_rights.right_name, t_rights.right_menugroup, t_menugroup.menugroup_name,
                                      t_rights.right_menu, t_menu.menu_title, t_rights.right_item, t_menuitem.item_title, 
                                      t_rights.right_class, t_rights.right_remark
                             FROM     t_rights LEFT OUTER JOIN
                                      t_menuitem ON t_rights.right_item = t_menuitem.item_id LEFT OUTER JOIN
                                      t_menu ON t_rights.right_menu = t_menu.menu_id LEFT OUTER JOIN
                                      t_menugroup ON t_rights.right_menugroup = t_menugroup.menugroup_id "
                         + GetWhere(v_right_code, v_right_name, v_right_menu, v_right_item, v_right_class)
                         + GetSort(v_grid_sort, v_grid_order);
        DataTable dt = null;
        using (dt = claSqlConnDB.ExecuteDataset(rows, page, claSqlConnDB.gStrConnDefault, CommandType.Text, lStrSQL).Tables[0])
        {
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                rights mRight = new rights();
                mRight.right_code = dt.Rows[i][0].ToString();
                mRight.right_name = dt.Rows[i][1].ToString();
                mRight.right_menugroup = dt.Rows[i][2].ToString();
                mRight.right_menugroup_name = dt.Rows[i][3].ToString();
                mRight.right_menu = dt.Rows[i][4].ToString();
                mRight.right_menu_title = dt.Rows[i][5].ToString();
                mRight.right_item = dt.Rows[i][6].ToString();
                mRight.right_item_title = dt.Rows[i][7].ToString();

                mRight.right_class = (int)dt.Rows[i][8];
                mRight.right_remark = dt.Rows[i][9].ToString();
                mLstRight.Add(mRight);
            }
        }
        return mLstRight;
    }


    private string GetWhere(string v_right_code, string v_right_name, string v_right_menu, string v_right_item, string v_right_class)
    {
        string mStrWhere = "";
        if (v_right_code != "")
        {
            if (mStrWhere != "")
            {
                mStrWhere = mStrWhere + " AND t_rights.right_code ='" + v_right_code + "'";
            }
            else
            {
                mStrWhere = " WHERE t_rights.right_code ='" + v_right_code + "'";
            }
        }
        if (v_right_name != "")
        {
            if (mStrWhere != "")
            {
                mStrWhere = mStrWhere + " AND t_rights.right_name like '%" + v_right_name + "%'";
            }
            else
            {
                mStrWhere = " WHERE t_rights.right_name like '%" + v_right_name + "%'";
            }
        }
        if (v_right_menu != "")
        {
            if (mStrWhere != "")
            {
                mStrWhere = mStrWhere + " AND t_rights.right_menu ='" + v_right_menu + "'";
            }
            else
            {
                mStrWhere = " WHERE t_rights.right_menu ='" + v_right_menu + "'";
            }
        }
        if (v_right_item != "")
        {
            if (mStrWhere != "")
            {
                mStrWhere = mStrWhere + " AND t_rights.right_item ='" + v_right_item + "'";
            }
            else
            {
                mStrWhere = " WHERE t_rights.right_item ='" + v_right_item + "'";
            }
        }

        if (v_right_class != "")
        {
            if (mStrWhere != "")
            {
                mStrWhere = mStrWhere + " AND t_rights.right_class =" + v_right_class;
            }
            else
            {
                mStrWhere = " WHERE t_rights.right_class =" + v_right_class;
            }
        }

        return mStrWhere;
    }
    private string GetSort(string v_grid_sort, string v_grid_order)
    {
        string mStrSort = "";
        if (v_grid_sort != "" && v_grid_sort != null)
        {
            mStrSort = " order by t_rights." + v_grid_sort;
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