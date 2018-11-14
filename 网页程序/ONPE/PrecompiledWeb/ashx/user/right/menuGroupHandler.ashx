<%@ WebHandler Language="C#" Class="menuGroupHandler" %>
using System;
using System.Web;
using Newtonsoft.Json;
using NPE.UIDataClass;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Generic;
using ModelClass;
using System.Text;

public class menuGroupHandler : IHttpHandler
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
            case "add":
                global mglobal=new global();
                string m_add_group_id=mglobal.GetIdentityID("PC","QX","ZB",System.DateTime.Now,4);
                string m_add_group_name = "";
                string m_add_group_class = "1";
                string m_add_group_sort = "";
                if (context.Request.Params["menugroup_class"] != null)
                {
                    m_add_group_class = context.Request.Params["menugroup_class"];
                }
                else
                {
                    mIntParamNullable = mIntParamNullable + 1;
                }
                if (context.Request.Params["menugroup_name"] != null)
                {
                    m_add_group_name = context.Request.Params["menugroup_name"];
                }
                else
                {
                    mIntParamNullable = mIntParamNullable + 1;
                }
                if (context.Request.Params["menugroup_sort"] != null)
                {
                    m_add_group_sort = context.Request.Params["menugroup_sort"];
                }
                else
                {
                    m_add_group_sort="999";
                }
                string m_add_font_color = "FFFFFF";
                if (context.Request.Params["font_color"] != null)
                {
                    m_add_font_color = context.Request.Params["font_color"];
                }

                string m_add_font_size = "12";
                if (context.Request.Params["font_size"] != null)
                {
                    m_add_font_size = context.Request.Params["font_size"];
                }

                string m_add_background_color = "336699";
                if (context.Request.Params["background_color"] != null)
                {
                    m_add_background_color = context.Request.Params["background_color"];
                }
                if (mIntParamNullable == 0)
                {
                    mObjDetial = AddMenuGroupData(m_add_group_id, m_add_group_class, m_add_group_name, m_add_group_sort, m_add_font_color,m_add_font_size,m_add_background_color);
                    if (mObjDetial.ToString() == "1")
                    {
                        mStrReturn = "{'success':true,'msg':'添加菜单组成功！'}";
                    }
                    else
                    {
                        mStrReturn = "{'success':false,'msg':'添加菜单组失败！'}";
                    }
                }
                    
                else
                {
                    mStrReturn = "{'success':false,'msg':'缺少必要参数！'}";
                }
                break;
            case "edit":
                string m_edit_group_id = "";
                if (context.Request.Params["menugroup_id"] != null)
                {
                    m_edit_group_id = context.Request.Params["menugroup_id"];
                }
                else
                {
                    mIntParamNullable = mIntParamNullable + 1;
                }
                string m_edit_group_class = ""; 
                if (context.Request.Params["menugroup_class"] != null)
                {
                    m_edit_group_class = context.Request.Params["menugroup_class"];
                }
                else
                {
                    mIntParamNullable = mIntParamNullable + 1;
                }
                string m_edit_group_name = "";
                if (context.Request.Params["menugroup_name"] != null)
                {
                    m_edit_group_name = context.Request.Params["menugroup_name"];
                }
                else
                {
                    mIntParamNullable = mIntParamNullable + 1;
                }
                string m_edit_group_sort = "";
                if (context.Request.Params["menugroup_sort"] != null)
                {
                    m_edit_group_sort = context.Request.Params["menugroup_sort"];
                }
                else
                {
                    m_edit_group_sort = "999";
                }
                string m_edit_font_color = "FFFFFF";
                if (context.Request.Params["font_color"] != null)
                {
                    m_edit_font_color = context.Request.Params["font_color"];
                }

                string m_edit_font_size = "12";
                if (context.Request.Params["font_size"] != null)
                {
                    m_edit_font_size = context.Request.Params["font_size"];
                }

                string m_edit_background_color = "336699";
                if (context.Request.Params["background_color"] != null)
                {
                    m_edit_background_color = context.Request.Params["background_color"];
                }
                
                if (mIntParamNullable == 0)
                {
                    mObjDetial = EditMenuGroupData(m_edit_group_id, m_edit_group_class, m_edit_group_name, m_edit_group_sort, m_edit_font_color, m_edit_font_size, m_edit_background_color);
                    if (mObjDetial.ToString() == "1")
                    {
                        mStrReturn = "{'success':true,'msg':'编辑菜单组成功！'}";
                    }
                    else
                    {
                        mStrReturn = "{'success':false,'msg':'编辑菜单组失败！'}";
                    }
                }
                else
                {
                    mStrReturn = "{'success':false,'msg':'缺少必要参数！'}";
                }
                break;
            case "del":
                string m_del_group_id = "";
                if (context.Request.Params["menugroup_id"] != null)
                {
                    m_del_group_id = context.Request.Params["menugroup_id"];
                }
                else
                {
                    mIntParamNullable = mIntParamNullable + 1;
                }
                
                if (mIntParamNullable == 0)
                {
                    mObjDetial = DelMenuGroupData(m_del_group_id);
                    if (mObjDetial.ToString() == "1")
                    {
                        mStrReturn = "{'success':true,'msg':'删除菜单组成功！'}";
                    }
                    else
                    {
                        mStrReturn = "{'success':false,'msg':'删除菜单组失败！'}";
                    }
                }
                else
                {
                    mStrReturn = "{'success':false,'msg':'缺少必要参数！'}";
                }
                break;
            case "combo":
                string m_combo_group_id = "";
                if (context.Request.Params["menugroup_id"] != null)
                {
                    m_combo_group_id = context.Request.Params["menugroup_id"];
                }
                string m_combo_group_class = "";
                if (context.Request.Params["menugroup_class"] != null)
                {
                    m_combo_group_class = context.Request.Params["menugroup_class"];
                }
                string m_combo_group_name = "";
                if (context.Request.Params["menugroup_name"] != null)
                {
                    m_combo_group_name = context.Request.Params["menugroup_name"];
                }
                mObjDetial = GetMenuGroupComboData(m_combo_group_id,m_combo_group_class, m_combo_group_name);
                mStrReturn = JsonConvert.SerializeObject(mObjDetial);
                break;
            case "count":
                string m_count_group_id = "";
                if (context.Request.Params["group_id"] != null)
                {
                    m_count_group_id = context.Request.Params["group_id"];
                }
                string m_count_group_class = "";
                if (context.Request.Params["menugroup_class"] != null)
                {
                    m_count_group_class = context.Request.Params["menugroup_class"];
                }
                string m_count_group_name = "";
                if (context.Request.Params["group_name"] != null)
                {
                    m_count_group_name = context.Request.Params["group_name"];
                }
                mObjDetial = GetMenuGroupCount(m_count_group_id,m_count_group_class, m_count_group_name);
                mStrMsg = "所请求的数据已成功返回";
                mStrReturn = setReturnValue(true, mObjDetial, mStrMsg);
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
                    rows = 10;
                }
                string m_grid_group_id = "";
                if (context.Request.Params["menugroup_id"] != null)
                {
                    m_grid_group_id = context.Request.Params["menugroup_id"];
                }
                string m_grid_group_class = "";
                if (context.Request.Params["menugroup_class"] != null)
                {
                    m_grid_group_class = context.Request.Params["menugroup_class"];
                }
                string m_grid_group_name = "";
                if (context.Request.Params["menugroup_name"] != null)
                {
                    m_grid_group_name = context.Request.Params["menugroup_name"];
                }
                mObjDetial = GetMenuGroupData(m_grid_group_id,m_grid_group_class, m_grid_group_name,sort,order);
                mStrMsg = string.Format("\"total\":{0},\"rows\":", GetMenuGroupCount(m_grid_group_id,m_grid_group_class, m_grid_group_name));
                mStrReturn = "{" + mStrMsg + JsonConvert.SerializeObject(mObjDetial) + "}";
                break;
            default:
                mStrReturn = setReturnValue(false, "缺少必要参数", "缺少必要参数");
                break;
        }
        context.Response.Write(mStrReturn);
    }
    private int AddMenuGroupData(string v_group_id, string v_group_class, string v_group_name, string v_group_sort, string v_font_color, string v_font_size, string v_background_color)
    {
        StringBuilder strSql = new StringBuilder();
        strSql.Append("insert into t_menugroup(");
        strSql.Append("menugroup_id,menugroup_class,menugroup_name,menugroup_sort,font_color,font_size,background_color");
        strSql.Append(") values (");
        strSql.Append("@group_id,@group_class,@group_name,@group_sort,@font_color,@font_size,@background_color");
        strSql.Append(") ");
        SqlParameter[] parameters = {
			new SqlParameter("@group_id", SqlDbType.VarChar,30),
            new SqlParameter("@group_class",SqlDbType.Int,4),            
            new SqlParameter("@group_name", SqlDbType.VarChar,30),
            new SqlParameter("@group_sort", SqlDbType.Int,4),
            new SqlParameter("@font_color", SqlDbType.VarChar,10),
            new SqlParameter("@font_size", SqlDbType.VarChar,4),
            new SqlParameter("@background_color", SqlDbType.VarChar,10)
            };
        parameters[0].Value = v_group_id;
        parameters[1].Value = v_group_class;
        parameters[2].Value = v_group_name;
        parameters[3].Value = v_group_sort;
        parameters[4].Value = v_font_color;
        parameters[5].Value = v_font_size;
        parameters[6].Value = v_background_color;
        int i = claSqlConnDB.ExecuteNonQuery(claSqlConnDB.gStrConnDefault, CommandType.Text, strSql.ToString(), parameters);
        return i;
    }
    private int EditMenuGroupData(string v_group_id, string v_group_class, string v_group_name, string v_group_sort, string v_font_color, string v_font_size, string v_background_color)
    {
        StringBuilder strSql = new StringBuilder();
        strSql.Append(" UPDATE t_menugroup set");
        strSql.Append(" menugroup_class=@group_class,menugroup_name=@group_name,menugroup_sort=@group_sort,");
        strSql.Append(" font_color=@font_color,font_size=@font_size,background_color=@background_color");
        strSql.Append(" WHERE");
        strSql.Append(" menugroup_id=@group_id");
        SqlParameter[] parameters = {
	        new SqlParameter("@group_id", SqlDbType.VarChar,30) ,
            new SqlParameter("@group_class",SqlDbType.Int,4),             
            new SqlParameter("@group_name", SqlDbType.VarChar,30),
            new SqlParameter("@group_sort", SqlDbType.Int,4),
            new SqlParameter("@font_color", SqlDbType.VarChar,10),
            new SqlParameter("@font_size", SqlDbType.VarChar,4),
            new SqlParameter("@background_color", SqlDbType.VarChar,10)
            };

        parameters[0].Value = v_group_id;
        parameters[1].Value = v_group_class;
        parameters[2].Value = v_group_name;
        parameters[3].Value = v_group_sort;
        parameters[4].Value = v_font_color;
        parameters[5].Value = v_font_size;
        parameters[6].Value = v_background_color;
        int i = claSqlConnDB.ExecuteNonQuery(claSqlConnDB.gStrConnDefault, CommandType.Text, strSql.ToString(), parameters);
        return i;
    }
    private int DelMenuGroupData(string v_group_id)
    {
        StringBuilder strSql = new StringBuilder();
        strSql.Append("DELETE FROM t_menugroup WHERE");
        strSql.Append(" menugroup_id=@menugroup_id ");
        SqlParameter[] parameters = {
			new SqlParameter("@menugroup_id", SqlDbType.VarChar,30) 
            };

        parameters[0].Value = v_group_id;
        int i = claSqlConnDB.ExecuteNonQuery(claSqlConnDB.gStrConnDefault, CommandType.Text, strSql.ToString(), parameters);
        return i;
    }
    private List<combobox> GetMenuGroupComboData(string v_group_id,string v_group_class,string v_group_name)
    {
        List<combobox> mLstCombo = new List<combobox>();
        
        StringBuilder strSql = new StringBuilder();
        DataTable dt=null;
        
        strSql.Append("SELECT menugroup_id,menugroup_name FROM t_menugroup ");
        strSql.Append(GetWhere(v_group_id, v_group_class,v_group_name));
        using (dt = claSqlConnDB.ExecuteDataset(claSqlConnDB.gStrConnDefault, CommandType.Text,strSql.ToString()).Tables[0])
        {
            if (dt.Rows.Count>0)
            {
                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    combobox mCombo = new combobox();
                    mCombo.id = dt.Rows[i][0].ToString();
                    mCombo.text = dt.Rows[i][1].ToString();
                    mLstCombo.Add(mCombo); 
                }
            }
        }
        return mLstCombo;
    }
    private int GetMenuGroupCount(string v_group_id,string v_group_class, string v_group_name)
    {

        string mStrSQL = @" select count(0) from t_menugroup " + GetWhere(v_group_id,v_group_class,v_group_name);
        int i = claSqlConnDB.GetRecordCount(claSqlConnDB.gStrConnDefault, mStrSQL);
        return i;
    }
    private List<menugroup> GetMenuGroupData(string v_group_id,string v_group_class, string v_group_name,string v_grid_sort,string v_grid_order)
    {
        List<menugroup> menuGroupGrid = new List<menugroup>();
        string lStrSQL = @"select menugroup_id,menugroup_class,menugroup_name,menugroup_sort,font_color,font_size,background_color from t_menugroup  " + GetWhere(v_group_id,v_group_class, v_group_name) + GetSort(v_grid_sort, v_grid_order);
        DataTable dt = null;
        using (dt = claSqlConnDB.ExecuteDataset(rows, page, claSqlConnDB.gStrConnDefault, CommandType.Text, lStrSQL).Tables[0])
        {
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                menugroup menugroupTmp = new menugroup();
                menugroupTmp.menugroup_id = dt.Rows[i][0].ToString();
                menugroupTmp.menugroup_class = dt.Rows[i][1] != null ? (int)dt.Rows[i][1] : 0;
                menugroupTmp.menugroup_name = dt.Rows[i][2].ToString();
                menugroupTmp.menugroup_sort = (int)dt.Rows[i][3];
                menugroupTmp.font_color = dt.Rows[i][4].ToString();
                menugroupTmp.font_size = dt.Rows[i][5].ToString();
                menugroupTmp.background_color = dt.Rows[i][6].ToString();
                menuGroupGrid.Add(menugroupTmp);
            }
        }
        return menuGroupGrid;
    }


    private string GetWhere(string v_group_id, string v_group_class,string v_group_name)
    {
        string mStrWhere = "";
        if (v_group_id != "")
        {
            if (mStrWhere != "")
            {
                mStrWhere = mStrWhere + " AND t_menugroup.menugroup_id ='" + v_group_id + "'";
            }
            else
            {
                mStrWhere = " WHERE t_menugroup.menugroup_id ='" + v_group_id + "'";
            }
        }
        if (v_group_class != "")
        {
            if (mStrWhere != "")
            {
                mStrWhere = mStrWhere + " AND t_menugroup.menugroup_class =" + v_group_class + " ";
            }
            else
            {
                mStrWhere = " WHERE t_menugroup.menugroup_class =" + v_group_class + " ";
            }
        }
        if (v_group_name != "")
        {
            if (mStrWhere != "")
            {
                mStrWhere = mStrWhere + " AND t_menugroup.menugroup_name ='" + v_group_name + "'";
            }
            else
            {
                mStrWhere = " WHERE t_menugroup.menugroup_name ='" + v_group_name + "'";
            }
        }
        return mStrWhere;
    }

    private string GetSort(string v_grid_sort, string v_grid_order)
    {
        string mStrSort = "";
        if (v_grid_sort != ""&& v_grid_sort!=null)
        {
            mStrSort = " order by t_menugroup." + v_grid_sort;
            if (v_grid_order != "" && v_grid_order != null)
            {
                mStrSort = mStrSort + " " + v_grid_order; 
            }
        }
        return mStrSort;
    }
    
    private string setReturnValue(Boolean vBlnResult, object vObjDetial, string vStrMsg)
    {
        mRequestReturn.responstResult = vBlnResult;
        mRequestReturn.responstDetial = vObjDetial;
        mRequestReturn.responstMsg = vStrMsg;
        return JsonConvert.SerializeObject(mRequestReturn);
    }
    public bool IsReusable
    {
        get
        {
            return false;
        }
    }

}