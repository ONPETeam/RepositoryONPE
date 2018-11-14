<%@ WebHandler Language="C#" Class="getGroupRightHandler" %>

using System;
using System.Web;
using Newtonsoft.Json;
using NPE.UIDataClass;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Generic;
using ModelClass;

public class getGroupRightHandler : IHttpHandler {

    public void ProcessRequest(HttpContext context)
    {
        context.Response.ContentType = "text/plain";
        string mStrReturn = "";
        if (context.Request.Params["group_code"] != null)
        {
            mStrReturn = JsonConvert.SerializeObject(GetGroupMenuGroupTree(context.Request.Params["group_code"])).Replace("ischecked", "checked");
        }
        else
        {
            mStrReturn = "";
        }
        context.Response.Write(mStrReturn);
    }
    private List<TreeNode> GetGroupMenuGroupTree(string v_group_code)
    {
        List<TreeNode> mLstTreeNode = new List<TreeNode>();
        string mStrSQL = @"SELECT     t_rights.right_code, t_rights.right_name, case when not t_groupright.group_code is NULL then 1 else 0 end  
                            FROM        t_rights  Left OUTER JOIN
                                                 t_groupright  ON (t_groupright.right_code = t_rights.right_code
                             and t_groupright.group_code='" + v_group_code + "')";
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