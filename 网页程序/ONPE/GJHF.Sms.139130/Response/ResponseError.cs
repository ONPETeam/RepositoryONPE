using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace GJHF.Sms._139130.Response
{
    /// <summary>
    /// 错误响应消息结构
    /// </summary>
    public class ResponseError
    {
        /// <summary>
        /// 结果
        /// </summary>
        public Result result { get; set; }
        /// <summary>
        /// 信息
        /// </summary>
        public Info info { get; set; }
        /// <summary>
        /// 主题
        /// </summary>
        public Subject subject { get; set; }
        /// <summary>
        /// 消息创建时间戳
        /// </summary>
        public string timestamp { get; set; }
    }
}
