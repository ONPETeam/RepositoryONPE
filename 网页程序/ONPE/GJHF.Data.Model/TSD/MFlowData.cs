using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace GJHF.Data.Model.TSD
{
    /// <summary>
    /// 停送电流程
    /// </summary>
    public class MFlowData
    {
        public string flow_id { get; set; }
        public string equip_code { get; set; }
        /// <summary>
        /// 流程状态 -99 已撤销,0 申请中/可继续添加,1 已人工确认未停电/可继续添加,2 已停电/可继续添加,3 已送电/不可添加,4 已归档/不可添加
        /// </summary>
        public int flow_status { get; set; }
        public string confirmoff_id { get; set; }
        public DateTime off_time { get; set; }
        public int offrun_branch { get; set; }
        public string offrun_employee { get; set; }
        public string confirmon_id { get; set; }
        public DateTime on_time { get; set; }
        public int onrun_branch { get; set; }
        public string onrun_employee { get; set; }
        public float off_timespan { get; set; }
    }
}
