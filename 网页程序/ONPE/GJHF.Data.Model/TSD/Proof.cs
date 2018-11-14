using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.ComponentModel;

namespace GJHF.Data.Model.TSD
{
    [DisplayName("审核凭据")]
    public class Proof
    {
        [DisplayName("凭据编号")]
        public string proof_id { get; set; }
        [DisplayName("设备编号")]
        public string equip_code { get; set; }
        [DisplayName("设备值")]
        public string equip_value { get; set; }
        [DisplayName("状态时间")]
        public DateTime value_time { get; set; }
    }
}
