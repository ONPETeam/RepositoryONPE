using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.ComponentModel;

namespace GJHF.Data.Model.TSD
{
    public class Examine
    {
        [DisplayName("审核编号")]
        public string examine_id { get; set; }
        [DisplayName("申请单编号")]
        public string request_id { get; set; }
        [DisplayName("审核时间")]
        public DateTime examine_time { get; set; }
        [DisplayName("审核人")]
        public string examine_people { get; set; }
        [DisplayName("审核凭据")]
        public string examine_proof { get; set; }
        [DisplayName("审核结果")]
        public int examine_result { get; set; }
        [DisplayName("审核备注")]
        public string examine_remark { get; set; }
    }
}
