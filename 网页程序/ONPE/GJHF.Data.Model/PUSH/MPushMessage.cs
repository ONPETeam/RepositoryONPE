using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace GJHF.Data.Model.PUSH
{
    public class MPushMessage
    {
        public int sendno;
        public string msg_id;
    }

    public class MPushMsg
    {
        /// <summary>
        /// 推送编号
        /// </summary>
        public string push_id { get; set; }
        /// <summary>
        /// 数据时间
        /// </summary>
        public DateTime push_time { get; set; }
        /// <summary>
        /// 数据内容
        /// </summary>
        public string message_content { get; set; }
        /// <summary>
        /// 附加参数
        /// </summary>
        public string message_extras { get; set; }
        /// <summary>
        /// 接收者
        /// </summary>
        public string employee_codes { get; set; }
        /// <summary>
        /// 推送序号（随机整数）
        /// </summary>
        public int send_no { get; set; }
        /// <summary>
        /// 消息编号（极光生成）
        /// </summary>
        public string msg_id { get; set; }
        /// <summary>
        /// 员工号与设备注册编号
        /// </summary>
        public string employee_registration { get; set; }
        /// <summary>
        /// 无设备注册编号员工信息
        /// </summary>
        public string no_registration { get; set; }
        /// <summary>
        /// 推送状态 0	未推送|1	推送成功|2	推送失败
        /// </summary>
        public int is_push { get; set; }
        /// <summary>
        /// 推送结果
        /// </summary>
        public string result_id { get; set; }
        /// <summary>
        /// 最后查询时间
        /// </summary>
        public DateTime query_time { get; set; }
    }
}
