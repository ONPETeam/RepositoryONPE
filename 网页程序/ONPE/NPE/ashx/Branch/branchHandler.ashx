<%@ WebHandler Language="C#" Class="branchHandler" %>

using System;
using System.Web;
using ModelClass;
using Newtonsoft.Json;
using NPE.UIDataClass;
using System.Data;
using System.Collections.Generic;
using System.Data.SqlClient;

public class branchHandler : IHttpHandler {

    string branch_id = "";
    string branch_name = "";
    string branch_parent = "";
    string branch_code = "";
    string company_id = "";

    string sort = "";
    string order = "";

    int rows = 10;
    int page = 1;


    public void ProcessRequest(HttpContext context)
    {
        int mIntParamNullable = 0;
        string mStrReturn = "";
        context.Response.ContentType = "text/plain";
        string action = "";
        if (context.Request.Params["branch_id"] != null)
        {
            branch_id = context.Request.Params["branch_id"];
        }
        if (context.Request.Params["area_name"] != null)
        {
            branch_name = context.Request.Params["branch_name"];
        }
        if (context.Request.Params["branch_parent"] != null)
        {
            branch_parent = context.Request.Params["branch_parent"];
        }
        if (context.Request.Params["branch_code"] != null)
        {
            branch_code = context.Request.Params["branch_code"];
        }
        if (context.Request.Params["company_id"] != null)
        {
            company_id = context.Request.Params["company_id"];
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
            rows = int.Parse(context.Request.Params["rows"]);
        }
        if (context.Request.Params["page"] != null)
        {
            page = int.Parse(context.Request.Params["page"]);
        }
        if (context.Request.Params["action"] != null)
        {
            action = context.Request.Params["action"];
        }
        switch (action)
        {
            case "add":
                string m_add_branch_name = "";
                if (context.Request.Params["branch_name"] != null)
                {
                    m_add_branch_name = context.Request.Params["branch_name"];
                }
                else
                {
                    mIntParamNullable = mIntParamNullable + 1;
                }
                string m_add_branch_innum = "";
                if (context.Request.Params["branch_innum"] != null)
                {
                    m_add_branch_innum = context.Request.Params["branch_innum"];
                }
                string m_add_branch_parent = "";
                if (context.Request.Params["branch_parent"] != null)
                {
                    m_add_branch_parent = context.Request.Params["branch_parent"];
                }
                else
                {
                    mIntParamNullable = mIntParamNullable + 1;
                }
                string m_add_company_id = "";
                if (context.Request.Params["company_id"] != null)
                {
                    m_add_company_id = context.Request.Params["company_id"];
                }
                else
                {
                    mIntParamNullable = mIntParamNullable + 1;
                }
                
                if (mIntParamNullable == 0)
                {
                    int mIntaddReturn = addBranch(m_add_branch_name, m_add_branch_innum, m_add_branch_parent, m_add_company_id);
                    if (mIntaddReturn == 1)
                    {
                        mStrReturn = "{'success':true,'msg':'添加数据成功！'}";
                    }
                    else
                    {
                        mStrReturn = "{'success':false,'msg':'添加数据失败！'}";
                    }
                }
                else
                {
                    mStrReturn = "{'success':false,'msg':'缺少必要参数！'}";
                }
                context.Response.Write(mStrReturn);
                break;
            case "edit":
                string m_edit_branch_id = "";
                if (context.Request.Params["branch_id"] != null)
                {
                    m_edit_branch_id = context.Request.Params["branch_id"];
                }
                else
                {
                    mIntParamNullable = mIntParamNullable + 1;
                }
                string m_edit_branch_name = "";
                if (context.Request.Params["branch_name"] != null)
                {
                    m_edit_branch_name = context.Request.Params["branch_name"];
                }
                else
                {
                    mIntParamNullable = mIntParamNullable + 1;
                }
                string m_edit_branch_innum = "";
                if (context.Request.Params["branch_innum"] != null)
                {
                    m_edit_branch_innum = context.Request.Params["branch_innum"];
                }
                string m_edit_branch_parent = "";
                if (context.Request.Params["branch_parent"] != null)
                {
                    m_edit_branch_parent = context.Request.Params["branch_parent"];
                }
                else
                {
                    mIntParamNullable = mIntParamNullable + 1;
                }
                string m_edit_company_id = "";
                if (context.Request.Params["company_id"] != null)
                {
                    m_edit_company_id = context.Request.Params["company_id"];
                }
                else
                {
                    mIntParamNullable = mIntParamNullable + 1;
                }
                
                if (mIntParamNullable == 0)
                {
                    int mIntaddReturn = editBranch(m_edit_branch_id, m_edit_branch_name, m_edit_branch_innum, m_edit_branch_parent, m_edit_company_id);
                    if (mIntaddReturn == 1)
                    {
                        mStrReturn = "{'success':true,'msg':'编辑数据成功！'}";
                    }
                    else
                    {
                        mStrReturn = "{'success':false,'msg':'编辑数据失败！'}";
                    }
                }
                else
                {
                    mStrReturn = "{'success':false,'msg':'缺少必要参数！'}";
                }
                context.Response.Write(mStrReturn);
                break;
            case "del":
                string m_del_branch_id = "";
                if (context.Request.Params["branch_id"] != null)
                {
                    m_del_branch_id = context.Request.Params["branch_id"];
                }
                else
                {
                    mIntParamNullable = mIntParamNullable + 1;
                }
                if (mIntParamNullable == 0)
                {
                    int mIntaddReturn = delBranch(m_del_branch_id);
                    if (mIntaddReturn == 1)
                    {
                        mStrReturn = "{'success':true,'msg':'删除数据成功！'}";
                    }
                    else
                    {
                        mStrReturn = "{'success':false,'msg':'删除数据失败！'}";
                    }
                }
                else
                {
                    mStrReturn = "{'success':false,'msg':'缺少必要参数！'}";
                }
                context.Response.Write(mStrReturn);
                break;
            case "show":
                System.Text.StringBuilder sb = new System.Text.StringBuilder();
                sb.Append("{ ");
                sb.Append(string.Format("\"total\":{0},\"rows\":", GetBranchPageCount()));
                string s = ShowBranchGird();
                sb.Append(s);
                sb.Append("}");
                context.Response.Write(sb.ToString());
                break;
            case "tree":
                context.Response.Write(GetBranchTreeJson());
                break;
            case "combo":
                context.Response.Write(GetBranchComboJson());
                break;
            //case "prop":
            //    context.Response.Write(GetProperty());
            //    break;
            case "detail":
                context.Response.Write(GetBranchDetail());
                break;
            default:

                break;
        }
    }
    private string GetBranchPageCount()
    {
        string mStrSQL = @" select count(0) from tHRBranchInfo " + GetWhere();
        int i = claSqlConnDB.GetRecordCount(claSqlConnDB.gStrConnDefault, mStrSQL);
        return i.ToString();
    }
    private int addBranch( string v_branch_name ,string v_branch_innum,string v_branch_parent,string v_company_id)
    {
        string mStrSQL = @"insert into tHRBranchInfo(dVchBranchName,dVchBranchPY,dIntUpBranch,dIntCompanyID) values(
                        '" + v_branch_name + "','" + v_branch_innum + "'," + v_branch_parent + "," + v_company_id + ")";
        int i = claSqlConnDB.ExecuteNonQuery(claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL);
        return i;
    }
    private int editBranch(string v_branch_id,string v_branch_name, string v_branch_innum, string v_branch_parent, string v_company_id)
    {
        string mStrSQL = @"update tHRBranchInfo set 
                    dVchBranchName=@branch_name,
                    dVchBranchPY=@branch_innum,
                    dIntUpBranch=@branch_parent,
                    dIntCompanyID=@company_id
                    where dIntBranchID=@branch_id";
        SqlParameter[] parameters = new SqlParameter[]{
            new SqlParameter("@branch_id",SqlDbType.Int,4),
            new SqlParameter("@branch_name",SqlDbType.VarChar,200),
            new SqlParameter("@branch_innum",SqlDbType.VarChar,100),
            new SqlParameter("@branch_parent",SqlDbType.Int,4),
            new SqlParameter("@company_id",SqlDbType.Int,4),
        };
        parameters[0].Value = v_branch_id;
        parameters[1].Value = v_branch_name;
        parameters[2].Value = v_branch_innum;
        parameters[3].Value = v_branch_parent;
        parameters[4].Value = v_company_id;
        int i = claSqlConnDB.ExecuteNonQuery(claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL, parameters);
        return i;
    }
    private int delBranch(string v_branch_id)
    {
        string mStrSQL = @"delete from tHRBranchInfo where dIntBranchID=" + v_branch_id;
        int i = claSqlConnDB.ExecuteNonQuery(claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL);
        return i;
    }
    private string ShowBranchGird()
    {
        string mStrReturn = "";
        List<Branch> listBranch = new List<Branch>();
        DataTable dt = null;
        string mStrSQL = @"SELECT     tHRBranchInfo.dIntBranchID, tHRBranchInfo.dVchBranchName, tHRBranchInfo.dVchBranchPY, tHRBranchInfo.dIntUpBranch, tHRBranchInfo_1.dVchBranchName AS dVchUpBranchName, 
                                      tHRBranchInfo.dIntCompanyID, tHRCompany.dVchCompanyName
                            FROM      tHRBranchInfo left outer JOIN
                                      tHRBranchInfo AS tHRBranchInfo_1 ON tHRBranchInfo.dIntUpBranch = tHRBranchInfo_1.dIntBranchID LEFT OUTER JOIN
                                      tHRCompany ON tHRBranchInfo.dIntCompanyID = tHRCompany.dIntCompanyID" + GetWhere() + GetOrder();
        using (dt = claSqlConnDB.ExecuteDataset(rows, page, claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL).Tables[0])
        {
            if (dt.Rows.Count > 0)
            {
                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    Branch branchTemp = new Branch();
                    if (dt.Rows[i][0] != null)
                    {
                        branchTemp.dIntBranchID = int.Parse(dt.Rows[i][0].ToString());
                    }
                    branchTemp.dVchBranchName = dt.Rows[i][1].ToString();

                    branchTemp.dVchBranchPY = dt.Rows[i][2].ToString();
                    if (dt.Rows[i][3] != null)
                    {
                        branchTemp.dIntUpBranch = int.Parse(dt.Rows[i][3].ToString() == "" ? "0" : dt.Rows[i][3].ToString());
                    }
                    if (dt.Rows[i][4] != null)
                    {
                        branchTemp.dVchUpBranchName = dt.Rows[i][4].ToString();
                    }
                    if (dt.Rows[i][5] != null)
                    {
                        branchTemp.dIntCompanyID = int.Parse(dt.Rows[i][5].ToString());
                    }
                    if (dt.Rows[i][6] != null)
                    {
                        branchTemp.dVchCompanyName = dt.Rows[i][6].ToString();
                    }
                    listBranch.Add(branchTemp);
                }
            }
            mStrReturn = JsonConvert.SerializeObject(listBranch);
        }

        return mStrReturn;
    }
    private string GetBranchComboJson()
    {
        string mStrReturn = "";
        mStrReturn = JsonConvert.SerializeObject(GetBranchCombo(branch_parent, company_id));
        return mStrReturn;
    }
    private List<combotree> GetBranchCombo(string branchParent,string companyId)
    {
        List<combotree> listCombo = new List<combotree>();
        DataTable dt = null;
        if (branchParent == "0")
        {
            combotree comboGetInit = new combotree();
            comboGetInit.id = "0";
            comboGetInit.text = "----";
            comboGetInit.state = "open";
            listCombo.Add(comboGetInit);
        }
        string lStrSQL = "select dIntBranchID,dVchBranchName from tHRBranchInfo where dIntUpBranch =@branch_parent and dIntCompanyID=@company_id";
        SqlParameter [] parameters=new SqlParameter[]{
            new SqlParameter("@branch_parent",SqlDbType.Int,4),
            new SqlParameter("@company_id",SqlDbType.Int,4)
        };
        parameters[0].Value = branchParent;
        parameters[1].Value = companyId;
        using (dt = claSqlConnDB.ExecuteDataset(claSqlConnDB.gStrConnDefault, System.Data.CommandType.Text, lStrSQL,parameters).Tables[0])
        {
            if (dt.Rows.Count > 0)
            {
                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    combotree comboNodetmp = new combotree();
                    comboNodetmp.id = dt.Rows[i][0].ToString();
                    comboNodetmp.text = dt.Rows[i][1].ToString();
                    if (GetBranchTreeNum(dt.Rows[i][0].ToString()) > 0)
                    {
                        comboNodetmp.children = GetBranchCombo(dt.Rows[i][0].ToString(), companyId);
                        comboNodetmp.state = "open";
                    }
                    else
                    {
                        comboNodetmp.state = "open";
                    }
                    //comboNodetmp.children = GetAreaCombo(dt.Rows[i][0].ToString());
                    listCombo.Add(comboNodetmp);
                }
            }
        }
        return listCombo;
    }

    private int GetBranchTreeNum(string branchID)
    {
        string mStrSQL = " select count(0) from tHRBranchInfo where dIntUpBranch =" + branchID;
        int i = claSqlConnDB.GetRecordCount(claSqlConnDB.gStrConnDefault, mStrSQL);
        return i;
    }

    private string GetBranchTreeJson()
    {
        string mStrReturn = "";
        mStrReturn = JsonConvert.SerializeObject(GetBranchTree(branch_parent));
        return mStrReturn;
    }
    private List<TreeNode> GetBranchTree(string branchParent)
    {
        List<TreeNode> listTree = new List<TreeNode>();
        DataTable dt = null;
        string mStrSQL = " SELECT  dIntBranchID, dVchBranchName from tHRBranchInfo where dIntUpBranch=" + branchParent;
        using (dt = claSqlConnDB.ExecuteDataset(claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL).Tables[0])
        {
            if (dt.Rows.Count > 0)
            {
                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    TreeNode treeTemp = new TreeNode();
                    treeTemp.id = dt.Rows[i][0].ToString();
                    treeTemp.text = dt.Rows[i][1].ToString();
                    if (GetBranchTreeNum(dt.Rows[i][0].ToString()) > 0)
                    {
                        treeTemp.state = "closed";
                        treeTemp.attributes = "branch";
                    }
                    else
                    {
                        treeTemp.attributes = "lastbranch";
                        treeTemp.state = "open";
                    }
                    //treeTemp.children = GetAreaTree(dt.Rows[i][0].ToString());
                    listTree.Add(treeTemp);
                }
            }
        }
        return listTree;
    }

    private string GetBranchDetail()
    {
        string mStrReturn = "";
        DataTable dt = null;
        List<Branch> listBranch = new List<Branch>();
        string mStrSQL = @"SELECT dIntBranchID, dVchBranchName, dVchBranchPY, dIntUpBranch, dIntCompanyID FROM tHRBranchInfo where dIntBranchID=" + branch_id;
        using (dt = claSqlConnDB.ExecuteDataset(claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL).Tables[0])
        {
            if (dt.Rows.Count > 0)
            {
                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    Branch branchTemp = new Branch();
                    if (dt.Rows[i][0] != null)
                    {
                        branchTemp.dIntBranchID = int.Parse(dt.Rows[i][0].ToString());
                    }
                    branchTemp.dVchBranchName = dt.Rows[i][1].ToString();

                    branchTemp.dVchBranchPY = dt.Rows[i][2].ToString();
                    if (dt.Rows[i][3] != null)
                    {
                        branchTemp.dIntUpBranch = int.Parse(dt.Rows[i][3].ToString());
                    }
                    if (dt.Rows[i][4] != null)
                    {
                        branchTemp.dIntCompanyID = int.Parse(dt.Rows[i][4].ToString());
                    }
                    listBranch.Add(branchTemp);
                }
            }
            mStrReturn = JsonConvert.SerializeObject(listBranch);
        }
        return mStrReturn;
    }
    


    public bool IsReusable
    {
        get
        {
            return false;
        }
    }
    private string GetWhere()
    {
        string mStrWhere = "";

        return mStrWhere;
    }
    private string GetOrder()
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
}