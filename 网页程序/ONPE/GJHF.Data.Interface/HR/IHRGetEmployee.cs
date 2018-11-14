using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace GJHF.Data.Interface.HR
{
    public interface IHRGetEmployee
    {
        HashSet<string> GetEmployeeByCompanyID(HashSet<string> v_company_ids);

        HashSet<string> GetEmployeeByBranchID(HashSet<string> v_branch_ids);

        HashSet<string> GetEmployeeByUserGroup(HashSet<string> v_user_groups);

        HashSet<string> GetEmployeeByUserRole(HashSet<string> v_user_roles);

        HashSet<string> GetEmployeeByMajorCode(HashSet<string> v_major_codes);

        HashSet<string> GetEmployeeByPostCode(HashSet<string> v_post_codes);

        HashSet<string> GetEmployeeByJobCode(HashSet<string> v_job_codes);

        HashSet<string> GetEmployeeByBranchJob(Dictionary<string, HashSet<string>> v_branch_job);

        HashSet<string> GetEmployeeByBranchMajor(Dictionary<string, HashSet<string>> v_branch_major);

        HashSet<string> GetEmployeeByBranchPost(Dictionary<string, HashSet<string>> v_branch_post);
    }
}
