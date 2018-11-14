using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data.SqlClient;
using System.Data;

namespace GJHF.Data.MSSQL.HR
{
    public class DEmployee : Interface.HR.IEmployee
    {
        #region IEmployee 成员

        public int GetEmployeeCount(string v_employee_name, string v_idcard_no, string v_employee_innum, string v_telphone_no, int v_visagetype_id,
            int v_nation_id, string v_marital_status, int v_education_id, string v_specialty_name)
        {
            string mStrSQL = @"SELECT COUNT(0) FROM t_employee " + GetWhere(v_employee_name, v_idcard_no, v_employee_innum, v_telphone_no, v_visagetype_id,
                v_nation_id, v_marital_status, v_education_id, v_specialty_name);
            return claSqlConnDB.GetRecordCount(claSqlConnDB.gStrConnDefault, mStrSQL);
        }

        public int AddNewEmployee(string v_employee_name, string v_user_id, string v_telphone_no, string v_mail_address)
        {
            string mStrEmployee = COMMON.DGlobal.GetIdentityEmployeeCode();
            string mStrSQL = @"INSERT INTO t_employee(employee_code,employee_name,user_id,telphone_no,mail_address) VALUES
                            (@employee_code,@employee_name,@user_id,@telphone_no,@mail_address)";
            SqlParameter[] parameters = new SqlParameter[] { 
                new SqlParameter("@employee_code",SqlDbType.VarChar,30){Value=mStrEmployee},
                new SqlParameter("@employee_name",SqlDbType.VarChar,50){Value=v_employee_name},
                new SqlParameter("@user_id",SqlDbType.VarChar,100){Value=v_user_id},
                new SqlParameter("@telphone_no",SqlDbType.VarChar,20){Value=v_telphone_no},
                new SqlParameter("@mail_address",SqlDbType.VarChar,100){Value=v_mail_address},
            };
            return claSqlConnDB.ExecuteNonQuery(claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL, parameters);
        }

        public int UpdateEmployee(string v_user_id, string v_employee_name, string v_telphone_no, string v_mail_address)
        {
            string mStrSQL = @"UPDATE t_employee SET employee_name=@employee_name,telphone_no=@telphone_no,mail_address=@mail_address
                                WHERE user_id=@user_id";
            SqlParameter[] parameters = new SqlParameter[] { 
                new SqlParameter("@employee_name",SqlDbType.VarChar,50){Value=v_employee_name},
                new SqlParameter("@user_id",SqlDbType.VarChar,100){Value=v_user_id},
                new SqlParameter("@telphone_no",SqlDbType.VarChar,20){Value=v_telphone_no},
                new SqlParameter("@mail_address",SqlDbType.VarChar,100){Value=v_mail_address},
            };
            return claSqlConnDB.ExecuteNonQuery(claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL, parameters);
        }

        public int UpdateEmployee(string v_employee_code, string v_employee_innum, string v_employee_sex, string v_idcard_no,
            long v_city_id, string v_home_address, int v_nation_id, int v_visagetype_id, string v_marital_status, int v_education_id,
            DateTime v_graduate_time, string v_graduate_school, string v_specialty_name)
        {
            string mStrSQL = @"UPDATE t_employee SET  employee_innum=@employee_innum, employee_sex=@employee_sex, idcard_no=@idcard_no, 
            city_id=@city_id, home_address=@home_address, nation_id=@nation_id, visagetype_id=@visagetype_id, marital_status=@marital_status, 
            education_id=@education_id, graduate_time=@graduate_time, graduate_school=@graduate_school, specialty_name=@specialty_name
            WHERE employee_code=@employee_code";
            SqlParameter[] parameters = new SqlParameter[] { 
                new SqlParameter("@employee_code",SqlDbType.VarChar,30){Value=v_employee_code},
                new SqlParameter("@employee_innum",SqlDbType.VarChar,30){Value=v_employee_innum},
                new SqlParameter("@employee_sex",SqlDbType.VarChar,4){Value=v_employee_sex},
                new SqlParameter("@idcard_no",SqlDbType.VarChar,22){Value=v_idcard_no},
                new SqlParameter("@city_id",SqlDbType.Int,4){Value=v_city_id},
                new SqlParameter("@home_address",SqlDbType.VarChar,200){Value=v_home_address},
                new SqlParameter("@nation_id",SqlDbType.Int,4){Value=v_nation_id},
                new SqlParameter("@visagetype_id",SqlDbType.Int,4){Value=v_visagetype_id},
                new SqlParameter("@marital_status",SqlDbType.VarChar,6){Value=v_marital_status},
                new SqlParameter("@education_id",SqlDbType.Int,4){Value=v_education_id},
                new SqlParameter("@graduate_time",SqlDbType.DateTime,20){Value=v_graduate_time},
                new SqlParameter("@graduate_school",SqlDbType.VarChar,100){Value=v_graduate_school},
                new SqlParameter("@specialty_name",SqlDbType.VarChar,50){Value=v_specialty_name},
            };
            return claSqlConnDB.ExecuteNonQuery(claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL, parameters);
        }

        public int SetBranch(string v_employee_code, int v_branch_id)
        {
            string mStrSQL = @"UPDATE t_employee SET branch_id=@branch_id
                            WHERE employee_code=@employee_code";
            SqlParameter[] parameters = new SqlParameter[] { 
                new SqlParameter("@employee_code",SqlDbType.VarChar,30){Value=v_employee_code},
                new SqlParameter("@branch_id",SqlDbType.Int,4){Value=v_branch_id},
            };
            return claSqlConnDB.ExecuteNonQuery(claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL, parameters);
        }

        public int DelEmployee(string v_user_id)
        {
            string mStrSQL = @"DELETE FROM t_employee 
                            WHERE user_id=@user_id";
            SqlParameter[] parameters = new SqlParameter[] { 
                new SqlParameter("@user_id",SqlDbType.VarChar,30){Value=v_user_id},
            };
            return claSqlConnDB.ExecuteNonQuery(claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL, parameters);
        }

        public System.Data.DataTable GetEmployee(int v_page, int v_rows, string v_employee_name, string v_idcard_no, string v_employee_innum, string v_telphone_no, int v_visagetype_id, int v_nation_id, string v_marital_status, int v_education_id, string v_specialty_name, string v_sort, string v_order)
        {
            string mStrSQL = @"SELECT tHRCompany.dIntCompanyID as company_id,tHRCompany.dVchCompanyName as company_name,tHRBranchInfo.dIntBranchID as branch_id,tHRBranchInfo.dVchBranchName as branch_name,t_employee.employee_code,
                                t_employee.employee_innum,t_employee.employee_name,t_employee.telphone_no,t_employee.mail_address,t_employee.employee_sex,t_employee.idcard_no,
                                t_Geog.geog_name as city_name,t_employee.city_id,t_employee.home_address,t_employee.nation_id,t_Nation.nation_name,t_employee.visagetype_id,t_VisageType.visagetype_name,t_employee.marital_status,
                                t_Education.education_id,t_Education.education_name,t_employee.graduate_time,t_employee.graduate_school,t_employee.specialty_name ,t_Employee.major_code, t_major.major_name,t_Employee.patrolgrade_id, t_PatrolGrade.patrolgrade_name
                                FROM t_employee LEFT OUTER JOIN tHRBranchInfo on tHRBranchInfo.dIntBranchID= t_employee.branch_id
                                                                              LEFT OUTER JOIN tHRCompany ON tHRBranchInfo.dIntCompanyID=tHRCompany.dIntCompanyID
                                                LEFT OUTER JOIN t_Geog ON t_Geog.geog_id=t_employee.city_id
                                                LEFT OUTER JOIN t_Nation ON t_Nation.nation_id=t_employee.nation_id
                                                LEFT OUTER JOIN t_VisageType ON t_VisageType.visagetype_id=t_employee.visagetype_id
                                                LEFT OUTER JOIN t_Education ON t_Education.education_id=t_employee.eductaion_id 
                                                LEFT OUTER JOIN t_PatrolGrade ON t_Employee.patrolgrade_id = t_PatrolGrade.patrolgrade_id
                                                LEFT OUTER JOIN t_major ON t_Employee.major_code = t_major.major_code "
                + GetWhere(v_employee_name, v_idcard_no, v_employee_innum, v_telphone_no, v_visagetype_id, v_nation_id, v_marital_status, v_education_id, v_specialty_name)
                + GetOrder(v_sort, v_order);
            return claSqlConnDB.ExecuteDataset(v_rows, v_page, claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL).Tables[0];
        }

        public System.Data.DataTable GetEmployee(string v_employee_name, string v_idcard_no, string v_employee_innum, string v_telphone_no, int v_visagetype_id, int v_nation_id, string v_marital_status, int v_education_id, string v_specialty_name, string v_sort, string v_order)
        {
            string mStrSQL = @"SELECT tHRCompany.dIntCompanyID as company_id,tHRCompany.dVchCompanyName as company_name,tHRBranchInfo.dIntBranchID as branch_id,tHRBranchInfo.dVchBranchName as branch_name,t_employee.employee_code,
                                t_employee.employee_innum,t_employee.employee_name,t_employee.telphone_no,t_employee.mail_address,t_employee.employee_sex,t_employee.idcard_no,
                                t_Geog.geog_name as city_name,t_employee.city_id,t_employee.home_address,t_employee.nation_id,t_Nation.nation_name,t_employee.visagetype_id,t_VisageType.visagetype_name,t_employee.marital_status,
                                t_Education.education_id,t_Education.education_name,t_employee.graduate_time,t_employee.graduate_school,t_employee.specialty_name ,t_Employee.major_code, t_major.major_name,t_Employee.patrolgrade_id, t_PatrolGrade.patrolgrade_name
                                FROM t_employee LEFT OUTER JOIN tHRBranchInfo on tHRBranchInfo.dIntBranchID= t_employee.branch_id
                                                                              LEFT OUTER JOIN tHRCompany ON tHRBranchInfo.dIntCompanyID=tHRCompany.dIntCompanyID
                                                LEFT OUTER JOIN t_Geog ON t_Geog.geog_id=t_employee.city_id
                                                LEFT OUTER JOIN t_Nation ON t_Nation.nation_id=t_employee.nation_id
                                                LEFT OUTER JOIN t_VisageType ON t_VisageType.visagetype_id=t_employee.visagetype_id
                                                LEFT OUTER JOIN t_Education ON t_Education.education_id=t_employee.eductaion_id 
                                                LEFT OUTER JOIN t_PatrolGrade ON t_Employee.patrolgrade_id = t_PatrolGrade.patrolgrade_id
                                                LEFT OUTER JOIN t_major ON t_Employee.major_code = t_major.major_code  "
                + GetWhere(v_employee_name, v_idcard_no, v_employee_innum, v_telphone_no, v_visagetype_id, v_nation_id, v_marital_status, v_education_id, v_specialty_name)
                + GetOrder(v_sort, v_order);
            return claSqlConnDB.ExecuteDataset(claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL).Tables[0];
        }

        public System.Data.DataTable GetEmployee(string v_employee_name, string v_idcard_no, string v_employee_innum, string v_telphone_no, int v_visagetype_id, int v_nation_id, string v_marital_status, int v_education_id, string v_specialty_name)
        {
            string mStrSQL = @"SELECT tHRCompany.dIntCompanyID as company_id,tHRCompany.dVchCompanyName as company_name,tHRBranchInfo.dIntBranchID as branch_id,tHRBranchInfo.dVchBranchName as branch_name,t_employee.employee_code,
                                t_employee.employee_innum,t_employee.employee_name,t_employee.telphone_no,t_employee.mail_address,t_employee.employee_sex,t_employee.idcard_no,
                                t_Geog.geog_name as city_name,t_employee.city_id,t_employee.home_address,t_employee.nation_id,t_Nation.nation_name,t_employee.visagetype_id,t_VisageType.visagetype_name,t_employee.marital_status,
                                t_Education.education_id,t_Education.education_name,t_employee.graduate_time,t_employee.graduate_school,t_employee.specialty_name ,t_Employee.major_code, t_major.major_name,t_Employee.patrolgrade_id, t_PatrolGrade.patrolgrade_name
                                FROM t_employee LEFT OUTER JOIN tHRBranchInfo on tHRBranchInfo.dIntBranchID= t_employee.branch_id
                                                                              LEFT OUTER JOIN tHRCompany ON tHRBranchInfo.dIntCompanyID=tHRCompany.dIntCompanyID
                                                LEFT OUTER JOIN t_Geog ON t_Geog.geog_id=t_employee.city_id
                                                LEFT OUTER JOIN t_Nation ON t_Nation.nation_id=t_employee.nation_id
                                                LEFT OUTER JOIN t_VisageType ON t_VisageType.visagetype_id=t_employee.visagetype_id
                                                LEFT OUTER JOIN t_Education ON t_Education.education_id=t_employee.eductaion_id 
                                                LEFT OUTER JOIN t_PatrolGrade ON t_Employee.patrolgrade_id = t_PatrolGrade.patrolgrade_id
                                                LEFT OUTER JOIN t_major ON t_Employee.major_code = t_major.major_code  "
                + GetWhere(v_employee_name, v_idcard_no, v_employee_innum, v_telphone_no, v_visagetype_id, v_nation_id, v_marital_status, v_education_id, v_specialty_name);
            return claSqlConnDB.ExecuteDataset(claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL).Tables[0];
        }
        public Dictionary<string, object> GetEmployeeByUserID(string vStrUserID)
        {
            string mStrSQL = @"SELECT tHRCompany.dIntCompanyID as company_id,tHRCompany.dVchCompanyName as company_name,tHRBranchInfo.dIntBranchID as branch_id,tHRBranchInfo.dVchBranchName as branch_name,t_employee.employee_code,
                                t_employee.employee_innum,t_employee.employee_name,t_employee.telphone_no,t_employee.mail_address,t_employee.employee_sex,t_employee.idcard_no,
                                t_Geog.geog_name as city_name,t_employee.city_id,t_employee.home_address,t_employee.nation_id,t_Nation.nation_name,t_employee.visagetype_id,t_VisageType.visagetype_name,t_employee.marital_status,
                                t_Education.education_id,t_Education.education_name,t_employee.graduate_time,t_employee.graduate_school,t_employee.specialty_name ,t_Employee.major_code, t_major.major_name,t_Employee.patrolgrade_id, t_PatrolGrade.patrolgrade_name
                                FROM t_employee LEFT OUTER JOIN tHRBranchInfo on tHRBranchInfo.dIntBranchID= t_employee.branch_id
                                                                              LEFT OUTER JOIN tHRCompany ON tHRBranchInfo.dIntCompanyID=tHRCompany.dIntCompanyID
                                                LEFT OUTER JOIN t_Geog ON t_Geog.geog_id=t_employee.city_id
                                                LEFT OUTER JOIN t_Nation ON t_Nation.nation_id=t_employee.nation_id
                                                LEFT OUTER JOIN t_VisageType ON t_VisageType.visagetype_id=t_employee.visagetype_id
                                                LEFT OUTER JOIN t_Education ON t_Education.education_id=t_employee.eductaion_id 
                                                LEFT OUTER JOIN t_PatrolGrade ON t_Employee.patrolgrade_id = t_PatrolGrade.patrolgrade_id
                                                LEFT OUTER JOIN t_major ON t_Employee.major_code = t_major.major_code
                                                WHERE t_employee.user_id=@user_id";
            SqlParameter[] parameters = new SqlParameter[]{
                new SqlParameter("@user_id",SqlDbType.VarChar,100){Value=vStrUserID},
            };
            return GJHF.Utility.Convert.ConvertModelToDictionary((Model.HR.Employee)claSqlConnDB.GetDetail(claSqlConnDB.gStrConnDefault, mStrSQL, "GJHF.Data.Model.HR.Employee", "GJHF.Data.Model", parameters));
        }
        public Dictionary<string, object> GetEmployeeByEmployeeCode(string v_employee_code)
        {
            string mStrSQL = @"SELECT tHRCompany.dIntCompanyID as company_id,tHRCompany.dVchCompanyName as company_name,tHRBranchInfo.dIntBranchID as branch_id,tHRBranchInfo.dVchBranchName as branch_name,t_employee.employee_code,
                                t_employee.employee_innum,t_employee.employee_name,t_employee.telphone_no,t_employee.mail_address,t_employee.employee_sex,t_employee.idcard_no,
                                t_Geog.geog_name as city_name,t_employee.city_id,t_employee.home_address,t_employee.nation_id,t_Nation.nation_name,t_employee.visagetype_id,t_VisageType.visagetype_name,t_employee.marital_status,
                                t_Education.education_id,t_Education.education_name,t_employee.graduate_time,t_employee.graduate_school,t_employee.specialty_name ,t_Employee.major_code, t_major.major_name,t_Employee.patrolgrade_id, t_PatrolGrade.patrolgrade_name
                                FROM t_employee LEFT OUTER JOIN tHRBranchInfo on tHRBranchInfo.dIntBranchID= t_employee.branch_id
                                                                              LEFT OUTER JOIN tHRCompany ON tHRBranchInfo.dIntCompanyID=tHRCompany.dIntCompanyID
                                                LEFT OUTER JOIN t_Geog ON t_Geog.geog_id=t_employee.city_id
                                                LEFT OUTER JOIN t_Nation ON t_Nation.nation_id=t_employee.nation_id
                                                LEFT OUTER JOIN t_VisageType ON t_VisageType.visagetype_id=t_employee.visagetype_id
                                                LEFT OUTER JOIN t_Education ON t_Education.education_id=t_employee.eductaion_id 
                                                LEFT OUTER JOIN t_PatrolGrade ON t_Employee.patrolgrade_id = t_PatrolGrade.patrolgrade_id
                                                LEFT OUTER JOIN t_major ON t_Employee.major_code = t_major.major_code
                                                WHERE t_employee.employee_code=@employee_code";
            SqlParameter[] parameters = new SqlParameter[]{
                new SqlParameter("@employee_code",SqlDbType.VarChar,100){Value=v_employee_code},
            };
            return GJHF.Utility.Convert.ConvertModelToDictionary((Model.HR.Employee)claSqlConnDB.GetDetail(claSqlConnDB.gStrConnDefault, mStrSQL, "GJHF.Data.Model.HR.Employee", "GJHF.Data.Model", parameters));
        }
        public DataTable GetEmployee(int v_branch_id)
        {
            string mStrSQL = @"SELECT  t_employee.employee_code,t_employee.employee_name FROM t_employee WHERE t_employee.branch_id=@branch_id";
            SqlParameter[] parameters = new SqlParameter[]{
                new SqlParameter("@branch_id",SqlDbType.Int){Value=v_branch_id},
            };
            return claSqlConnDB.ExecuteDataset(claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL, parameters).Tables[0];
        }

        public int GetEmployeeCount(int v_branch_id)
        {
            string mStrSQL = @"SELECT  count(0) FROM t_employee WHERE t_employee.branch_id=@branch_id";
            SqlParameter[] parameters = new SqlParameter[]{
                new SqlParameter("@branch_id",SqlDbType.Int){Value=v_branch_id},
            };
            return claSqlConnDB.GetRecordCount(claSqlConnDB.gStrConnDefault, mStrSQL, parameters);
        }

        #endregion

        private string GetWhere(string v_employee_name, string v_idcard_no, string v_employee_innum, string v_telphone_no, int v_visagetype_id, int v_nation_id, string v_marital_status, int v_education_id, string v_specialty_name)
        {
            string mStrWhere = " WHERE 1=1 ";
            if (v_employee_name != "") mStrWhere = mStrWhere + " AND t_employee.employee_name LIKE '%" + v_employee_name + "%' ";
            if (v_idcard_no != "") mStrWhere = mStrWhere + " AND t_employee.idcard_no LIKE '%" + v_idcard_no + "%' ";
            if (v_employee_innum != "") mStrWhere = mStrWhere + " AND t_employee.employee_innum LIKE '%" + v_employee_innum + "%' ";
            if (v_telphone_no != "") mStrWhere = mStrWhere + " AND t_employee.telphone_no LIKE '%" + v_telphone_no + "%' ";
            if (v_visagetype_id != 0) mStrWhere = mStrWhere + " AND t_employee.visagetype_id =" + v_visagetype_id;
            if (v_nation_id != 0) mStrWhere = mStrWhere + " AND t_employee.nation_id =" + v_nation_id;
            if (v_marital_status != "") mStrWhere = mStrWhere + " AND t_employee.nation_id ='" + v_marital_status + "' ";
            if (v_education_id != 0) mStrWhere = mStrWhere + " AND t_employee.education_id =" + v_education_id;
            if (v_specialty_name != "") mStrWhere = mStrWhere + " AND t_employee.specialty_name LIKE '%" + v_specialty_name + "%' ";
            return mStrWhere;
        }
        private string GetOrder(string v_sort, string v_order)
        {
            string mStrOrder = "";
            if (v_sort != "")
            {
                mStrOrder = " ORDER BY t_employee." + v_sort;
                if (v_order != "")
                {
                    mStrOrder = mStrOrder + " " + v_order;
                }
            }
            return mStrOrder;
        }



    }
}
