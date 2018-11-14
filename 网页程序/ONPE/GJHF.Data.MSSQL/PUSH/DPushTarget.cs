using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using System.Data.SqlClient;
using GJHF.Data.Interface.PUSH;

namespace GJHF.Data.MSSQL.PUSH
{
    public class DPushTarget:IPushTarget
    {
        #region IPushTarget 成员

        public string GetRegistrationIDByEmployeeCode(string v_employee_code)
        {
            string mStrRegistrationId="";
            string mStrSQL = @"SELECT  top 1    t_UserLoginRecord.equip_sign,t_UserLoginRecord.logout_time
                                FROM         t_EmployeeUser LEFT OUTER JOIN
                                                      t_UserLoginRecord ON t_EmployeeUser.user_code = t_UserLoginRecord.user_code
                                WHERE     (t_EmployeeUser.employee_code = @employee_code) AND (t_UserLoginRecord.equip_type = 2) AND (t_UserLoginRecord.way_type = 2) order by t_UserLoginRecord.record_id desc";
            SqlParameter[] parameters = new SqlParameter[]{
                new SqlParameter("@employee_code",SqlDbType.VarChar,30){Value=v_employee_code}
            };
            DataTable dt = null;
            using (dt = claSqlConnDB.ExecuteDataset(claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL, parameters).Tables[0])
            {
                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    if (dt.Rows[i][1].ToString()=="")
                    {
                        mStrRegistrationId = dt.Rows[i][0].ToString();
                    }
                }
            }
            return mStrRegistrationId;
        }

        public Dictionary<string,string> GetRegistrationIDsByEmployeeCodes(HashSet<string> v_employee_codes)
        {
            Dictionary<string, string> mReturn = new Dictionary<string, string>();
            foreach (string mStrEmployeeCode in v_employee_codes)
            {
                string mStrRegistrationId = GetRegistrationIDByEmployeeCode(mStrEmployeeCode);
                mReturn.Add(mStrEmployeeCode, mStrRegistrationId);
            }
            return mReturn;
        }

        #endregion

    }
}
