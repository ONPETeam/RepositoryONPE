<%@ WebHandler Language="C#" Class="roleGroupHandler" %>

using System;
using System.Web;
using Newtonsoft.Json;
using NPE.UIDataClass;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Generic;
using ModelClass;
using System.Text;

public class roleGroupHandler : IHttpHandler
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
                string m_set_group_set = "";
                if (context.Request.Params["group_set"] != null)
                {
                    m_set_group_set = context.Request.Params["group_set"];
                }
                if (mIntParamNullable == 0)
                {
                    int mIntReturn = SetRoleGroup(m_set_role_code, m_set_group_set);
                    if (mIntReturn == 0)
                    {
                        mStrReturn = "{'success':true,'msg':'设置角色分组成功！'}";
                    }
                    else
                    {
                        mStrReturn = "{'success':false,'msg':'设置角色分组失败！'}";
                    }
                }
                else
                {
                    mStrReturn = "{'success':false,'msg':'缺少必要参数！'}";
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
                string m_grid_group_code = "";
                if (context.Request.Params["group_code"] != null)
                {
                    m_grid_group_code = context.Request.Params["group_code"];
                }
                mObjDetial = GetRoleGroupData(m_grid_role_code, m_grid_group_code, sort, order);
                mStrMsg = string.Format("\"total\":{0},\"rows\":", GetRoleGroupCount(m_grid_role_code, m_grid_group_code));
                mStrReturn = "{" + mStrMsg + JsonConvert.SerializeObject(mObjDetial) + "}";
                break;
            default:
                mStrReturn = setReturnValue(false, "缺少必要参数", "缺少必要参数");
                break;
        }
        context.Response.Write(mStrReturn);
    }
    private int SetRoleGroup(string v_role_code, string v_group_set)
    {
        
        SqlParameter[] _Parameter = new SqlParameter[3]
            {
                new SqlParameter("@viVchRoleCode",SqlDbType.VarChar,8000),
                new SqlParameter("@viVchGroupSet",SqlDbType.VarChar,8000),
                new SqlParameter("@voIntReturn",SqlDbType.Int),
            };
        _Parameter[0].Value = v_role_code;
        _Parameter[1].Value = v_group_set;
        _Parameter[2].Direction = System.Data.ParameterDirection.Output;
        claSqlConnDB.ExecuteNonQuery(claSqlConnDB.gStrConnDefault, CommandType.StoredProcedure, "p_role_group_set", _Parameter);
        int i = (int)_Parameter[2].Value;
        return i;
    }

    
    private int GetRoleGroupCount(string v_role_code, string v_group_code)
    {

        string mStrSQL = @" select count(0) from t_role_group " + GetWhere(v_role_code, v_group_code);
        int i = claSqlConnDB.GetRecordCount(claSqlConnDB.gStrConnDefault, mStrSQL);
        return i;
    }
    private List<role> GetRoleGroupData(string v_role_code, string v_group_code, string v_grid_sort, string v_grid_order)
    {
        List<role> mLstRoleGroupGrid = new List<role>();
        string lStrSQL = @"SELECT     t_role_group.role_code, t_role.role_name, t_role.role_discript, t_role.flag_valid, t_role.create_time, t_role.lost_time, t_role_group.group_code
                            FROM      t_role_group  LEFT OUTER JOIN
                                      t_role ON t_role_group.role_code = t_role.role_code" + GetWhere(v_role_code, v_group_code)
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
                mRoleTmp.flag_valid = dt.Rows[i][3].ToString();
                mRoleTmp.create_time = dt.Rows[i][4].ToString();
                mRoleTmp.lost_time = dt.Rows[i][5].ToString();
                mLstRoleGroupGrid.Add(mRoleTmp);
            }
        }
        return mLstRoleGroupGrid;
    }


    private string GetWhere(string v_role_code, string v_group_code)
    {
        string mStrWhere = "";
        if (v_role_code != "")
        {
            if (mStrWhere != "")
            {
                mStrWhere = mStrWhere + " AND t_role_group.role_code ='" + v_role_code + "'";
            }
            else
            {
                mStrWhere = " WHERE t_role_group.role_code ='" + v_role_code + "'";
            }
        }
        if (v_group_code != "")
        {
            if (mStrWhere != "")
            {
                mStrWhere = mStrWhere + " AND t_role_group.group_code ='" + v_group_code + "'";
            }
            else
            {
                mStrWhere = " WHERE t_role_group.group_code ='" + v_group_code + "'";
            }
        }
        return mStrWhere;
    }
    private string GetSort(string v_grid_sort, string v_grid_order)
    {
        string mStrSort = "";
        if (v_grid_sort != "" && v_grid_sort != null)
        {
            mStrSort = " order by t_role_group." + v_grid_sort;
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