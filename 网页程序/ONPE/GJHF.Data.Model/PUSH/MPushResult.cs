using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace GJHF.Data.Model.PUSH
{
    public class MPushResult
    {
        public string result_id { get; set; }
        public string android_received { get; set; }
        public string ios_apns_sent { get; set; }
        public string ios_apns_received { get; set; }
        public string ios_msg_received { get; set; }
        public string wp_mpns_sent { get; set; }
        public string msg_id { get; set; }


    }
    public class MPushResultDetail
    {
        /// <summary>
        /// 数据编号
        /// </summary>
        public string data_id { get; set; }
        /// <summary>
        /// 消息编号
        /// </summary>
        public string msg_id { get; set; }
        /// <summary>
        /// 推送编号
        /// </summary>
        public string push_id { get; set; }
        /// <summary>
        /// 用户编号
        /// </summary>
        public string employee_code { get; set; }
        /// <summary>
        /// 设备注册编号
        /// </summary>
        public string registration_id { get; set; }
        /// <summary>
        /// 是否推送
        /// </summary>
        public int is_push { get; set; }
        /// <summary>
        /// 是否送达
        /// </summary>
        public int is_receive { get; set; }
        /// <summary>
        /// 是否确认
        /// </summary>
        public int is_confirm { get; set; }
        /// <summary>
        /// 确认时间
        /// </summary>
        public DateTime confirm_time { get; set; }
        /// <summary>
        /// 推送时间
        /// </summary>
        public DateTime push_time { get; set; }
    }
    
}
