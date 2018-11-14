using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace GJHF.Data.Model.TSD
{
    /// <summary>
    /// 审核申请
    /// </summary>
    public class MExamineRequest
    {
        public MRequestForm request_form { get; set; }
        public MExamineForm examine_form { get; set; }
        /// <summary>
        /// 记录状态 1 审核通过 2 审核未通过 -1 申请被撤销 -2 审核被撤销
        /// </summary>
        public int record_status { get; set; }
    }
}
