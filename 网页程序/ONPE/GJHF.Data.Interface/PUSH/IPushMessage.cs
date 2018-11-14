using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace GJHF.Data.Interface.PUSH
{
    public interface IPushMessage
    {
        /// <summary>
        /// 获取新的消息编号
        /// </summary>
        /// <returns></returns>
        int GetNewSendNO();

        /// <summary>
        /// 推送之前保存推送消息
        /// </summary>
        /// <param name="v_push_type">推送类型</param>
        /// <param name="v_push_key">推送类型关键字</param>
        /// <param name="v_message_content">推送消息内容</param>
        /// <param name="v_message_extras">推送消息扩展参数</param>
        /// <param name="v_employee_codes">推送目标</param>
        /// <returns></returns>
        string SavePushMessage(int v_push_type, string v_push_key, string v_message_content, string v_message_extras, HashSet<string> v_employee_codes);

        string GetRegistrationIDsByPushID(string v_push_id);

        /// <summary>
        /// 获取是否推送
        /// </summary>
        /// <param name="v_push_id">推送编号</param>
        /// <returns></returns>
        GJHF.Data.Model.PUSH.MPushMsg GetPushMessageDetailByPushID(string v_push_id);


        int UpdateQueryTime(string v_push_id, DateTime v_query_time);
    }
}
