using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace GJHF.Sms._139130.Response
{
    /// <summary>
    /// 请求回应消息体定义
    /// </summary>
    public class ResponseContent
    {
        /// <summary>
        /// 结果
        /// </summary>
        public Result result { get; set; }
        /// <summary>
        /// 共用信息
        /// </summary>
        public Info info { get; set; }
        /// <summary>
        /// 消息主题
        /// </summary>
        public Subject subject { get; set; }
        /// <summary>
        /// 私有数据
        /// </summary>
        public string data { get; set; }
        /// <summary>
        /// 回应时间戳
        /// </summary>
        public string timestamp { get; set; }
    }
}
