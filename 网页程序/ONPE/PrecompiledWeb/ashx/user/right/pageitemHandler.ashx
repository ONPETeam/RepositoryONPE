<%@ WebHandler Language="C#" Class="pageitemHandler" %>

using System;
using System.Web;
using Newtonsoft.Json;
using NPE.UIDataClass;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Generic;
using ModelClass;
using System.Text;

public class pageitemHandler : IHttpHandler {

    int page = 1;
    int rows = 10;
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
                
                string m_add_item_name = "";
                if (context.Request.Params["item_name"] != null)
                {
                    m_add_item_name = context.Request.Params["item_name"];
                }
                else
                {
                    mIntParamNullable = mIntParamNullable + 1;
                }
                string m_add_item_class = "0";
                if (context.Request.Params["item_class"] != null && context.Request.Params["item_class"]!="")
                {
                    m_add_item_class = context.Request.Params["item_class"];
                }
                else
                {
                    m_add_item_class = "0";
                }
                string m_add_item_parent = "0";
                if (context.Request.Params["item_parent"] != null)
                {
                    m_add_item_parent = context.Request.Params["item_parent"];
                }
                
                string m_add_item_title = "";
                if (context.Request.Params["item_title"] != null)
                {
                    m_add_item_title = context.Request.Params["item_title"];
                }
                else
                {
                    mIntParamNullable = mIntParamNullable + 1;
                }
                string m_add_item_code = "";
                if (context.Request.Params["item_code"] != null)
                {
                    m_add_item_code = context.Request.Params["item_code"];
                }
                else
                {
                    mIntParamNullable = mIntParamNullable + 1;
                }
                string m_add_item_icon = "";
                if (context.Request.Params["item_icon"] != null)
                {
                    m_add_item_icon = context.Request.Params["item_icon"];
                }
                
                string m_add_item_iconalign = "";
                if (context.Request.Params["item_iconalign"] != null)
                {
                    m_add_item_iconalign = context.Request.Params["item_iconalign"];
                }
                
                string m_add_item_iconsize = "";
                if (context.Request.Params["item_iconsize"] != null)
                {
                    m_add_item_iconsize = context.Request.Params["item_iconsize"];
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
                string m_add_item_remark = "";
                if (context.Request.Params["item_remark"] != null)
                {
                    m_add_item_remark = context.Request.Params["item_remark"];
                }
                
                if (mIntParamNullable == 0)
                {
                    mObjDetial = AddPageItemData( m_add_item_name, m_add_item_class, m_add_item_parent, m_add_item_title, m_add_item_code, m_add_item_icon, m_add_item_iconalign, m_add_item_iconsize, m_add_add_time, m_add_item_remark);
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
            case "edit":
                string m_edit_item_id = "";
                if (context.Request.Params["item_id"] != null)
                {
                    m_edit_item_id = context.Request.Params["item_id"];
                }
                else
                {
                    mIntParamNullable = mIntParamNullable + 1;
                }
                string m_edit_item_name = "";
                if (context.Request.Params["item_name"] != null)
                {
                    m_edit_item_name = context.Request.Params["item_name"];
                }
                else
                {
                    mIntParamNullable = mIntParamNullable + 1;
                }
                string m_edit_item_class = "";
                if (context.Request.Params["item_class"] != null)
                {
                    m_edit_item_class = context.Request.Params["item_class"];
                }
                else
                {
                    mIntParamNullable = mIntParamNullable + 1;
                }
                string m_edit_item_parent = "";
                if (context.Request.Params["item_parent"] != null)
                {
                    m_edit_item_parent = context.Request.Params["item_parent"];
                }
                
                string m_edit_item_title = "";
                if (context.Request.Params["item_title"] != null)
                {
                    m_edit_item_title = context.Request.Params["item_title"];
                }
                else
                {
                    mIntParamNullable = mIntParamNullable + 1;
                }
                string m_edit_item_code = "";
                if (context.Request.Params["item_code"] != null)
                {
                    m_edit_item_code = context.Request.Params["item_code"];
                }
                else
                {
                    mIntParamNullable = mIntParamNullable + 1;
                }
                string m_edit_item_icon = "";
                if (context.Request.Params["item_icon"] != null)
                {
                    m_edit_item_icon = context.Request.Params["item_icon"];
                }
                string m_edit_item_iconalign = "";
                if (context.Request.Params["item_iconalign"] != null)
                {
                    m_edit_item_iconalign = context.Request.Params["item_iconalign"];
                }
                string m_edit_item_iconsize = "";
                if (context.Request.Params["item_iconsize"] != null)
                {
                    m_edit_item_iconsize = context.Request.Params["item_iconsize"];
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
                string m_edit_item_remark = "";
                if (context.Request.Params["item_remark"] != null)
                {
                    m_edit_item_remark = context.Request.Params["item_remark"];
                }
                if (mIntParamNullable == 0)
                {
                    mObjDetial = EditPageItemData(m_edit_item_id, m_edit_item_name, m_edit_item_class, m_edit_item_parent, m_edit_item_title, m_edit_item_code, m_edit_item_icon, m_edit_item_iconalign, m_edit_item_iconsize, m_edit_add_time, m_edit_item_remark);
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
                string m_del_item_id = "";
                if (context.Request.Params["item_id"] != null)
                {
                    m_del_item_id = context.Request.Params["item_id"];
                }
                else
                {
                    mIntParamNullable = mIntParamNullable + 1;
                }
                if (mIntParamNullable == 0)
                {
                    mObjDetial = DelPageItemData(m_del_item_id);
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
                string m_prop_item_id = "";
                if (context.Request.Params["item_id"] != null)
                {
                    m_prop_item_id = context.Request.Params["item_id"];
                }
                else
                {
                    mIntParamNullable = mIntParamNullable + 1;
                }
                if (mIntParamNullable == 0)
                {
                    mObjDetial = GetPageItemPropData(m_prop_item_id);
                    mStrReturn = JsonConvert.SerializeObject(mObjDetial);
                }
                else
                {
                    mStrReturn = "{'error':'缺少必要参数'}";
                }
                break;
            case "count":
                string m_count_item_id = "";
                if (context.Request.Params["item_id"] != null)
                {
                    m_count_item_id = context.Request.Params["item_id"];
                }
                string m_count_item_name = "";
                if (context.Request.Params["item_name"] != null)
                {
                    m_count_item_name = context.Request.Params["item_name"];
                }
                string m_count_item_class = "";
                if (context.Request.Params["item_class"] != null)
                {
                    m_count_item_class = context.Request.Params["item_class"];
                }
                string m_count_item_parent = "";
                if (context.Request.Params["item_parent"] != null)
                {
                    m_count_item_parent = context.Request.Params["item_parent"];
                }
                string m_count_item_title = "";
                if (context.Request.Params["item_title"] != null)
                {
                    m_count_item_title = context.Request.Params["item_title"];
                }
                string m_count_item_code = "";
                if (context.Request.Params["item_code"] != null)
                {
                    m_count_item_code = context.Request.Params["item_code"];
                }
                string m_count_item_icon = "";
                if (context.Request.Params["item_icon"] != null)
                {
                    m_count_item_icon = context.Request.Params["item_icon"];
                }
                string m_count_item_iconalign = "";
                if (context.Request.Params["item_iconalign"] != null)
                {
                    m_count_item_iconalign = context.Request.Params["item_iconalign"];
                }
                string m_count_item_iconsize = "";
                if (context.Request.Params["item_iconsize"] != null)
                {
                    m_count_item_iconsize = context.Request.Params["item_iconsize"];
                }
                string m_count_add_time = "";
                if (context.Request.Params["add_time"] != null)
                {
                    m_count_add_time = context.Request.Params["add_time"];
                }
                string m_count_item_remark = "";
                if (context.Request.Params["item_remark"] != null)
                {
                    m_count_item_remark = context.Request.Params["item_remark"];
                }
                mObjDetial = GetPageItemCount(m_count_item_id, m_count_item_name, m_count_item_class, m_count_item_parent, m_count_item_title, m_count_item_code, m_count_item_icon, m_count_item_iconalign, m_count_item_iconsize, m_count_add_time, m_count_item_remark);

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
                string m_grid_item_id = "";
                if (context.Request.Params["item_id"] != null)
                {
                    m_grid_item_id = context.Request.Params["item_id"];
                }
                string m_grid_item_name = "";
                if (context.Request.Params["item_name"] != null)
                {
                    m_grid_item_name = context.Request.Params["item_name"];
                }
                string m_grid_item_class = "";
                if (context.Request.Params["item_class"] != null)
                {
                    m_grid_item_class = context.Request.Params["item_class"];
                }
                string m_grid_item_parent = "";
                if (context.Request.Params["item_parent"] != null)
                {
                    m_grid_item_parent = context.Request.Params["item_parent"];
                }
                string m_grid_item_title = "";
                if (context.Request.Params["item_title"] != null)
                {
                    m_grid_item_title = context.Request.Params["item_title"];
                }
                string m_grid_item_code = "";
                if (context.Request.Params["item_code"] != null)
                {
                    m_grid_item_code = context.Request.Params["item_code"];
                }
                string m_grid_item_icon = "";
                if (context.Request.Params["item_icon"] != null)
                {
                    m_grid_item_icon = context.Request.Params["item_icon"];
                }
                string m_grid_item_iconalign = "";
                if (context.Request.Params["item_iconalign"] != null)
                {
                    m_grid_item_iconalign = context.Request.Params["item_iconalign"];
                }
                string m_grid_item_iconsize = "";
                if (context.Request.Params["item_iconsize"] != null)
                {
                    m_grid_item_iconsize = context.Request.Params["item_iconsize"];
                }
                string m_grid_add_time = "";
                if (context.Request.Params["add_time"] != null)
                {
                    m_grid_add_time = context.Request.Params["add_time"];
                }
                string m_grid_item_remark = "";
                if (context.Request.Params["item_remark"] != null)
                {
                    m_grid_item_remark = context.Request.Params["item_remark"];
                }
                mObjDetial = GetPageItemData(m_grid_item_id, m_grid_item_name, m_grid_item_class, m_grid_item_parent, m_grid_item_title, m_grid_item_code, m_grid_item_icon, m_grid_item_iconalign, m_grid_item_iconsize, m_grid_add_time, m_grid_item_remark, sort, order);
                mStrMsg = string.Format("\"total\":{0},\"rows\":", GetPageItemCount(m_grid_item_id, m_grid_item_name, m_grid_item_class, m_grid_item_parent, m_grid_item_title, m_grid_item_code, m_grid_item_icon, m_grid_item_iconalign, m_grid_item_iconsize, m_grid_add_time, m_grid_item_remark));
                mStrReturn = "{" + mStrMsg + JsonConvert.SerializeObject(mObjDetial) + "}";
                break;
            case "combo":
                string m_combo_item_id = "";
                if (context.Request.Params["item_id"] != null)
                {
                    m_combo_item_id = context.Request.Params["item_id"];
                }
                string m_combo_item_name = "";
                if (context.Request.Params["item_name"] != null)
                {
                    m_combo_item_name = context.Request.Params["item_name"];
                }
                string m_combo_item_class = "";
                if (context.Request.Params["item_class"] != null)
                {
                    m_combo_item_class = context.Request.Params["item_class"];
                }
                string m_combo_item_parent = "";
                if (context.Request.Params["item_parent"] != null)
                {
                    m_combo_item_parent = context.Request.Params["item_parent"];
                }
                string m_combo_item_title = "";
                if (context.Request.Params["item_title"] != null)
                {
                    m_combo_item_title = context.Request.Params["item_title"];
                }
                string m_combo_item_code = "";
                if (context.Request.Params["item_code"] != null)
                {
                    m_combo_item_code = context.Request.Params["item_code"];
                }
                mObjDetial = GetPageItemComboData(m_combo_item_id, m_combo_item_name, m_combo_item_class, m_combo_item_parent, m_combo_item_title, m_combo_item_code);
                mStrReturn = JsonConvert.SerializeObject(mObjDetial);
                break;
            case "combotree":
                string m_combotree_item_parent = "";
                if (context.Request.Params["item_parent"] != null)
                {
                    m_combotree_item_parent = context.Request.Params["item_parent"];
                }
                mObjDetial = GetPageItemComboTreeData(m_combotree_item_parent);
                mStrReturn = JsonConvert.SerializeObject(mObjDetial);
                break;
            default:
                mStrReturn = "{'success':false,'msg':'缺少必要参数！'}";
                break;
        }
        context.Response.Write(mStrReturn);
    }
    private int AddPageItemData(string v_item_name, string v_item_class, string v_item_parent, string v_item_title, string v_item_code, string v_item_icon, string v_item_iconalign, string v_item_iconsize, string v_add_time, string v_item_remark)
    {
        global mglobal = new global();
        
        string v_item_id = "";

        v_item_id = mglobal.GetIdentityID("PC", "QX", "XM", System.DateTime.Now, 4);
        
        StringBuilder strSql = new StringBuilder();
        strSql.Append("insert into t_menuitem(");
        strSql.Append("item_id,item_name,item_class,item_parent,item_title,item_code,item_icon,item_iconalign,item_iconsize,add_time,item_remark");
        strSql.Append(") values (");
        strSql.Append("@item_id,@item_name,@item_class,@item_parent,@item_title,@item_code,@item_icon,@item_iconalign,@item_iconsize,@add_time,@item_remark");
        strSql.Append(") ");
        SqlParameter[] parameters = {
			             new SqlParameter("@item_id", SqlDbType.VarChar,30) ,            
                         new SqlParameter("@item_name", SqlDbType.VarChar,50) ,            
                         new SqlParameter("@item_class", SqlDbType.Int,4) ,            
                         new SqlParameter("@item_parent", SqlDbType.VarChar,30) ,            
                         new SqlParameter("@item_title", SqlDbType.VarChar,50) ,            
                         new SqlParameter("@item_code", SqlDbType.VarChar,100) ,            
                         new SqlParameter("@item_icon", SqlDbType.VarChar,100) ,            
                         new SqlParameter("@item_iconalign", SqlDbType.VarChar,30) ,            
                         new SqlParameter("@item_iconsize", SqlDbType.VarChar,30) ,            
                         new SqlParameter("@add_time", SqlDbType.DateTime) ,            
                         new SqlParameter("@item_remark", SqlDbType.VarChar,200)             
             
            };

        parameters[0].Value = v_item_id;
        parameters[1].Value = v_item_name;
        parameters[2].Value = v_item_class;
        parameters[3].Value = v_item_parent;
        parameters[4].Value = v_item_title;
        parameters[5].Value = v_item_code;
        parameters[6].Value = v_item_icon;
        parameters[7].Value = v_item_iconalign;
        parameters[8].Value = v_item_iconsize;
        parameters[9].Value = v_add_time;
        parameters[10].Value = v_item_remark;
        int i = claSqlConnDB.ExecuteNonQuery(claSqlConnDB.gStrConnDefault, CommandType.Text, strSql.ToString(), parameters);
        return i;
    }
    private int EditPageItemData(string v_item_id, string v_item_name, string v_item_class, string v_item_parent, string v_item_title, string v_item_code, string v_item_icon, string v_item_iconalign, string v_item_iconsize, string v_add_time, string v_item_remark)
    {
        StringBuilder strSql = new StringBuilder();
        strSql.Append("UPDATE t_menuitem set ");
        
        strSql.Append("item_name=@item_name,");
        strSql.Append("item_class=@item_class,");
        strSql.Append("item_parent=@item_parent,");
        strSql.Append("item_title=@item_title,");
        strSql.Append("item_code=@item_code,");
        strSql.Append("item_icon=@item_icon,");
        strSql.Append("item_iconalign=@item_iconalign,");
        strSql.Append("item_iconsize=@item_iconsize,");
        strSql.Append("add_time=@add_time,");
        strSql.Append("item_remark=@item_remark");
        strSql.Append(" where item_id=@item_id");
        SqlParameter[] parameters = {
	              new SqlParameter("@item_id", SqlDbType.VarChar,30) ,            
                       new SqlParameter("@item_name", SqlDbType.VarChar,50) ,            
                       new SqlParameter("@item_class", SqlDbType.Int,4) ,            
                       new SqlParameter("@item_parent", SqlDbType.VarChar,30) ,            
                       new SqlParameter("@item_title", SqlDbType.VarChar,50) ,            
                       new SqlParameter("@item_code", SqlDbType.VarChar,100) ,            
                       new SqlParameter("@item_icon", SqlDbType.VarChar,100) ,            
                       new SqlParameter("@item_iconalign", SqlDbType.VarChar,30) ,            
                       new SqlParameter("@item_iconsize", SqlDbType.VarChar,30) ,            
                       new SqlParameter("@add_time", SqlDbType.DateTime) ,            
                       new SqlParameter("@item_remark", SqlDbType.VarChar,200)             
             
            };

        parameters[0].Value = v_item_id;
        parameters[1].Value = v_item_name;
        parameters[2].Value = v_item_class;
        parameters[3].Value = v_item_parent;
        parameters[4].Value = v_item_title;
        parameters[5].Value = v_item_code;
        parameters[6].Value = v_item_icon;
        parameters[7].Value = v_item_iconalign;
        parameters[8].Value = v_item_iconsize;
        parameters[9].Value = v_add_time;
        parameters[10].Value = v_item_remark;
        int i = claSqlConnDB.ExecuteNonQuery(claSqlConnDB.gStrConnDefault, CommandType.Text, strSql.ToString(), parameters);
        return i;
    }
    private int DelPageItemData(string v_item_id)
    {
        StringBuilder strSql = new StringBuilder();
        strSql.Append("DELETE FROM t_menuitem WHERE ");
        strSql.Append("item_id=@item_id");
        SqlParameter[] parameters = {
			           new SqlParameter("@item_id", SqlDbType.VarChar,30)   
            };

        parameters[0].Value = v_item_id;
        int i = claSqlConnDB.ExecuteNonQuery(claSqlConnDB.gStrConnDefault, CommandType.Text, strSql.ToString(), parameters);
        return i;
    }
    private List<combotree> GetPageItemComboTreeData(string v_item_parent)
    {
        List<combotree> mLstComboTree = new List<combotree>();
        StringBuilder strSql = new StringBuilder();
        strSql.Append("SELECT item_id,item_title FROM t_menuitem WHERE ");
        strSql.Append("item_parent=@item_parent");
        SqlParameter[] parameters = {
			           new SqlParameter("@item_parent", SqlDbType.VarChar,30)   
            };

        parameters[0].Value = v_item_parent;
        DataTable dt = null;
        using (dt = claSqlConnDB.ExecuteDataset(claSqlConnDB.gStrConnDefault, CommandType.Text, strSql.ToString(), parameters).Tables[0])
        {
            if (dt.Rows.Count > 0)
            {
                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    combotree mComboTree = new combotree();
                    mComboTree.attributes = "";
                    mComboTree.id = dt.Rows[i][0].ToString();
                    mComboTree.text = dt.Rows[i][1].ToString();
                    mComboTree.state = "open";
                    mComboTree.children = GetPageItemComboTreeData(dt.Rows[i][0].ToString());
                    mLstComboTree.Add(mComboTree);
                } 
            } 
        }
        return mLstComboTree;
    }
    
    private List<combobox> GetPageItemComboData(string v_item_id, string v_item_name, string v_item_class, string v_item_parent, string v_item_title, string v_item_code)
    {
        List<combobox> mLstCombo = new List<combobox>();
        StringBuilder strSql = new StringBuilder();
        strSql.Append("SELECT item_id,item_title FROM t_menuitem ");
        strSql.Append(GetWhere(v_item_id, v_item_name, v_item_class, v_item_parent, v_item_title, v_item_code));
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
    
    private pageitem GetPageItemPropData(string v_item_id)
    {
        StringBuilder strSql = new StringBuilder();
        strSql.Append("SELECT * FROM t_menuitem WHERE");
        strSql.Append("item_id=@item_id");
        SqlParameter[] parameters = {
			           new SqlParameter("@item_id", SqlDbType.VarChar,30)             
             
            };

        parameters[0].Value = v_item_id;
        pageitem mpageitem = new pageitem();
        mpageitem = (pageitem)claSqlConnDB.GetDetail(claSqlConnDB.gStrConnDefault, strSql.ToString(), "ModelClass.Model.tmenuitem", parameters);
        return mpageitem;
    }
    private int GetPageItemCount(string v_item_id, string v_item_name, string v_item_class, string v_item_parent, string v_item_title, string v_item_code, string v_item_icon, string v_item_iconalign, string v_item_iconsize, string v_add_time, string v_item_remark)
    {

        string mStrSQL = @" select count(0) from t_menuitem " + GetWhere(v_item_id, v_item_name, v_item_class, v_item_parent, v_item_title, v_item_code);
        int i = claSqlConnDB.GetRecordCount(claSqlConnDB.gStrConnDefault, mStrSQL);
        return i;
    }
    private List<pageitem> GetPageItemData(string v_item_id, string v_item_name, string v_item_class, string v_item_parent, string v_item_title, string v_item_code, string v_item_icon, string v_item_iconalign, string v_item_iconsize, string v_add_time, string v_item_remark, string v_grid_sort, string v_grid_order)
    {
        List<pageitem> mLstPageItem = new List<pageitem>();
        string lStrSQL = @"select * from t_menuitem  " + GetWhere(v_item_id, v_item_name, v_item_class, v_item_parent, v_item_title, v_item_code)
                         + GetSort(v_grid_sort, v_grid_order);
        DataTable dt = null;
        using (dt = claSqlConnDB.ExecuteDataset(rows, page, claSqlConnDB.gStrConnDefault, CommandType.Text, lStrSQL).Tables[0])
        {
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                pageitem tPageItemTemp = new pageitem();
                tPageItemTemp.item_id = dt.Rows[i][0].ToString();
                tPageItemTemp.item_name = dt.Rows[i][1].ToString();
                tPageItemTemp.item_class = (int)dt.Rows[i][2];
                tPageItemTemp.item_parent = dt.Rows[i][3].ToString();
                tPageItemTemp.item_title = dt.Rows[i][4].ToString();
                tPageItemTemp.item_code = dt.Rows[i][5].ToString();
                tPageItemTemp.item_icon = dt.Rows[i][6].ToString();
                tPageItemTemp.item_iconalign = dt.Rows[i][7].ToString();
                tPageItemTemp.item_iconsize = dt.Rows[i][8].ToString();
                tPageItemTemp.add_time = (DateTime)dt.Rows[i][9];
                tPageItemTemp.item_remark = dt.Rows[i][10].ToString();
                mLstPageItem.Add(tPageItemTemp);
            }
        }
        return mLstPageItem;
    }


    private string GetWhere(string v_item_id, string v_item_name, string v_item_class, string v_item_parent, string v_item_title, string v_item_code)
    {
        string mStrWhere = "";
        if (v_item_id != "")
        {
            if (mStrWhere != "")
            {
                mStrWhere = mStrWhere + " AND t_menuitem.item_id ='" + v_item_id + "'";
            }
            else
            {
                mStrWhere = " WHERE t_menuitem.item_id ='" + v_item_id + "'";
            }
        }
        if (v_item_name != "")
        {
            if (mStrWhere != "")
            {
                mStrWhere = mStrWhere + " AND t_menuitem.item_name like '%" + v_item_name + "%'";
            }
            else
            {
                mStrWhere = " WHERE t_menuitem.item_name like '%" + v_item_name + "%'";
            }
        }
        if (v_item_class != "")
        {
            if (mStrWhere != "")
            {
                mStrWhere = mStrWhere + " AND t_menuitem.item_class =" + v_item_class;
            }
            else
            {
                mStrWhere = " WHERE t_menuitem.item_class =" + v_item_class;
            }
        }
        if (v_item_parent != "")
        {
            if (mStrWhere != "")
            {
                mStrWhere = mStrWhere + " AND t_menuitem.item_parent ='" + v_item_parent + "'";
            }
            else
            {
                mStrWhere = " WHERE t_menuitem.item_parent ='" + v_item_parent + "'";
            }
        }
        if (v_item_title != "")
        {
            if (mStrWhere != "")
            {
                mStrWhere = mStrWhere + " AND t_menuitem.item_title like '%" + v_item_title + "%'";
            }
            else
            {
                mStrWhere = " WHERE t_menuitem.item_title like '%" + v_item_title + "%'";
            }
        }
        if (v_item_code != "")
        {
            if (mStrWhere != "")
            {
                mStrWhere = mStrWhere + " AND t_menuitem.item_code like '%" + v_item_code + "%'";
            }
            else
            {
                mStrWhere = " WHERE t_menuitem.item_code like '%" + v_item_code + "%'";
            }
        }
        
        return mStrWhere;
    }
    private string GetSort(string v_grid_sort, string v_grid_order)
    {
        string mStrSort = "";
        if (v_grid_sort != "" && v_grid_sort != null)
        {
            mStrSort = " order by t_menuitem." + v_grid_sort;
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