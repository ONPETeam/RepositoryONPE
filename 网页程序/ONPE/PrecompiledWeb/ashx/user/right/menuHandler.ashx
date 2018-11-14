<%@ WebHandler Language="C#" Class="menuHandler" %>

using System;
using System.Web;
using Newtonsoft.Json;
using NPE.UIDataClass;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Generic;
using ModelClass;
using System.Text;

public class menuHandler : IHttpHandler
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
                #region 添加开始
                global mglobal = new global();
                string m_add_menu_id = mglobal.GetIdentityID("PC", "QX", "CD", System.DateTime.Now, 4);

                int m_add_menu_class = 0;
                if (context.Request.Params["menu_class"] != null)
                {
                    if (int.TryParse(context.Request.Params["menu_class"], out m_add_menu_class) == false)
                    {
                        mIntParamNullable = mIntParamNullable + 1;
                    }
                }
                else
                {
                    mIntParamNullable = mIntParamNullable + 1;
                }

                string m_add_menu_name = "";
                if (context.Request.Params["menu_name"] != null)
                {
                    m_add_menu_name = context.Request.Params["menu_name"];
                }
                else
                {
                    mIntParamNullable = mIntParamNullable + 1;
                }
                string m_add_menu_parent = "";
                if (context.Request.Params["menu_parent"] != null)
                {
                    m_add_menu_parent = context.Request.Params["menu_parent"];
                }
                int m_add_menu_code = 0;
                if (context.Request.Params["menu_code"] != null)
                {
                    if (int.TryParse(context.Request.Params["menu_code"], out m_add_menu_code) == false)
                    {
                        m_add_menu_code = 0;
                    }
                }
                else
                {
                    mIntParamNullable = mIntParamNullable + 1;
                }
                string m_add_menu_title = "";
                if (context.Request.Params["menu_title"] != null)
                {
                    m_add_menu_title = context.Request.Params["menu_title"];
                }
                else
                {
                    mIntParamNullable = mIntParamNullable + 1;
                }
                string m_add_menu_link = "";
                if (context.Request.Params["menu_link"] != null)
                {
                    m_add_menu_link = context.Request.Params["menu_link"];
                }
                else
                {
                    mIntParamNullable = mIntParamNullable + 1;
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

                string m_add_menu_iconcls = "";
                if (context.Request.Params["menu_iconcls"] != null)
                {
                    m_add_menu_iconcls = context.Request.Params["menu_iconcls"];
                }
                else
                {
                    mIntParamNullable = mIntParamNullable + 1;
                }
                string m_add_menu_iconalign = "";
                if (context.Request.Params["menu_iconalign"] != null)
                {
                    m_add_menu_iconalign = context.Request.Params["menu_iconalign"];
                }
                else
                {
                    mIntParamNullable = mIntParamNullable + 1;
                }
                string m_add_menu_iconsize = "";
                if (context.Request.Params["menu_iconsize"] != null)
                {
                    m_add_menu_iconsize = context.Request.Params["menu_iconsize"];
                }
                else
                {
                    mIntParamNullable = mIntParamNullable + 1;
                }

                string m_add_add_time = "";
                if (context.Request.Params["add_time"] != null)
                {
                    m_add_add_time = context.Request.Params["add_time"];
                }
                else
                {
                    m_add_add_time = System.DateTime.Now.ToString();
                }
                string m_add_menu_remark = "";
                if (context.Request.Params["menu_remark"] != null)
                {
                    m_add_menu_remark = context.Request.Params["menu_remark"];
                }
                else
                {
                    mIntParamNullable = mIntParamNullable + 1;
                }
                if (mIntParamNullable == 0)
                {
                    mObjDetial = AddMenuData(m_add_menu_id, m_add_menu_class, m_add_menu_name, m_add_menu_parent, m_add_menu_code, m_add_menu_title, m_add_menu_link, m_add_font_color, m_add_font_size, m_add_background_color, m_add_menu_iconcls, m_add_menu_iconalign, m_add_menu_iconsize, m_add_add_time, m_add_menu_remark);
                    if (mObjDetial.ToString() == "1")
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
                #endregion
            case "edit":
                string m_edit_menu_id = "";
                if (context.Request.Params["menu_id"] != null)
                {
                    m_edit_menu_id = context.Request.Params["menu_id"];
                }
                else
                {
                    mIntParamNullable = mIntParamNullable + 1;
                }
                int m_edit_menu_class = 0;
                if (context.Request.Params["menu_class"] != null)
                {
                    if (int.TryParse(context.Request.Params["menu_class"], out m_edit_menu_class) == false)
                    {
                        mIntParamNullable = mIntParamNullable + 1;
                    }
                }
                else
                {
                    mIntParamNullable = mIntParamNullable + 1;
                }
                string m_edit_menu_name = "";
                if (context.Request.Params["menu_name"] != null)
                {
                    m_edit_menu_name = context.Request.Params["menu_name"];
                }
                else
                {
                    mIntParamNullable = mIntParamNullable + 1;
                }
                string m_edit_menu_parent = "";
                if (context.Request.Params["menu_parent"] != null)
                {
                    m_edit_menu_parent = context.Request.Params["menu_parent"];
                }

                int m_edit_menu_code = 0;
                if (context.Request.Params["menu_code"] != null)
                {
                    if (int.TryParse(context.Request.Params["menu_code"], out m_edit_menu_code) == false)
                    {
                        m_edit_menu_code = 0;
                    }
                }
                else
                {
                    mIntParamNullable = mIntParamNullable + 1;
                }
                string m_edit_menu_title = "";
                if (context.Request.Params["menu_title"] != null)
                {
                    m_edit_menu_title = context.Request.Params["menu_title"];
                }
                else
                {
                    mIntParamNullable = mIntParamNullable + 1;
                }
                string m_edit_menu_link = "";
                if (context.Request.Params["menu_link"] != null)
                {
                    m_edit_menu_link = context.Request.Params["menu_link"];
                }
                else
                {
                    mIntParamNullable = mIntParamNullable + 1;
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
                
                string m_edit_menu_iconcls = "";
                if (context.Request.Params["menu_iconcls"] != null)
                {
                    m_edit_menu_iconcls = context.Request.Params["menu_iconcls"];
                }
                else
                {
                    mIntParamNullable = mIntParamNullable + 1;
                }
                string m_edit_menu_iconalign = "";
                if (context.Request.Params["menu_iconalign"] != null)
                {
                    m_edit_menu_iconalign = context.Request.Params["menu_iconalign"];
                }
                else
                {
                    mIntParamNullable = mIntParamNullable + 1;
                }
                string m_edit_menu_iconsize = "";
                if (context.Request.Params["menu_iconsize"] != null)
                {
                    m_edit_menu_iconsize = context.Request.Params["menu_iconsize"];
                }
                else
                {
                    mIntParamNullable = mIntParamNullable + 1;
                }


                string m_edit_add_time = "";
                if (context.Request.Params["add_time"] != null)
                {
                    m_edit_add_time = context.Request.Params["add_time"];
                }
                else
                {
                    m_edit_add_time = System.DateTime.Now.ToString();
                }
                string m_edit_menu_remark = "";
                if (context.Request.Params["menu_remark"] != null)
                {
                    m_edit_menu_remark = context.Request.Params["menu_remark"];
                }
                else
                {
                    mIntParamNullable = mIntParamNullable + 1;
                }
                if (mIntParamNullable == 0)
                {
                    mObjDetial = EditMenuData(m_edit_menu_id, m_edit_menu_class, m_edit_menu_name, m_edit_menu_parent, m_edit_menu_code, m_edit_menu_title, m_edit_menu_link, m_edit_font_color, m_edit_font_size, m_edit_background_color, m_edit_menu_iconcls, m_edit_menu_iconalign, m_edit_menu_iconsize, m_edit_add_time, m_edit_menu_remark);
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
                string m_del_menu_id = "";
                if (context.Request.Params["menu_id"] != null)
                {
                    m_del_menu_id = context.Request.Params["menu_id"];
                }
                else
                {
                    mIntParamNullable = mIntParamNullable + 1;
                }
                if (mIntParamNullable == 0)
                {
                    mObjDetial = DelMenuData(m_del_menu_id);
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
            case "prop":
                string m_prop_menu_id = "";
                if (context.Request.Params["menu_id"] != null)
                {
                    m_prop_menu_id = context.Request.Params["menu_id"];
                }
                else
                {
                    mIntParamNullable = mIntParamNullable + 1;
                }
                if (mIntParamNullable == 0)
                {
                    mObjDetial = GetMenuPropData(m_prop_menu_id);
                    mStrMsg = "所请求的数据已成功返回";
                    mStrReturn = setReturnValue(true, mObjDetial, mStrMsg);
                }
                else
                {
                    mStrReturn = setReturnValue(false, "缺少必要参数", "缺少必要参数");
                }
                break;
            case "count":
                string m_count_menu_id = "";
                if (context.Request.Params["menu_id"] != null)
                {
                    m_count_menu_id = context.Request.Params["menu_id"];
                }
                string m_count_menu_class = "";
                if (context.Request.Params["menu_class"] != null)
                {
                    m_count_menu_class = context.Request.Params["menu_class"];
                }
                string m_count_menu_name = "";
                if (context.Request.Params["menu_name"] != null)
                {
                    m_count_menu_name = context.Request.Params["menu_name"];
                }
                string m_count_menu_parent = "";
                if (context.Request.Params["menu_parent"] != null)
                {
                    m_count_menu_parent = context.Request.Params["menu_parent"];
                }

                int m_count_menu_code = 0;
                if (context.Request.Params["menu_code"] != null)
                {
                    if (int.TryParse(context.Request.Params["menu_code"], out m_count_menu_code) == false)
                    {
                        m_count_menu_code = 0;
                    }
                }
                string m_count_menu_title = "";
                if (context.Request.Params["menu_title"] != null)
                {
                    m_count_menu_title = context.Request.Params["menu_title"];
                }
                string m_count_menu_link = "";
                if (context.Request.Params["menu_link"] != null)
                {
                    m_count_menu_link = context.Request.Params["menu_link"];
                }
                string m_count_menu_iconcls = "";
                if (context.Request.Params["menu_iconcls"] != null)
                {
                    m_count_menu_iconcls = context.Request.Params["menu_iconcls"];
                }
                string m_count_menu_iconalign = "";
                if (context.Request.Params["menu_iconalign"] != null)
                {
                    m_count_menu_iconalign = context.Request.Params["menu_iconalign"];
                }
                string m_count_menu_iconsize = "";
                if (context.Request.Params["menu_iconsize"] != null)
                {
                    m_count_menu_iconsize = context.Request.Params["menu_iconsize"];
                }

                string m_count_add_time = "";
                if (context.Request.Params["add_time"] != null)
                {
                    m_count_add_time = context.Request.Params["add_time"];
                }
                string m_count_menu_remark = "";
                if (context.Request.Params["menu_remark"] != null)
                {
                    m_count_menu_remark = context.Request.Params["menu_remark"];
                }
                mObjDetial = GetMenuCount(m_count_menu_id, m_count_menu_class, m_count_menu_name, m_count_menu_parent, m_count_menu_code, m_count_menu_title, m_count_menu_link, m_count_menu_iconcls, m_count_menu_iconalign, m_count_menu_iconsize, m_count_add_time, m_count_menu_remark);
                mStrMsg = "所请求的数据已成功返回";
                mStrReturn = setReturnValue(true, mObjDetial, mStrMsg);
                break;
            case "combo":
                string m_combo_menugroup_id = "";
                if (context.Request.Params["menugroup_id"] != null)
                {
                    m_combo_menugroup_id = context.Request.Params["menugroup_id"];
                }

                mObjDetial = GetMenuComboData(m_combo_menugroup_id);

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
                    rows = 10;
                }
                string m_grid_menu_class = "";
                if (context.Request.Params["menu_class"] != null)
                {
                    m_grid_menu_class = context.Request.Params["menu_class"];
                }
                string m_grid_menu_id = "";
                if (context.Request.Params["menu_id"] != null)
                {
                    m_grid_menu_id = context.Request.Params["menu_id"];
                }
                string m_grid_menu_name = "";
                if (context.Request.Params["menu_name"] != null)
                {
                    m_grid_menu_name = context.Request.Params["menu_name"];
                }
                string m_grid_menu_parent = "";
                if (context.Request.Params["menu_parent"] != null)
                {
                    m_grid_menu_parent = context.Request.Params["menu_parent"];
                }

                int m_grid_menu_code = 0;
                if (context.Request.Params["menu_code"] != null)
                {
                    if (int.TryParse(context.Request.Params["menu_code"], out m_grid_menu_code) == false)
                    {
                        m_grid_menu_code = 0;
                    }
                }
                string m_grid_menu_title = "";
                if (context.Request.Params["menu_title"] != null)
                {
                    m_grid_menu_title = context.Request.Params["menu_title"];
                }
                string m_grid_menu_link = "";
                if (context.Request.Params["menu_link"] != null)
                {
                    m_grid_menu_link = context.Request.Params["menu_link"];
                }
                string m_grid_menu_iconcls = "";
                if (context.Request.Params["menu_iconcls"] != null)
                {
                    m_grid_menu_iconcls = context.Request.Params["menu_iconcls"];
                }
                string m_grid_menu_iconalign = "";
                if (context.Request.Params["menu_iconalign"] != null)
                {
                    m_grid_menu_iconalign = context.Request.Params["menu_iconalign"];
                }
                string m_grid_menu_iconsize = "";
                if (context.Request.Params["menu_iconsize"] != null)
                {
                    m_grid_menu_iconsize = context.Request.Params["menu_iconsize"];
                }

                string m_grid_add_time = "";
                if (context.Request.Params["add_time"] != null)
                {
                    m_grid_add_time = context.Request.Params["add_time"];
                }
                string m_grid_menu_remark = "";
                if (context.Request.Params["menu_remark"] != null)
                {
                    m_grid_menu_remark = context.Request.Params["menu_remark"];
                }
                mObjDetial = GetMenuData(m_grid_menu_id, m_grid_menu_class, m_grid_menu_name, m_grid_menu_parent, m_grid_menu_code, m_grid_menu_title, m_grid_menu_link, m_grid_menu_iconcls, m_grid_menu_iconalign, m_grid_menu_iconsize, m_grid_add_time, m_grid_menu_remark, sort, order);
                mStrMsg = string.Format("\"total\":{0},\"rows\":", GetMenuCount(m_grid_menu_id, m_grid_menu_class, m_grid_menu_name, m_grid_menu_parent, m_grid_menu_code, m_grid_menu_title, m_grid_menu_link, m_grid_menu_iconcls, m_grid_menu_iconalign, m_grid_menu_iconsize, m_grid_add_time, m_grid_menu_remark));
                mStrReturn = "{" + mStrMsg + JsonConvert.SerializeObject(mObjDetial) + "}";
                break;
            default:
                mStrReturn = setReturnValue(false, "缺少必要参数", "缺少必要参数");
                break;
        }
        context.Response.Write(mStrReturn);
    }
    private int AddMenuData(string v_menu_id, int v_menu_class, string v_menu_name, string v_menu_parent, int v_menu_code, string v_menu_title, string v_menu_link, string v_font_color, string v_font_size, string v_background_color, string v_menu_iconcls, string v_menu_iconalign, string v_menu_iconsize, string v_add_time, string v_menu_remark)
    {
        StringBuilder strSql = new StringBuilder();
        strSql.Append("insert into t_menu(");
        strSql.Append("menu_id,menu_class,menu_name,menu_parent,menu_code,menu_title,menu_link,font_color,font_size,background_color,menu_iconcls,menu_iconalign,menu_iconsize,add_time,menu_remark");
        strSql.Append(") values (");
        strSql.Append("@menu_id,@menu_class,@menu_name,@menu_parent,@menu_code,@menu_title,@menu_link,@font_color,@font_size,@background_color,@menu_iconcls,@menu_iconalign,@menu_iconsize,@add_time,@menu_remark");
        strSql.Append(") ");
        SqlParameter[] parameters = {
			             new SqlParameter("@menu_id", SqlDbType.VarChar,30) ,  
                         new SqlParameter("@menu_class",SqlDbType.Int,4),          
                         new SqlParameter("@menu_name", SqlDbType.VarChar,50) ,            
                         new SqlParameter("@menu_parent", SqlDbType.VarChar,30) ,             
                         new SqlParameter("@menu_code", SqlDbType.Int,4) ,            
                         new SqlParameter("@menu_title", SqlDbType.VarChar,50) ,            
                         new SqlParameter("@menu_link", SqlDbType.VarChar,200) ,  
                         new SqlParameter("@font_color", SqlDbType.VarChar,10) ,      
                         new SqlParameter("@font_size", SqlDbType.VarChar,4) ,      
                         new SqlParameter("@background_color", SqlDbType.VarChar,10) ,                
                         new SqlParameter("@menu_iconcls", SqlDbType.VarChar,100) ,            
                         new SqlParameter("@menu_iconalign", SqlDbType.VarChar,30) ,            
                         new SqlParameter("@menu_iconsize", SqlDbType.VarChar,30) ,
                         new SqlParameter("@add_time", SqlDbType.DateTime) ,            
                         new SqlParameter("@menu_remark", SqlDbType.VarChar,200)             
             
            };

        parameters[0].Value = v_menu_id;
        parameters[1].Value = v_menu_class;
        parameters[2].Value = v_menu_name;
        parameters[3].Value = v_menu_parent;
        parameters[4].Value = v_menu_code;
        parameters[5].Value = v_menu_title;
        parameters[6].Value = v_menu_link;

        parameters[7].Value = v_font_color;
        parameters[8].Value = v_font_size;
        parameters[9].Value = v_background_color;

        parameters[10].Value = v_menu_iconcls;
        parameters[11].Value = v_menu_iconalign;
        parameters[12].Value = v_menu_iconsize;
        parameters[13].Value = v_add_time;
        parameters[14].Value = v_menu_remark;
        int i = claSqlConnDB.ExecuteNonQuery(claSqlConnDB.gStrConnDefault, CommandType.Text, strSql.ToString(), parameters);
        return i;
    }
    private int EditMenuData(string v_menu_id, int v_menu_class, string v_menu_name, string v_menu_parent, int v_menu_code, string v_menu_title, string v_menu_link, string v_font_color, string v_font_size, string v_background_color, string v_menu_iconcls, string v_menu_iconalign, string v_menu_iconsize, string v_add_time, string v_menu_remark)
    {
        StringBuilder strSql = new StringBuilder();
        strSql.Append(" UPDATE t_menu set ");
        strSql.Append(" menu_class=@menu_class,");
        strSql.Append(" menu_name=@menu_name,");
        strSql.Append(" menu_parent=@menu_parent,");
        strSql.Append(" menu_code=@menu_code,");
        strSql.Append(" menu_title=@menu_title,");
        strSql.Append(" menu_link=@menu_link,");
        strSql.Append(" font_color=@font_color,");
        strSql.Append(" font_size=@font_size,");
        strSql.Append(" background_color=@background_color,");
        strSql.Append(" menu_iconcls=@menu_iconcls,");
        strSql.Append(" menu_iconalign=@menu_iconalign,");
        strSql.Append(" menu_iconsize=@menu_iconsize,");
        strSql.Append(" add_time=@add_time,");
        strSql.Append(" menu_remark=@menu_remark");
        strSql.Append(" WHERE menu_id=@menu_id");
        SqlParameter[] parameters = {
	            new SqlParameter("@menu_id", SqlDbType.VarChar,30) ,      
                new SqlParameter("@menu_class",SqlDbType.Int,4),           
                new SqlParameter("@menu_name", SqlDbType.VarChar,50) ,            
                new SqlParameter("@menu_parent", SqlDbType.VarChar,30) ,             
                new SqlParameter("@menu_code", SqlDbType.Int,4) ,            
                new SqlParameter("@menu_title", SqlDbType.VarChar,50) ,            
                new SqlParameter("@menu_link", SqlDbType.VarChar,200) , 
                new SqlParameter("@font_color", SqlDbType.VarChar,10) ,      
                new SqlParameter("@font_size", SqlDbType.VarChar,4) ,      
                new SqlParameter("@background_color", SqlDbType.VarChar,10) ,               
                new SqlParameter("@menu_iconcls", SqlDbType.VarChar,100) ,            
                new SqlParameter("@menu_iconalign", SqlDbType.VarChar,30) ,            
                new SqlParameter("@menu_iconsize", SqlDbType.VarChar,30) ,    
                new SqlParameter("@add_time", SqlDbType.DateTime) ,            
                new SqlParameter("@menu_remark", SqlDbType.VarChar,200)             
             
            };

        parameters[0].Value = v_menu_id;
        parameters[1].Value = v_menu_class;
        parameters[2].Value = v_menu_name;
        parameters[3].Value = v_menu_parent;
        parameters[4].Value = v_menu_code;
        parameters[5].Value = v_menu_title;
        parameters[6].Value = v_menu_link;

        parameters[7].Value = v_font_color;
        parameters[8].Value = v_font_size;
        parameters[9].Value = v_background_color;

        parameters[10].Value = v_menu_iconcls;
        parameters[11].Value = v_menu_iconalign;
        parameters[12].Value = v_menu_iconsize;
        parameters[13].Value = v_add_time;
        parameters[14].Value = v_menu_remark;
        int i = claSqlConnDB.ExecuteNonQuery(claSqlConnDB.gStrConnDefault, CommandType.Text, strSql.ToString(), parameters);
        return i;
    }
    private int DelMenuData(string v_menu_id)
    {
        StringBuilder strSql = new StringBuilder();
        strSql.Append("DELETE FROM t_menu WHERE ");
        strSql.Append("menu_id=@menu_id");
        SqlParameter[] parameters = {
			           new SqlParameter("@menu_id", SqlDbType.VarChar,30)             
             
            };

        parameters[0].Value = v_menu_id;
        int i = claSqlConnDB.ExecuteNonQuery(claSqlConnDB.gStrConnDefault, CommandType.Text, strSql.ToString(), parameters);
        return i;
    }
    private menu GetMenuPropData(string v_menu_id)
    {
        StringBuilder strSql = new StringBuilder();
        strSql.Append("SELECT * FROM t_menu WHERE");
        strSql.Append("menu_id=@menu_id");
        SqlParameter[] parameters = {
			           new SqlParameter("@menu_id", SqlDbType.VarChar,30)             
             
            };

        parameters[0].Value = v_menu_id;
        menu mMenu = new menu();
        mMenu = (menu)claSqlConnDB.GetDetail(claSqlConnDB.gStrConnDefault, strSql.ToString(), "ModelClass.Model.menu", parameters);
        return mMenu;
    }
    private List<combobox> GetMenuComboData(string v_menugroup_id)
    {
        List<combobox> mLstCombo = new List<combobox>();
        StringBuilder strSql = new StringBuilder();
        strSql.Append(" SELECT     t_menu.menu_id, t_menu.menu_title ");
        strSql.Append(" FROM         t_menugroup_menu LEFT OUTER JOIN ");
        strSql.Append(" t_menu ON t_menugroup_menu.menu_id = t_menu.menu_id");
        strSql.Append(" WHERE     (t_menugroup_menu.menugroup_id = '" + v_menugroup_id + "')");

        DataTable dt = null;
        using (dt = claSqlConnDB.ExecuteDataset(claSqlConnDB.gStrConnDefault, CommandType.Text, strSql.ToString()).Tables[0])
        {
            if (dt.Rows.Count > 0)
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
    private int GetMenuCount(string v_menu_id, string v_menu_class, string v_menu_name, string v_menu_parent, int v_menu_code, string v_menu_title, string v_menu_link, string v_menu_iconcls, string v_menu_iconalign, string v_menu_iconsize, string v_add_time, string v_menu_remark)
    {

        string mStrSQL = @" select count(0) from t_menu " + GetWhere(v_menu_id, v_menu_class, v_menu_name, v_menu_parent, v_menu_code, v_menu_title, v_menu_link, v_menu_remark);
        int i = claSqlConnDB.GetRecordCount(claSqlConnDB.gStrConnDefault, mStrSQL);
        return i;
    }
    private List<menu> GetMenuData(string v_menu_id, string v_menu_class, string v_menu_name, string v_menu_parent, int v_menu_code, string v_menu_title, string v_menu_link, string v_menu_iconcls, string v_menu_iconalign, string v_menu_iconsize, string v_add_time, string v_menu_remark, string v_grid_sort, string v_grid_order)
    {
        List<menu> t_menuGrid = new List<menu>();
        string lStrSQL = @"select t_menu.menu_id,
                                  t_menu.menu_class,
                                  t_menu.menu_name,
                                  t_menu.menu_parent,
                                  t_menu.menu_code,
                                  t_menu.menu_title,
                                  t_menu.menu_link,
                                  t_menu.font_color,
                                  t_menu.font_size,
                                  t_menu.background_color,
                                  t_menu.menu_iconcls,
                                  t_menu.menu_iconalign,
                                  t_menu.menu_iconsize,
                                  t_menu.add_time,
                                  t_menu.menu_remark,
                                  t_menugroup.menugroup_name from t_menu  
                            left outer join t_menugroup on t_menu.menugroup_id=t_menugroup.menugroup_id" + GetWhere(v_menu_id, v_menu_class, v_menu_name, v_menu_parent, v_menu_code, v_menu_title, v_menu_link, v_menu_remark)
                         + GetSort(v_grid_sort, v_grid_order);
        DataTable dt = null;
        using (dt = claSqlConnDB.ExecuteDataset(rows, page, claSqlConnDB.gStrConnDefault, CommandType.Text, lStrSQL).Tables[0])
        {
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                menu menuTmp = new menu();
                menuTmp.menu_id = dt.Rows[i][0].ToString();
                menuTmp.menu_class = dt.Rows[i][1] != null ? int.Parse(dt.Rows[i][1].ToString()) : 0;
                menuTmp.menu_name = dt.Rows[i][2].ToString();
                menuTmp.menu_parent = dt.Rows[i][3].ToString();
                menuTmp.menugroup_name = dt.Rows[i][15].ToString();
                menuTmp.menu_code = dt.Rows[i][4].ToString();
                menuTmp.menu_title = dt.Rows[i][5].ToString();
                menuTmp.menu_link = dt.Rows[i][6].ToString();
                menuTmp.font_color = dt.Rows[i][7].ToString();
                menuTmp.font_size = dt.Rows[i][8].ToString();
                menuTmp.background_color = dt.Rows[i][9].ToString();
                menuTmp.menu_iconcls = dt.Rows[i][10].ToString();
                menuTmp.menu_iconalign = dt.Rows[i][11].ToString();
                menuTmp.menu_iconsize = dt.Rows[i][12].ToString();
                menuTmp.add_time = dt.Rows[i][13].ToString();
                menuTmp.menu_remark = dt.Rows[i][14].ToString();
                t_menuGrid.Add(menuTmp);
            }
        }
        return t_menuGrid;
    }


    private string GetWhere(string v_menu_id, string v_menu_class, string v_menu_name, string v_menu_parent, int v_menu_code, string v_menu_title, string v_menu_link, string v_menu_remark)
    {
        string mStrWhere = "";
        if (v_menu_id != "")
        {
            if (mStrWhere != "")
            {
                mStrWhere = mStrWhere + " AND t_menu.menu_id ='" + v_menu_id + "'";
            }
            else
            {
                mStrWhere = " WHERE t_menu.menu_id ='" + v_menu_id + "'";
            }
        }
        if (v_menu_class != "")
        {
            if (mStrWhere != "")
            {
                mStrWhere = mStrWhere + " AND t_menu.menu_class =" + v_menu_class + " ";
            }
            else
            {
                mStrWhere = " WHERE t_menu.menu_class =" + v_menu_class + " ";
            }
        }
        if (v_menu_name != "")
        {
            if (mStrWhere != "")
            {
                mStrWhere = mStrWhere + " AND t_menu.menu_name ='" + v_menu_name + "'";
            }
            else
            {
                mStrWhere = " WHERE t_menu.menu_name ='" + v_menu_name + "'";
            }
        }
        if (v_menu_parent != "")
        {
            if (mStrWhere != "")
            {
                mStrWhere = mStrWhere + " AND t_menu.menu_parent ='" + v_menu_parent + "'";
            }
            else
            {
                mStrWhere = " WHERE t_menu.menu_parent ='" + v_menu_parent + "'";
            }
        }

        if (v_menu_code != 0)
        {
            if (mStrWhere != "")
            {
                mStrWhere = mStrWhere + " AND t_menu.menu_code =" + v_menu_code;
            }
            else
            {
                mStrWhere = " WHERE t_menu.menu_code =" + v_menu_code;
            }
        }
        if (v_menu_title != "")
        {
            if (mStrWhere != "")
            {
                mStrWhere = mStrWhere + " AND t_menu.menu_title ='" + v_menu_title + "'";
            }
            else
            {
                mStrWhere = " WHERE t_menu.menu_title ='" + v_menu_title + "'";
            }
        }
        if (v_menu_link != "")
        {
            if (mStrWhere != "")
            {
                mStrWhere = mStrWhere + " AND t_menu.menu_link ='" + v_menu_link + "'";
            }
            else
            {
                mStrWhere = " WHERE t_menu.menu_link ='" + v_menu_link + "'";
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