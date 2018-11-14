using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace GJHF.Data.Model.TSD
{
    public class MVerificationRequest
    {
        /// <summary>
        /// 停电申请单
        /// </summary>
        public MRequestForm poweroff_request { get; set; }
        /// <summary>
        /// 送电申请单
        /// </summary>
        public MRequestForm poweron_request { get; set; }
        /// <summary>
        /// 记录状态 0 正常
        /// </summary>
        public int record_status { get; set; }
    }
}
