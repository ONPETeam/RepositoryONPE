<%@ WebHandler Language="C#" Class="getAreaComtree" %>

using System;
using System.Web;
using Newtonsoft.Json;
using NPE.UIDataClass;
using System.Data;
using System.Collections.Generic;

public class getAreaComtree : IHttpHandler {
    List<combotree> treeList = new List<combotree>();
    public void ProcessRequest (HttpContext context) {
        context.Response.ContentType = "text/plain";

        context.Response.Write(JsonConvert.SerializeObject(GetArea()));
    }

    public List<combotree> GetArea()
    {
        List<combotree> treeList = new List<combotree>();
        DataTable dt = null;
        string lStrSQL = "select area_id,area_name from t_EquipArea where area_parent <=0";
        using (dt = claSqlConnDB.ExecuteDataset(claSqlConnDB.gStrConnDefault, System.Data.CommandType.Text, lStrSQL).Tables[0])
        {
            if (dt.Rows.Count > 0)
            {
                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    combotree treeNodetmp = new combotree();
                    treeNodetmp.id = dt.Rows[i][0].ToString();
                    treeNodetmp.text = dt.Rows[i][1].ToString();
                    treeNodetmp.children = GetAreaChild(Int32.Parse(dt.Rows[i][0].ToString()));
                    treeList.Add(treeNodetmp);
                }
            }
        }
        return treeList;
    }

    public List<combotree> GetAreaChild(int AreaID)
    {
        List<combotree> treeListNode1 = new List<combotree>();
        DataTable dt = null;
        string lStrSQL = "select area_id,area_name from t_EquipArea where area_parent >0 and area_parent = " + AreaID.ToString() + "";
        using (dt = claSqlConnDB.ExecuteDataset(claSqlConnDB.gStrConnDefault, System.Data.CommandType.Text, lStrSQL).Tables[0])
        {
            if (dt.Rows.Count > 0)
            {
                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    combotree treeNodetmp = new combotree();
                    treeNodetmp.id = dt.Rows[i][0].ToString();
                    treeNodetmp.text = dt.Rows[i][1].ToString();
                    treeNodetmp.children = GetAreaChild(Int32.Parse(dt.Rows[i][0].ToString()));
                    treeListNode1.Add(treeNodetmp);
                }
            }
        }
        return treeListNode1;
    }
    
    public bool IsReusable {
        get {
            return false;
        }
    }

}