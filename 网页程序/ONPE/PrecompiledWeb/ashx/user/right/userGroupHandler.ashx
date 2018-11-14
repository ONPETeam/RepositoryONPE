<%@ WebHandler Language="C#" Class="userGroupHandler" %>

using System;
using System.Web;
using Newtonsoft.Json;
using NPE.UIDataClass;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Generic;
using ModelClass;
using System.Text;

public class userGroupHandler : IHttpHandler {

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
                string m_set_group_set = "";
                if (context.Request.Params["group_set"] != null)
                {
                    m_set_group_set = context.Request.Params["group_set"];
                }
                if (mIntParamNullable == 0)
                {
                    int mIntReturn = SetUserGroup(m_set_user_code, m_set_group_set);
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
                string m_grid_user_code = "";
                if (context.Request.Params["user_code"] != null)
                {
                    m_grid_user_code = context.Request.Params["user_code"];
                }
                string m_grid_group_code = "";
                if (context.Request.Params["group_code"] != null)
                {
                    m_grid_group_code = context.Request.Params["group_code"];
                }
                mObjDetial = GetUserGroupData(m_grid_user_code, m_grid_group_code, sort, order);
                mStrMsg = string.Format("\"total\":{0},\"rows\":", GetUserGroupCount(m_grid_user_code, m_grid_group_code));
                mStrReturn = "{" + mStrMsg + JsonConvert.SerializeObject(mObjDetial) + "}";
                break;
            default:
                mStrReturn = GJHF.Utility.WEBUI.EasyuiControl.GetMissParamReturn();
                break;
        }
        context.Response.Write(mStrReturn);
    }
    private int SetUserGroup(string v_user_code, string v_group_set)
    {
        
        SqlParameter[] _Parameter = new SqlParameter[3]
            {
                new SqlParameter("@viVchUserCode",SqlDbType.VarChar,8000),
                new SqlParameter("@viVchGroupSet",SqlDbType.VarChar,8000),
                new SqlParameter("@voIntReturn",SqlDbType.Int),
            };
        _Parameter[0].Value = v_user_code;
        _Parameter[1].Value = v_group_set;
        _Parameter[2].Direction = System.Data.ParameterDirection.Output;
        claSqlConnDB.ExecuteNonQuery(claSqlConnDB.gStrConnDefault, CommandType.StoredProcedure, "p_user_group_set", _Parameter);
        int i = (int)_Parameter[2].Value;
        return i;
    }

    
    private int GetUserGroupCount(string v_user_code, string v_group_code)
    {

        string mStrSQL = @" select count(0) from t_user_group " + GetWhere(v_user_code, v_group_code);
        int i = claSqlConnDB.GetRecordCount(claSqlConnDB.gStrConnDefault, mStrSQL);
        return i;
    }
    private List<userGroup> GetUserGroupData(string v_user_code, string v_group_code, string v_grid_sort, string v_grid_order)
    {
        List<userGroup> mLstUserGroupGrid = new List<userGroup>();
        string lStrSQL = @"SELECT     t_user_group.user_code, t_User.user_name, t_User.auto_lock, t_User.user_state, t_User.create_time, t_User.lastlogin_time, t_User.login_num, t_user_group.group_code
                            FROM      t_user_group LEFT OUTER JOIN
                                      t_group ON t_user_group.group_code = t_group.group_code LEFT OUTER JOIN
                                      t_User ON t_user_group.user_code = t_User.user_code" + GetWhere(v_user_code, v_group_code)
                         + GetSort(v_grid_sort, v_grid_order);
        DataTable dt = null;
        using (dt = claSqlConnDB.ExecuteDataset(rows, page, claSqlConnDB.gStrConnDefault, CommandType.Text, lStrSQL).Tables[0])
        {
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                userGroup mUserGroupTmp = new userGroup();
                mUserGroupTmp.user_code = dt.Rows[i][0].ToString();
                mUserGroupTmp.user_name = dt.Rows[i][1].ToString();
                mUserGroupTmp.auto_lock = int.Parse(dt.Rows[i][2].ToString() == "" ? "0" : dt.Rows[i][2].ToString());
                mUserGroupTmp.user_state = int.Parse(dt.Rows[i][3].ToString() == "" ? "0" : dt.Rows[i][3].ToString()); mUserGroupTmp.auto_lock = int.Parse(dt.Rows[i][2].ToString() == "" ? "0" : dt.Rows[i][2].ToString());
                mUserGroupTmp.user_state = int.Parse(dt.Rows[i][3].ToString() == "" ? "0" : dt.Rows[i][3].ToString());
                mUserGroupTmp.user_create_time = dt.Rows[i][4].ToString();
                mUserGroupTmp.lastlogin_time = dt.Rows[i][5].ToString();
                mUserGroupTmp.login_num = dt.Rows[i][6].ToString();
                mUserGroupTmp.group_code = dt.Rows[i][7].ToString();
                mLstUserGroupGrid.Add(mUserGroupTmp);
            }
        }
        return mLstUserGroupGrid;
    }


    private string GetWhere(string v_user_code, string v_group_code)
    {
        string mStrWhere = "";
        if (v_user_code != "")
        {
            if (mStrWhere != "")
            {
                mStrWhere = mStrWhere + " AND t_user_group.user_code ='" + v_user_code + "'";
            }
            else
            {
                mStrWhere = " WHERE t_user_group.user_code ='" + v_user_code + "'";
            }
        }
        if (v_group_code != "")
        {
            if (mStrWhere != "")
            {
                mStrWhere = mStrWhere + " AND t_user_group.group_code ='" + v_group_code + "'";
            }
            else
            {
                mStrWhere = " WHERE t_user_group.group_code ='" + v_group_code + "'";
            }
        }
        return mStrWhere;
    }
    private string GetSort(string v_grid_sort, string v_grid_order)
    {
        string mStrSort = "";
        if (v_grid_sort != "" && v_grid_sort != null)
        {
            mStrSort = " order by t_user_group." + v_grid_sort;
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