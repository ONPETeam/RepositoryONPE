<%@ WebHandler Language="C#" Class="getBranchComTree" %>

using System;
using System.Web;
using System.Collections.Generic;
using NPE.UIDataClass;
using Newtonsoft.Json;
using System.Data;

public class getBranchComTree : IHttpHandler {
    
    public void ProcessRequest (HttpContext context) {
        
        context.Response.ContentType = "text/plain";
        string nodeID = context.Request.Params["nodeID"];
        string type = context.Request.Params["type"];
        switch (type)
        {
            case "1":
                context.Response.Write(JsonConvert.SerializeObject(GetTopBranch(nodeID)));
                break; 
            case "2":
                context.Response.Write(JsonConvert.SerializeObject(GetDownBranch(nodeID)));
                break;
            default:
                context.Response.Write(JsonConvert.SerializeObject(GetErrBranch()));
                break;
        }
        
    }
    public List<combotree> GetErrBranch()
    {
        List<combotree> treelist = new List<combotree>();
        combotree treeNode = new combotree();
        treeNode.id = "err";
        treeNode.text = "参数错误！";
        treelist.Add(treeNode);
        return treelist;
    }

    public List<combotree> GetTopBranch(string vStrCompanyID) {
        List<combotree> treelist = new List<combotree>();
        DataTable dt = null;
        string mStrSql = "select dIntBranchID,dVchBranchName from tHRBranchInfo where dIntUpBranch=0 and dIntCompanyID= " + vStrCompanyID;
        using (dt = claSqlConnDB.ExecuteDataset(claSqlConnDB.gStrConnDefault, System.Data.CommandType.Text, mStrSql).Tables[0])
        {
            if (dt.Rows.Count > 0)
            {
                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    combotree treeNode = new combotree();
                    treeNode.id = dt.Rows[i][0].ToString();
                    treeNode.text = dt.Rows[i][1].ToString();
                    treeNode.children = GetDownBranch(dt.Rows[i][0].ToString());
                    treelist.Add(treeNode); 
                } 
            } 
        }
            
        return treelist;
    }
    public List<combotree> GetDownBranch(string vStrUpBranchID)
    {
        List<combotree> treelist = new List<combotree>();
        DataTable dt = null;
        string mStrSql = "select dIntBranchID,dVchBranchName from tHRBranchInfo where dIntUpBranch=" + vStrUpBranchID;
        using (dt = claSqlConnDB.ExecuteDataset(claSqlConnDB.gStrConnDefault, System.Data.CommandType.Text, mStrSql).Tables[0])
        {
            if (dt.Rows.Count > 0)
            {
                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    combotree treeNode = new combotree();
                    treeNode.id = dt.Rows[i][0].ToString();
                    treeNode.text = dt.Rows[i][1].ToString();
                    treeNode.children = GetDownBranch(dt.Rows[i][0].ToString());
                    treelist.Add(treeNode);
                }
            }
        }
        return treelist;
    }
    
    public bool IsReusable {
        get {
            return false;
        }
    }

}