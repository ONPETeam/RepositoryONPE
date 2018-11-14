using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace GJHF.Push.Setting.jiguangSetting
{
    /// <summary>
    /// 极光推送 IOS 通知设置
    /// </summary>
    public class jiguang_iosnotification
    {
        
        /// <summary>
        /// IOS通知内容
        /// </summary>
        public string notification_alert
        {
            get;
            set;
        }
        /// <summary>
        /// IOS通知提示声音 如果无此字段，则此消息无声音提示；有此字段，如果找到了指定的声音就播放该声音，否则播放默认声音,如果此字段为空字符串，iOS 7 为默认声音，iOS 8及以上系统为无声音。(消息) 说明：JPush 官方 API Library (SDK) 会默认填充声音字段。
        /// </summary>
        public string notification_sound
        {
            get;
            set;
        }
        /// <summary>
        /// IOS通知 如果为-99，表示不改变角标数字；否则把角标数字改为指定的数字；为 0 表示清除。JPush 官方 API Library(SDK) 会默认填充badge值为"+1"
        /// </summary>
        public int notification_badge
        {
            get;
            set;
        }
        /// <summary>
        /// IOS通知 设置APNs payload中的"category"字段值
        /// </summary>
        public string notification_category
        {
            get;
            set;
        }
        /// <summary>
        /// 推送唤醒 推送的时候携带"content-available":true 说明是 Background Remote Notification，如果不携带此字段则是普通的Remote Notification。
        /// </summary>
        public bool notification_content_available
        {
            get;
            set;
        }
        /// <summary>
        /// extras JSON Object 可选 附加字段 这里自定义 Key/value 信息，以供业务使用。
        /// </summary>
        public Dictionary<string, string> notification_extras
        {
            get;
            set;
        }
    }
    /// <summary>
    /// 极光推送 ANDROID 通知设置
    /// </summary>
    public class jiguang_androidnotification
    {
        
        /// <summary>
        /// 通知内容
        /// </summary>
        public string notification_alert
        {
            get;
            set;
        }
        /// <summary>
        /// 通知标题
        /// </summary>
        public string notification_title
        {
            get;
            set;
        }
        /// <summary>
        /// 通知栏样式ID Android SDK 可设置通知栏样式，这里根据样式 ID 来指定该使用哪套样式。
        /// </summary>
        public int build_id
        {
            get;
            set;
        }
        /// <summary>
        /// extras JSON Object 可选 扩展字段 这里自定义 JSON 格式的 Key/Value 信息，以供业务使用。
        /// </summary>
        public Dictionary<string, string> notification_extras
        {
            get;
            set;
        }
    }
}
