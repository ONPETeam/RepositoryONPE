using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using cn.jpush.api.device;
using cn.jpush.api.common;
using cn.jpush.api.push;
using cn.jpush.api.report;
using cn.jpush.api.schedule;
using cn.jpush.api.util;
using cn.jpush.api;
using cn.jpush.api.push.mode;
using cn.jpush.api.push.notification;
using cn.jpush.api.common.resp;
using Newtonsoft.Json;
using GJHF.Push.Setting.jiguangSetting;
using GJHF.Push.Result;

namespace GJHF.Push.Client
{

    public class jiguangPushClient
    {
        private string _app_key = "bbbe9694682491817eb2c0c0";
        private string _master_secret = "9209b6d3658649e7b9e8caf1";

        private JPushClient _jPushClient = null;

        private Platform _platform = Platform.all();
        private Audience _audience = Audience.all();
        private Notification _notification = null;
        private Message _message = null;
        private SmsMessage _smsmessage = null;
        private Options _options = null;

        public jiguangPushClient(string v_App_Key, string v_Master_Secret)
        {
            try
            {
                SetAppKey(v_App_Key);
                SetMasterSecret(v_Master_Secret);
                _jPushClient = new JPushClient(_app_key, _master_secret);
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public void SetAppKey(string v_App_Key)
        {
            if (v_App_Key != "")
            {
                _app_key = v_App_Key;
            }
        }

        public void SetMasterSecret(string v_Master_Secret)
        {
            if (v_Master_Secret != "")
            {
                _master_secret = v_Master_Secret;
            }
        }

        /// <summary>
        /// 设置推送平台 
        /// </summary>
        /// <param name="v_all_platform">所有平台 此项值为FALSE时，后三项值才有意义</param>
        /// <param name="v_ios_checked">IOS平台</param>
        /// <param name="v_android_checked">安卓平台</param>
        /// <param name="v_winphone_checked">Winphone平台</param>
        public void SetPlatform(bool v_all_platform, bool v_ios_checked, bool v_android_checked, bool v_winphone_checked)
        {
            if (v_all_platform)
            {
                _platform = Platform.all();
            }
            else
            {
                HashSet<string> hs = new HashSet<string>();
                if (v_ios_checked)
                {
                    hs.Add("ios");
                }
                if (v_android_checked)
                {
                    hs.Add("android");
                }
                if (v_winphone_checked)
                {
                    hs.Add("winphone");
                }
                _platform.deviceTypes = hs;
            }
        }

        /// <summary>
        /// 设定推送目标
        /// </summary>
        /// <param name="v_audience_type">1 广播 2 按TAG推送 3 按Alias推送 4 按注册ID推送</param>
        /// <param name="v_audience_tag_or">推送给多个标签（只要在任何一个标签范围内都满足）</param>
        /// <param name="v_tag_or">多个标签，标签间使用“,”(逗号)分隔</param>
        /// <param name="v_audience_tag_and">推送给多个标签（需要同时在多个标签范围内）</param>
        /// <param name="v_tag_and">多个标签，标签间使用“,”(逗号)分隔</param>
        /// <param name="v_alias">多个别名，别名间使用“,”(逗号)分隔</param>
        /// <param name="v_registation">多个注册ID</param>
        public void SetAudience(int v_audience_type, bool v_audience_tag_or, string v_tag_or, bool v_audience_tag_and, string v_tag_and, string v_alias, HashSet<string> v_registation)
        {
            Audience ad = Audience.all();
            switch (v_audience_type)
            {
                case 1:
                    ad = Audience.all();
                    break;
                case 2:
                    if (v_audience_tag_or && v_tag_or != "")
                    {
                        string[] sm = v_tag_or.Split(new char[] { ',' });
                        HashSet<string> hs = new HashSet<string>();
                        foreach (string s in sm)
                        {
                            hs.Add(s);
                        }
                        ad.tag(hs);
                    }

                    if (v_audience_tag_and && v_tag_and != "")
                    {
                        string[] sm = v_tag_and.Split(new char[] { ',' });
                        HashSet<string> hs = new HashSet<string>();
                        foreach (string s in sm)
                        {
                            hs.Add(s);
                        }
                        ad.tag_and(hs);
                    }
                    break;
                case 3:
                    string[] sm_alias = v_alias.Split(new char[] { ',' });
                    HashSet<string> hs_alias = new HashSet<string>();
                    foreach (string s in sm_alias)
                    {
                        hs_alias.Add(s);
                    }
                    ad.alias(hs_alias);
                    break;
                case 4:
                    ad.registrationId(v_registation);
                    break;
                default:
                    ad = Audience.all();
                    break;
            }
            _audience = ad;
        }

        /// <summary>
        /// 设置通知内容
        /// </summary>
        /// <param name="v_notification_alert">全平台通知内容</param>
        /// <param name="v_notification_ios">IOS通知设置</param>
        /// <param name="v_notification_android">ANDROID通知设置</param>
        public void SetNotification(string v_notification_alert,jiguang_iosnotification v_notification_ios,jiguang_androidnotification v_notification_android)
        {
            Notification nf = new Notification();
            nf.alert = v_notification_alert;
            if (v_notification_ios!=null)
            {
                IosNotification ios = new IosNotification();
                if (v_notification_ios.notification_alert != "")
                {
                    ios.setAlert(v_notification_ios.notification_alert);
                }
                if (v_notification_ios.notification_sound != "")
                {
                    ios.setSound(v_notification_ios.notification_sound);
                }
                if (v_notification_ios.notification_badge != -99)
                {
                    ios.setBadge(v_notification_ios.notification_badge);
                }
                if (v_notification_ios.notification_category != "")
                {
                    ios.setCategory(v_notification_ios.notification_category);
                }
                ios.setContentAvailable(v_notification_ios.notification_content_available);
                foreach (KeyValuePair<string, string> kv in v_notification_ios.notification_extras)
                {
                    ios.AddExtra(kv.Key, kv.Value);
                }
                nf.setIos(ios);
            }
            if (v_notification_android!=null)
            {
                AndroidNotification android = new AndroidNotification();
                if (v_notification_android.notification_alert != "")
                {
                    android.setAlert(v_notification_android.notification_alert);
                }
                if (v_notification_android.notification_title != "")
                {
                    android.setTitle(v_notification_android.notification_title);
                }
                if (v_notification_android.build_id != 0)
                {
                    android.setBuilderID(v_notification_android.build_id);
                }
                foreach (KeyValuePair<string, string> kv in v_notification_android.notification_extras)
                {
                    android.AddExtra(kv.Key, kv.Value);
                }
                nf.setAndroid(android);
            }
            _notification = nf;
        }

        /// <summary>
        /// 设置自定义消息
        /// </summary>
        /// <param name="v_message_content">自定义消息内容</param>
        /// <param name="v_message_title">自定义消息标题</param>
        /// <param name="v_content_type">自定义消息内容类型</param>
        /// <param name="v_message_extras">可选 JSON 格式的可选参数</param>
        public void SetMessage(string v_message_content, string v_message_title, string v_content_type, Dictionary<string, string> v_message_extras)
        {
            if (v_message_content != "")
            {
                Message message = Message.content(v_message_content);
                if (v_message_title != "")
                {
                    message.setTitle(v_message_title);
                }
                message.setContentType(v_content_type);
                foreach (KeyValuePair<string, string> keyValue in v_message_extras)
                {
                    message.AddExtras(keyValue.Key, keyValue.Value);
                }
                _message=message;
            }
        }

        /// <summary>
        /// 可选参数
        /// </summary>
        /// <param name="v_options_sendno">推送序号 纯粹用来作为 API 调用标识，API 返回时被原样返回，以方便 API 调用方匹配请求与返回</param>
        /// <param name="v_time_to_live">离线消息保留时长(秒) 推送当前用户不在线时，为该用户保留多长时间的离线消息，以便其上线时再次推送。默认 86400 （1 天），最长 10 天。设置为 0 表示不保留离线消息，只有推送当前在线的用户可以收到。 </param>
        /// <param name="v_override_msgid">要覆盖的消息ID 如果当前的推送要覆盖之前的一条推送，这里填写前一条推送的 msg_id 就会产生覆盖效果，即：1）该 msg_id 离线收到的消息是覆盖后的内容；2）即使该 msg_id Android 端用户已经收到，如果通知栏还未清除，则新的消息内容会覆盖之前这条通知；覆盖功能起作用的时限是：1 天。如果在覆盖指定时限内该 msg_id 不存在，则返回 1003 错误，提示不是一次有效的消息覆盖操作，当前的消息不会被推送。</param>
        /// <param name="v_apns_production">APNs是否生产环境 True 表示推送生产环境，False 表示要推送开发环境；如果不指定则为推送生产环境。JPush 官方 API LIbrary (SDK) 默认设置为推送 “开发环境”。</param>
        /// <param name="v_big_push_duration">定速推送时长(分钟) 又名缓慢推送，把原本尽可能快的推送速度，降低下来，给定的n分钟内，均匀地向这次推送的目标用户推送。最大值为1400.未设置则不是定速推送。</param>
        public void SetOptions(int v_options_sendno, long v_time_to_live, long v_override_msgid, bool v_apns_production, long v_big_push_duration)
        {
            Options op = new Options();
            op.sendno = v_options_sendno;
            op.time_to_live = v_time_to_live;
            op.override_msg_id = v_override_msgid;
            op.apns_production = v_apns_production;
            op.big_push_duration = v_big_push_duration;
            _options = op;
        }

        public string UpdateDeviceInfo(string v_registration_id, string v_alias, string v_mobile, HashSet<string> v_tag_to_add, HashSet<string> v_tag_to_remove)
        {
            DefaultResult dr = _jPushClient.updateDeviceTagAlias(v_registration_id, v_alias, v_mobile, v_tag_to_add, v_tag_to_remove);
            string mStrReturn = "";
            if (dr.isResultOK())
            {
                mStrReturn = dr.ResponseResult.responseContent;
            }
            else
            {
                mStrReturn = "";
            }
            return mStrReturn;
        }

        public Device_Info GetDeviceInfo(string v_registration_id)
        {
            Device_Info di = new Device_Info();

            TagAliasResult tar = _jPushClient.getDeviceTagAlias(v_registration_id);
            if (tar.isResultOK())
            {
                di.isResultOK = true;
                Device_Info device_info = (Device_Info)JsonConvert.DeserializeObject<Device_Info>(tar.ResponseResult.responseContent);
                di.tags = device_info.tags;
                di.alias = device_info.alias;
                di.mobile = device_info.mobile;
            }
            else
            {
                di.isResultOK = false;
                di.alias = "";
                di.tags = null;
                di.mobile = "";
            }
            return di;
        }

        public string PushMessage()
        {
            PushPayload ppl = new PushPayload();
            if (_platform != null)
            {
                ppl.platform = _platform;
            }
            else
            {
                ppl.platform = Platform.all();
            }
            if (_audience != null)
            {
                ppl.audience = _audience;
            }
            else
            {
                ppl.audience = Audience.all();
            }
            if (_notification != null)
            {
                ppl.notification = _notification;
            }
            if (_message != null)
            {
                ppl.message = _message;
            }
            if (_options != null)
            {
                ppl.options = _options;
            }
            MessageResult mr= _jPushClient.SendPush(ppl);
            if (mr.isResultOK())
            {
                return mr.ResponseResult.responseContent;
            }
            else
            {
                return "";
            }
        }

        public string GetPushResult(string v_msg_id)
        {
            ReceivedResult rr=_jPushClient.getReceivedApi_v3(v_msg_id);
            return rr.ResponseResult.responseContent;
        }

        public string GetReceiveDetail(string v_msg_id, List<string> v_registration_ids)
        {
            ResponseWrapper rw = _jPushClient.getMessageSendStatus(v_msg_id, v_registration_ids, "");
            return rw.responseContent;
        }
    }
}
