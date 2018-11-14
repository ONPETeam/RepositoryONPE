<%@ WebHandler Language="C#" Class="getUserGroupTreeHandler" %>

using System;
using System.Web;
using Newtonsoft.Json;
using NPE.UIDataClass;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Generic;
using ModelClass;

public class getUserGroupTreeHandler : IHttpHandler {

    public void ProcessRequest(HttpContext context)
    {
        context.Response.ContentType = "text/plain";
        string mStrReturn = "";
        if (context.Request.Params["user_code"] != null)
        {
            mStrReturn = JsonConvert.SerializeObject(GetUserGroupTree(context.Request.Params["user_code"])).Replace("ischecked", "checked");
        }
        else
        {
            mStrReturn = "";
        }
        context.Response.Write(mStrReturn);
    }
    private List<TreeNode> GetUserGroupTree(string v_user_code)
    {
        List<TreeNode> mLstTreeNode = new List<TreeNode>();
        string mStrSQL = @"SELECT     t_group.group_code, t_group.group_name, case when not t_user_group.user_code is NULL then 1 else 0 end  
                            FROM        t_group  Left OUTER JOIN
                                                 t_user_group  ON (t_user_group.group_code = t_group.group_code
                             and t_user_group.user_code='" + v_user_code + @"')
                             where t_group.group_type=2";
        //SqlParameter[] parameters = {
        //    new SqlParameter("@role_code", SqlDbType.VarChar,30) 
        //    };

        //parameters[0].Value = v_role_code;
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