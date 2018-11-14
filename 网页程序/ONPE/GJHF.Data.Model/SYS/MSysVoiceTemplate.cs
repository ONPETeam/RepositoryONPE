using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace GJHF.Data.Model.SYS
{
    public class MSysVoiceTemplate
    {
        /// <summary>
        /// 模板编号
        /// </summary>
        public string template_id { get; set; }
        /// <summary>
        /// 模板No(即信生成)
        /// </summary>
        public int template_no { get; set; }
        /// <summary>
        /// 模板类型
        /// </summary>
        public int template_type { get; set; }
        /// <summary>
        /// 模板内容
        /// </summary>
        public string template_content { get; set; }
        /// <summary>
        /// 模板名称
        /// </summary>
        public string template_name { get; set; }
        /// <summary>
        /// 模板状态
        /// </summary>
        public int template_state { get; set; }
        /// <summary>
        /// 模板备注
        /// </summary>
        public string template_remark { get; set; }
    }
}
