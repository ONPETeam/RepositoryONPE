using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace GJHF.Sms._139130.Response
{
    public enum State
    {
        /// <summary>
        /// 呼叫创建
        /// </summary>
        CallCreate,
        /// <summary>
        /// 呼叫振铃
        /// </summary>
        CallProcess,
        /// <summary>
        /// 呼叫应答
        /// </summary>
        CallAnswer,
        /// <summary>
        /// 呼叫结束
        /// </summary>
        CallEnd,
        /// <summary>
        /// 通话详单
        /// </summary>
        Cdr,
        /// <summary>
        /// 按键码推送
        /// </summary>
        IvrDtmf
    }
}
