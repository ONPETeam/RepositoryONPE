using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using System.Data.SqlClient;
using GJHF.Data.Interface.HR;

namespace GJHF.Data.MSSQL.HR
{
    public class DHRGetEmployeeCode:IHRGetEmployee
    {
        #region IHRGetEmployeeCode 成员

        /// <summary>
        /// 获取公司下所有员工编号
        /// </summary>
        /// <param name="v_company_ids"></param>
        /// <returns></returns>
        public HashSet<string> GetEmployeeByCompanyID(HashSet<string> v_company_ids)
        {
            HashSet<string> mHashSetEmployeeCode = new HashSet<string>();
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
                mStrSQL = @"SELECT     t_Employee.employee_code
                            FROM         t_Employee left OUTER JOIN
                      tHRBranchInfo ON t_Employee.branch_id = tHRBranchInfo.dIntBranchID left OUTER JOIN
                      tHRCompany ON tHRBranchInfo.dIntCompanyID = tHRCompany.dIntCompanyID
                      where tHRCompany.dIntCompanyID in (@company_id)";
                SqlParameter[] parameters = new SqlParameter[]{
                    new SqlParameter("@company_id",SqlDbType.VarChar,int.MaxValue){Value=mStrCompanyIDs}
                };
                DataTable dt = null;
                using (dt = claSqlConnDB.ExecuteDataset(claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL, parameters).Tables[0])
                {
                    for (int i = 0; i < dt.Rows.Count; i++)
                    {
                        mHashSetEmployeeCode.Add(dt.Rows[i][0].ToString());
                    }
                }
            }
            return mHashSetEmployeeCode;
        }

        /// <summary>
        /// 获取部门下所有员工编号
        /// </summary>
        /// <param name="v_branch_ids"></param>
        /// <returns></returns>
        public HashSet<string> GetEmployeeByBranchID(HashSet<string> v_branch_ids)
        {
            HashSet<string> mHashSetEmployeeCode = new HashSet<string>();
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
                mStrSQL = @"SELECT     t_Employee.employee_code
                        FROM         t_Employee left OUTER JOIN
                      tHRBranchInfo ON t_Employee.branch_id = tHRBranchInfo.dIntBranchID 
                      where tHRBranchInfo.dIntBranchID in (@branch_id)";
                SqlParameter[] parameters = new SqlParameter[]{
                    new SqlParameter("@branch_id",SqlDbType.VarChar,int.MaxValue){Value=mStrBranchIDs}
                };
                DataTable dt = null;
                using (dt = claSqlConnDB.ExecuteDataset(claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL, parameters).Tables[0])
                {
                    for (int i = 0; i < dt.Rows.Count; i++)
                    {
                        mHashSetEmployeeCode.Add(dt.Rows[i][0].ToString());
                    }
                }
            }
            return mHashSetEmployeeCode;
        }

        /// <summary>
        /// 获取某个用户组下所有员工编号
        /// </summary>
        /// <param name="v_group_code"></param>
        /// <returns></returns>
        public HashSet<string> GetEmployeeByUserGroup(HashSet<string> v_group_code)
        {
            HashSet<string> mHashSetEmployeeCode = new HashSet<string>();
            string mStrUserGroups = "";
            string mStrSQL = @"";
            if (v_group_code != null && v_group_code.Count > 0)
            {
                foreach (string mStrUserGroup in v_group_code)
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
                mStrSQL = @"SELECT     t_EmployeeUser.employee_code
                        FROM  t_user_group  RIGHT OUTER JOIN
                      t_EmployeeUser ON t_user_group.user_code = t_EmployeeUser.user_code where t_user_group.group_code in  (@group_code)";
                SqlParameter[] parameters = new SqlParameter[]{
                    new SqlParameter("@group_code",SqlDbType.VarChar,int.MaxValue){Value=mStrUserGroups}
                };
                DataTable dt = null;
                using (dt = claSqlConnDB.ExecuteDataset(claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL, parameters).Tables[0])
                {
                    for (int i = 0; i < dt.Rows.Count; i++)
                    {
                        mHashSetEmployeeCode.Add(dt.Rows[i][0].ToString());
                    }
                }
            }
            return mHashSetEmployeeCode;
        }

        /// <summary>
        /// 获取某个角色组下所有员工编号
        /// </summary>
        /// <param name="v_role_code"></param>
        /// <returns></returns>
        public HashSet<string> GetEmployeeByUserRole(HashSet<string> v_role_code)
        {
            HashSet<string> mHashSetEmployeeCode = new HashSet<string>();
            string mStrUserRoles = "";
            string mStrSQL = @"";
            if (v_role_code != null && v_role_code.Count > 0)
            {
                foreach (string mStrUserRole in v_role_code)
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
                mStrSQL = @"SELECT     t_EmployeeUser.employee_code
                            FROM         t_EmployeeUser INNER JOIN
                                                  t_role_user ON t_EmployeeUser.user_code = t_role_user.user_code
                            WHERE     (t_role_user.role_code in (@role_code))";
                SqlParameter[] parameters = new SqlParameter[]{
                    new SqlParameter("@role_code",SqlDbType.VarChar,int.MaxValue){Value=mStrUserRoles}
                };
                DataTable dt = null;
                using (dt = claSqlConnDB.ExecuteDataset(claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL, parameters).Tables[0])
                {
                    for (int i = 0; i < dt.Rows.Count; i++)
                    {
                        mHashSetEmployeeCode.Add(dt.Rows[i][0].ToString());
                    }
                }
            }
            return mHashSetEmployeeCode;
        }

        /// <summary>
        /// 获取点巡检专业下所有员工编号
        /// </summary>
        /// <param name="v_major_codes"></param>
        /// <returns></returns>
        public HashSet<string> GetEmployeeByMajorCode(HashSet<string> v_major_codes)
        {
            HashSet<string> mHashSetEmployeeCode = new HashSet<string>();
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
                mStrSQL = @"select t_Employee.employee_code from t_Employee  where  t_Employee.major_code in (@major_code))";
                SqlParameter[] parameters = new SqlParameter[]{
                    new SqlParameter("@major_code",SqlDbType.VarChar,int.MaxValue){Value=mStrMajorCodes}
                };
                DataTable dt = null;
                using (dt = claSqlConnDB.ExecuteDataset(claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL, parameters).Tables[0])
                {
                    for (int i = 0; i < dt.Rows.Count; i++)
                    {
                        mHashSetEmployeeCode.Add(dt.Rows[i][0].ToString());
                    }
                }
            }
            return mHashSetEmployeeCode;
        }

        /// <summary>
        /// 获取某个职务下所有员工编号
        /// </summary>
        /// <param name="v_post_codes"></param>
        /// <returns></returns>
        public HashSet<string> GetEmployeeByPostCode(HashSet<string> v_post_codes)
        {
            HashSet<string> mHashSetEmployeeCode = new HashSet<string>();
            string mStrSQL = @"SELECT t_posttransfer.employee_code FROM t_posttransfer WHERE t_posttransfer.post_code in(@post_code)";
            SqlParameter[] parameters = new SqlParameter[]{
                new SqlParameter("@post_code",SqlDbType.VarChar,int.MaxValue){Value=v_post_codes}
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

        /// <summary>
        /// 获取某个岗位下所有员工编号
        /// </summary>
        /// <param name="v_job_codes"></param>
        /// <returns></returns>
        public HashSet<string> GetEmployeeByJobCode(HashSet<string> v_job_codes)
        {
            HashSet<string> mHashSetEmployeeCode = new HashSet<string>();
            string mStrSQL = @"SELECT t_jobtransfer.employee_code FROM t_jobtransfer WHERE t_jobtransfer.job_code in(@job_code)";
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

        /// <summary>
        /// 获取某个部门中某个岗位下所有员工编号
        /// </summary>
        /// <param name="v_branch_job"></param>
        /// <returns></returns>
        public HashSet<string> GetEmployeeByBranchJob(Dictionary<string, HashSet<string>> v_branch_job)
        {
            HashSet<string> mHashSetEmployeeCode = new HashSet<string>();

            return mHashSetEmployeeCode;
        }

        /// <summary>
        /// 获取某个部门中某个点巡检专业下所有员工编号
        /// </summary>
        /// <param name="v_branch_major"></param>
        /// <returns></returns>
        public HashSet<string> GetEmployeeByBranchMajor(Dictionary<string, HashSet<string>> v_branch_major)
        {
            HashSet<string> mHashSetEmployeeCode = new HashSet<string>();

            return mHashSetEmployeeCode;
        }

        /// <summary>
        /// 获取某个部门中某个职务下所有员工编号
        /// </summary>
        /// <param name="v_branch_post"></param>
        /// <returns></returns>
        public HashSet<string> GetEmployeeByBranchPost(Dictionary<string, HashSet<string>> v_branch_post)
        {
            HashSet<string> mHashSetEmployeeCode = new HashSet<string>();

            return mHashSetEmployeeCode;
        }

        #endregion
    }
}
