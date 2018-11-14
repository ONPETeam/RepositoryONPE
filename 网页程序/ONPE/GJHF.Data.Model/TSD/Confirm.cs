using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.ComponentModel;

namespace GJHF.Data.Model.TSD
{
    [DisplayName("人工确认")]
    public class Confirm
    {
        [DisplayName("确认编号")]
        public string confirm_code { get; set; }
        [DisplayName("确认人")]
        public string confirm_people { get; set; }
        [DisplayName("确认时间")]
        public DateTime confirm_time { get; set; }
        [DisplayName("坐标")]
        public string location_info { get; set; }
        [DisplayName("设备编号")]
        public string equip_code { get; set; }
        [DisplayName("设备状态")]
        public int equip_state { get; set; }
        [DisplayName("附加信息")]
        public string confirm_remark { get; set; }
    }
}
