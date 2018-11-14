<%@ WebHandler Language="C#" Class="getUnitComTree" %>

using System;
using System.Web;
using Newtonsoft.Json;
using NPE.UIDataClass;
using System.Data;
using System.Collections.Generic;

public class getUnitComTree : IHttpHandler
{
    List<combotree> treeList = new List<combotree>();
    public void ProcessRequest (HttpContext context) {
        context.Response.ContentType = "text/plain";

        context.Response.Write(JsonConvert.SerializeObject(GetUnit()));     
    }

    public List<combotree> GetUnit()
    {
        DataTable dt = null;
        string lStrSQL = "select dIntCompanyID,dVchCompanyName from tHRCompany";
        using (dt = claSqlConnDB.ExecuteDataset(claSqlConnDB.gStrConnDefault, System.Data.CommandType.Text, lStrSQL).Tables[0])
        {
            if (dt.Rows.Count > 0)
            {
                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    combotree treeNodetmp = new combotree();
                    treeNodetmp.id = dt.Rows[i][0].ToString() + ",unit";
                    treeNodetmp.text = dt.Rows[i][1].ToString();
                    treeNodetmp.attributes = "unit";
                    treeNodetmp.children = GetUnitChild(Int32.Parse(dt.Rows[i][0].ToString()));
                    treeList.Add(treeNodetmp);
                }
            }
        }
        return treeList;
    }

    public List<combotree> GetUnitChild(int CompanyID)
    {
        List<combotree> treeListNode1 = new List<combotree>();
        DataTable dt = null;
        string lStrSQL = "select dIntBranchID,dVchBranchName from tHRBranchInfo where dIntCompanyID=" + CompanyID.ToString() + " and dIntUpBranch <=0";
        using (dt = claSqlConnDB.ExecuteDataset(claSqlConnDB.gStrConnDefault, System.Data.CommandType.Text, lStrSQL).Tables[0])
        {
            if (dt.Rows.Count > 0)
            {
                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    combotree treeNodetmp = new combotree();
                    treeNodetmp.id = dt.Rows[i][0].ToString() + ",dep";
                    treeNodetmp.text = dt.Rows[i][1].ToString();
                    treeNodetmp.attributes = "dep";
                    treeNodetmp.children = GetUnitChildNode(Int32.Parse(dt.Rows[i][0].ToString()));
                    treeListNode1.Add(treeNodetmp);
                }
            }
        }
        return treeListNode1;
    }
    
    public List<combotree> GetUnitChildNode(int BranchID)
    {
        List<combotree> treeListNode2 = new List<combotree>();
        DataTable dt = null;
        string lStrSQL = "select dIntBranchID,dVchBranchName from tHRBranchInfo where dIntUpBranch=" + BranchID.ToString();
        using (dt = claSqlConnDB.ExecuteDataset(claSqlConnDB.gStrConnDefault, System.Data.CommandType.Text, lStrSQL).Tables[0])
        {
            if (dt.Rows.Count > 0)
            {
                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    combotree treeNodetmp = new combotree();
                    treeNodetmp.id = dt.Rows[i][0].ToString() + ",dep";
                    treeNodetmp.text = dt.Rows[i][1].ToString();
                    treeNodetmp.attributes = "dep";
                    treeNodetmp.children = GetUnitChildNode(Int32.Parse(dt.Rows[i][0].ToString()));
                    treeListNode2.Add(treeNodetmp);

                }
            }
        }
        return treeListNode2;
    }

    public bool IsReusable
    {
        get
        {
            return false;
        }
    }
}