using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;

namespace GJHF.Business.HR
{
    public class Branch
    {
        private Data.Interface.HR.IBranch BBranch;
        public Branch() {
            this.BBranch = Data.Factory.HR.FBranch.Create();
        }
        public int AddBranch(string v_branch_name, string v_branch_innum, int v_branch_parent, int v_company_id)
        {
            return BBranch.AddBranch(v_branch_name, v_branch_innum, v_branch_parent, v_company_id);
        }

        public int EditBranch(int v_branch_id, string v_branch_name, string v_branch_innum, int v_branch_parent, int v_company_id)
        {
            return BBranch.EditBranch(v_branch_id, v_branch_name, v_branch_innum, v_branch_parent, v_company_id);
        }

        public int DelBranch(int v_branch_id)
        {
            return BBranch.DelBranch(v_branch_id);
        }

        public int GetBranchCount(int v_company_id, int v_branch_parent, string v_branch_name, string v_branch_innum)
        {
            return BBranch.GetBranchCount(v_company_id, v_branch_parent, v_branch_name, v_branch_innum);
        }

        public DataTable GetBranch(int v_company_id, int v_branch_parent, string v_branch_name, string v_branch_innum)
        {
            return BBranch.GetBranch(v_company_id, v_branch_parent, v_branch_name, v_branch_innum);
        }

        public DataTable GetBranch(int v_company_id, int v_branch_parent, string v_branch_name, string v_branch_innum, string v_sort, string v_order)
        {
            return BBranch.GetBranch(v_company_id, v_branch_parent, v_branch_name, v_branch_innum, v_sort, v_order);
        }

        public DataTable GetBranch(int v_page, int v_rows, int v_company_id, int v_branch_parent, string v_branch_name, string v_branch_innum, string v_sort, string v_order)
        {
            return BBranch.GetBranch(v_page, v_rows, v_company_id, v_branch_parent, v_branch_name, v_branch_innum, v_sort, v_order);
        }
        public Dictionary<string, object> GetBranchDetail(int v_branch_id)
        {
            return BBranch.GetBranchDetail(v_branch_id);
        }
    }
}
