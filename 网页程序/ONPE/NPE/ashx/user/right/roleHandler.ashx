<%@ WebHandler Language="C#" Class="roleHandler" %>

using System;
using System.Web;
using Newtonsoft.Json;
using NPE.UIDataClass;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Generic;
using ModelClass;
using System.Text;

public class roleHandler : IHttpHandler {

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
                string m_add_role_code = "";
                global mGlobal = new global();
                m_add_role_code = mGlobal.GetIdentityID("PC", "QX", "JS", System.DateTime.Now, 4);
                string m_add_role_name = "";
                if (context.Request.Params["role_name"] != null)
                {
                    m_add_role_name = context.Request.Params["role_name"];
                }
                else
                {
                    mIntParamNullable = mIntParamNullable + 1;
                }
                string m_add_role_discript = "";
                if (context.Request.Params["role_discript"] != null)
                {
                    m_add_role_discript = context.Request.Params["role_discript"];
                }
                else
                {
                    mIntParamNullable = mIntParamNullable + 1;
                }
                string m_add_create_time = "";
                if (context.Request.Params["create_time"] != null)
                {
                    m_add_create_time = context.Request.Params["create_time"];
                }
                else
                {
                    m_add_create_time = System.DateTime.Now.ToString();
                }
                string m_add_flag_valid = "";
                if (context.Request.Params["flag_valid"] != null)
                {
                    m_add_flag_valid = context.Request.Params["flag_valid"];
                }
                else
                {
                    m_add_flag_valid = "1";
                }
                string m_add_lost_time = "";
                if (context.Request.Params["lost_time"] != null)
                {
                    m_add_lost_time = context.Request.Params["lost_time"];
                }
                else
                {
                    m_add_lost_time = "1900-01-01 00:00:00";
                }
                if (mIntParamNullable == 0)
                {
                    mObjDetial = AddRoleData(m_add_role_code, m_add_role_name, m_add_role_discript, m_add_create_time, m_add_flag_valid, m_add_lost_time);
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
                string m_edit_role_code = "";
                if (context.Request.Params["role_code"] != null)
                {
                    m_edit_role_code = context.Request.Params["role_code"];
                }
                else
                {
                    mIntParamNullable = mIntParamNullable + 1;
                }
                string m_edit_role_name = "";
                if (context.Request.Params["role_name"] != null)
                {
                    m_edit_role_name = context.Request.Params["role_name"];
                }
                else
                {
                    mIntParamNullable = mIntParamNullable + 1;
                }
                string m_edit_role_discript = "";
                if (context.Request.Params["role_discript"] != null)
                {
                    m_edit_role_discript = context.Request.Params["role_discript"];
                }
                else
                {
                    mIntParamNullable = mIntParamNullable + 1;
                }
                string m_edit_create_time = "";
                if (context.Request.Params["create_time"] != null)
                {
                    m_edit_create_time = context.Request.Params["create_time"];
                }
                else
                {
                    m_edit_create_time = System.DateTime.Now.ToString();
                }
                string m_edit_flag_valid = "";
                if (context.Request.Params["flag_valid"] != null)
                {
                    m_edit_flag_valid = context.Request.Params["flag_valid"];
                }
                else
                {
                    m_edit_flag_valid = "1";
                }
                string m_edit_lost_time = "";
                if (context.Request.Params["lost_time"] != null)
                {
                    m_edit_lost_time = context.Request.Params["lost_time"];
                }
                else
                {
                    m_edit_lost_time = "1900-01-01 00:00:00"; 
                }
                if (mIntParamNullable == 0)
                {
                    mObjDetial = EditRoleData(m_edit_role_code, m_edit_role_name, m_edit_role_discript, m_edit_create_time, m_edit_flag_valid, m_edit_lost_time);
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
                string m_del_role_code = "";
                if (context.Request.Params["role_code"] != null)
                {
                    m_del_role_code = context.Request.Params["role_code"];
                }
                else
                {
                    mIntParamNullable = mIntParamNullable + 1;
                }
                if (mIntParamNullable == 0)
                {
                    mObjDetial = DelRoleData(m_del_role_code);
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
                string m_prop_role_code = "";
                if (context.Request.Params["role_code"] != null)
                {
                    m_prop_role_code = context.Request.Params["role_code"];
                }
                else
                {
                    mIntParamNullable = mIntParamNullable + 1;
                }
                if (mIntParamNullable == 0)
                {
                    mObjDetial = GetRolePropData(m_prop_role_code);
                    mStrMsg = "所请求的数据已成功返回";
                    mStrReturn = setReturnValue(true, mObjDetial, mStrMsg);
                }
                else
                {
                    mStrReturn = setReturnValue(false, "缺少必要参数", "缺少必要参数");
                }
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
                string m_grid_role_code = "";
                if (context.Request.Params["role_code"] != null)
                {
                    m_grid_role_code = context.Request.Params["role_code"];
                }
                string m_grid_role_name = "";
                if (context.Request.Params["role_name"] != null)
                {
                    m_grid_role_name = context.Request.Params["role_name"];
                }
                string m_grid_role_discript = "";
                if (context.Request.Params["role_discript"] != null)
                {
                    m_grid_role_discript = context.Request.Params["role_discript"];
                }
                string m_grid_create_time = "";
                if (context.Request.Params["create_time"] != null)
                {
                    m_grid_create_time = context.Request.Params["create_time"];
                }
                string m_grid_flag_valid = "";
                if (context.Request.Params["flag_valid"] != null)
                {
                    m_grid_flag_valid = context.Request.Params["flag_valid"];
                }
                string m_grid_lost_time = "";
                if (context.Request.Params["lost_time"] != null)
                {
                    m_grid_lost_time = context.Request.Params["lost_time"];
                }
                mObjDetial = GetRoleData(m_grid_role_code, m_grid_role_name, m_grid_role_discript, m_grid_create_time, m_grid_flag_valid, m_grid_lost_time, sort, order);
                mStrMsg = string.Format("\"total\":{0},\"rows\":", GetRoleCount(m_grid_role_code, m_grid_role_name, m_grid_role_discript, m_grid_create_time, m_grid_flag_valid, m_grid_lost_time));
                mStrReturn = "{" + mStrMsg + JsonConvert.SerializeObject(mObjDetial) + "}";
                break;
            default:
                mStrReturn = setReturnValue(false, "缺少必要参数", "缺少必要参数");
                break;
        }
        context.Response.Write(mStrReturn);
    }
    private int AddRoleData(string v_role_code, string v_role_name, string v_role_discript, string v_create_time, string v_flag_valid, string v_lost_time)
    {
        StringBuilder strSql = new StringBuilder();
        strSql.Append("insert into t_role(");
        strSql.Append("role_code,role_name,role_discript,create_time,flag_valid,lost_time");
        strSql.Append(") values (");
        strSql.Append("@role_code,@role_name,@role_discript,@create_time,@flag_valid,@lost_time");
        strSql.Append(") ");
        SqlParameter[] parameters = {
			             new SqlParameter("@role_code", SqlDbType.VarChar,30) ,            
                         new SqlParameter("@role_name", SqlDbType.VarChar,50) ,            
                         new SqlParameter("@role_discript", SqlDbType.VarChar,200) ,            
                         new SqlParameter("@create_time", SqlDbType.DateTime) ,            
                         new SqlParameter("@flag_valid", SqlDbType.Int,4) ,            
                         new SqlParameter("@lost_time", SqlDbType.DateTime)             
             
            };

        parameters[0].Value = v_role_code;
        parameters[1].Value = v_role_name;
        parameters[2].Value = v_role_discript;
        parameters[3].Value = v_create_time;
        parameters[4].Value = v_flag_valid;
        parameters[5].Value = v_lost_time;
        int i = claSqlConnDB.ExecuteNonQuery(claSqlConnDB.gStrConnDefault, CommandType.Text, strSql.ToString(), parameters);
        return i;
    }

    private int EditRoleData(string v_role_code, string v_role_name, string v_role_discript, string v_create_time, string v_flag_valid, string v_lost_time)
    {
        StringBuilder strSql = new StringBuilder();
        strSql.Append(" UPDATE t_role set");
        strSql.Append(" role_name=@role_name,");
        strSql.Append(" role_discript=@role_discript,");
        strSql.Append(" create_time=@create_time,");
        strSql.Append(" flag_valid=@flag_valid,");
        strSql.Append(" lost_time=@lost_time");
        strSql.Append(" Where role_code=@role_code");
        SqlParameter[] parameters = {
	              new SqlParameter("@role_code", SqlDbType.VarChar,30) ,            
                       new SqlParameter("@role_name", SqlDbType.VarChar,50) ,            
                       new SqlParameter("@role_discript", SqlDbType.VarChar,200) ,            
                       new SqlParameter("@create_time", SqlDbType.DateTime) ,            
                       new SqlParameter("@flag_valid", SqlDbType.Int,4) ,            
                       new SqlParameter("@lost_time", SqlDbType.DateTime)             
             
            };

        parameters[0].Value = v_role_code;
        parameters[1].Value = v_role_name;
        parameters[2].Value = v_role_discript;
        parameters[3].Value = v_create_time;
        parameters[4].Value = v_flag_valid;
        parameters[5].Value = v_lost_time;
        int i = claSqlConnDB.ExecuteNonQuery(claSqlConnDB.gStrConnDefault, CommandType.Text, strSql.ToString(), parameters);
        return i;
    }
    private int DelRoleData(string v_role_code)
    {
        StringBuilder strSql = new StringBuilder();
        strSql.Append("DELETE FROM t_role WHERE ");
        strSql.Append(" role_code=@role_code");
        SqlParameter[] parameters = {
			           new SqlParameter("@role_code", SqlDbType.VarChar,30)             
             
            };

        parameters[0].Value = v_role_code;
        int i = claSqlConnDB.ExecuteNonQuery(claSqlConnDB.gStrConnDefault, CommandType.Text, strSql.ToString(), parameters);
        return i;
    }
    private role GetRolePropData(string v_role_code)
    {
        StringBuilder strSql = new StringBuilder();
        strSql.Append("SELECT * FROM t_role WHERE");
        strSql.Append(" role_code=@role_code");
        SqlParameter[] parameters = {
			           new SqlParameter("@role_code", SqlDbType.VarChar,30)             
             
            };

        parameters[0].Value = v_role_code;
        role mRole = new role();
        mRole = (role)claSqlConnDB.GetDetail(claSqlConnDB.gStrConnDefault, strSql.ToString(), "Maticsoft.Model.t_role", parameters);
        return mRole;
    }
    private int GetRoleCount(string v_role_code, string v_role_name, string v_role_discript, string v_create_time, string v_flag_valid, string v_lost_time)
    {

        string mStrSQL = @" select count(0) from t_role " + GetWhere(v_role_code, v_role_name, v_role_discript, v_create_time, v_flag_valid, v_lost_time);
        int i = claSqlConnDB.GetRecordCount(claSqlConnDB.gStrConnDefault, mStrSQL);
        return i;
    }
    private List<role> GetRoleData(string v_role_code, string v_role_name, string v_role_discript, string v_create_time, string v_flag_valid, string v_lost_time, string v_grid_sort, string v_grid_order)
    {
        List<role> mLsrRoleGrid = new List<role>();
        string lStrSQL = @"select * from t_role  " + GetWhere(v_role_code, v_role_name, v_role_discript, v_create_time, v_flag_valid, v_lost_time)
                         + GetSort(v_grid_sort, v_grid_order);
        DataTable dt = null;
        using (dt = claSqlConnDB.ExecuteDataset(rows, page, claSqlConnDB.gStrConnDefault, CommandType.Text, lStrSQL).Tables[0])
        {
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                role mRoleTmp = new role();
                mRoleTmp.role_code = dt.Rows[i][0].ToString();
                mRoleTmp.role_name = dt.Rows[i][1].ToString();
                mRoleTmp.role_discript = dt.Rows[i][2].ToString();
                mRoleTmp.create_time = dt.Rows[i][3].ToString();
                mRoleTmp.flag_valid = dt.Rows[i][4].ToString();
                mRoleTmp.lost_time = dt.Rows[i][5].ToString();
                mLsrRoleGrid.Add(mRoleTmp);
            }
        }
        return mLsrRoleGrid;
    }


    private string GetWhere(string v_role_code, string v_role_name, string v_role_discript, string v_create_time, string v_flag_valid, string v_lost_time)
    {
        string mStrWhere = "";
        if (v_role_code != "")
        {
            if (mStrWhere != "")
            {
                mStrWhere = mStrWhere + " AND t_role.role_code ='" + v_role_code + "'";
            }
            else
            {
                mStrWhere = " WHERE t_role.role_code ='" + v_role_code + "'";
            }
        }
        if (v_role_name != "")
        {
            if (mStrWhere != "")
            {
                mStrWhere = mStrWhere + " AND t_role.role_name ='" + v_role_name + "'";
            }
            else
            {
                mStrWhere = " WHERE t_role.role_name ='" + v_role_name + "'";
            }
        }
        if (v_role_discript != "")
        {
            if (mStrWhere != "")
            {
                mStrWhere = mStrWhere + " AND t_role.role_discript ='" + v_role_discript + "'";
            }
            else
            {
                mStrWhere = " WHERE t_role.role_discript ='" + v_role_discript + "'";
            }
        }
        if (v_create_time != "")
        {
            if (mStrWhere != "")
            {
                mStrWhere = mStrWhere + " AND t_role.create_time ='" + v_create_time + "'";
            }
            else
            {
                mStrWhere = " WHERE t_role.create_time ='" + v_create_time + "'";
            }
        }
        if (v_flag_valid != "")
        {
            if (mStrWhere != "")
            {
                mStrWhere = mStrWhere + " AND t_role.flag_valid =" + v_flag_valid;
            }
            else
            {
                mStrWhere = " WHERE t_role.flag_valid =" + v_flag_valid;
            }
        }
        if (v_lost_time != "")
        {
            if (mStrWhere != "")
            {
                mStrWhere = mStrWhere + " AND t_role.lost_time ='" + v_lost_time + "'";
            }
            else
            {
                mStrWhere = " WHERE t_role.lost_time ='" + v_lost_time + "'";
            }
        }
        return mStrWhere;
    }
    private string GetSort(string v_grid_sort, string v_grid_order)
    {
        string mStrSort = "";
        if (v_grid_sort != "" && v_grid_sort != null)
        {
            mStrSort = " order by t_role." + v_grid_sort;
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