using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;

namespace GJHF.Business.HR
{
    public class Employee
    {
        private GJHF.Data.Interface.HR.IEmployee BIEmployee;
        private GJHF.Data.Interface.User.IUser BIUser;
        public Employee()
        {
            this.BIEmployee = GJHF.Data.Factory.HR.FEmployee.Create();
            this.BIUser = GJHF.Data.Factory.User.FUser.Create();
        }
        public int GetEmployeeCount(string v_employee_name, string v_idcard_no, string v_employee_innum, string v_telphone_no, int v_visagetype_id, int v_nation_id, string v_marital_status, int v_education_id, string v_specialty_name)
        {
            return BIEmployee.GetEmployeeCount(v_employee_name, v_idcard_no, v_employee_innum, v_telphone_no, v_visagetype_id,
               v_nation_id, v_marital_status, v_education_id, v_specialty_name);
        }

        public int AddNewEmployee(string v_employee_name, string v_user_id, string v_telphone_no, string v_mail_address)
        {
            if (BIUser.IsExistUser(v_user_id))
            {
                return UpdateEmployee(v_user_id, v_employee_name, v_telphone_no, v_mail_address);
            }
            if (BIEmployee.AddNewEmployee(v_employee_name, v_user_id, v_telphone_no, v_mail_address) == 1)
            {
                if (BIUser.SetDefaultRightGroup(v_user_id) == 1)
                {
                    return 1;
                }
            }
            return 0;
        }

        public int UpdateEmployee(string v_user_id, string v_employee_name, string v_telphone_no, string v_mail_address)
        {
            return BIEmployee.UpdateEmployee(v_user_id, v_employee_name, v_telphone_no, v_mail_address);
        }

        public int UpdateEmployee(string v_employee_code, string v_employee_innum, string v_employee_sex, string v_idcard_no, long v_city_id, string v_home_address, int v_nation_id, int v_visagetype_id, string v_marital_status, int v_education_id, DateTime v_graduate_time, string v_graduate_school, string v_specialty_name)
        {
            return BIEmployee.UpdateEmployee(v_employee_code, v_employee_innum, v_employee_sex, v_idcard_no, v_city_id, v_home_address, v_nation_id, v_visagetype_id, v_marital_status, v_education_id, v_graduate_time, v_graduate_school, v_specialty_name);
        }

        public int SetBranch(string v_employee_code, int v_branch_id)
        {
            return BIEmployee.SetBranch(v_employee_code, v_branch_id);
        }

        public int DelEmployee(string v_user_id)
        {
            return BIEmployee.DelEmployee(v_user_id);
        }

        public DataTable GetEmployee(int v_page, int v_rows, string v_employee_name, string v_idcard_no, string v_employee_innum, string v_telphone_no, int v_visagetype_id, int v_nation_id, string v_marital_status, int v_education_id, string v_specialty_name, string v_sort, string v_order)
        {
            return BIEmployee.GetEmployee(v_page, v_rows, v_employee_name, v_idcard_no, v_employee_innum, v_telphone_no, v_visagetype_id,
                v_nation_id, v_marital_status, v_education_id, v_specialty_name, v_sort, v_order);
        }

        public DataTable GetEmployee(string v_employee_name, string v_idcard_no, string v_employee_innum, string v_telphone_no, int v_visagetype_id, int v_nation_id, string v_marital_status, int v_education_id, string v_specialty_name, string v_sort, string v_order)
        {
            return BIEmployee.GetEmployee(v_employee_name, v_idcard_no, v_employee_innum, v_telphone_no, v_visagetype_id,
                v_nation_id, v_marital_status, v_education_id, v_specialty_name, v_sort, v_order);
        }

        public DataTable GetEmployee(string v_employee_name, string v_idcard_no, string v_employee_innum, string v_telphone_no, int v_visagetype_id, int v_nation_id, string v_marital_status, int v_education_id, string v_specialty_name)
        {
            return BIEmployee.GetEmployee(v_employee_name, v_idcard_no, v_employee_innum, v_telphone_no, v_visagetype_id,
                 v_nation_id, v_marital_status, v_education_id, v_specialty_name);
        }
        public DataTable GetEmployee(int v_branch_id)
        {
            return BIEmployee.GetEmployee(v_branch_id);
        }

        public int GetEmployeeCount(int v_branch_id)
        {
            return BIEmployee.GetEmployeeCount(v_branch_id);
        }
        public Dictionary<string, object> GetEmployeeByToken(string v_user_id)
        {
            return BIEmployee.GetEmployeeByUserID(v_user_id);
        }
        public Dictionary<string, object> GetEmployeeByEmployeeCode(string v_employee_code)
        {
            return BIEmployee.GetEmployeeByEmployeeCode(v_employee_code);
        }
    }
}
