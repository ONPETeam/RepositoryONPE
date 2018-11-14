<%@ WebHandler Language="C#" Class="djbzHandler" %>

using System;
using System.Web;
using System.Collections.Generic;
using ModelClass;
using System.Data.SqlClient;
using System.Data;
using Newtonsoft.Json;

public class djbzHandler : IHttpHandler {
    string type = "";
    string line = "";

    string nodeId = ""; string lindId = ""; string nodeIndex = "";
    string nodesearch = "";
    string contentID = "-1";
    string contentName = "";
    List<ActionLine> lst = new List<ActionLine>();
    List<ActionNode> lst1 = new List<ActionNode>();

    
    public void ProcessRequest (HttpContext context) {
        context.Response.ContentType = "text/plain";
        type = context.Request.Params["type"];
        line = context.Request.Params["line"];
        nodeId = context.Request.Params["nodeId"];
        lindId = context.Request.Params["lindId"] == null ? "-1" : context.Request.Params["lindId"];
        nodeIndex = context.Request.Params["nodeIndex"];
        nodesearch = context.Request.Params["nodesearch"];
        contentID = context.Request.Params["contentID"];
        contentName = context.Request.Params["contentName"];
        
        string deleted = context.Request.Form["deleted"];
        string inserted = context.Request.Form["inserted"];
        string updated = context.Request.Form["updated"];
        
        switch (type)
        {
            case "DelContentNode":
                context.Response.Write(DelContentNodeData());
                break;
            case "ShowContentNode":
                context.Response.Write(GetNodeByContent());
                break;
            case "contentNode":
                context.Response.Write(SetContentNodeData());
                break;
            case "searchNode":
                context.Response.Write(showData1ByCondition());
                break;
            case "SetNode":
                context.Response.Write(SetNodeData());
                break;
            case "lineNode":
                context.Response.Write(GetLineNode());
                break;
            case "show":
                context.Response.Write(showData());
                break;
            case "showddl":
                context.Response.Write(showddlData());
                break;
            case "show1":
                context.Response.Write(showData1());
                break;  
            case "saveLine":
                if (deleted != null)
                {
                    lst = common.JsonDeserialize<List<ActionLine>>(deleted);
                    context.Response.Write(DeleteLineData(lst));
                }
                if (inserted != null)
                {
                    lst = common.JsonDeserialize<List<ActionLine>>(inserted);
                    context.Response.Write(AddLineData(lst));
                }
                if (updated != null)
                {
                    lst = common.JsonDeserialize<List<ActionLine>>(updated);
                    context.Response.Write(UpdateLineData(lst));
                }
                break;
            case "saveNode":
                if (deleted != null)
                {
                    lst1 = common.JsonDeserialize<List<ActionNode>>(deleted);
                    context.Response.Write(DeleteNodeData(lst1));
                }
                if (inserted != null)
                {
                    lst1 = common.JsonDeserialize<List<ActionNode>>(inserted);
                    context.Response.Write(AddNodeData(lst1));
                }
                if (updated != null)
                {
                    lst1 = common.JsonDeserialize<List<ActionNode>>(updated);
                    context.Response.Write(UpdateNodeData(lst1));
                }
                break;
            default:
                break;
        }
        
        
        
        
        
        
        
        
        //context.Response.Write("Hello World");
    }
    private string DelContentNodeData()
    {
        try
        {
            int lIntReturn = -1;
            SqlParameter[] _Parameter = new SqlParameter[3]
            {
                new SqlParameter("@viIntNodeNote",SqlDbType.Int,4),
                new SqlParameter("@viIntContentNote",SqlDbType.Int,4),
                new SqlParameter("@voIntReturn",SqlDbType.Int),
            };
            _Parameter[0].Value = Int32.Parse(nodeId);
            _Parameter[1].Value = Int32.Parse(contentID);
            _Parameter[2].Direction = System.Data.ParameterDirection.Output;
            claSqlConnDB.ExecuteNonQuery(claSqlConnDB.gStrConnDefault, CommandType.StoredProcedure, "pTCActionContentLineDel", _Parameter);
            lIntReturn = (int)_Parameter[2].Value;
            if (lIntReturn == 0)
            {
                return "ok";
            }
            else
            {
                return "error";
            }
        }
        catch (Exception e)
        {
            return "error";
        }
    }
    private string SetContentNodeData()
    {
        try
        {
            int lIntReturn = -1;
            SqlParameter[] _Parameter = new SqlParameter[4]
            {
                new SqlParameter("@viIntNodeNote",SqlDbType.Int,4),
                new SqlParameter("@viIntContentNote",SqlDbType.Int,4),
                new SqlParameter("@viVchContentName",SqlDbType.VarChar,50),
                new SqlParameter("@voIntReturn",SqlDbType.Int),
            };
            _Parameter[0].Value = Int32.Parse(nodeId);
            _Parameter[1].Value = Int32.Parse(contentID);
            _Parameter[2].Value = contentName;
            _Parameter[3].Direction = System.Data.ParameterDirection.Output;
            claSqlConnDB.ExecuteNonQuery(claSqlConnDB.gStrConnDefault, CommandType.StoredProcedure, "pTCActionContentLineAdd", _Parameter);
            lIntReturn = (int)_Parameter[3].Value;
            if (lIntReturn == 0)
            {
                return "ok";
            }
            else
            {
                return "error";
            }
        }
        catch (Exception e)
        {
            return "error";
        }

    }
    /// <summary>
    /// 通过检查内容，查看该检查内容的节点
    /// </summary>
    /// <returns></returns>
    private string GetNodeByContent()
    {
        if(contentID=="")
        {
            contentID = "-1";
        }
        string returnstr = "";
        string strSQL = @"SELECT dVchContentName,dVchLine,dVchNode,t_TCActionNode.dIntNodeNote,t_TCActionContentLine.dIntContentNote
                FROM t_TCActionContentLine
                INNER JOIN t_TCActionNode ON t_TCActionNode.dIntNodeNote = t_TCActionContentLine.dIntNodeNote
                LEFT JOIN t_TCActionLineNode ON t_TCActionLineNode.dIntNodeNote = t_TCActionNode.dIntNodeNote
                INNER JOIN t_TCActionLine ON t_TCActionLine.dIntLineNote = t_TCActionLineNode.dIntLineNote
                WHERE t_TCActionContentLine.dIntContentNote = "+ contentID  +"";
        List<ContentNode> Grid = new List<ContentNode>();
        System.Data.DataTable dt = null;
        using (dt = claSqlConnDB.ExecuteDataset(claSqlConnDB.gStrConnDefault, System.Data.CommandType.Text, strSQL).Tables[0])
        {
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                ContentNode tmp = new ContentNode();
                tmp.dVchContentName = dt.Rows[i][0].ToString();
                tmp.dVchLine = dt.Rows[i][1].ToString();
                tmp.dVchNode = dt.Rows[i][2].ToString();
                tmp.dIntNodeNote = Int32.Parse(dt.Rows[i][3].ToString());
                tmp.dIntContentNote = Int32.Parse(dt.Rows[i][4].ToString());
                Grid.Add(tmp);
            }
        }
        return returnstr = JsonConvert.SerializeObject(Grid);
    }
    private string GetLineNode()
    {
        string returnstr = "";
        string strSQL = @"SELECT t_TCActionLine.dVchLine,t_TCActionNode.dVchNode,t_TCActionLineNode.dIntNodeIndex FROM t_TCActionLineNode
                    LEFT JOIN t_TCActionLine ON t_TCActionLine.dIntLineNote = t_TCActionLineNode.dIntLineNote
                    LEFT JOIN t_TCActionNode ON t_TCActionNode.dIntNodeNote = t_TCActionLineNode.dIntNodeNote
                    WHERE t_TCActionLineNode.dIntLineNote = " + lindId + " ORDER BY t_TCActionLineNode.dIntNodeIndex ASC";
        List<LineNode> Grid = new List<LineNode>();
        System.Data.DataTable dt = null;
        using (dt = claSqlConnDB.ExecuteDataset(claSqlConnDB.gStrConnDefault, System.Data.CommandType.Text, strSQL).Tables[0])
        {
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                LineNode tmp = new LineNode();
                tmp.dVchLine = dt.Rows[i][0].ToString();
                tmp.dVchNode = dt.Rows[i][1].ToString();
                tmp.dIntNodeIndex = Int32.Parse(dt.Rows[i][2].ToString());
                Grid.Add(tmp);
            }
        }
        return returnstr = JsonConvert.SerializeObject(Grid);
    }
    private string SetNodeData()
    {
        try
        {
            int lIntReturn = -1;
            SqlParameter[] _Parameter = new SqlParameter[4]
            {
                new SqlParameter("@viIntNodeNote",SqlDbType.Int,4),
                new SqlParameter("@viIntLineNote",SqlDbType.Int,4),
                new SqlParameter("@viIntNodeIndex",SqlDbType.Int,4),
                new SqlParameter("@voIntReturn",SqlDbType.Int),
            };
            _Parameter[0].Value = Int32.Parse(nodeId);
            _Parameter[1].Value = Int32.Parse(lindId);
            _Parameter[2].Value = Int32.Parse(nodeIndex);
            _Parameter[3].Direction = System.Data.ParameterDirection.Output;
            claSqlConnDB.ExecuteNonQuery(claSqlConnDB.gStrConnDefault, CommandType.StoredProcedure, "pTCActionLineNodeAdd", _Parameter);
            lIntReturn = (int)_Parameter[3].Value;
            if (lIntReturn == 0)
            {
                return "ok";
            }
            else
            {
                return "error";
            }
        }
        catch(Exception e)
        {
            return "error";
        }

    }
    private string showData1ByCondition()
    {
        string returnStr = "";
        List<ActionNode> Grid = new List<ActionNode>();

        string lStrSQL = @"SELECT dIntNodeNote,dVchNode from t_TCActionNode where dVchNode like '%" + nodesearch + "%' order by dIntNodeNote asc";
        System.Data.DataTable dt = null;
        using (dt = claSqlConnDB.ExecuteDataset(claSqlConnDB.gStrConnDefault, System.Data.CommandType.Text, lStrSQL).Tables[0])
        {
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                ActionNode tmp = new ActionNode();
                tmp.dIntNodeNote = Int32.Parse(dt.Rows[i][0].ToString());
                tmp.dVchNode = dt.Rows[i][1].ToString();

                Grid.Add(tmp);
            }
        }
        return returnStr = JsonConvert.SerializeObject(Grid);
    }
    private string showData1()
    {
        string returnStr = "";
        List<ActionNode> Grid = new List<ActionNode>();

        string lStrSQL = @"SELECT dIntNodeNote,dVchNode from t_TCActionNode order by dIntNodeNote asc";
        System.Data.DataTable dt = null;
        using (dt = claSqlConnDB.ExecuteDataset(claSqlConnDB.gStrConnDefault, System.Data.CommandType.Text, lStrSQL).Tables[0])
        {
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                ActionNode tmp = new ActionNode();
                tmp.dIntNodeNote = Int32.Parse(dt.Rows[i][0].ToString());
                tmp.dVchNode = dt.Rows[i][1].ToString();

                Grid.Add(tmp);
            }
        }
        return returnStr = JsonConvert.SerializeObject(Grid);
    }
    private string showddlData()
    {
        string returnStr = "";
        List<ActionLine> Grid = new List<ActionLine>();

        string lStrSQL = @"SELECT dIntLineNote,dVchLine from t_TCActionLine order by dIntLineNote asc";
        System.Data.DataTable dt = null;
        using (dt = claSqlConnDB.ExecuteDataset(claSqlConnDB.gStrConnDefault, System.Data.CommandType.Text, lStrSQL).Tables[0])
        {
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                ActionLine tmp = new ActionLine();
                tmp.dIntLineNote = Int32.Parse(dt.Rows[i][0].ToString());
                tmp.dVchLine = dt.Rows[i][1].ToString();

                Grid.Add(tmp);
            }
        }
        return returnStr = JsonConvert.SerializeObject(Grid);
    }
    private string showData()
    {
        string returnStr = "";
        List<ActionLine> Grid = new List<ActionLine>();

        string lStrSQL = @"SELECT dIntLineNote,dVchLine from t_TCActionLine order by dIntLineNote asc";
        System.Data.DataTable dt = null;
        using (dt = claSqlConnDB.ExecuteDataset(claSqlConnDB.gStrConnDefault, System.Data.CommandType.Text, lStrSQL).Tables[0])
        {
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                ActionLine tmp = new ActionLine();
                tmp.dIntLineNote = Int32.Parse(dt.Rows[i][0].ToString());
                tmp.dVchLine = dt.Rows[i][1].ToString();

                Grid.Add(tmp);
            }
        }
        return returnStr = JsonConvert.SerializeObject(Grid);
    }
    private string UpdateNodeData(List<ActionNode> Item)
    {
        string lStrSQL = "";
        int k = 0;

        lStrSQL = @"update t_TCActionNode set dVchNode = '" + Item[0].dVchNode + "' where dIntNodeNote = " + Item[0].dIntNodeNote + "";
        k = claSqlConnDB.ExecuteNonQuery(claSqlConnDB.gStrConnDefault, CommandType.Text, lStrSQL);
        if (k > 0)
        {
            return "ok";
        }
        else
        {
            return "error";
        }
    }
    private string UpdateLineData(List<ActionLine> Item)
    {
        string lStrSQL = "";
        int k = 0;

        lStrSQL = @"update t_TCActionLine set dVchLine = '" + Item[0].dVchLine + "' where dIntLineNote = " + Item[0].dIntLineNote + "";
        k = claSqlConnDB.ExecuteNonQuery(claSqlConnDB.gStrConnDefault, CommandType.Text, lStrSQL);
        if (k > 0)
        {
            return "ok";
        }
        else
        {
            return "error";
        }
    }
    private string DeleteNodeData(List<ActionNode> Item)
    {
        string lStrSQL = "";
        int k = 0;

        lStrSQL = @"Delete from t_TCActionNode where dIntNodeNote = " + Item[0].dIntNodeNote + "";
        k = claSqlConnDB.ExecuteNonQuery(claSqlConnDB.gStrConnDefault, CommandType.Text, lStrSQL);
        if (k > 0)
        {
            return "ok";
        }
        else
        {
            return "error";
        }
    }
    private string DeleteLineData(List<ActionLine> Item)
    {
        string lStrSQL = "";
        int k = 0;

        lStrSQL = @"Delete from t_TCActionLine where dIntLineNote = " + Item[0].dIntLineNote + "";
        k = claSqlConnDB.ExecuteNonQuery(claSqlConnDB.gStrConnDefault, CommandType.Text, lStrSQL);
        if (k > 0)
        {
            return "ok";
        }
        else
        {
            return "error";
        }
    }
    private string AddNodeData(List<ActionNode> Item)
    {
        int lIntReturn = -1;
        SqlParameter[] _Parameter = new SqlParameter[2]
            {
                new SqlParameter("@viVchNode",SqlDbType.VarChar,50),
                new SqlParameter("@voIntReturn",SqlDbType.Int),
            };
        _Parameter[0].Value = Item[0].dVchNode;
        _Parameter[1].Direction = System.Data.ParameterDirection.Output;
        claSqlConnDB.ExecuteNonQuery(claSqlConnDB.gStrConnDefault, CommandType.StoredProcedure, "pTCActionNodeAdd", _Parameter);
        lIntReturn = (int)_Parameter[1].Value;
        if (lIntReturn == 0)
        {
            return "ok";
        }
        else
        {
            return "error";
        }
    }
    private string AddLineData(List<ActionLine> Item)
    {
        int lIntReturn = -1;
        SqlParameter[] _Parameter = new SqlParameter[2]
            {
                new SqlParameter("@viVchLine",SqlDbType.VarChar,50),
                new SqlParameter("@voIntReturn",SqlDbType.Int),
            };
        _Parameter[0].Value = Item[0].dVchLine;
        _Parameter[1].Direction = System.Data.ParameterDirection.Output;
        claSqlConnDB.ExecuteNonQuery(claSqlConnDB.gStrConnDefault, CommandType.StoredProcedure, "pTCActionLineAdd", _Parameter);
        lIntReturn = (int)_Parameter[1].Value;
        if (lIntReturn == 0)
        {
            return "ok";
        }
        else
        {
            return "error";
        }
    }
    
    public bool IsReusable {
        get {
            return false;
        }
    }

}