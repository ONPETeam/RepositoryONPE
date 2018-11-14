using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace GJHF.Data.Model.FLOW.TYPE
{
    /// <summary>
    /// 流程分类
    /// </summary>
    public class MFLOWFlowType
    {
        /// <summary>
        /// 流程分类编号
        /// </summary>
        public int type_id { get; set; }
        /// <summary>
        /// 分类名称
        /// </summary>
        public string type_name { get; set; }
        /// <summary>
        /// 分类排序号
        /// </summary>
        public int type_order { get; set; }
        /// <summary>
        /// 上级分类编号
        /// </summary>
        public int type_parent { get; set; }
    }
}
