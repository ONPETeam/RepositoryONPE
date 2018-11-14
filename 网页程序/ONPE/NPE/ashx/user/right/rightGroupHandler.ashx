<%@ WebHandler Language="C#" Class="rightGroupHandler" %>

using System;
using System.Web;
using Newtonsoft.Json;
using NPE.UIDataClass;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Generic;
using ModelClass;
using System.Text;

public class rightGroupHandler : IHttpHandler {

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
                string m_add_group_code = "";
                global mGlobal = new global();
                m_add_group_code = mGlobal.GetIdentityID("PC", "QX", "RG", System.DateTime.Now, 4);
                string m_add_group_name = "";
                if (context.Request.Params["group_name"] != null)
                {
                    m_add_group_name = context.Request.Params["group_name"];
                }
                else
                {
                    mIntParamNullable = mIntParamNullable + 1;
                }
                string m_add_group_type = "";
                if (context.Request.Params["group_type"] != null)
                {
                    m_add_group_type = context.Request.Params["group_type"];
                }
                else
                {
                    mIntParamNullable = mIntParamNullable + 1;
                }
                string m_add_group_discript = "";
                if (context.Request.Params["group_discript"] != null)
                {
                    m_add_group_discript = context.Request.Params["group_discript"];
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
                    mObjDetial = AddGroupData(m_add_group_code, m_add_group_name, m_add_group_type, m_add_group_discript, m_add_create_time, m_add_flag_valid, m_add_lost_time);
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
                string m_edit_group_code = "";
                if (context.Request.Params["group_code"] != null)
                {
                    m_edit_group_code = context.Request.Params["group_code"];
                }
                else
                {
                    mIntParamNullable = mIntParamNullable + 1;
                }
                string m_edit_group_name = "";
                if (context.Request.Params["group_name"] != null)
                {
                    m_edit_group_name = context.Request.Params["group_name"];
                }
                else
                {
                    mIntParamNullable = mIntParamNullable + 1;
                }
                string m_edit_group_type = "";
                if (context.Request.Params["group_type"] != null)
                {
                    m_edit_group_type = context.Request.Params["group_type"];
                }
                else
                {
                    mIntParamNullable = mIntParamNullable + 1;
                }
                string m_edit_group_discript = "";
                if (context.Request.Params["group_discript"] != null)
                {
                    m_edit_group_discript = context.Request.Params["group_discript"];
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
                    m_edit_create_time =System.DateTime.Now.ToString();
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
                    mObjDetial = EditGroupData(m_edit_group_code, m_edit_group_name, m_edit_group_type, m_edit_group_discript, m_edit_create_time, m_edit_flag_valid, m_edit_lost_time);
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
                string m_del_group_code = "";
                if (context.Request.Params["group_code"] != null)
                {
                    m_del_group_code = context.Request.Params["group_code"];
                }
                else
                {
                    mIntParamNullable = mIntParamNullable + 1;
                }
                if (mIntParamNullable == 0)
                {
                    mObjDetial = DelGroupData(m_del_group_code);
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
                string m_prop_group_code = "";
                if (context.Request.Params["group_code"] != null)
                {
                    m_prop_group_code = context.Request.Params["group_code"];
                }
                else
                {
                    mIntParamNullable = mIntParamNullable + 1;
                }
                if (mIntParamNullable == 0)
                {
                    mObjDetial = GetGroupPropData(m_prop_group_code);
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
                string m_grid_group_code = "";
                if (context.Request.Params["group_code"] != null)
                {
                    m_grid_group_code = context.Request.Params["group_code"];
                }
                string m_grid_group_name = "";
                if (context.Request.Params["group_name"] != null)
                {
                    m_grid_group_name = context.Request.Params["group_name"];
                }
                string m_grid_group_type = "";
                if (context.Request.Params["group_type"] != null)
                {
                    m_grid_group_type = context.Request.Params["group_type"];
                }
                string m_grid_group_discript = "";
                if (context.Request.Params["group_discript"] != null)
                {
                    m_grid_group_discript = context.Request.Params["group_discript"];
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
                mObjDetial = GetGroupData(m_grid_group_code, m_grid_group_name, m_grid_group_type, m_grid_group_discript, m_grid_create_time, m_grid_flag_valid, m_grid_lost_time, sort, order);
                mStrMsg = string.Format("\"total\":{0},\"rows\":", Gett_groupCount(m_grid_group_code, m_grid_group_name, m_grid_group_type, m_grid_group_discript, m_grid_create_time, m_grid_flag_valid, m_grid_lost_time));
                mStrReturn = "{" + mStrMsg + JsonConvert.SerializeObject(mObjDetial) + "}";
                break;
            default:
                mStrReturn = setReturnValue(false, "缺少必要参数", "缺少必要参数");
                break;
        }
        context.Response.Write(mStrReturn);
    }
    private int AddGroupData(string v_group_code, string v_group_name, string v_group_type, string v_group_discript, string v_create_time, string v_flag_valid, string v_lost_time)
    {
        StringBuilder strSql = new StringBuilder();
        strSql.Append("insert into t_group(");
        strSql.Append("group_code,group_name,group_type,group_discript,create_time,flag_valid,lost_time");
        strSql.Append(") values (");
        strSql.Append("@group_code,@group_name,@group_type,@group_discript,@create_time,@flag_valid,@lost_time");
        strSql.Append(") ");
        SqlParameter[] parameters = {
			             new SqlParameter("@group_code", SqlDbType.VarChar,30) ,            
                         new SqlParameter("@group_name", SqlDbType.VarChar,50) ,            
                         new SqlParameter("@group_type", SqlDbType.Int,4) ,            
                         new SqlParameter("@group_discript", SqlDbType.VarChar,200) ,            
                         new SqlParameter("@create_time", SqlDbType.DateTime) ,            
                         new SqlParameter("@flag_valid", SqlDbType.Int,4) ,            
                         new SqlParameter("@lost_time", SqlDbType.DateTime)             
             
            };

        parameters[0].Value = v_group_code;
        parameters[1].Value = v_group_name;
        parameters[2].Value = v_group_type;
        parameters[3].Value = v_group_discript;
        parameters[4].Value = v_create_time;
        parameters[5].Value = v_flag_valid;
        parameters[6].Value = v_lost_time;
        int i = claSqlConnDB.ExecuteNonQuery(claSqlConnDB.gStrConnDefault, CommandType.Text, strSql.ToString(), parameters);
        return i;
    }
    private int EditGroupData(string v_group_code, string v_group_name, string v_group_type, string v_group_discript, string v_create_time, string v_flag_valid, string v_lost_time)
    {
        StringBuilder strSql = new StringBuilder();
        strSql.Append(" UPDATE t_group set ");
        
        strSql.Append(" group_name=@group_name,");
        strSql.Append(" group_type=@group_type,");
        strSql.Append(" group_discript=@group_discript,");
        strSql.Append(" create_time=@create_time,");
        strSql.Append(" flag_valid=@flag_valid,");
        strSql.Append(" lost_time=@lost_time");
        strSql.Append(" Where group_code=@group_code");
        SqlParameter[] parameters = {
	              new SqlParameter("@group_code", SqlDbType.VarChar,30) ,            
                       new SqlParameter("@group_name", SqlDbType.VarChar,50) ,            
                       new SqlParameter("@group_type", SqlDbType.Int,4) ,            
                       new SqlParameter("@group_discript", SqlDbType.VarChar,200) ,            
                       new SqlParameter("@create_time", SqlDbType.DateTime) ,            
                       new SqlParameter("@flag_valid", SqlDbType.Int,4) ,            
                       new SqlParameter("@lost_time", SqlDbType.DateTime)             
             
            };

        parameters[0].Value = v_group_code;
        parameters[1].Value = v_group_name;
        parameters[2].Value = v_group_type;
        parameters[3].Value = v_group_discript;
        parameters[4].Value = v_create_time;
        parameters[5].Value = v_flag_valid;
        parameters[6].Value = v_lost_time;
        int i = claSqlConnDB.ExecuteNonQuery(claSqlConnDB.gStrConnDefault, CommandType.Text, strSql.ToString(), parameters);
        return i;
    }
    private int DelGroupData(string v_group_code)
    {
        StringBuilder strSql = new StringBuilder();
        strSql.Append("DELETE FROM t_group WHERE ");
        strSql.Append("group_code=@group_code");
        SqlParameter[] parameters = {
			           new SqlParameter("@group_code", SqlDbType.VarChar,30)             
             
            };

        parameters[0].Value = v_group_code;
        int i = claSqlConnDB.ExecuteNonQuery(claSqlConnDB.gStrConnDefault, CommandType.Text, strSql.ToString(), parameters);
        return i;
    }
    private group GetGroupPropData(string v_group_code)
    {
        StringBuilder strSql = new StringBuilder();
        strSql.Append("SELECT * FROM t_group WHERE");
        strSql.Append("group_code=@group_code");
        SqlParameter[] parameters = {
			           new SqlParameter("@group_code", SqlDbType.VarChar,30)             
             
            };

        parameters[0].Value = v_group_code;
        group mGroup = new group();
        mGroup = (group)claSqlConnDB.GetDetail(claSqlConnDB.gStrConnDefault, strSql.ToString(), "Maticsoft.Model.t_group", parameters);
        return mGroup;
    }
    private int Gett_groupCount(string v_group_code, string v_group_name, string v_group_type, string v_group_discript, string v_create_time, string v_flag_valid, string v_lost_time)
    {

        string mStrSQL = @" select count(0) from t_group " + GetWhere(v_group_code, v_group_name, v_group_type, v_group_discript, v_create_time, v_flag_valid, v_lost_time);
        int i = claSqlConnDB.GetRecordCount(claSqlConnDB.gStrConnDefault, mStrSQL);
        return i;
    }
    private List<group> GetGroupData(string v_group_code, string v_group_name, string v_group_type, string v_group_discript, string v_create_time, string v_flag_valid, string v_lost_time, string v_grid_sort, string v_grid_order)
    {
        List<group> t_groupGrid = new List<group>();
        string lStrSQL = @"select * from t_group  " + GetWhere(v_group_code, v_group_name, v_group_type, v_group_discript, v_create_time, v_flag_valid, v_lost_time)
                         + GetSort(v_grid_sort, v_grid_order);
        DataTable dt = null;
        using (dt = claSqlConnDB.ExecuteDataset(rows, page, claSqlConnDB.gStrConnDefault, CommandType.Text, lStrSQL).Tables[0])
        {
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                group t_groupTmp = new group();
                t_groupTmp.group_code = dt.Rows[i][0].ToString();
                t_groupTmp.group_name = dt.Rows[i][1].ToString();
                t_groupTmp.group_type =(int) dt.Rows[i][2];
                t_groupTmp.group_discript = dt.Rows[i][3].ToString();
                t_groupTmp.create_time = (DateTime)dt.Rows[i][4];
                t_groupTmp.flag_valid = (int)dt.Rows[i][5];
                t_groupTmp.lost_time = (DateTime)dt.Rows[i][6];
                t_groupGrid.Add(t_groupTmp);
            }
        }
        return t_groupGrid;
    }


    private string GetWhere(string v_group_code, string v_group_name, string v_group_type, string v_group_discript, string v_create_time, string v_flag_valid, string v_lost_time)
    {
        string mStrWhere = "";
        if (v_group_code != "")
        {
            if (mStrWhere != "")
            {
                mStrWhere = mStrWhere + " AND t_group.group_code ='" + v_group_code + "'";
            }
            else
            {
                mStrWhere = " WHERE t_group.group_code ='" + v_group_code + "'";
            }
        }
        if (v_group_name != "")
        {
            if (mStrWhere != "")
            {
                mStrWhere = mStrWhere + " AND t_group.group_name ='" + v_group_name + "'";
            }
            else
            {
                mStrWhere = " WHERE t_group.group_name ='" + v_group_name + "'";
            }
        }
        if (v_group_type != "")
        {
            if (mStrWhere != "")
            {
                mStrWhere = mStrWhere + " AND t_group.group_type =" + v_group_type;
            }
            else
            {
                mStrWhere = " WHERE t_group.group_type =" + v_group_type;
            }
        }
        if (v_group_discript != "")
        {
            if (mStrWhere != "")
            {
                mStrWhere = mStrWhere + " AND t_group.group_discript ='" + v_group_discript + "'";
            }
            else
            {
                mStrWhere = " WHERE t_group.group_discript ='" + v_group_discript + "'";
            }
        }
        if (v_create_time != "")
        {
            if (mStrWhere != "")
            {
                mStrWhere = mStrWhere + " AND t_group.create_time ='" + v_create_time + "'";
            }
            else
            {
                mStrWhere = " WHERE t_group.create_time ='" + v_create_time + "'";
            }
        }
        if (v_flag_valid != "")
        {
            if (mStrWhere != "")
            {
                mStrWhere = mStrWhere + " AND t_group.flag_valid =" + v_flag_valid;
            }
            else
            {
                mStrWhere = " WHERE t_group.flag_valid =" + v_flag_valid;
            }
        }
        if (v_lost_time != "")
        {
            if (mStrWhere != "")
            {
                mStrWhere = mStrWhere + " AND t_group.lost_time ='" + v_lost_time + "'";
            }
            else
            {
                mStrWhere = " WHERE t_group.lost_time ='" + v_lost_time + "'";
            }
        }
        return mStrWhere;
    }
    private string GetSort(string v_grid_sort, string v_grid_order)
    {
        string mStrSort = "";
        if (v_grid_sort != "" && v_grid_sort != null)
        {
            mStrSort = " order by t_group." + v_grid_sort;
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