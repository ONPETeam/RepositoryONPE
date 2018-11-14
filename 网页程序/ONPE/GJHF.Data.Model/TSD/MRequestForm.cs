using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace GJHF.Data.Model.TSD
{
    /// <summary>
    /// 申请单
    /// </summary>
    public class MRequestForm
    {
        public string request_id { get; set; }
        /// <summary>
        /// 申请单状态 0 正常 -99 已撤销
        /// </summary>
        public int request_status { get; set; }
        public int request_company { get; set; }
        public int request_branch { get; set; }
        public string request_people { get; set; }
        public DateTime request_time { get; set; }
        /// <summary>
        /// 申请单类型 0 停电申请 1 送电申请
        /// </summary>
        public int request_type { get; set; }
        public string stop_equip { get; set; }
        public DateTime stop_time { get; set; }
        public float stop_duration { get; set; }
        public string request_remark { get; set; }
    }
}
