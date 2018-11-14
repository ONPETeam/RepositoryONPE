<%@ WebHandler Language="C#" Class="employeeHandler" %>

using System;
using System.Web;
using ModelClass;
using Newtonsoft.Json;
using NPE.UIDataClass;
using System.Data;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Text;

public class employeeHandler : IHttpHandler
{
    private GJHF.Business.HR.Employee BEmployee;
    private GJHF.Business.HR.Company _Company;
    private GJHF.Business.HR.Branch _Branch;
    public employeeHandler()
    {
        this.BEmployee = new GJHF.Business.HR.Employee();
        this._Company = new GJHF.Business.HR.Company();
        this._Branch = new GJHF.Business.HR.Branch();
    }
    int page = 1;
    int rows = 10;
    string order = "";
    string sort = "";
    public void ProcessRequest(HttpContext context)
    {
        string action = "";
        string mStrReturn = "";
        context.Response.ContentType = "text/plain";
        action = context.Request.Params["action"];
        switch (action)
        {
            case "add":
                mStrReturn = AddEmployeeData(context);
                break;
            case "edit":
                mStrReturn = EditEmployeeData(context);
                break;
            case "del":
                mStrReturn = DelEmployeeData(context);
                break;
            case "prop":
                mStrReturn = GetEmployeeProp(context);
                break;
            case "grid":
                mStrReturn = GetEmployeeData(context);
                break;
            case "combo":
                mStrReturn = GetEmployeeComboData(context);
                break;
            case "tree":
                mStrReturn = GetHRTreeData(context);
                break;
            default:
                mStrReturn = GJHF.Utility.WEBUI.EasyuiControl.GetMissParamReturn();
                break;
        }
        context.Response.Write(mStrReturn);
    }
    private string AddEmployeeData(HttpContext context)
    {
        global mGlobal = new global();

        string m_add_employee_code = mGlobal.GetIdentityID("PC", "HR", "RY", System.DateTime.Now, 4);

        string m_add_employee_innum = "";
        if (context.Request.Params["employee_innum"] != null)
        {
            m_add_employee_innum = context.Request.Params["employee_innum"];
        }

        string m_add_employee_Name = "";
        if (context.Request.Params["employee_Name"] != null)
        {
            m_add_employee_Name = context.Request.Params["employee_Name"];
        }
        if (m_add_employee_Name == "") return GJHF.Utility.WEBUI.EasyuiControl.GetParamFailRetuen();

        string m_add_employee_sex = "";
        if (context.Request.Params["employee_sex"] != null)
        {
            m_add_employee_sex = context.Request.Params["employee_sex"];
        }
        else
        {
            m_add_employee_sex = "男";
        }
        string m_add_idcard_no = "";
        if (context.Request.Params["idcard_no"] != null)
        {
            m_add_idcard_no = context.Request.Params["idcard_no"];
        }

        int m_add_city_id = 0;
        if (context.Request.Params["city_id"] != null)
        {
            if (int.TryParse(context.Request.Params["city_id"], out m_add_city_id) == false)
            {
                m_add_city_id = 0;
            }
        }
        else
        {
            m_add_city_id = 0;
        }
        string m_add_home_address = "";
        if (context.Request.Params["home_address"] != null)
        {
            m_add_home_address = context.Request.Params["home_address"];
        }
        int m_add_nation_id = 0;
        if (context.Request.Params["nation_id"] != null)
        {
            if (int.TryParse(context.Request.Params["nation_id"], out m_add_nation_id) == false)
            {
                m_add_nation_id = 0;
            }
        }
        else
        {
            m_add_nation_id = 0;
        }
        int m_add_visagetype_id = 0;
        if (context.Request.Params["visagetype_id"] != null)
        {
            if (int.TryParse(context.Request.Params["visagetype_id"], out m_add_visagetype_id) == false)
            {
                m_add_visagetype_id = 0;
            }
        }
        else
        {
            m_add_visagetype_id = 0;
        }
        string m_add_marital_status = "";
        if (context.Request.Params["marital_status"] != null)
        {
            m_add_marital_status = context.Request.Params["marital_status"];
        }


        string m_add_telphone_no = "";
        if (context.Request.Params["telphone_no"] != null)
        {
            m_add_telphone_no = context.Request.Params["telphone_no"];
        }

        int m_add_eductaion_id = 0;
        if (context.Request.Params["eductaion_id"] != null)
        {
            if (int.TryParse(context.Request.Params["eductaion_id"], out m_add_eductaion_id) == false)
            {
                m_add_eductaion_id = 0;
            }
        }
        else
        {
            m_add_eductaion_id = 0;
        }

        string m_add_graduate_time = "";
        if (context.Request.Params["graduate_time"] != null)
        {
            m_add_graduate_time = context.Request.Params["graduate_time"];
        }
        else
        {
            m_add_graduate_time = "1900-01-01 00:00";
        }
        string m_add_graduate_school = "";
        if (context.Request.Params["graduate_school"] != null)
        {
            m_add_graduate_school = context.Request.Params["graduate_school"];
        }

        string m_add_specialty_name = "";
        if (context.Request.Params["specialty_name"] != null)
        {
            m_add_specialty_name = context.Request.Params["specialty_name"];
        }
        int m_add_branch_id = 0;
        if (context.Request.Params["branch_id"] != null)
        {
            if (int.TryParse(context.Request.Params["branch_id"], out m_add_branch_id) == false)
            {
                m_add_branch_id = 0;
            }
        }
        if (m_add_branch_id == 0) return GJHF.Utility.WEBUI.EasyuiControl.GetParamFailRetuen();

        string m_add_major_code = "";
        if (context.Request.Params["major_code"] != null)
        {
            m_add_major_code = context.Request.Params["major_code"];
        }
        if (m_add_major_code == "") return GJHF.Utility.WEBUI.EasyuiControl.GetParamFailRetuen();

        int m_add_patrolgrade_id = 0;
        if (context.Request.Params["patrolgrade_id"] != null)
        {
            if (int.TryParse(context.Request.Params["patrolgrade_id"], out m_add_patrolgrade_id) == false)
            {
                m_add_patrolgrade_id = 0;
            }
        }
        else
        {
            m_add_patrolgrade_id = 0;
        }
        int mIntDetial = AddEmployeeData(m_add_employee_code, m_add_employee_innum, m_add_employee_Name, m_add_employee_sex, m_add_idcard_no, m_add_city_id, m_add_home_address, m_add_nation_id, m_add_visagetype_id, m_add_marital_status, m_add_telphone_no, m_add_eductaion_id, m_add_graduate_time, m_add_graduate_school, m_add_specialty_name, m_add_branch_id, m_add_major_code, m_add_patrolgrade_id);
        return GJHF.Utility.WEBUI.EasyuiControl.GetAddReturn(mIntDetial, 1);
    }
    private string EditEmployeeData(HttpContext context)
    {
        string m_edit_employee_code = "";
        if (context.Request.Params["employee_code"] != null)
        {
            m_edit_employee_code = context.Request.Params["employee_code"];
        }
        if (m_edit_employee_code == "") return GJHF.Utility.WEBUI.EasyuiControl.GetParamFailRetuen();
        string m_edit_employee_innum = "";
        if (context.Request.Params["employee_innum"] != null)
        {
            m_edit_employee_innum = context.Request.Params["employee_innum"];
        }

        string m_edit_employee_Name = "";
        if (context.Request.Params["employee_Name"] != null)
        {
            m_edit_employee_Name = context.Request.Params["employee_Name"];
        }
        if (m_edit_employee_Name == "") return GJHF.Utility.WEBUI.EasyuiControl.GetParamFailRetuen();
        string m_edit_employee_sex = "";
        if (context.Request.Params["employee_sex"] != null)
        {
            m_edit_employee_sex = context.Request.Params["employee_sex"];
        }
        else
        {
            m_edit_employee_sex = "男";
        }
        string m_edit_idcard_no = "";
        if (context.Request.Params["idcard_no"] != null)
        {
            m_edit_idcard_no = context.Request.Params["idcard_no"];
        }

        int m_edit_city_id = 0;
        if (context.Request.Params["city_id"] != null)
        {
            if (int.TryParse(context.Request.Params["city_id"], out m_edit_city_id) == false)
            {
                m_edit_city_id = 0;
            }
        }
        else
        {
            m_edit_city_id = 0;
        }
        string m_edit_home_address = "";
        if (context.Request.Params["home_address"] != null)
        {
            m_edit_home_address = context.Request.Params["home_address"];
        }
        int m_edit_nation_id = 0;
        if (context.Request.Params["nation_id"] != null)
        {
            if (int.TryParse(context.Request.Params["nation_id"], out m_edit_nation_id) == false)
            {
                m_edit_nation_id = 0;
            }
        }
        else
        {
            m_edit_nation_id = 0;
        }
        int m_edit_visagetype_id = 0;
        if (context.Request.Params["visagetype_id"] != null)
        {
            if (int.TryParse(context.Request.Params["visagetype_id"], out m_edit_visagetype_id) == false)
            {
                m_edit_visagetype_id = 0;
            }
        }
        else
        {
            m_edit_visagetype_id = 0;
        }

        string m_edit_marital_status = "";
        if (context.Request.Params["marital_status"] != null)
        {
            m_edit_marital_status = context.Request.Params["marital_status"];
        }
        string m_edit_telphone_no = "";
        if (context.Request.Params["telphone_no"] != null)
        {
            m_edit_telphone_no = context.Request.Params["telphone_no"];
        }

        int m_edit_eductaion_id = 0;
        if (context.Request.Params["eductaion_id"] != null)
        {
            if (int.TryParse(context.Request.Params["eductaion_id"], out m_edit_eductaion_id) == false)
            {
                m_edit_eductaion_id = 0;
            }
        }
        else
        {
            m_edit_eductaion_id = 0;
        }

        string m_edit_graduate_time = "";
        if (context.Request.Params["graduate_time"] != null)
        {
            m_edit_graduate_time = context.Request.Params["graduate_time"];
        }
        else
        {
            m_edit_graduate_time = "1900-01-01 00:00";
        }
        string m_edit_graduate_school = "";
        if (context.Request.Params["graduate_school"] != null)
        {
            m_edit_graduate_school = context.Request.Params["graduate_school"];
        }

        string m_edit_specialty_name = "";
        if (context.Request.Params["specialty_name"] != null)
        {
            m_edit_specialty_name = context.Request.Params["specialty_name"];
        }
        int m_edit_branch_id = 0;
        if (context.Request.Params["branch_id"] != null)
        {
            if (int.TryParse(context.Request.Params["branch_id"], out m_edit_branch_id) == false)
            {
                m_edit_branch_id = 0;
            }
        }
        if (m_edit_branch_id == 0) return GJHF.Utility.WEBUI.EasyuiControl.GetParamFailRetuen();

        string m_edit_major_code = "";
        if (context.Request.Params["major_code"] != null)
        {
            m_edit_major_code = context.Request.Params["major_code"];
        }
        if (m_edit_major_code == "") return GJHF.Utility.WEBUI.EasyuiControl.GetParamFailRetuen();
        int m_edit_patrolgrade_id = 0;
        if (context.Request.Params["patrolgrade_id"] != null)
        {
            if (int.TryParse(context.Request.Params["patrolgrade_id"], out m_edit_patrolgrade_id) == false)
            {
                m_edit_patrolgrade_id = 0;
            }
        }
        else
        {
            m_edit_patrolgrade_id = 0;
        }
       int mIntReturn = EditEmployeeData(m_edit_employee_code, m_edit_employee_innum, m_edit_employee_Name, m_edit_employee_sex, m_edit_idcard_no, m_edit_city_id, m_edit_home_address, m_edit_nation_id, m_edit_visagetype_id, m_edit_marital_status, m_edit_telphone_no, m_edit_eductaion_id, m_edit_graduate_time, m_edit_graduate_school, m_edit_specialty_name, m_edit_branch_id, m_edit_major_code, m_edit_patrolgrade_id);
       return GJHF.Utility.WEBUI.EasyuiControl.GetEditReturn(mIntReturn, 1);
    }
    private string DelEmployeeData(HttpContext context)
    {
        string m_del_employee_code = "";
        if (context.Request.Params["employee_code"] != null)
        {
            m_del_employee_code = context.Request.Params["employee_code"];
        }
        if (m_del_employee_code == "") return GJHF.Utility.WEBUI.EasyuiControl.GetParamFailRetuen();
        int mIntReturn = DelEmployeeData(m_del_employee_code);
        return GJHF.Utility.WEBUI.EasyuiControl.GetDelReturn(mIntReturn, 1);
    }
    private string GetEmployeeProp(HttpContext context)
    {
        string m_prop_employee_code = "";
        if (context.Request.Params["employee_code"] != null)
        {
            m_prop_employee_code = context.Request.Params["employee_code"];
        }
        if (m_prop_employee_code == "") return GJHF.Utility.WEBUI.EasyuiControl.GetParamFailRetuen();
        return GJHF.Utility.WEBUI.EasyuiControl.GetPropReturn(BEmployee.GetEmployeeByEmployeeCode(m_prop_employee_code));
    }

    private string GetEmployeeData(HttpContext context)
    {
        string order ="";
        if (context.Request.Params["order"] != null)
        {
            order = context.Request.Params["order"].ToString();
        }
        string sort = "";
        if (context.Request.Params["sort"] != null)
        {
            sort = context.Request.Params["sort"].ToString(); 
        }
        if (int.TryParse(context.Request.Params["page"], out page) == false)
        {
            page = 1;
        }
        if (int.TryParse(context.Request.Params["rows"], out rows) == false)
        {
            rows = 10;
        }
        string m_grid_employee_code = "";
        if (context.Request.Params["employee_code"] != null)
        {
            m_grid_employee_code = context.Request.Params["employee_code"];
        }
        string m_grid_employee_innum = "";
        if (context.Request.Params["employee_innum"] != null)
        {
            m_grid_employee_innum = context.Request.Params["employee_innum"];
        }
        string m_grid_employee_Name = "";
        if (context.Request.Params["employee_Name"] != null)
        {
            m_grid_employee_Name = context.Request.Params["employee_Name"];
        }

        string m_grid_employee_sex = "";
        if (context.Request.Params["employee_sex"] != null)
        {
            m_grid_employee_sex = context.Request.Params["employee_sex"];
        }
        string m_grid_idcard_no = "";
        if (context.Request.Params["idcard_no"] != null)
        {
            m_grid_idcard_no = context.Request.Params["idcard_no"];
        }
        string m_grid_city_id = "";
        if (context.Request.Params["city_id"] != null)
        {
            m_grid_city_id = context.Request.Params["city_id"];
        }
        string m_grid_home_address = "";
        if (context.Request.Params["home_address"] != null)
        {
            m_grid_home_address = context.Request.Params["home_address"];
        }
        int m_grid_nation_id = 0;
        if (context.Request.Params["nation_id"] != null)
        {
            if (int.TryParse(context.Request.Params["nation_id"], out m_grid_nation_id) == false)
            {
                m_grid_nation_id = 0;
            }
        }
        int m_grid_visagetype_id = 0;
        if (context.Request.Params["visagetype_id"] != null)
        {
            if (int.TryParse(context.Request.Params["visagetype_id"], out m_grid_visagetype_id) == false)
            {
                m_grid_visagetype_id = 0;
            }
        }
        string m_grid_marital_status = "";
        if (context.Request.Params["marital_status"] != null)
        {
            m_grid_marital_status = context.Request.Params["marital_status"];
        }
        string m_grid_telphone_no = "";
        if (context.Request.Params["telphone_no"] != null)
        {
            m_grid_telphone_no = context.Request.Params["telphone_no"];
        }
        int  m_grid_eductaion_id = 0;
        if (context.Request.Params["eductaion_id"] != null)
        {
            if (int.TryParse(context.Request.Params["eductaion_id"], out m_grid_eductaion_id) == false)
            {
                m_grid_eductaion_id = 0;
            }
        }
        string m_grid_graduate_time = "";
        if (context.Request.Params["graduate_time"] != null)
        {
            m_grid_graduate_time = context.Request.Params["graduate_time"];
        }
        string m_grid_graduate_school = "";
        if (context.Request.Params["graduate_school"] != null)
        {
            m_grid_graduate_school = context.Request.Params["graduate_school"];
        }
        string m_grid_specialty_name = "";
        if (context.Request.Params["specialty_name"] != null)
        {
            m_grid_specialty_name = context.Request.Params["specialty_name"];
        }
        string m_grid_branch_id = "";
        if (context.Request.Params["branch_id"] != null)
        {
            m_grid_branch_id = context.Request.Params["branch_id"].Replace('T', ' ');
        }
        string m_grid_patrolgrade_id = "";
        if (context.Request.Params["patrolgrade_id"] != null)
        {
            m_grid_patrolgrade_id = context.Request.Params["patrolgrade_id"];
        }
        string m_grid_major_code = "";
        if (context.Request.Params["major_code"] != null)
        {
            m_grid_major_code = context.Request.Params["major_code"];
        }
        int mIntCount = BEmployee.GetEmployeeCount(m_grid_employee_Name, m_grid_idcard_no, m_grid_employee_innum, m_grid_telphone_no, m_grid_visagetype_id, m_grid_nation_id, m_grid_marital_status, m_grid_eductaion_id, m_grid_specialty_name);
            //GetEmployeeCount(m_grid_employee_code, m_grid_employee_innum, m_grid_employee_Name, m_grid_employee_sex, m_grid_idcard_no, m_grid_city_id, m_grid_home_address, m_grid_nation_id, m_grid_visagetype_id, m_grid_marital_status, m_grid_telphone_no, m_grid_eductaion_id, m_grid_graduate_time, m_grid_graduate_school, m_grid_specialty_name, m_grid_branch_id, m_grid_major_code, m_grid_patrolgrade_id);
        DataTable dt = BEmployee.GetEmployee(page,rows,m_grid_employee_Name, m_grid_idcard_no, m_grid_employee_innum, m_grid_telphone_no, m_grid_visagetype_id, m_grid_nation_id, m_grid_marital_status, m_grid_eductaion_id, m_grid_specialty_name,sort,order);
            //GetEmployeeData(m_grid_employee_code, m_grid_employee_innum, m_grid_employee_Name, m_grid_employee_sex, m_grid_idcard_no, m_grid_city_id, m_grid_home_address, m_grid_nation_id, m_grid_visagetype_id, m_grid_marital_status, m_grid_telphone_no, m_grid_eductaion_id, m_grid_graduate_time, m_grid_graduate_school, m_grid_specialty_name, m_grid_branch_id, m_grid_major_code, m_grid_patrolgrade_id, sort, order);
        return GJHF.Utility.WEBUI.EasyuiControl.GetGridReturn(mIntCount, dt);
    }
    private string GetEmployeeComboData(HttpContext context)
    {
        int m_combo_branch_id = 0;
        if (context.Request.Params["branch_id"] != null)
        {
            if (int.TryParse(context.Request.Params["branch_id"], out m_combo_branch_id) == false)
            {
                m_combo_branch_id=0;
            }
        }
        if(m_combo_branch_id==0)return GJHF.Utility.WEBUI.EasyuiControl.GetParamFailRetuen();
        return GJHF.Utility.WEBUI.EasyuiControl.GetComboReturn(GetEmployeeComboData(m_combo_branch_id), "employee_code", "employee_name");
        
    }
    
    private int AddEmployeeData(string v_employee_code, string v_employee_innum, string v_employee_Name, string v_employee_sex, string v_idcard_no, int v_city_id, string v_home_address, int v_nation_id, int v_visagetype_id, string v_marital_status, string v_telphone_no, int v_eductaion_id, string v_graduate_time, string v_graduate_school, string v_specialty_name, int v_branch_id, string v_major_code, int v_patrolgrade_id)
    {
        StringBuilder strSql = new StringBuilder();
        strSql.Append("insert into t_Employee(");
        strSql.Append("employee_code,employee_innum,employee_Name,employee_sex,idcard_no,city_id,home_address,nation_id,visagetype_id,marital_status,telphone_no,eductaion_id,graduate_time,graduate_school,specialty_name,branch_id,major_code,patrolgrade_id");
        strSql.Append(") values (");
        strSql.Append("@employee_code,@employee_innum,@employee_Name,@employee_sex,@idcard_no,@city_id,@home_address,@nation_id,@visagetype_id,@marital_status@telphone_no,@eductaion_id,@graduate_time,@graduate_school,@specialty_name,@branch_id,@major_code,@patrolgrade_id");
        strSql.Append(") ");
        SqlParameter[] parameters = {
			             new SqlParameter("@employee_code", SqlDbType.VarChar,30) ,            
                         new SqlParameter("@employee_innum", SqlDbType.VarChar,30) ,            
                         new SqlParameter("@employee_Name", SqlDbType.VarChar,50) ,            
                         new SqlParameter("@employee_sex", SqlDbType.VarChar,4) ,            
                         new SqlParameter("@idcard_no", SqlDbType.VarChar,22) ,            
                         new SqlParameter("@city_id", SqlDbType.Int,4) ,            
                         new SqlParameter("@home_address", SqlDbType.VarChar,200) ,            
                         new SqlParameter("@nation_id", SqlDbType.Int,4) ,            
                         new SqlParameter("@visagetype_id", SqlDbType.Int,4) ,            
                         new SqlParameter("@marital_status", SqlDbType.VarChar,6) ,           
                         new SqlParameter("@telphone_no", SqlDbType.VarChar,20) ,            
                         new SqlParameter("@eductaion_id", SqlDbType.Int,4) ,            
                         new SqlParameter("@graduate_time", SqlDbType.DateTime) ,            
                         new SqlParameter("@graduate_school", SqlDbType.VarChar,100) ,            
                         new SqlParameter("@specialty_name", SqlDbType.VarChar,50) ,            
                         new SqlParameter("@branch_id", SqlDbType.Int,4) ,            
                         new SqlParameter("@major_code", SqlDbType.VarChar,30),      
                         new SqlParameter("@patrolgrade_id",SqlDbType.Int,4)
            };

        parameters[0].Value = v_employee_code;
        parameters[1].Value = v_employee_innum;
        parameters[2].Value = v_employee_Name;
        parameters[3].Value = v_employee_sex;
        parameters[4].Value = v_idcard_no;
        parameters[5].Value = v_city_id;
        parameters[6].Value = v_home_address;
        parameters[7].Value = v_nation_id;
        parameters[8].Value = v_visagetype_id;
        parameters[9].Value = v_marital_status;
        parameters[10].Value = v_telphone_no;
        parameters[11].Value = v_eductaion_id;
        parameters[12].Value = v_graduate_time;
        parameters[13].Value = v_graduate_school;
        parameters[14].Value = v_specialty_name;
        parameters[15].Value = v_branch_id;
        parameters[16].Value = v_major_code;
        parameters[17].Value = v_patrolgrade_id;
        int i = claSqlConnDB.ExecuteNonQuery(claSqlConnDB.gStrConnDefault, CommandType.Text, strSql.ToString(), parameters);
        return i;
    }

    private int EditEmployeeData(string v_employee_code, string v_employee_innum, string v_employee_Name, string v_employee_sex, string v_idcard_no, int v_city_id, string v_home_address, int v_nation_id, int v_visagetype_id, string v_marital_status, string v_telphone_no, int v_eductaion_id, string v_graduate_time, string v_graduate_school, string v_specialty_name, int v_branch_id, string v_major_code, int v_patrolgrade_id)
    {
        StringBuilder strSql = new StringBuilder();
        strSql.Append(" UPDATE t_Employee set");
        strSql.Append(" employee_innum=@employee_innum,");
        strSql.Append(" employee_Name=@employee_Name,");
        strSql.Append(" employee_sex=@employee_sex,");
        strSql.Append(" idcard_no=@idcard_no,");
        strSql.Append(" city_id=@city_id,");
        strSql.Append(" home_address=@home_address,");
        strSql.Append(" nation_id=@nation_id,");
        strSql.Append(" visagetype_id=@visagetype_id,");
        strSql.Append(" marital_status=@marital_status,");
        strSql.Append(" telphone_no=@telphone_no,");
        strSql.Append(" eductaion_id=@eductaion_id,");
        strSql.Append(" graduate_time=@graduate_time,");
        strSql.Append(" graduate_school=@graduate_school,");
        strSql.Append(" specialty_name=@specialty_name,");
        strSql.Append(" branch_id=@branch_id,");
        strSql.Append(" major_code=@major_code,");
        strSql.Append(" patrolgrade_id=@patrolgrade_id");
        strSql.Append(" WHERE employee_code=@employee_code");
        SqlParameter[] parameters = {
	              new SqlParameter("@employee_code", SqlDbType.VarChar,30) ,            
                       new SqlParameter("@employee_innum", SqlDbType.VarChar,30) ,            
                       new SqlParameter("@employee_Name", SqlDbType.VarChar,50) ,           
                       new SqlParameter("@employee_sex", SqlDbType.VarChar,4) ,            
                       new SqlParameter("@idcard_no", SqlDbType.VarChar,22) ,            
                       new SqlParameter("@city_id", SqlDbType.Int,4) ,            
                       new SqlParameter("@home_address", SqlDbType.VarChar,200) ,            
                       new SqlParameter("@nation_id", SqlDbType.Int,4) ,            
                       new SqlParameter("@visagetype_id", SqlDbType.Int,4) ,            
                       new SqlParameter("@marital_status", SqlDbType.VarChar,6) ,            
                       new SqlParameter("@telphone_no", SqlDbType.VarChar,20) ,            
                       new SqlParameter("@eductaion_id", SqlDbType.Int,4) ,            
                       new SqlParameter("@graduate_time", SqlDbType.DateTime) ,            
                       new SqlParameter("@graduate_school", SqlDbType.VarChar,100) ,            
                       new SqlParameter("@specialty_name", SqlDbType.VarChar,50) ,            
                       new SqlParameter("@branch_id", SqlDbType.Int,4) ,            
                       new SqlParameter("@major_code", SqlDbType.VarChar,30),             
                       new SqlParameter("@patrolgrade_id",SqlDbType.Int,4)
            };

        parameters[0].Value = v_employee_code;
        parameters[1].Value = v_employee_innum;
        parameters[2].Value = v_employee_Name;
        parameters[3].Value = v_employee_sex;
        parameters[4].Value = v_idcard_no;
        parameters[5].Value = v_city_id;
        parameters[6].Value = v_home_address;
        parameters[7].Value = v_nation_id;
        parameters[8].Value = v_visagetype_id;
        parameters[9].Value = v_marital_status;
        parameters[10].Value = v_telphone_no;
        parameters[11].Value = v_eductaion_id;
        parameters[12].Value = v_graduate_time;
        parameters[13].Value = v_graduate_school;
        parameters[14].Value = v_specialty_name;
        parameters[15].Value = v_branch_id;
        parameters[16].Value = v_major_code;
        parameters[17].Value = v_patrolgrade_id;
        int i = claSqlConnDB.ExecuteNonQuery(claSqlConnDB.gStrConnDefault, CommandType.Text, strSql.ToString(), parameters);
        return i;
    }
    private int DelEmployeeData(string v_employee_code)
    {
        StringBuilder strSql = new StringBuilder();
        strSql.Append("DELETE FROM t_Employee WHERE ");
        strSql.Append(" employee_code=@employee_code");
        SqlParameter[] parameters = {
			           new SqlParameter("@employee_code", SqlDbType.VarChar,30)             
             
            };

        parameters[0].Value = v_employee_code;
        int i = claSqlConnDB.ExecuteNonQuery(claSqlConnDB.gStrConnDefault, CommandType.Text, strSql.ToString(), parameters);
        return i;
    }
    private employee GetEmployeePropData(string v_employee_code)
    {
        StringBuilder strSql = new StringBuilder();
        strSql.Append(@"SELECT     t_Employee.employee_code, t_Employee.employee_innum, t_Employee.employee_Name, t_Employee.employee_sex, t_Employee.idcard_no, t_Employee.city_id, 
                                      t_Geog.geog_name, t_Employee.home_address, t_Employee.nation_id, t_Nation.nation_name, t_Employee.visagetype_id, t_VisageType.visagetype_name, t_Employee.marital_status, 
                                      t_Employee.phone_no, t_Employee.telphone_no, t_Employee.eductaion_id, t_Education.education_name, t_Employee.graduate_time, t_Employee.graduate_school, t_Employee.specialty_name, 
                                      t_Employee.branch_id, tHRBranchInfo.dVchBranchName AS branch_name, tHRCompany.dIntCompanyID AS company_id, tHRCompany.dVchCompanyName AS company_name,t_Employee.major_code, t_major.major_name,t_Employee.patrolgrade_id, t_PatrolGrade.patrolgrade_name
                            FROM      t_Education RIGHT OUTER JOIN
                                      t_Employee LEFT OUTER JOIN t_major ON t_Employee.major_code = t_major.major_code 
                                                 LEFT OUTER JOIN t_PatrolGrade ON t_Employee.patrolgrade_id = t_PatrolGrade.patrolgrade_id                                
                                                 LEFT OUTER JOIN tHRBranchInfo 
                                                                 LEFT OUTER JOIN tHRCompany ON tHRBranchInfo.dIntCompanyID = tHRCompany.dIntCompanyID 
                                                                 ON t_Employee.branch_id = tHRBranchInfo.dIntBranchID 
                                                 LEFT OUTER JOIN t_Geog ON t_Employee.city_id = t_Geog.geog_id LEFT OUTER JOIN
                                      t_Nation ON t_Employee.nation_id = t_Nation.nation_id LEFT OUTER JOIN
                                      t_VisageType ON t_Employee.visagetype_id = t_VisageType.visagetype_id ON t_Education.education_id = t_Employee.eductaion_id WHERE");
        strSql.Append(" employee_code=@employee_code");
        SqlParameter[] parameters = {
			           new SqlParameter("@employee_code", SqlDbType.VarChar,30)             
             
            };

        parameters[0].Value = v_employee_code;
        employee mEmployee = new employee();
        mEmployee = (employee)claSqlConnDB.GetDetail(claSqlConnDB.gStrConnDefault, strSql.ToString(), "ModelClass.employee", parameters);
        return mEmployee;
    }
    private int GetEmployeeCount(string v_employee_code, string v_employee_innum, string v_employee_Name, string v_employee_sex, string v_idcard_no, string v_city_id, string v_home_address, string v_nation_id, string v_visagetype_id, string v_marital_status, string v_telphone_no, string v_eductaion_id, string v_graduate_time, string v_graduate_school, string v_specialty_name, string v_branch_id, string v_major_code, string v_patrolgrade_id)
    {

        string mStrSQL = @" SELECT count(0)  FROM         t_Education RIGHT OUTER JOIN
                                      t_Employee LEFT OUTER JOIN t_major ON t_Employee.major_code = t_major.major_code 
                                                 LEFT OUTER JOIN t_PatrolGrade ON t_Employee.patrolgrade_id = t_PatrolGrade.patrolgrade_id                                
                                                 LEFT OUTER JOIN tHRBranchInfo 
                                                                 LEFT OUTER JOIN tHRCompany ON tHRBranchInfo.dIntCompanyID = tHRCompany.dIntCompanyID 
                                                                 ON t_Employee.branch_id = tHRBranchInfo.dIntBranchID 
                                                 LEFT OUTER JOIN t_Geog ON t_Employee.city_id = t_Geog.geog_id LEFT OUTER JOIN
                                      t_Nation ON t_Employee.nation_id = t_Nation.nation_id LEFT OUTER JOIN
                                      t_VisageType ON t_Employee.visagetype_id = t_VisageType.visagetype_id ON t_Education.education_id = t_Employee.eductaion_id "
            + GetWhere(v_employee_code, v_employee_innum, v_employee_Name, v_employee_sex, v_idcard_no, v_city_id, v_home_address, v_nation_id, v_visagetype_id, v_marital_status, v_telphone_no, v_eductaion_id, v_graduate_time, v_graduate_school, v_specialty_name, v_branch_id, v_major_code, v_patrolgrade_id);
        int i = claSqlConnDB.GetRecordCount(claSqlConnDB.gStrConnDefault, mStrSQL);
        return i;
    }
    private DataTable GetEmployeeData(string v_employee_code, string v_employee_innum, string v_employee_Name, string v_employee_sex, string v_idcard_no, string v_city_id, string v_home_address, string v_nation_id, string v_visagetype_id, string v_marital_status, string v_telphone_no, string v_eductaion_id, string v_graduate_time, string v_graduate_school, string v_specialty_name, string v_branch_id, string v_major_code, string v_patrolgrade_id, string v_grid_sort, string v_grid_order)
    {
        string lStrSQL = @"SELECT     t_Employee.employee_code, t_Employee.employee_innum, t_Employee.employee_name,  t_Employee.employee_sex, t_Employee.idcard_no, t_Employee.city_id, 
                                      t_Geog.geog_name, t_Employee.home_address, t_Employee.nation_id, t_Nation.nation_name, t_Employee.visagetype_id, t_VisageType.visagetype_name, t_Employee.marital_status, 
                                      t_Employee.telphone_no, t_Employee.eductaion_id, t_Education.education_name, t_Employee.graduate_time, t_Employee.graduate_school, t_Employee.specialty_name, 
                                      t_Employee.branch_id, tHRBranchInfo.dVchBranchName AS branch_name, tHRCompany.dIntCompanyID AS company_id, tHRCompany.dVchCompanyName AS company_name,t_Employee.major_code, t_major.major_name,t_Employee.patrolgrade_id, t_PatrolGrade.patrolgrade_name
                            FROM      t_Education RIGHT OUTER JOIN
                                      t_Employee LEFT OUTER JOIN t_major ON t_Employee.major_code = t_major.major_code 
                                                 LEFT OUTER JOIN t_PatrolGrade ON t_Employee.patrolgrade_id = t_PatrolGrade.patrolgrade_id                                
                                                 LEFT OUTER JOIN tHRBranchInfo 
                                                                 LEFT OUTER JOIN tHRCompany ON tHRBranchInfo.dIntCompanyID = tHRCompany.dIntCompanyID 
                                                                 ON t_Employee.branch_id = tHRBranchInfo.dIntBranchID 
                                                 LEFT OUTER JOIN t_Geog ON t_Employee.city_id = t_Geog.geog_id LEFT OUTER JOIN
                                      t_Nation ON t_Employee.nation_id = t_Nation.nation_id LEFT OUTER JOIN
                                      t_VisageType ON t_Employee.visagetype_id = t_VisageType.visagetype_id ON t_Education.education_id = t_Employee.eductaion_id "
                         + GetWhere(v_employee_code, v_employee_innum, v_employee_Name, v_employee_sex, v_idcard_no, v_city_id, v_home_address, v_nation_id, v_visagetype_id, v_marital_status, v_telphone_no, v_eductaion_id, v_graduate_time, v_graduate_school, v_specialty_name, v_branch_id, v_major_code, v_patrolgrade_id)
                         + GetSort(v_grid_sort, v_grid_order);
        return claSqlConnDB.ExecuteDataset(rows, page, claSqlConnDB.gStrConnDefault, CommandType.Text, lStrSQL).Tables[0];
        //{
        //    for (int i = 0; i < dt.Rows.Count; i++)
        //    {
        //        employee employeeTemp = new employee();
        //        employeeTemp.employee_code = dt.Rows[i][0].ToString();
        //        employeeTemp.employee_innum = dt.Rows[i][1].ToString();
        //        employeeTemp.employee_name = dt.Rows[i][2].ToString();
        //        employeeTemp.employee_sex = dt.Rows[i][3].ToString();
        //        employeeTemp.idcard_no = dt.Rows[i][4].ToString();
        //        employeeTemp.city_id = long.Parse(dt.Rows[i][5].ToString() == "" ? "0" : dt.Rows[i][5].ToString());
        //        employeeTemp.city_name = dt.Rows[i][6].ToString();
        //        employeeTemp.home_address = dt.Rows[i][7].ToString();
        //        employeeTemp.nation_id = int.Parse(dt.Rows[i][8].ToString() == "" ? "0" : dt.Rows[i][8].ToString());
        //        employeeTemp.nation_name = dt.Rows[i][9].ToString();
        //        employeeTemp.visagetype_id = int.Parse(dt.Rows[i][10].ToString() == "" ? "0" : dt.Rows[i][10].ToString());
        //        employeeTemp.visagetype_name = dt.Rows[i][11].ToString();
        //        employeeTemp.marital_status = dt.Rows[i][12].ToString();
        //        employeeTemp.telphone_no = dt.Rows[i][13].ToString();
        //        employeeTemp.education_id = int.Parse(dt.Rows[i][14].ToString() == "" ? "0" : dt.Rows[i][14].ToString());
        //        employeeTemp.education_name = dt.Rows[i][15].ToString();
        //        employeeTemp.graduate_time = "未知";
        //        if (dt.Rows[i][16] != null && dt.Rows[i][16].ToString() != "")
        //        {
        //            if ((DateTime)dt.Rows[i][16] != DateTime.Parse("1900-01-01"))
        //            {
        //                employeeTemp.graduate_time = ((DateTime)dt.Rows[i][16]).ToShortDateString().Replace("/", "-");
        //            }
        //        }
        //        employeeTemp.graduate_school = dt.Rows[i][17].ToString();
        //        employeeTemp.specialty_name = dt.Rows[i][18].ToString();
        //        employeeTemp.branch_id = dt.Rows[i][19].ToString();
        //        employeeTemp.branch_name = dt.Rows[i][20].ToString();
        //        employeeTemp.company_id = dt.Rows[i][21].ToString();
        //        employeeTemp.company_name = dt.Rows[i][22].ToString();
        //        employeeTemp.major_code = dt.Rows[i][23].ToString();
        //        employeeTemp.major_name = dt.Rows[i][24].ToString();
        //        employeeTemp.patrolgrade_id = dt.Rows[i][25].ToString() == "" ? "0" : dt.Rows[i][25].ToString();
        //        employeeTemp.patrolgrade_name = dt.Rows[i][26].ToString();
        //        mLstmployeeGrid.Add(employeeTemp);
        //    }
        //}
        //return mLstmployeeGrid;
    }


    private string GetWhere(string v_employee_code, string v_employee_innum, string v_employee_Name, string v_employee_sex, string v_idcard_no, string v_city_id, string v_home_address, string v_nation_id, string v_visagetype_id, string v_marital_status, string v_telphone_no, string v_eductaion_id, string v_graduate_time, string v_graduate_school, string v_specialty_name, string v_branch_id, string v_major_code, string v_patrolgrade_id)
    {
        string mStrWhere = "";
        if (v_employee_code != "")
        {
            if (mStrWhere != "")
            {
                mStrWhere = mStrWhere + " AND t_Employee.employee_code ='" + v_employee_code + "'";
            }
            else
            {
                mStrWhere = " WHERE t_Employee.employee_code ='" + v_employee_code + "'";
            }
        }
        if (v_employee_innum != "")
        {
            if (mStrWhere != "")
            {
                mStrWhere = mStrWhere + " AND t_Employee.employee_innum like '" + v_employee_innum + "'";
            }
            else
            {
                mStrWhere = " WHERE t_Employee.employee_innum like '" + v_employee_innum + "'";
            }
        }
        if (v_employee_Name != "")
        {
            if (mStrWhere != "")
            {
                mStrWhere = mStrWhere + " AND t_Employee.employee_Name like '" + v_employee_Name + "'";
            }
            else
            {
                mStrWhere = " WHERE t_Employee.employee_Name like '" + v_employee_Name + "'";
            }
        }
        //if (v_birthday_date != "")
        //{
        //    if (mStrWhere != "")
        //    {
        //        mStrWhere = mStrWhere + " AND t_Employee.birthday_date ='" + v_birthday_date + "'";
        //    }
        //    else
        //    {
        //        mStrWhere = " WHERE t_Employee.birthday_date ='" + v_birthday_date + "'";
        //    }
        //}
        if (v_employee_sex != "")
        {
            if (mStrWhere != "")
            {
                mStrWhere = mStrWhere + " AND t_Employee.employee_sex ='" + v_employee_sex + "'";
            }
            else
            {
                mStrWhere = " WHERE t_Employee.employee_sex ='" + v_employee_sex + "'";
            }
        }
        if (v_idcard_no != "")
        {
            if (mStrWhere != "")
            {
                mStrWhere = mStrWhere + " AND t_Employee.idcard_no like '" + v_idcard_no + "'";
            }
            else
            {
                mStrWhere = " WHERE t_Employee.idcard_no like '" + v_idcard_no + "'";
            }
        }
        if (v_city_id != "")
        {
            if (mStrWhere != "")
            {
                mStrWhere = mStrWhere + " AND t_Employee.city_id =" + v_city_id;
            }
            else
            {
                mStrWhere = " WHERE t_Employee.city_id =" + v_city_id;
            }
        }
        if (v_home_address != "")
        {
            if (mStrWhere != "")
            {
                mStrWhere = mStrWhere + " AND t_Employee.home_address like '" + v_home_address + "'";
            }
            else
            {
                mStrWhere = " WHERE t_Employee.home_address like '" + v_home_address + "'";
            }
        }
        if (v_nation_id != "")
        {
            if (mStrWhere != "")
            {
                mStrWhere = mStrWhere + " AND t_Employee.nation_id =" + v_nation_id;
            }
            else
            {
                mStrWhere = " WHERE t_Employee.nation_id =" + v_nation_id;
            }
        }
        if (v_visagetype_id != "")
        {
            if (mStrWhere != "")
            {
                mStrWhere = mStrWhere + " AND t_Employee.visagetype_id =" + v_visagetype_id;
            }
            else
            {
                mStrWhere = " WHERE t_Employee.visagetype_id =" + v_visagetype_id;
            }
        }
        if (v_marital_status != "")
        {
            if (mStrWhere != "")
            {
                mStrWhere = mStrWhere + " AND t_Employee.marital_status ='" + v_marital_status + "'";
            }
            else
            {
                mStrWhere = " WHERE t_Employee.marital_status ='" + v_marital_status + "'";
            }
        }

        if (v_telphone_no != "")
        {
            if (mStrWhere != "")
            {
                mStrWhere = mStrWhere + " AND t_Employee.telphone_no like '" + v_telphone_no + "'";
            }
            else
            {
                mStrWhere = " WHERE t_Employee.telphone_no like '" + v_telphone_no + "'";
            }
        }
        if (v_eductaion_id != "")
        {
            if (mStrWhere != "")
            {
                mStrWhere = mStrWhere + " AND t_Employee.eductaion_id =" + v_eductaion_id;
            }
            else
            {
                mStrWhere = " WHERE t_Employee.eductaion_id =" + v_eductaion_id;
            }
        }
        if (v_graduate_time != "")
        {
            if (mStrWhere != "")
            {
                mStrWhere = mStrWhere + " AND t_Employee.graduate_time ='" + v_graduate_time + "'";
            }
            else
            {
                mStrWhere = " WHERE t_Employee.graduate_time ='" + v_graduate_time + "'";
            }
        }
        if (v_graduate_school != "")
        {
            if (mStrWhere != "")
            {
                mStrWhere = mStrWhere + " AND t_Employee.graduate_school like '" + v_graduate_school + "'";
            }
            else
            {
                mStrWhere = " WHERE t_Employee.graduate_school like '" + v_graduate_school + "'";
            }
        }
        if (v_specialty_name != "")
        {
            if (mStrWhere != "")
            {
                mStrWhere = mStrWhere + " AND t_Employee.specialty_name  like '" + v_specialty_name + "'";
            }
            else
            {
                mStrWhere = " WHERE t_Employee.specialty_name like '" + v_specialty_name + "'";
            }
        }
        if (v_branch_id != "")
        {
            if (mStrWhere != "")
            {
                mStrWhere = mStrWhere + " AND t_Employee.branch_id =" + v_branch_id;
            }
            else
            {
                mStrWhere = " WHERE t_Employee.branch_id =" + v_branch_id;
            }
        }
        if (v_major_code != "")
        {
            if (mStrWhere != "")
            {
                mStrWhere = mStrWhere + " AND t_Employee.major_code  ='" + v_major_code + "'";
            }
            else
            {
                mStrWhere = " WHERE t_Employee.major_code ='" + v_major_code + "'";
            }
        }

        if (v_patrolgrade_id != "")
        {
            if (mStrWhere != "")
            {
                mStrWhere = mStrWhere + " AND t_Employee.patrolgrade_id  =" + v_patrolgrade_id;
            }
            else
            {
                mStrWhere = " WHERE t_Employee.patrolgrade_id =" + v_patrolgrade_id;
            }
        }
        return mStrWhere;
    }
    private string GetSort(string v_grid_sort, string v_grid_order)
    {
        string mStrSort = "";
        if (v_grid_sort != "" && v_grid_sort != null)
        {
            mStrSort = " order by t_Employee." + v_grid_sort;
            if (v_grid_order != "" && v_grid_order != null)
            {
                mStrSort = mStrSort + " " + v_grid_order;
            }
        }
        return mStrSort;
    }
    private DataTable GetEmployeeComboData(int branchID)
    {
        //List<combobox> listCombo = new List<combobox>();
        string mStrSQL = @"SELECT     t_Employee.employee_code, t_Employee.employee_Name
                            FROM         t_Employee 
                            WHERE     t_Employee.branch_id = @branch_id";
        SqlParameter[] parameters = new SqlParameter[]{
            new SqlParameter("@branch_id",SqlDbType.Int ){Value=branchID}
        };
        return claSqlConnDB.ExecuteDataset(claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL,parameters).Tables[0];
        //{
        //    if (dt.Rows.Count > 0)
        //    {
        //        for (int i = 0; i < dt.Rows.Count; i++)
        //        {
        //            combobox comboTemp = new combobox();
        //            comboTemp.id = dt.Rows[i][0].ToString();
        //            comboTemp.text = dt.Rows[i][1].ToString();
        //            listCombo.Add(comboTemp);
        //        }
        //    }
        //}
        //return listCombo;
    }

    private string GetHRTreeData(HttpContext context)
    {
        List<TreeNode> mLstTreeNode = new List<TreeNode>();
        DataTable dt = _Company.GetCompany("", "", "", "", "", "", "");
        for (int i = 0; i < dt.Rows.Count; i++)
        {
            TreeNode mTreeNode = new TreeNode();
            mTreeNode.id = dt.Rows[i][0].ToString();
            mTreeNode.text = dt.Rows[i][1].ToString();
            mTreeNode.attributes = "company";
            if (_Branch.GetBranchCount(int.Parse(dt.Rows[i][0].ToString()), 0, "", "") > 0)
            {
                mTreeNode.state = "closed";
                mTreeNode.children = GetBranchTreeNode(int.Parse(dt.Rows[i][0].ToString()), 0);
            }
            else
            {
                mTreeNode.state = "open"; 
            }
            mLstTreeNode.Add(mTreeNode);
        }
        return JsonConvert.SerializeObject(mLstTreeNode);
    }
    private List<TreeNode> GetBranchTreeNode(int v_company_id, int v_branch_parent)
    {
        List<TreeNode> mLstTreeNode = new List<TreeNode>();
        DataTable dt = _Branch.GetBranch(v_company_id, v_branch_parent, "", "");
        for (int i = 0; i < dt.Rows.Count; i++)
        {
            TreeNode mTreeNode = new TreeNode();
            mTreeNode.id = dt.Rows[i][0].ToString();
            mTreeNode.text = dt.Rows[i][1].ToString();
            mTreeNode.attributes = "branch";
            if (_Branch.GetBranchCount(v_company_id, int.Parse(dt.Rows[i][0].ToString()), "", "") > 0)
            {
                mTreeNode.state = "closed";
                mTreeNode.children = GetBranchTreeNode(v_company_id, int.Parse(dt.Rows[i][0].ToString()));
                List<TreeNode> mLstEmpNode = GetEmployeeTreeData(int.Parse(dt.Rows[i][0].ToString()));
                foreach (TreeNode m in mLstEmpNode)
                {
                    mTreeNode.children.Add(m); 
                }
            }
            else
            {
                if (BEmployee.GetEmployeeCount(int.Parse(dt.Rows[i][0].ToString())) > 0)
                {
                    mTreeNode.state = "closed";
                    mTreeNode.children = GetEmployeeTreeData(int.Parse(dt.Rows[i][0].ToString()));
                }
                else
                {
                    mTreeNode.state = "open";
                }
            }
            mLstTreeNode.Add(mTreeNode);
        }
        return mLstTreeNode;
    }
    private List<TreeNode> GetEmployeeTreeData(int v_branch_id)
    {
        List<TreeNode> mLstTreeNode = new List<TreeNode>();
        DataTable dt = BEmployee.GetEmployee(v_branch_id);
        for (int i = 0; i < dt.Rows.Count; i++)
        {
            TreeNode mTreeNode = new TreeNode();
            mTreeNode.id = dt.Rows[i][0].ToString();
            mTreeNode.text = dt.Rows[i][1].ToString();
            mTreeNode.attributes = "employee";
            mTreeNode.state = "open";
            mLstTreeNode.Add(mTreeNode);
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