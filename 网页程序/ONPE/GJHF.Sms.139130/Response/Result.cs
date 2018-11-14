using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace GJHF.Sms._139130.Response
{
    /// <summary>
    /// 结果
    /// </summary>
    public class Result
    {
        /// <summary>
        /// 结果，0成功，其他失败
        /// </summary>
        public int code { get; set; }
        /// <summary>
        /// 描述
        /// </summary>
        public string description { get; set; }
    }
    
}
