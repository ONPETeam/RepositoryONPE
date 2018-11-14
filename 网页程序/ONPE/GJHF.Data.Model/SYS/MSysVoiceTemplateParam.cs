using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace GJHF.Data.Model.SYS
{
    public class MSysVoiceTemplateParam
    {
        /// <summary>
        /// 参数编号
        /// </summary>
        public string param_id { get; set; }
        /// <summary>
        /// 参数名称
        /// </summary>
        public string param_name { get; set; }
        /// <summary>
        /// 参数代码
        /// </summary>
        public string param_code { get; set; }
        /// <summary>
        /// 参数类型
        /// </summary>
        public int param_type { get; set; }
        /// <summary>
        /// 参数长度
        /// </summary>
        public int param_length { get; set; }
        /// <summary>
        /// 模板编号
        /// </summary>
        public string template_id { get; set; }
        /// <summary>
        /// 参数说明
        /// </summary>
        public string param_remark { get; set; }
    }
}
