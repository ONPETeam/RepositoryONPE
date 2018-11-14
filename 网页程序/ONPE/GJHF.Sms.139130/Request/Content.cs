using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace GJHF.Sms._139130.Request
{

    /// <summary>
    /// 用户信息
    /// </summary>
    public class Info
    {
        /// <summary>
        /// 应用ID
        /// </summary>
        public string appID 
        {
            get
            {
                return AppSecret.GetAppID;
            }
        }
    }
    /// <summary>
    /// 消息主题
    /// </summary>
    public class Subject
    {
        /// <summary>
        /// 被叫号
        /// </summary>
        public string called { get; set; }
        /// <summary>
        /// 被叫显号
        /// </summary>
        public string calledDisplay { get; set; }
        /// <summary>
        /// 模板ID
        /// </summary>
        public string templateID { get; set; }
        /// <summary>
        /// 模板变量（占位）列表
        /// </summary>
        
        public List<string> Params { get; set; }
        /// <summary>
        /// 播放次数
        /// </summary>
        public int playTimes { get; set; }
        /// <summary>
        /// 单位是毫秒，最小值0，最大值30000毫秒 ，语音重复播放的间隔时间
        /// </summary>
        public int playDelay { get; set; }
    }

    public class Content
    {
        /// <summary>
        /// 用户信息
        /// </summary>
        public Info info { get; set; }
        /// <summary>
        /// 消息主题
        /// </summary>
        public Subject subject { get; set; }
        /// <summary>
        /// 私有数据，回应和通知带回，可被更新
        /// </summary>
        public string data { get; set; }
        /// <summary>
        /// 请求时间戳，毫秒
        /// </summary>
        public string timestamp { get; set; }

    }

    
}
