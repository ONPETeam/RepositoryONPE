using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace GJHF.Data.Model.FLOW.DB
{
    /// <summary>
    /// 数据来源类型
    /// </summary>
    public class MFLOWValueType
    {
        /// <summary>
        /// 类型编号
        /// </summary>
        public int type_id { get; set; }
        /// <summary>
        /// 类型名称
        /// </summary>
        public string type_name { get; set; }
        /// <summary>
        /// 备注说明
        /// </summary>
        public string type_remark { get; set; }
    }
}
