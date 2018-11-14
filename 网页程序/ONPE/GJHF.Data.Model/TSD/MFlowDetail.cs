using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace GJHF.Data.Model.TSD
{
    /// <summary>
    /// 流程详情
    /// </summary>
    public class MFlowDetail
    {
        public MFlowData flow_data { get; set; }
        public MRequestForm poweroff_request { get; set; }
        /// <summary>
        /// 详情状态
        /// </summary>
        public int detail_status { get; set; }
    }
}
