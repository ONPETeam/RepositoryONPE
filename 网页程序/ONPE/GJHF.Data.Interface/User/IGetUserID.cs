using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace GJHF.Data.Interface.User
{
    public interface IGetUserID
    {
        HashSet<string> GetUserIDByEmployeeCodes(HashSet<string> v_employee_codes);

        HashSet<string> GetUserIDByCompanyID(HashSet<string> v_company_ids);

        HashSet<string> GetUserIDByBranchID(HashSet<string> v_branch_ids);

        HashSet<string> GetUserIDByUserGroup(HashSet<string> v_user_groups);

        HashSet<string> GetUserIDByUserRole(HashSet<string> v_user_roles);

        HashSet<string> GetUserIDByMajorCode(HashSet<string> v_major_codes);

        HashSet<string> GetUserIDByPostCode(HashSet<string> v_post_codes);

        HashSet<string> GetUserIDByJobCode(HashSet<string> v_job_codes);

        HashSet<string> GetUserIDByBranchJob(Dictionary<string, HashSet<string>> v_branch_job);

        HashSet<string> GetUserIDByBranchMajor(Dictionary<string, HashSet<string>> v_branch_major);

        HashSet<string> GetUserIDByBranchPost(Dictionary<string, HashSet<string>> v_branch_post);
    }
}
