using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace ModelClass
{
    /// <summary>
    ///Branch 的摘要说明
    /// </summary>
    public class Branch
    {
        public int dIntBranchID { get; set; }
        public string dVchBranchName { get; set; }
        public string dVchBranchPY { get; set; }
        public int dIntUpBranch { get; set; }
        public string dVchUpBranchName { get; set; }
        public int dIntCompanyID { get; set; }
        public string dVchCompanyName { get; set; }
    }
    public class Job
    {
        /// <summary>
        /// 岗位编号
        /// </summary>
        public string job_id { get; set; }
        /// <summary>
        /// 岗位编码
        /// </summary>
        public string job_innum { get; set; }
        /// <summary>
        /// 岗位名称
        /// </summary>
        public string job_name { get; set; }
        /// <summary>
        /// 部门编号
        /// </summary>
        public string job_branch_id { get; set; }
        /// <summary>
        /// 部门名称
        /// </summary>
        public string job_branch_name { get; set; }
        /// <summary>
        /// 公司编号
        /// </summary>
        public string job_company_id { get; set; }
        /// <summary>
        /// 公司名称
        /// </summary>
        public string job_company_name { get; set; }
        /// <summary>
        /// 岗位成立时间
        /// </summary>
        public string job_build { get; set; }
        /// <summary>
        /// 岗位状态
        /// </summary>
        public string job_state { get; set; }
        /// <summary>
        /// 岗位取消时间
        /// </summary>
        public string job_close { get; set; }
        /// <summary>
        /// 岗位取消原因
        /// </summary>
        public string job_close_reason { get; set; }
    }
}