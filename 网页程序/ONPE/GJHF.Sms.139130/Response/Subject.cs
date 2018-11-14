using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace GJHF.Sms._139130.Response
{
    public class Subject
    {
        /// <summary>
        /// 主叫号
        /// </summary>
        public string caller { get; set; }
        /// <summary>
        /// 被叫号
        /// </summary>
        public string called { get; set; }
        /// <summary>
        /// 业务类型
        /// </summary>
        public int business { get; set; }
        /// <summary>
        /// 挂断原因
        /// </summary>
        public int cause { get; set; }
        /// <summary>
        /// 挂断方向
        /// </summary>
        public string disposition { get; set; }
        /// <summary>
        /// 使用tts次数
        /// </summary>
        public int ttsCount { get; set; }
        /// <summary>
        /// 总tts长度
        /// </summary>
        public int ttsLength { get; set; }
        /// <summary>
        /// Ivr播放次数
        /// </summary>
        public int ivrCount { get; set; }
        /// <summary>
        /// Ivr播放总时长
        /// </summary>
        public int ivrTime { get; set; }
        /// <summary>
        /// 总通话时长，包含ivr时间
        /// </summary>
        public int duration { get; set; }
        /// <summary>
        /// 总费用
        /// </summary>
        public float cost { get; set; }
        /// <summary>
        /// 录音文件名
        /// </summary>
        public string recordFilename { get; set; }
        /// <summary>
        /// 录音大小
        /// </summary>
        public int recordSize { get; set; }
        /// <summary>
        /// 通话创建时间
        /// </summary>
        public string createTime { get; set; }
        /// <summary>
        /// 通话开始时间
        /// </summary>
        public string answerTime { get; set; }
        /// <summary>
        /// 通话结束时间
        /// </summary>
        public string releaseTime { get; set; }
        /// <summary>
        /// 按键码
        /// </summary>
        public int dtmf { get; set; }
        /// <summary>
        /// 呼叫逻辑呼入呼出方向，0呼入，1呼出
        /// </summary>
        public int direction { get; set; }
        /// <summary>
        /// 呼叫实际呼入呼出方向，0呼入，1呼出
        /// </summary>
        public int callout { get; set; }
        /// <summary>
        /// 号码
        /// </summary>
        public string number { get; set; }
        /// <summary>
        /// 按键码
        /// </summary>
        public string dtmfCode { get; set; }
    }
}
