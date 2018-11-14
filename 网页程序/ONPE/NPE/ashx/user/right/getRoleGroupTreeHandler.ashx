<%@ WebHandler Language="C#" Class="getRoleGroupTreeHandler" %>

using System;
using System.Web;
using Newtonsoft.Json;
using NPE.UIDataClass;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Generic;
using ModelClass;

public class getRoleGroupTreeHandler : IHttpHandler {
    
    public void ProcessRequest (HttpContext context) {
        context.Response.ContentType = "text/plain";
        string mStrReturn="";
        if (context.Request.Params["role_code"] != null)
        {
            mStrReturn = JsonConvert.SerializeObject(GetRoleGroupTree(context.Request.Params["role_code"])).Replace("ischecked","checked");
        }
        else
        {
            mStrReturn = ""; 
        }
        context.Response.Write(mStrReturn);
    }
    private List<TreeNode> GetRoleGroupTree(string v_role_code)
    {
        List<TreeNode> mLstTreeNode = new List<TreeNode>();
        string mStrSQL = @"SELECT     t_group.group_code, t_group.group_name, case when not t_role_group.role_code is NULL then 1 else 0 end  
                            FROM        t_group  Left OUTER JOIN
                                                 t_role_group  ON (t_role_group.group_code = t_group.group_code
                             and t_role_group.role_code='" + v_role_code + @"')
                             where t_group.group_type=1";
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
    
    public bool IsReusable {
        get {
            return false;
        }
    }

}