using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace GJHF.Data.Model.TSD
{
    /// <summary>
    /// 审核凭据
    /// </summary>
    public class MExamineProof
    {
        public string proof_id { get; set; }
        public string equip_code { get; set; }
        public string equip_value { get; set; }
        public DateTime value_time { get; set; }
    }
}
