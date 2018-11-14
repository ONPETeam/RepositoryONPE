<%@ WebHandler Language="C#" Class="CompanyHandler" %>

using System;
using System.Web;
using System.Collections.Generic;
using System.Data;
using NPE.UIDataClass;
using ModelClass;
using Newtonsoft.Json;
using System.Data.SqlClient;

public class CompanyHandler : IHttpHandler {

    string companyID="";
    string companyName = "";
    string shortName = "";
    string zzjgdm = "";
    string companyAddress = "";
    string companyPhone = "";
    string companyWeb = "";
    string companyMail = "";

    string sort = "";
    string order = "";

    int rows = 10;
    int page = 1;

    string searchName = "";
    int mIntParamNullable = 0;
    string mStrReturn = "";
    public void ProcessRequest (HttpContext context) {
        context.Response.ContentType = "text/plain";
        string action = context.Request.Params["action"];
        companyID = context.Request.Params["companyID"];
        companyName = context.Request.Params["companyName"];
        shortName = context.Request.Params["shortName"];
        zzjgdm = context.Request.Params["zzjgdm"];
        companyAddress = context.Request.Params["companyAddress"];
        companyPhone = context.Request.Params["companyPhone"];
        companyWeb = context.Request.Params["companyWeb"];
        companyMail = context.Request.Params["companyMail"];
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
            page =int.Parse( context.Request.Params["page"]); 
        }
        if (context.Request.Params["searchCompanyName"] != null)
        {
            searchName = context.Request.Params["searchCompanyName"]; 
        }
        switch (action)
        {
            case "add":
                string m_add_company_name= "";
                if (context.Request.Params["companyName"] != null)
                {
                    m_add_company_name = context.Request.Params["companyName"];
                }
                else
                {
                    mIntParamNullable = mIntParamNullable + 1; 
                }
                string m_add_short_name = "";
                if (context.Request.Params["shortName"] != null)
                {
                    m_add_short_name = context.Request.Params["shortName"]; 
                }
                string m_add_zzjgdm = "";
                if (context.Request.Params["zzjgdm"] != null)
                {
                    m_add_zzjgdm = context.Request.Params["zzjgdm"]; 
                }
                string m_add_company_address = "";
                if (context.Request.Params["companyAddress"] != null)
                {
                    m_add_company_address = context.Request.Params["companyAddress"]; 
                }
                string m_add_company_phone= "";
                if (context.Request.Params["companyPhone"] != null)
                {
                    m_add_company_phone = context.Request.Params["companyPhone"]; 
                }
                string m_add_company_web= "";
                if (context.Request.Params["companyWeb"]!=null)
                {
                    m_add_company_web = context.Request.Params["companyWeb"]; 
                }
                string m_add_company_mail= "";
                if (context.Request.Params["companyMail"] != null)
                {
                    m_add_company_mail = context.Request.Params["companyMail"]; 
                }
                if (mIntParamNullable == 0)
                {
                    int mIntaddReturn = addCompany(m_add_company_name, m_add_short_name, m_add_zzjgdm, m_add_company_address, m_add_company_phone,
                        m_add_company_web, m_add_company_mail);
                    if (mIntaddReturn == 0)
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
                string m_edit_company_id = "";
                if (context.Request.Params["companyID"]!=null)
                {
                    m_edit_company_id=context.Request.Params["companyID"];
                }
                else
                {
                    mIntParamNullable=mIntParamNullable+1;
                }
                string m_edit_company_name= "";
                if (context.Request.Params["companyName"] != null)
                {
                    m_edit_company_name = context.Request.Params["companyName"];
                }
                else
                {
                    mIntParamNullable = mIntParamNullable + 1; 
                }
                string m_edit_short_name = "";
                if (context.Request.Params["shortName"] != null)
                {
                    m_edit_short_name = context.Request.Params["shortName"]; 
                }
                string m_edit_zzjgdm = "";
                if (context.Request.Params["zzjgdm"] != null)
                {
                    m_edit_zzjgdm = context.Request.Params["zzjgdm"]; 
                }
                string m_edit_company_address = "";
                if (context.Request.Params["companyAddress"] != null)
                {
                    m_edit_company_address = context.Request.Params["companyAddress"]; 
                }
                string m_edit_company_phone= "";
                if (context.Request.Params["companyPhone"] != null)
                {
                    m_edit_company_phone = context.Request.Params["companyPhone"]; 
                }
                string m_edit_company_web= "";
                if (context.Request.Params["companyWeb"]!=null)
                {
                    m_edit_company_web = context.Request.Params["companyWeb"]; 
                }
                string m_edit_company_mail= "";
                if (context.Request.Params["companyMail"] != null)
                {
                    m_edit_company_mail = context.Request.Params["companyMail"]; 
                }
                if (mIntParamNullable == 0)
                {
                    int mIntEditReturn = editCompany(m_edit_company_id, m_edit_company_name, m_edit_short_name, m_edit_zzjgdm, m_edit_company_address, m_edit_company_phone,
                        m_edit_company_web, m_edit_company_mail);
                    if (mIntEditReturn >= 0)
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
                context.Response.Write(delCompany());
                break;
            case "show":
                System.Text.StringBuilder sb = new System.Text.StringBuilder();
                sb.Append("{ ");
                sb.Append(string.Format("\"total\":{0},\"rows\":", GetCompanyCount()));
                string s=ShowCompany(sort, order, page, rows);
                sb.Append(s);
                sb.Append("}");
                context.Response.Write(sb.ToString());
                break;
            case "combo":
                context.Response.Write(GetCompanyComboJson());
                break;
            default:

                break; 
        }
    }
    public string GetCompanyComboJson()
    {
        string mStrReturn = "";
        mStrReturn = JsonConvert.SerializeObject(GetCompanyCombo());
        return mStrReturn; 
    }
    public List<combotree> GetCompanyCombo()
    {
        List<combotree> treelist = new List<combotree>();
        DataTable dt = null;
        string mStrSql = " select dIntCompanyID,dVchCompanyName from tHRCompany";
        using (dt = claSqlConnDB.ExecuteDataset(claSqlConnDB.gStrConnDefault, System.Data.CommandType.Text, mStrSql).Tables[0])
        {
            if (dt.Rows.Count > 0)
            {
                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    combotree treeNodetemp = new combotree();
                    treeNodetemp.id = dt.Rows[i][0].ToString();
                    treeNodetemp.text = dt.Rows[i][1].ToString();
                    treelist.Add(treeNodetemp);
                }
            }
        }
        return treelist; 
    }

    public int addCompany(string company_name, string short_name, string zzjg_code, string company_address,
        string company_phone, string company_web, string company_mail) 
    {
        string mStrSQL = @"insert into tHRCompany(dVchCompanyName,dVchShortName,dVchZZJGDM,dVchAddress,dVchPhone,dVchWeb,dVchEmail) 
                        values(@company_name,@short_name,@zzjg_code,@company_address,@company_phone,@company_web,@company_mail)";
        SqlParameter[] parameter = new SqlParameter[]{
            new SqlParameter("@company_name",SqlDbType.VarChar,200),
            new SqlParameter("@short_name",SqlDbType.VarChar,10),
            new SqlParameter("@zzjg_code",SqlDbType.VarChar,100),
            new SqlParameter("@company_address",SqlDbType.VarChar,200),
            new SqlParameter("@company_phone",SqlDbType.VarChar,50),
            new SqlParameter("@company_web",SqlDbType.VarChar,100),
            new SqlParameter("@company_mail",SqlDbType.VarChar,100)
        };
        parameter[0].Value = company_name;
        parameter[1].Value = short_name;
        parameter[2].Value = zzjg_code;
        parameter[3].Value = company_address;
        parameter[4].Value = company_phone;
        parameter[5].Value = company_web;
        parameter[6].Value = company_mail;
        int i = claSqlConnDB.ExecuteNonQuery(claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL, parameter);
        return i;
    }
    public int editCompany(string company_id,string company_name,string short_name,string zzjg_code,string company_address,
        string company_phone,string company_web,string company_mail)
    {
        string mStrSQL = @"UPDATE tHRCompany SET 
                            dVchCompanyName=@company_name,
                            dVchShortName=@short_name,
                            dVchZZJGDM=@zzjg_code,
                            dVchAddress=@company_address,
                            dVchPhone=@company_phone,
                            dVchWeb=@company_web,
                            dVchEmail=@company_mail 
                        Where dIntCompanyID=@company_id";
        SqlParameter[] parameter = new SqlParameter[]{
            new SqlParameter("@company_id",SqlDbType.Int,4),
            new SqlParameter("@company_name",SqlDbType.VarChar,200),
            new SqlParameter("@short_name",SqlDbType.VarChar,10),
            new SqlParameter("@zzjg_code",SqlDbType.VarChar,100),
            new SqlParameter("@company_address",SqlDbType.VarChar,200),
            new SqlParameter("@company_phone",SqlDbType.VarChar,50),
            new SqlParameter("@company_web",SqlDbType.VarChar,100),
            new SqlParameter("@company_mail",SqlDbType.VarChar,100)
        };
        parameter[0].Value = company_id;
        parameter[1].Value = company_name;
        parameter[2].Value = short_name;
        parameter[3].Value = zzjg_code;
        parameter[4].Value = company_address;
        parameter[5].Value = company_phone;
        parameter[6].Value = company_web;
        parameter[7].Value = company_mail;
        int i = claSqlConnDB.ExecuteNonQuery(claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL,parameter);
        return i;
    }
    public string delCompany()
    {
        string mStrSQL = @"delete from tHRCompany where dIntCompanyID=" + companyID;
        int i = claSqlConnDB.ExecuteNonQuery(claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL);

        return i.ToString();
    }

    public string GetCompanyCount()
    {
        string mStrSQL = "select count(*) from tHRCompany " + GetWhere();
        int i = claSqlConnDB.GetRecordCount(claSqlConnDB.gStrConnDefault, mStrSQL);
        return i.ToString();
    }

    public string GetWhere()
    {
        string mStrWhere = "";
        if (searchName != "")
        {
            mStrWhere = " where dVchCompanyName like '%" + searchName + "%' ";
        }
        return mStrWhere;
    }
    
    public string ShowCompany(string vStrSort,string vStrOrder,int vIntPage,int vIntRows)
    {
        string mStrData="";
        string mStrOrder = "";
        List<ModelClass.Company> listCompany = new List<ModelClass.Company>();
        if (vStrSort != "")
        {
            mStrOrder = " order by " + vStrSort;
            if (vStrOrder != "")
            {
                mStrOrder = mStrOrder + " " + vStrOrder;
            }
        }
        
        string mStrSQL = "select dIntCompanyID,dVchCompanyName,dVchShortName,dVchZZJGDM,dVchAddress,dVchPhone,dVchWeb,dVchEmail,dIntFlagSelf from tHRCompany"
                        + GetWhere() + mStrOrder;
        DataTable dt = null;
        using (dt = claSqlConnDB.ExecuteDataset(vIntRows,vIntPage,claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL).Tables[0])
        {
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                ModelClass.Company companyTemp = new ModelClass.Company();
                companyTemp.dIntCompanyID = int.Parse(dt.Rows[i][0].ToString());
                companyTemp.dVchCompanyName = dt.Rows[i][1].ToString();
                companyTemp.dVchShortName = dt.Rows[i][2].ToString();
                companyTemp.dVchZZJGDM = dt.Rows[i][3].ToString();
                companyTemp.dVchAddress = dt.Rows[i][4].ToString();
                companyTemp.dVchPhone = dt.Rows[i][5].ToString();
                companyTemp.dVchWeb = dt.Rows[i][6].ToString();
                companyTemp.dVchEmail = dt.Rows[i][7].ToString();
                companyTemp.dIntFlagSelf = int.Parse(dt.Rows[i][8].ToString() == "" ? "0" : dt.Rows[i][8].ToString());
                listCompany.Add(companyTemp);
            }
            mStrData = JsonConvert.SerializeObject(listCompany);
        }        
        return mStrData; 
    }
    public bool IsReusable {
        get {
            return false;
        }
    }

}