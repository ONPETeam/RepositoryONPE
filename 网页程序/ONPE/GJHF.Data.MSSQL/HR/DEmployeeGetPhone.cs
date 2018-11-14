using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using System.Data.SqlClient;

namespace GJHF.Data.MSSQL.HR
{
    public class DEmployeeGetPhone:GJHF.Data.Interface.HR.IEmployeeGetPhone
    {
        public Dictionary<string, string> GetEmployeePhoneNoByCode(List<string> v_employee_code)
        {
            Dictionary<string, string> mDicEmployeePhone = new Dictionary<string, string>();
            try
            {
                if (v_employee_code != null && v_employee_code.Count > 0)
                {
                    string mStrEmployees = GJHF.Utility.Convert.ConvertListToString(v_employee_code, ",");
                    if (mStrEmployees.Substring(mStrEmployees.Length - 1) == ",")
                    {
                        mStrEmployees = mStrEmployees.Substring(0, mStrEmployees.Length - 1);
                    }
                    string mStrSQL = @"SELECT t_employee.employee_code,t_employee.telphone_no FROM t_employee WHERE t_employee.employee_code in('" + mStrEmployees.Replace(",", "','") + "')";
                    DataTable dt = null;
                    using (dt = claSqlConnDB.ExecuteDataset(claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL).Tables[0])
                    {
                        for (int i = 0; i < dt.Rows.Count; i++)
                        {
                            mDicEmployeePhone.Add(dt.Rows[i][0].ToString(), dt.Rows[i][1] == null ? "" : dt.Rows[i][1].ToString());
                        }
                    }
                }
            }
            catch (Exception ex)
            {
 
            }
            return mDicEmployeePhone;
        }


        public Dictionary<string, string> GetPhoneByUserGroup(List<string> v_employee_code)
        {
            throw new NotImplementedException();
        }

        public Dictionary<string, string> GetPhoneByUserRole(List<string> v_employee_code)
        {
            throw new NotImplementedException();
        }

        public Dictionary<string, string> GetPhoneByBranchID(List<string> v_employee_code)
        {
            throw new NotImplementedException();
        }

        public Dictionary<string, string> GetPhoneByCompanyID(List<string> v_employee_code)
        {
            throw new NotImplementedException();
        }

        public Dictionary<string, string> GetPhoneByMajorCode(List<string> v_employee_code)
        {
            throw new NotImplementedException();
        }

        public Dictionary<string, string> GetPhoneByPostCode(List<string> v_employee_code)
        {
            throw new NotImplementedException();
        }

        public Dictionary<string, string> GetPhoneByJobCode(List<string> v_employee_code)
        {
            throw new NotImplementedException();
        }
    }
}
