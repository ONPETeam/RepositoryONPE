using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace GJHF.Data.Model.TSD
{
    /// <summary>
    /// 人工确认单
    /// </summary>
    public class MFlowConfirm
    {
        public string confirm_id { get; set; }
        public string confirm_people { get; set; }
        public DateTime confirm_time { get; set; }
        public string location_info { get; set; }
        public string equip_code { get; set; }
        public int equip_state { get; set; }
        public string confirm_remark { get; set; }
    }
}
