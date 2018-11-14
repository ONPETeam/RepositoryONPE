using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace GJHF.Data.Model.TSD
{
    /// <summary>
    /// 审核单
    /// </summary>
    public class MExamineForm
    {
        public string examine_id { get; set; }
        /// <summary>
        /// 审核单状态 -99 已撤销 0 正常
        /// </summary>
        public int examine_status { get; set; }
        public DateTime examine_time { get; set; }
        public string examine_people { get; set; }
        public MExamineProof examine_proof { get; set; }
        /// <summary>
        /// 审核结果 0 未通过 1 已通过
        /// </summary>
        public int examine_result { get; set; }
        public string examine_remark { get; set; }
    }
}
