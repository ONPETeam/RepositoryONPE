<%@ WebHandler Language="C#" Class="fileDiretoryHandler" %>

using System;
using System.Web;
using System.Collections.Generic;
using ModelClass;
using Newtonsoft.Json;
using System.Data;
using NPE.UIDataClass;

public class fileDiretoryHandler : IHttpHandler {

    
    string fileclass_code = "";
    string diretory_parent = "";
    string filediretory_show_number = "";
    string filediretory_code = "";
    public void ProcessRequest (HttpContext context) {
        string action = "";
        context.Response.ContentType = "text/plain";
        if (context.Request.Params["filediretory_code"] != null)
        {
            filediretory_code = context.Request.Params["filediretory_code"];
        } 
        if (context.Request.Params["fileclass_code"] != null)
        {
            fileclass_code = context.Request.Params["fileclass_code"];
        }
        if (context.Request.Params["diretory_parent"] != null)
        {
            diretory_parent = context.Request.Params["diretory_parent"];
        }
        if (context.Request.Params["filediretory_show_number"]!=null)
        {
            filediretory_show_number=context.Request.Params["filediretory_show_number"];
        }
        if (context.Request.Params["action"] != null)
        {
            action = context.Request.Params["action"];
        }
        switch (action) { 
            case "tree":
                context.Response.Write(GetTreeJson());
                break;
            case "sort":
                context.Response.Write(SortFileDiretory(filediretory_code,filediretory_show_number));
                break;
            default:
                
                break;
        }
    }
    private int SortFileDiretory(string fileDiretoryCode,string filediretoryShowNumber)
    {
        int mIntReturn = 0;
        int mIntSortNum=0;
        if (int.TryParse(filediretoryShowNumber, out mIntSortNum) == false)
        {
            mIntReturn= -1;
        }
        else
        {
            string mStrSQL = @"update t_FileDiretory  set filediretory_show_number=" + filediretoryShowNumber+
                                " WHERE filediretory_code='"+fileDiretoryCode+ "'";
            mIntReturn = claSqlConnDB.ExecuteNonQuery(claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL);
        }
        return mIntReturn;
    }
    public string GetTreeJson()
    {
        return JsonConvert.SerializeObject(GetTree(fileclass_code, diretory_parent));
    }
    public List<TreeNode> GetTree(string fileclassCode, string diretoryParent)
    {
        List<TreeNode> listTree = new List<TreeNode>();
        DataTable dt = null;
        string mStrSQL = " select diretory_code,diretory_name,diretory_parent from t_Diretory where diretory_parent='" + diretoryParent + "' and fileclass_code='" + fileclassCode + "'";
        using (dt = claSqlConnDB.ExecuteDataset(claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL).Tables[0])
        {
            if (dt.Rows.Count > 0)
            {
                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    TreeNode treeTemp = new TreeNode();
                    treeTemp.id = dt.Rows[i][0].ToString();
                    treeTemp.text = dt.Rows[i][1].ToString();
                    //treeTemp.children = GetTree(dt.Rows[i][0].ToString());
                    if (GetDiretoryTreeNum(dt.Rows[i][0].ToString()) > 0 || GetFileNum(dt.Rows[i][0].ToString()) > 0)
                    {
                        treeTemp.state = "closed";
                    }
                    else
                    {
                        treeTemp.state = "open";
                    }
                    treeTemp.attributes = "diretory";
                    treeTemp.iconCls = "icon-diretory";
                    listTree.Add(treeTemp);
                }
            }
        }
        mStrSQL = @"select t_File.file_code,t_File.file_name from t_File right outer join t_FileDiretory 
                            on t_FileDiretory.file_code=t_File.file_code where t_FileDiretory.diretory_code ='" + diretoryParent
                            + "' and t_File.fileclass_code='" + fileclassCode + "' order by t_File.file_sort";
        using (dt = claSqlConnDB.ExecuteDataset(claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL).Tables[0])
        {
            if (dt.Rows.Count > 0)
            {
                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    TreeNode treeTemp = new TreeNode();
                    treeTemp.id = dt.Rows[i][0].ToString();
                    treeTemp.text = dt.Rows[i][1].ToString();
                    treeTemp.attributes = "file";
                    treeTemp.iconCls = "icon-file";
                    listTree.Add(treeTemp);
                }
            }
        }
        return listTree;
    }
    private int GetDiretoryTreeNum(string diretoryCode)
    {
        string mStrSQL = " select count(0) from t_Diretory where diretory_parent ='" + diretoryCode + "'";
        int i = claSqlConnDB.GetRecordCount(claSqlConnDB.gStrConnDefault, mStrSQL);
        return i;
    }
    private int GetFileNum(string diretoryCode)
    {
        string mStrSQL = " select count(0) from t_FileDiretory where diretory_code ='" + diretoryCode + "'";
        int i = claSqlConnDB.GetRecordCount(claSqlConnDB.gStrConnDefault, mStrSQL);
        return i;
    }
    public bool IsReusable {
        get {
            return false;
        }
    }

}