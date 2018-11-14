<%@ WebHandler Language="C#" Class="userRoleHandler" %>

using System;
using System.Web;
using Newtonsoft.Json;
using NPE.UIDataClass;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Generic;
using ModelClass;
using System.Text;

public class userRoleHandler : IHttpHandler {

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
                string m_set_user_code = "";
                if (context.Request.Params["user_code"] != null)
                {
                    m_set_user_code = context.Request.Params["user_code"];
                }
                else
                {
                    mIntParamNullable = mIntParamNullable + 1;
                }
                string m_set_role_set = "";
                if (context.Request.Params["role_set"] != null)
                {
                    m_set_role_set = context.Request.Params["role_set"];
                }
                if (mIntParamNullable == 0)
                {
                    int mIntReturn = SetUserRole(m_set_user_code, m_set_role_set);
                    if (mIntReturn == 0)
                    {
                        mStrReturn = "{'success':true,'msg':'设置用户分组成功！'}";
                    }
                    else
                    {
                        mStrReturn = "{'success':false,'msg':'设置用户分组失败！'}";
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
                string m_grid_user_code = "";
                if (context.Request.Params["user_code"] != null)
                {
                    m_grid_user_code = context.Request.Params["user_code"];
                }
                mObjDetial = GetRoleUserData(m_grid_role_code, m_grid_user_code, sort, order);
                mStrMsg = string.Format("\"total\":{0},\"rows\":", GetRoleUserCount(m_grid_role_code, m_grid_user_code));
                mStrReturn = "{" + mStrMsg + JsonConvert.SerializeObject(mObjDetial) + "}";
                break;
            default:
                mStrReturn = setReturnValue(false, "缺少必要参数", "缺少必要参数");
                break;
        }
        context.Response.Write(mStrReturn);
    }
    private int SetUserRole(string v_user_code, string v_role_set)
    {

        SqlParameter[] _Parameter = new SqlParameter[3]
            {
                new SqlParameter("@viVchUserCode",SqlDbType.VarChar,8000),
                new SqlParameter("@viVchRoleSet",SqlDbType.VarChar,8000),
                new SqlParameter("@voIntReturn",SqlDbType.Int),
            };
        _Parameter[0].Value = v_user_code;
        _Parameter[1].Value = v_role_set;
        _Parameter[2].Direction = System.Data.ParameterDirection.Output;
        claSqlConnDB.ExecuteNonQuery(claSqlConnDB.gStrConnDefault, CommandType.StoredProcedure, "p_user_role_set", _Parameter);
        int i = (int)_Parameter[2].Value;
        return i;
    }
    private int GetRoleUserCount(string v_role_code, string v_user_code)
    {

        string mStrSQL = @" select count(0) from t_role_user " + GetWhere(v_role_code, v_user_code);
        int i = claSqlConnDB.GetRecordCount(claSqlConnDB.gStrConnDefault, mStrSQL);
        return i;
    }
    private List<roleuser> GetRoleUserData(string v_role_code, string v_user_code, string v_grid_sort, string v_grid_order)
    {
        List<roleuser> mLstRoleUserGrid = new List<roleuser>();
        string lStrSQL = @"SELECT     t_role_user.role_code,t_role_user.user_code,t_User.user_name, t_User.auto_lock, t_User.user_state, 
                                      t_User.create_time AS create_time, t_User.lastlogin_time, t_User.login_num
                            FROM      t_role_user LEFT OUTER JOIN
                                      t_User ON t_role_user.user_code = t_User.user_code LEFT OUTER JOIN
                                      t_role ON t_role_user.role_code = t_role.role_code" + GetWhere(v_role_code, v_user_code)
                         + GetSort(v_grid_sort, v_grid_order);
        DataTable dt = null;
        using (dt = claSqlConnDB.ExecuteDataset(rows, page, claSqlConnDB.gStrConnDefault, CommandType.Text, lStrSQL).Tables[0])
        {
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                roleuser mUserRoleTmp = new roleuser();
                mUserRoleTmp.role_code = dt.Rows[i][0].ToString();
                mUserRoleTmp.user_code = dt.Rows[i][1].ToString();
                mUserRoleTmp.user_name = dt.Rows[i][2].ToString();
                mUserRoleTmp.auto_lock = dt.Rows[i][3].ToString();
                mUserRoleTmp.user_state = dt.Rows[i][4].ToString();
                mUserRoleTmp.user_create_time = dt.Rows[i][5].ToString();
                mUserRoleTmp.lastlogin_time = dt.Rows[i][6].ToString();
                mUserRoleTmp.login_num = dt.Rows[i][7].ToString();
                mLstRoleUserGrid.Add(mUserRoleTmp);
            }
        }
        return mLstRoleUserGrid;
    }


    private string GetWhere(string v_role_code, string v_user_code)
    {
        string mStrWhere = "";
        if (v_role_code != "")
        {
            if (mStrWhere != "")
            {
                mStrWhere = mStrWhere + " AND t_role_user.role_code ='" + v_role_code + "'";
            }
            else
            {
                mStrWhere = " WHERE t_role_user.role_code ='" + v_role_code + "'";
            }
        }
        if (v_user_code != "")
        {
            if (mStrWhere != "")
            {
                mStrWhere = mStrWhere + " AND t_role_user.user_code ='" + v_user_code + "'";
            }
            else
            {
                mStrWhere = " WHERE t_role_user.user_code ='" + v_user_code + "'";
            }
        }
        return mStrWhere;
    }
    private string GetSort(string v_grid_sort, string v_grid_order)
    {
        string mStrSort = "";
        if (v_grid_sort != "" && v_grid_sort != null)
        {
            mStrSort = " order by t_role_user." + v_grid_sort;
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