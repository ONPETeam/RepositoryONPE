using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;

namespace GJHF.Data.Interface.HR
{
    public interface IBranch
    {
        int AddBranch(string v_branch_name, string v_branch_innum, int v_branch_parent, int v_company_id);

        int EditBranch(int v_branch_id, string v_branch_name, string v_branch_innum, int v_branch_parent, int v_company_id);

        int DelBranch(int v_branch_id);

        int GetBranchCount(int v_company_id, int v_branch_parent, string v_branch_name, string v_branch_innum);

        DataTable GetBranch(int v_company_id, int v_branch_parent, string v_branch_name, string v_branch_innum);

        DataTable GetBranch(int v_company_id, int v_branch_parent, string v_branch_name, string v_branch_innum,string v_sort,string v_order);

        DataTable GetBranch(int v_page,int v_rows,int v_company_id, int v_branch_parent, string v_branch_name, string v_branch_innum, string v_sort, string v_order);

        Dictionary<string, object> GetBranchDetail(int v_branch_id);
    }
}
