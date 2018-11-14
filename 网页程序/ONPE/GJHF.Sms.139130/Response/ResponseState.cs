using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace GJHF.Sms._139130.Response
{
    /// <summary>
    /// 状态通知结构体
    /// </summary>
    public class ResponseState
    {
        /// <summary>
        /// 通知名称
        /// </summary>
        public string notify { get; set; }
        /// <summary>
        /// 共用信息
        /// </summary>
        public Info info { get; set; }
        /// <summary>
        /// 消息主题
        /// </summary>
        public Subject subject { get; set; }
        /// <summary>
        /// 透传数据
        /// </summary>
        public string data { get; set; }
        /// <summary>
        /// 事件产生时间戳
        /// </summary>
        public string timestamp { get; set; }
    }
}
