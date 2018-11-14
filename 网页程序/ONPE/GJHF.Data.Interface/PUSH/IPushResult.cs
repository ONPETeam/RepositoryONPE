using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using GJHF.Data.Model.PUSH;
using System.Data;

namespace GJHF.Data.Interface.PUSH
{
    public interface IPushResult
    {
        /// <summary>
        /// 保存推送信息
        /// </summary>
        /// <param name="v_record_type">推送类型</param>
        /// <param name="v_record_key">推送类型关键字</param>
        /// <param name="v_push_id">推送记录编号</param>
        /// <param name="v_send_no">序列号（随机整数）</param>
        /// <param name="v_msg_id">推送编号（极光生成）</param>
        /// <param name="v_employee_registration"></param>
        /// <param name="v_noregistration_userid"></param>
        /// <returns></returns>
        int SavePushInfo(int v_record_type, string v_record_key, string v_push_id, int v_send_no, string v_msg_id, Dictionary<string, string> v_employee_registration, HashSet<string> v_noregistration_userid);

        /// <summary>
        /// 保存推送送达信息
        /// </summary>
        /// <param name="v_push_id"></param>
        /// <param name="v_android_received"></param>
        /// <param name="v_ios_apns_sent"></param>
        /// <param name="v_ios_apns_received"></param>
        /// <param name="v_ios_msg_received"></param>
        /// <param name="v_wp_mpns_sent"></param>
        /// <returns></returns>
        int SavePushRecived(string v_push_id, int v_android_received, int v_ios_apns_sent, int v_ios_apns_received, int v_ios_msg_received, int v_wp_mpns_sent);

        /// <summary>
        /// 保存推送送达详情
        /// </summary>
        /// <param name="v_msg_id"></param>
        /// <param name="v_registration_id"></param>
        /// <param name="detail_status"></param>
        /// <returns></returns>
        int SavePushResultDetail(string v_push_id, string v_registration_id, int detail_status);

        DataTable GetPushResultDetails(string v_push_id);

        /// <summary>
        /// 确认推送信息
        /// </summary>
        /// <param name="v_push_id">推送编号</param>
        /// <param name="v_user_id">用户编号</param>
        /// <param name="v_confirm_time">确认时间</param>
        /// <returns></returns>
        int ConfirmPush(string v_push_id, string v_user_id, DateTime v_confirm_time);
    }
}
