<%@ WebHandler Language="C#" Class="getUserRoleTreeHandler" %>

using System;
using System.Web;
using Newtonsoft.Json;
using NPE.UIDataClass;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Generic;
using ModelClass;

public class getUserRoleTreeHandler : IHttpHandler {

    public void ProcessRequest(HttpContext context)
    {
        context.Response.ContentType = "text/plain";
        string mStrReturn = "";
        if (context.Request.Params["user_code"] != null)
        {
            mStrReturn = JsonConvert.SerializeObject(GetUserRoleTree(context.Request.Params["user_code"])).Replace("ischecked", "checked");
        }
        else
        {
            mStrReturn = "";
        }
        context.Response.Write(mStrReturn);
    }
    private List<TreeNode> GetUserRoleTree(string v_user_code)
    {
        List<TreeNode> mLstTreeNode = new List<TreeNode>();
        string mStrSQL = @"SELECT     t_role.role_code, t_role.role_name, case when not t_role_user.user_code is NULL then 1 else 0 end  
                            FROM        t_role  Left OUTER JOIN
                                                 t_role_user  ON (t_role_user.role_code = t_role.role_code
                             and t_role_user.user_code='" + v_user_code + "')";
        DataTable dt = null;
        using (dt = claSqlConnDB.ExecuteDataset(claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL).Tables[0])
        {
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                TreeNode mTreeNode = new TreeNode();
                mTreeNode.id = dt.Rows[i][0].ToString();
                mTreeNode.text = dt.Rows[i][1].ToString();
                mTreeNode.state = "open";
                mTreeNode.ischecked = dt.Rows[i][2].ToString() == "1" ? true : false;
                mTreeNode.attributes = dt.Rows[i][0].ToString();
                mLstTreeNode.Add(mTreeNode);
            }
        }
        return mLstTreeNode;
    }

    public bool IsReusable
    {
        get
        {
            return false;
        }
    }

}