using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using GJHF.Push.Client;
using GJHF.Push.Setting.jiguangSetting;
using GJHF.Push.Result;
using Newtonsoft.Json;

namespace GJHF.Push.Device
{
    public class jiguangDevice
    {
        public enum platform_type
        {
            ALL=0,
            IOS=1,
            ANDROID=2,
            WINPHONE=3
        }
        private static jiguangPushClient jpc = new jiguangPushClient("","");

        /// <summary>
        /// 更新设备信息
        /// </summary>
        /// <param name="v_registration_id">需更新信息的设备注册ID</param>
        /// <param name="v_alias">新的设备别名，为空 表示清除别名</param>
        /// <param name="v_mobile">设备手机号，用作发送短信</param>
        /// <param name="v_tag_to_add">要添加的标签集合</param>
        /// <param name="v_tag_to_remove">要移除的标签集合</param>
        /// <returns></returns>
        public static string UpdateDeviceInfo(string v_registration_id,string v_alias,string v_mobile,HashSet<string> v_tag_to_add,HashSet<string> v_tag_to_remove)
        {
            string m_return_result = jpc.UpdateDeviceInfo(v_registration_id, v_alias, v_mobile, v_tag_to_add, v_tag_to_remove);
            return m_return_result;
        }

        /// <summary>
        /// 根据注册ID获取设备标签和别名
        /// </summary>
        /// <param name="v_registration_id">注册ID</param>
        /// <returns></returns>
        public static Device_Info GetDeviceInfo(string v_registration_id)
        {
            Device_Info di = jpc.GetDeviceInfo(v_registration_id);
            return di;
        }

        private static string SendMessage()
        {
            return "";
        }

        public static string GetPushResult(string v_msg_id)
        {
            return jpc.GetPushResult(v_msg_id);
        }

        /// <summary>
        /// 获取推送送达信息
        /// </summary>
        /// <param name="v_msg_id">消息编号</param>
        /// <param name="v_registration_ids">设备注册编号</param>
        /// <returns>各个设备注册编号送达状态</returns>
        public static string GetReceiveDetail(string v_msg_id, List<string> v_registration_ids)
        {
            return jpc.GetReceiveDetail(v_msg_id, v_registration_ids);
        }

        /// <summary>
        /// 广播一条通知
        /// </summary>
        /// <param name="v_notification_content">通知内容</param>
        /// <returns></returns>
        public static string SendNotification(string v_notification_content)
        {
            jpc.SetNotification(v_notification_content, null, null);
            string m = jpc.PushMessage();
            return m;
        }

        /// <summary>
        /// 按平台广播一条通知
        /// </summary>
        /// <param name="v_notification_content">通知内容</param>
        /// <param name="v_platform">平台类型</param>
        /// <returns></returns>
        public static string SendNotification(string v_notification_content,platform_type v_platform)
        {
            switch (v_platform)
            {
                case platform_type.ANDROID:
                    jpc.SetPlatform(false, false, true, false);
                    break;
                case platform_type.IOS:
                    jpc.SetPlatform(false, true, false, false);
                    break;
                case platform_type.WINPHONE:
                    jpc.SetPlatform(false, false, false, true);
                    break;
                case platform_type.ALL:
                default:
                    jpc.SetPlatform(true, false, false, false);
                    break;
            }
            jpc.SetNotification(v_notification_content, null, null);
            string m = jpc.PushMessage();
            return m;
        }

        /// <summary>
        /// 给所有安卓手机推送一条通知
        /// </summary>
        /// <param name="v_android_notifiction">安卓通知设置</param>
        /// <returns></returns>
        public static string SendNotification(jiguang_androidnotification v_android_notifiction)
        {
            jpc.SetPlatform(false, false, true, false);
            jpc.SetAudience(1, false, "", false, "", "", null);
            jpc.SetNotification("", null, v_android_notifiction);
            string m = jpc.PushMessage();
            return m;
        }

        /// <summary>
        /// 给所有的苹果手机推送一条通知
        /// </summary>
        /// <param name="v_ios_notification">苹果通知设置</param>
        /// <returns></returns>
        public static string SendNotification(jiguang_iosnotification v_ios_notification)
        {
            jpc.SetPlatform(false, true, false, false);
            jpc.SetAudience(1,false,"",false,"","",null);
            jpc.SetNotification("", v_ios_notification, null);
            string m = jpc.PushMessage();
            return m;
        }

        /// <summary>
        /// 给满足多个标签的客户端推送一条通知
        /// </summary>
        /// <param name="v_notification_content">通知内容</param>
        /// <param name="v_tag_and">需同时满足多个标签集合，用“,”分隔多个标签</param>
        /// <param name="v_tag_or">在多个标签集合中，用“,”分隔多个标签</param>
        /// <returns></returns>
        public static string SendNotification(string v_notification_content,string v_tag_and,string v_tag_or)
        {
            bool m_tag_and = false;
            bool m_tag_or = false;
            jpc.SetPlatform(true, false, false, false);
            if (v_tag_and != "")
            {
                m_tag_and = true;
            }
            if (v_tag_or != "")
            {
                m_tag_or = true;
            }
            jpc.SetAudience(2, m_tag_or, v_tag_or, m_tag_and, v_tag_and, "", null);
            jpc.SetNotification(v_notification_content, null, null);
            string m = jpc.PushMessage();
            return m;
        }

        /// <summary>
        /// 按别名推送
        /// </summary>
        /// <param name="v_notification_content">通知内容</param>
        /// <param name="v_alias">别名集合，多个别名间用“,”分隔</param>
        /// <returns></returns>
        public static string SendNotification(string v_notification_content, string[] v_alias)
        {
            string m="";
            string m_alias = "";
            if (v_notification_content.Length > 1 && v_alias.Length > 0)
            {
                foreach (string m_alia in v_alias)
                {
                    m_alias += m_alia.ToString() + ",";
                }
                if (m_alias.Length > 0)
                {
                    m_alias = m_alias.Substring(0, m_alias.Length - 1);
                }
                jpc.SetPlatform(true, false, false, false);
                jpc.SetAudience(3, false, "", false, "", m_alias, null);
                jpc.SetNotification(v_notification_content, null, null);
                m = jpc.PushMessage();
            }
            return m;
        }

        /// <summary>
        /// 按照注册ID推送
        /// </summary>
        /// <param name="v_notification_content">通知内容</param>
        /// <param name="v_registration_ids">多个注册ID，注册ID间使用“,”(逗号)分隔</param>
        /// <returns></returns>
        public static string SendNotification(int v_send_no, string v_notification_content, HashSet<string> v_registration_ids, Dictionary<string, string> v_notification_extras, int v_android_build_id = 0, string v_ios_sound = "")
        {
            jpc.SetPlatform(true, false, false, false);
            jpc.SetAudience(4, false, "", false, "", "", v_registration_ids);
            if (v_notification_extras == null)
            {
                jpc.SetNotification(v_notification_content, null, null);
            }
            else
            {
                jiguang_iosnotification j_ios_notification = new jiguang_iosnotification();
                j_ios_notification.notification_extras = v_notification_extras;
                if (v_ios_sound != null)
                {
                    j_ios_notification.notification_sound = v_ios_sound;
                }
                jiguang_androidnotification j_android_notification = new jiguang_androidnotification();
                j_android_notification.build_id = v_android_build_id;
                j_android_notification.notification_extras = v_notification_extras;
                jpc.SetNotification(v_notification_content, j_ios_notification, j_android_notification);
            }
            jpc.SetOptions(v_send_no, 86400, 0, false, 0);
            string m = jpc.PushMessage();
            return m;
        }
    }
}
