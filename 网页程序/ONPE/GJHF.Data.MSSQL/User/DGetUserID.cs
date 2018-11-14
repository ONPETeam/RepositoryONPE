using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using System.Data.SqlClient;

namespace GJHF.Data.MSSQL.User
{
    public class DGetUserID:Interface.User.IGetUserID
    {

        #region IGetUserID 成员

        public HashSet<string> GetUserIDByEmployeeCodes(HashSet<string> v_employee_codes)
        {
            HashSet<string> mHashSetUserID = new HashSet<string>();
            string mStrCompanyIDs = "";
            string mStrSQL = @"";
            if (v_employee_codes != null && v_employee_codes.Count > 0)
            {
                mStrCompanyIDs = GJHF.Utility.Convert.ConvertHashSetToString(v_employee_codes, ",");
                if (mStrCompanyIDs.Substring(mStrCompanyIDs.Length - 1) == ",")
                {
                    mStrCompanyIDs = mStrCompanyIDs.Substring(0, mStrCompanyIDs.Length - 1);
                }
                mStrSQL = @"SELECT     t_Employee.user_id
                            FROM         t_Employee 
                      where t_Employee.employee_code in ('" + mStrCompanyIDs.Replace(",", "','") + "')";
                SqlParameter[] parameters = new SqlParameter[]{
                    new SqlParameter("@employee_codes",SqlDbType.VarChar,int.MaxValue){Value=mStrCompanyIDs}
                };
                DataTable dt = null;
                using (dt = claSqlConnDB.ExecuteDataset(claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL, parameters).Tables[0])
                {
                    for (int i = 0; i < dt.Rows.Count; i++)
                    {
                        mHashSetUserID.Add(dt.Rows[i][0].ToString());
                    }
                }
            }
            return mHashSetUserID;
        }

        public HashSet<string> GetUserIDByCompanyID(HashSet<string> v_company_ids)
        {
            HashSet<string> mHashSetUserID = new HashSet<string>();
            string mStrCompanyIDs = "";
            string mStrSQL = @"";
            if (v_company_ids != null && v_company_ids.Count > 0)
            {
                foreach (string mStrCompanyId in v_company_ids)
                {
                    if (mStrCompanyId != "")
                    {
                        mStrCompanyIDs += mStrCompanyId + ",";
                    }
                }
                if (mStrCompanyIDs.Substring(mStrCompanyIDs.Length - 1) == ",")
                {
                    mStrCompanyIDs = mStrCompanyIDs.Substring(0, mStrCompanyIDs.Length - 1);
                }
                mStrSQL = @"SELECT     t_Employee.user_id
                            FROM         t_Employee left OUTER JOIN
                      tHRBranchInfo ON t_Employee.branch_id = tHRBranchInfo.dIntBranchID left OUTER JOIN
                      tHRCompany ON tHRBranchInfo.dIntCompanyID = tHRCompany.dIntCompanyID
                      where tHRCompany.dIntCompanyID in ('" + mStrCompanyIDs.Replace(",", "','") + "')";
                SqlParameter[] parameters = new SqlParameter[]{
                    new SqlParameter("@company_id",SqlDbType.VarChar,int.MaxValue){Value=mStrCompanyIDs}
                };
                DataTable dt = null;
                using (dt = claSqlConnDB.ExecuteDataset(claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL, parameters).Tables[0])
                {
                    for (int i = 0; i < dt.Rows.Count; i++)
                    {
                        mHashSetUserID.Add(dt.Rows[i][0].ToString());
                    }
                }
            }
            return mHashSetUserID;
        }

        public HashSet<string> GetUserIDByBranchID(HashSet<string> v_branch_ids)
        {
            HashSet<string> mHashSetUserID = new HashSet<string>();
            string mStrBranchIDs = "";
            string mStrSQL = @"";
            if (v_branch_ids != null && v_branch_ids.Count > 0)
            {
                foreach (string mStrBranchId in v_branch_ids)
                {
                    if (mStrBranchId != "")
                    {
                        mStrBranchIDs += mStrBranchId + ",";
                    }
                }
                if (mStrBranchIDs.Substring(mStrBranchIDs.Length - 1) == ",")
                {
                    mStrBranchIDs = mStrBranchIDs.Substring(0, mStrBranchIDs.Length - 1);
                }
                mStrSQL = @"SELECT     t_Employee.user_id
                        FROM         t_Employee left OUTER JOIN
                      tHRBranchInfo ON t_Employee.branch_id = tHRBranchInfo.dIntBranchID 
                      where tHRBranchInfo.dIntBranchID in ('" + mStrBranchIDs.Replace(",", "','") + "')";
                SqlParameter[] parameters = new SqlParameter[]{
                    new SqlParameter("@branch_id",SqlDbType.VarChar,int.MaxValue){Value=mStrBranchIDs}
                };
                DataTable dt = null;
                using (dt = claSqlConnDB.ExecuteDataset(claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL, parameters).Tables[0])
                {
                    for (int i = 0; i < dt.Rows.Count; i++)
                    {
                        mHashSetUserID.Add(dt.Rows[i][0].ToString());
                    }
                }
            }
            return mHashSetUserID;
        }

        public HashSet<string> GetUserIDByUserGroup(HashSet<string> v_user_groups)
        {
            HashSet<string> mHashSetUserID = new HashSet<string>();
            string mStrUserGroups = "";
            string mStrSQL = @"";
            if (v_user_groups != null && v_user_groups.Count > 0)
            {
                foreach (string mStrUserGroup in v_user_groups)
                {
                    if (mStrUserGroup != "")
                    {
                        mStrUserGroups += mStrUserGroup + ",";
                    }
                }
                if (mStrUserGroups.Substring(mStrUserGroups.Length - 1) == ",")
                {
                    mStrUserGroups = mStrUserGroups.Substring(0, mStrUserGroups.Length - 1);
                }
                mStrSQL = @"SELECT     t_user_group.user_code FROM t_user_group where t_user_group.group_code in  ('" + mStrUserGroups.Replace(",", "','") + "')";
                SqlParameter[] parameters = new SqlParameter[]{
                    new SqlParameter("@group_code",SqlDbType.VarChar,int.MaxValue){Value=mStrUserGroups}
                };
                DataTable dt = null;
                using (dt = claSqlConnDB.ExecuteDataset(claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL, parameters).Tables[0])
                {
                    for (int i = 0; i < dt.Rows.Count; i++)
                    {
                        mHashSetUserID.Add(dt.Rows[i][0].ToString());
                    }
                }
            }
            return mHashSetUserID;
        }

        public HashSet<string> GetUserIDByUserRole(HashSet<string> v_user_roles)
        {
            HashSet<string> mHashSetUserID = new HashSet<string>();
            string mStrUserRoles = "";
            string mStrSQL = @"";
            if (v_user_roles != null && v_user_roles.Count > 0)
            {
                foreach (string mStrUserRole in v_user_roles)
                {
                    if (mStrUserRole != "")
                    {
                        mStrUserRoles += mStrUserRole + ",";
                    }
                }
                if (mStrUserRoles.Substring(mStrUserRoles.Length - 1) == ",")
                {
                    mStrUserRoles = mStrUserRoles.Substring(0, mStrUserRoles.Length - 1);
                }
                mStrSQL = @"SELECT  t_role_user.role_code
                            FROM    t_role_user 
                            WHERE   t_role_user.role_code in ('" + mStrUserRoles.Replace(",", "','") + "')";
                SqlParameter[] parameters = new SqlParameter[]{
                    new SqlParameter("@role_code",SqlDbType.VarChar,int.MaxValue){Value=mStrUserRoles}
                };
                DataTable dt = null;
                using (dt = claSqlConnDB.ExecuteDataset(claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL, parameters).Tables[0])
                {
                    for (int i = 0; i < dt.Rows.Count; i++)
                    {
                        mHashSetUserID.Add(dt.Rows[i][0].ToString());
                    }
                }
            }
            return mHashSetUserID;
        }

        public HashSet<string> GetUserIDByMajorCode(HashSet<string> v_major_codes)
        {
            HashSet<string> mHashSetUserID = new HashSet<string>();
            string mStrMajorCodes = "";
            string mStrSQL = @"";
            if (v_major_codes != null && v_major_codes.Count > 0)
            {
                foreach (string mStrMajorCode in v_major_codes)
                {
                    if (mStrMajorCode != "")
                    {
                        mStrMajorCodes += mStrMajorCode + ",";
                    }
                }
                if (mStrMajorCodes.Substring(mStrMajorCodes.Length - 1) == ",")
                {
                    mStrMajorCodes = mStrMajorCodes.Substring(0, mStrMajorCodes.Length - 1);
                }
                mStrSQL = @"select t_Employee.user_id from t_Employee  where  t_Employee.major_code in ('" + mStrMajorCodes.Replace(",", "','") + "')";
                SqlParameter[] parameters = new SqlParameter[]{
                    new SqlParameter("@major_code",SqlDbType.VarChar,int.MaxValue){Value=mStrMajorCodes}
                };
                DataTable dt = null;
                using (dt = claSqlConnDB.ExecuteDataset(claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL, parameters).Tables[0])
                {
                    for (int i = 0; i < dt.Rows.Count; i++)
                    {
                        mHashSetUserID.Add(dt.Rows[i][0].ToString());
                    }
                }
            }
            return mHashSetUserID;
        }

        public HashSet<string> GetUserIDByPostCode(HashSet<string> v_post_codes)
        {
            HashSet<string> mHashSetUserID = new HashSet<string>();
            string mStrPostCodes = "";
            if (v_post_codes != null && v_post_codes.Count > 0)
            {
                foreach (string mStrPostCode in v_post_codes)
                {
                    if (mStrPostCode != "")
                    {
                        mStrPostCodes = mStrPostCodes + mStrPostCode + ",";
                    }
                }
                if (mStrPostCodes.Substring(mStrPostCodes.Length - 1) == ",")
                {
                    mStrPostCodes = mStrPostCodes.Substring(0, mStrPostCodes.Length - 1);
                }
            }
            string mStrSQL = @"SELECT t_employee.user_id from t_employee 
                                right outer join t_posttransfer on t_posttransfer.employee_code=t_employee.employee_code  
                                WHERE t_posttransfer.post_code in('" + mStrPostCodes.Replace(",", "','") + "')";
            SqlParameter[] parameters = new SqlParameter[]{
                new SqlParameter("@post_code",SqlDbType.VarChar,int.MaxValue){Value=v_post_codes}
            };
            DataTable dt = null;
            using (dt = claSqlConnDB.ExecuteDataset(claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL, parameters).Tables[0])
            {
                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    mHashSetUserID.Add(dt.Rows[i][0].ToString());
                }
            }
            return mHashSetUserID;
        }

        public HashSet<string> GetUserIDByJobCode(HashSet<string> v_job_codes)
        {
            HashSet<string> mHashSetEmployeeCode = new HashSet<string>();
            string mStrSQL = @"SELECT t_employee.user_id From t_employee right outer join t_jobtransfer on  t_employee.employee_code=t_jobtransfer.employee_code  WHERE t_jobtransfer.job_code in(@job_code)";
            SqlParameter[] parameters = new SqlParameter[]{
                new SqlParameter("@job_code",SqlDbType.VarChar,int.MaxValue){Value=v_job_codes}
            };
            DataTable dt = null;
            using (dt = claSqlConnDB.ExecuteDataset(claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL, parameters).Tables[0])
            {
                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    mHashSetEmployeeCode.Add(dt.Rows[i][0].ToString());
                }
            }
            return mHashSetEmployeeCode;
        }

        public HashSet<string> GetUserIDByBranchJob(Dictionary<string, HashSet<string>> v_branch_job)
        {
            HashSet<string> mHashSetEmployeeCode = new HashSet<string>();

            return mHashSetEmployeeCode;
        }

        public HashSet<string> GetUserIDByBranchMajor(Dictionary<string, HashSet<string>> v_branch_major)
        {
            HashSet<string> mHashSetEmployeeCode = new HashSet<string>();

            return mHashSetEmployeeCode;
        }

        public HashSet<string> GetUserIDByBranchPost(Dictionary<string, HashSet<string>> v_branch_post)
        {
            HashSet<string> mHashSetEmployeeCode = new HashSet<string>();

            return mHashSetEmployeeCode;
        }

        #endregion
    }
}
