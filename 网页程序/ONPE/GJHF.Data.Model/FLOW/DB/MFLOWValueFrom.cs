using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace GJHF.Data.Model.FLOW.DB
{
    /// <summary>
    /// 数据来源
    /// </summary>
    public class MFLOWValueFrom
    {
        public int value_from_id { get; set; }
        public string value_from_name { get; set; }
        public int type_id { get; set; }
        public string analyze_function { get; set; }
        public string return_type { get; set; }
        public string value_from_remark { get; set; }
    }
}
