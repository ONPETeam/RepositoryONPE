<%@ WebHandler Language="C#" Class="diretoryHandler" %>

using System;
using System.Web;
using System.Collections.Generic;
using ModelClass;
using Newtonsoft.Json;
using System.Data;
using NPE.UIDataClass;
using System.Text;

public class diretoryHandler : IHttpHandler
{
    string diretory_code = "";
    string diretory_name = "";
    string diretory_innum = "";
    string diretory_create_time = "";
    string diretory_create_people = "";
    string diretory_visible = "";
    string fileclass_code = "";
    string diretory_parent = "";
    string diretory_remark = "";
    string diretory_general = "";
    string diretory_selectable = "";
    string diretory_sort = "";

    int intRows = 0;
    int intPage = 0;

    string sort = "";
    string order = "";

    string action = "";

    public void ProcessRequest(HttpContext context)
    {
        context.Response.ContentType = "text/plain";
        if (context.Request.Params["diretory_code"] != null)
        {
            diretory_code = context.Request.Params["diretory_code"];
        }
        if (context.Request.Params["diretory_name"] != null)
        {
            diretory_name = context.Request.Params["diretory_name"];
        }
        if (context.Request.Params["diretory_innum"] != null)
        {
            diretory_innum = context.Request.Params["diretory_innum"];
        }
        if (context.Request.Params["diretory_create_time"] != null)
        {
            diretory_create_time = context.Request.Params["diretory_create_time"];
        }
        if (context.Request.Params["diretory_create_people"] != null)
        {
            diretory_create_people = context.Request.Params["diretory_create_people"];
        }
        if (context.Request.Params["diretory_visible"] != null)
        {
            diretory_visible = context.Request.Params["diretory_visible"];
        }
        if (context.Request.Params["fileclass_code"] != null)
        {
            fileclass_code = context.Request.Params["fileclass_code"];
        }
        if (context.Request.Params["diretory_parent"] != null)
        {
            diretory_parent = context.Request.Params["diretory_parent"];
        }
        if (context.Request.Params["diretory_remark"] != null)
        {
            diretory_remark = context.Request.Params["diretory_remark"];
        }
        if (context.Request.Params["diretory_general"] != null)
        {
            diretory_general = context.Request.Params["diretory_general"];
        }
        if (context.Request.Params["diretory_selectable"] != null)
        {
            diretory_selectable = context.Request.Params["diretory_selectable"];
        }
        if (context.Request.Params["diretory_sort"] != null)
        {
            diretory_sort = context.Request.Params["diretory_sort"];
        }
        if (context.Request.Params["sort"] != null)
        {
            sort = context.Request.Params["sort"];
        }
        if (context.Request.Params["order"] != null)
        {
            order = context.Request.Params["order"];
        }
        if (context.Request.Params["rows"] != null)
        {
            intRows = int.Parse(context.Request.Params["rows"]);
        }
        if (context.Request.Params["page"] != null)
        {
            intPage = int.Parse(context.Request.Params["page"]);
        }
        if (context.Request.Params["action"] != null)
        {
            action = context.Request.Params["action"];
        }
        switch (action)
        {
            case "grid":
                System.Text.StringBuilder sb = new System.Text.StringBuilder();
                sb.Append("{ ");
                sb.Append(string.Format("\"total\":{0},\"rows\":", GetDiretoryPageCount()));
                string s = GetDataGrid();
                sb.Append(s);
                sb.Append("}");
                context.Response.Write(sb.ToString());
                
                break;
            case "add":
                context.Response.Write(AddDiretory());
                break;
            case "edit":
                context.Response.Write(EditDiretory());
                break;
            case "del":
                context.Response.Write(DelDiretory());
                break;
            case "tree":
                context.Response.Write(GetTreeJson());
                break;
            case "combo":
                context.Response.Write(GetComboTreeJson());
                break;
            case "prop":
                context.Response.Write(GetProperty());
                break;
            case "sort":
                context.Response.Write(SortDiretory(diretory_code, diretory_sort).ToString());
                break;
            default:
                break;
        }
    }
    private int SortDiretory(string diretoryCode, string diretorySort)
    {
        int mIntReturn = 0;
        int mIntSortNum = 0;
        if ((int.TryParse(diretorySort, out mIntSortNum) == false)||diretoryCode=="")
        {
            mIntReturn = -1;
        }
        else
        {
            string mStrSQL = @"update t_Diretory  set diretory_sort=" + diretorySort +
                                " WHERE diretory_code='" + diretoryCode + "'";
            mIntReturn = claSqlConnDB.ExecuteNonQuery(claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL);
        }
        return mIntReturn;
    }
    private string GetDiretoryPageCount() 
    {
        string mStrSQL = @" select count(0) from t_Diretory " + GetDataWhere();
        int i = claSqlConnDB.GetRecordCount(claSqlConnDB.gStrConnDefault, mStrSQL);
        return i.ToString(); 
    }
    public string GetProperty()
    {
        string mStrReturn = "";
        PropertyGrid property = new PropertyGrid();
        List<PropertyGridNode> propList = new List<PropertyGridNode>();
        DataTable dt = null;
        if (diretory_code != "")
        {
            string mStrSQL = @"SELECT     t_Diretory.diretory_code AS 目录编号, t_Diretory.diretory_name AS 目录名称, t_Diretory.diretory_innum AS 自编码, t_Diretory_1.diretory_name AS 上级目录,
                                t_Diretory.diretory_sort as 显示排序
                                FROM         t_Diretory LEFT OUTER JOIN
                                                      t_Diretory AS t_Diretory_1 ON t_Diretory.diretory_parent = t_Diretory_1.diretory_code
                                WHERE     t_Diretory.diretory_code = '" + diretory_code + "'";
            using (dt = claSqlConnDB.ExecuteDataset(claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL).Tables[0])
            {
                if (dt.Rows.Count > 0)
                {
                    property.total = dt.Columns.Count;
                    for (int i = 0; i < dt.Columns.Count; i++)
                    {
                        PropertyGridNode propertyNodeTemp = new PropertyGridNode();
                        propertyNodeTemp.name = dt.Columns[i].ColumnName;
                        propertyNodeTemp.group = "资料目录";
                        propertyNodeTemp.value = dt.Rows[0][i].ToString();
                        if (i == dt.Columns.Count - 1)
                        {
                            propertyNodeTemp.editor = "text";
                        }
                        propList.Add(propertyNodeTemp);
                    }
                    property.rows = propList;
                }
            }
            mStrReturn = JsonConvert.SerializeObject(property);
        }
        return mStrReturn;

    }

    public string GetDataWhere()
    {
        string mStrWhere = "";
        if (diretory_name != "")
        {
            mStrWhere = " where t_Diretory.diretory_name like '%" + diretory_name + "%'";
        }
        return mStrWhere;
    }
    public string GetDataOrder()
    {
        string mStrOrder = "";
        if (sort != "")
        {
            mStrOrder = " order by " + sort;
            if (order != "")
            {
                mStrOrder = mStrOrder + " " + order;
            }
        }
        return mStrOrder;
    }

    public string GetDataGrid()
    {
        List<diretory> diretoryList = new List<diretory>();
        string mStrSQL = @" SELECT     t_Diretory.diretory_code, t_Diretory.diretory_name, t_Diretory.diretory_innum, t_Diretory.diretory_create_time, t_Diretory.diretory_create_people, t_FileClass.fileclass_code, t_FileClass.fileclass_name, 
                                                  t_Diretory.diretory_parent AS diretory_parent_code, t_Diretory_1.diretory_name AS diretory_parent_name, t_Diretory.diretory_remark, t_Diretory.diretory_general, t_Diretory.diretory_selectable, 
                                                  t_Diretory.diretory_visible
                            FROM         t_Diretory LEFT OUTER JOIN
                                                  t_FileClass ON t_Diretory.fileclass_code = t_FileClass.fileclass_code LEFT OUTER JOIN
                                                  t_Diretory AS t_Diretory_1 ON t_Diretory.diretory_parent = t_Diretory_1.diretory_code ";
        mStrSQL = mStrSQL + " " + GetDataWhere() + " " + GetDataOrder();
        DataTable dt = null;
        using (dt = claSqlConnDB.ExecuteDataset(intRows,intPage,claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL).Tables[0])
        {
            if (dt.Rows.Count > 0)
            {
                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    diretory diretoryTemp = new diretory();
                    diretoryTemp.diretory_code = dt.Rows[i][0].ToString();
                    diretoryTemp.diretory_name = dt.Rows[i][1].ToString();
                    diretoryTemp.diretory_innum = dt.Rows[i][2].ToString();
                    diretoryTemp.diretory_create_time = dt.Rows[i][3].ToString();
                    diretoryTemp.diretory_create_people = dt.Rows[i][4].ToString();
                    diretoryTemp.fileclass_code = dt.Rows[i][5].ToString();
                    diretoryTemp.fileclass_name = dt.Rows[i][6].ToString();
                    diretoryTemp.diretory_parent_code = dt.Rows[i][7].ToString();
                    diretoryTemp.diretory_parent_name = dt.Rows[i][8].ToString();
                    diretoryTemp.diretory_remark = dt.Rows[i][8].ToString();
                    diretoryTemp.diretory_general = dt.Rows[i][10].ToString();
                    diretoryTemp.diretory_selectable = dt.Rows[i][11].ToString();
                    diretoryTemp.diretory_visible = dt.Rows[i][12].ToString();
                    diretoryList.Add(diretoryTemp);
                }
            }
        }
        return JsonConvert.SerializeObject(diretoryList);

    }

    public string AddDiretory()
    {
        string mStrSQL = "";
       
        global mglobal = new global();
        diretory_code = mglobal.GetIdentityID("PC", "ZL", "ML", System.DateTime.Now, 6);
        mStrSQL = @" insert into t_Diretory (diretory_code,diretory_name,diretory_innum,diretory_create_time,diretory_create_people,diretory_visible,
                        fileclass_code,diretory_parent,diretory_remark,diretory_general,diretory_selectable) values
                    ('" + diretory_code + "','" + diretory_name + "','" + diretory_innum + "','" + diretory_create_time + "','" + diretory_create_people + "'," + diretory_visible
                       + ",'" + fileclass_code + "','" + diretory_parent + "','" + diretory_remark + "'," + diretory_general + "," + diretory_selectable + ")";
        int i = claSqlConnDB.ExecuteNonQuery(claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL);
        return i.ToString();
    }

    public string EditDiretory()
    {
        string mStrSQL = "";
        mStrSQL = @"UPDATE t_Diretory set diretory_name='" + diretory_name + "',diretory_innum='" + diretory_innum + "',diretory_create_time='" + diretory_create_time + "',diretory_create_people='" + diretory_create_people + "',diretory_visible=" + diretory_visible
                  + ",fileclass_code='" + fileclass_code + "',diretory_parent='" + diretory_parent + "',diretory_remark='" + diretory_remark + "',diretory_general=" + diretory_general + ",diretory_selectable=" + diretory_selectable
                  + " where diretory_code='" + diretory_code + "'";
        int i = claSqlConnDB.ExecuteNonQuery(claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL);
        return i.ToString();
    }

    public string DelDiretory()
    {
        string mStrSQL = "";
        mStrSQL = @"DELETE FROM t_Diretory where diretory_code='" + diretory_code + "'";
        int i = claSqlConnDB.ExecuteNonQuery(claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL);
        return i.ToString();
    }
    public string GetTreeJson()
    {
        return JsonConvert.SerializeObject(GetTree(fileclass_code, diretory_parent));
    }
    public List<TreeNode> GetTree(string fileclassCode, string diretoryParent)
    {
        List<TreeNode> listTree = new List<TreeNode>();
        DataTable dt = null;
        string mStrSQL = " select diretory_code,diretory_name,diretory_parent from t_Diretory where diretory_parent='" + diretoryParent + "' and fileclass_code='" + fileclassCode + "' order by diretory_sort ";
        using (dt = claSqlConnDB.ExecuteDataset(claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL).Tables[0])
        {
            if (dt.Rows.Count > 0)
            {
                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    TreeNode treeTemp = new TreeNode();
                    treeTemp.id = dt.Rows[i][0].ToString();
                    treeTemp.text = dt.Rows[i][1].ToString();
                    treeTemp.attributes = "diretory";
                    if (GetDiretoryTreeNum(dt.Rows[i][0].ToString()) > 0 || GetFileNum(dt.Rows[i][0].ToString())>0)
                    {
                        treeTemp.state = "closed";
                        
                    }
                    else
                    {
                        treeTemp.state = "open"; 
                    }
                    treeTemp.iconCls = "icon-diretory";
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
    public string GetComboTreeJson()
    {
        return JsonConvert.SerializeObject(GetComboTree(fileclass_code, diretory_parent));
    }
    private List<combotree> GetComboTree(string fileclassCode, string diretoryParent)
    {
        List<combotree> listCombo = new List<combotree>();
        DataTable dt = null;
        //if (diretoryParent == "")
        //{
        //    combotree comboTreeInit = new combotree();
        //    comboTreeInit.id = "0";
        //    comboTreeInit.text = "----";
        //    comboTreeInit.state = "open";
        //    listCombo.Add(comboTreeInit);
        //}
        string mStrSQL = "  select diretory_code,diretory_name,diretory_parent from t_Diretory where diretory_parent='" + diretoryParent + "'  and fileclass_code='" + fileclassCode + "' order by diretory_sort ";
        using (dt = claSqlConnDB.ExecuteDataset(claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL).Tables[0])
        {
            if (dt.Rows.Count > 0)
            {
                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    combotree comboTreeTemp = new combotree();
                    comboTreeTemp.id = dt.Rows[i][0].ToString();
                    comboTreeTemp.text = dt.Rows[i][1].ToString();
                    if (GetDiretoryComboNum(dt.Rows[i][0].ToString()) > 0)
                    {
                        comboTreeTemp.state = "closed";
                    }
                    else
                    {
                        comboTreeTemp.state = "open"; 
                    }
                    //comboTreeTemp.children = GetComboTree(dt.Rows[i][0].ToString());
                    listCombo.Add(comboTreeTemp);
                }
            }
        }
        return listCombo;
    }
    private int GetDiretoryComboNum(string diretoryCode)
    {
        string mStrSQL = "SELECT COUNT(0) FROM t_Diretory WHERE diretory_parent='" + diretoryCode + "'";
        int i = claSqlConnDB.GetRecordCount(claSqlConnDB.gStrConnDefault, mStrSQL);
        return i; 
    }
    
    public bool IsReusable
    {
        get
        {
            return false;
        }
    }

}