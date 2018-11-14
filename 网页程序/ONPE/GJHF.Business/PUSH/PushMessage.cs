using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Newtonsoft.Json;
using System.Threading;
using System.Runtime.InteropServices;
using System.Data;

namespace GJHF.Business.PUSH
{
    public class PushMessage
    {
        /// <summary>
        /// 推送消息ID（极光）
        /// </summary>
        private string _msg_id = "";

        /// <summary>
        /// 推送消息编号（系统）
        /// </summary>
        private string _push_id;

        /// <summary>
        /// 推送消息编号（验证）
        /// </summary>
        private int _send_no;

        public int GetSendNo()
        {
            return _send_no;
        }

        public void SetSendNo()
        {
            GJHF.Data.Interface.PUSH.IPushMessage iIPushMessage = GJHF.Data.Factory.PUSH.FPushMessage.Create();
            _send_no = iIPushMessage.GetNewSendNO();
        }

        public string GetMsgID()
        {
            return _msg_id;
        }


        /// <summary>
        /// 给指定的用户推送消息
        /// </summary>
        /// <param name="v_user_id">用户编号合计</param>
        /// <param name="v_notification_content">推送内容</param>
        /// <param name="v_notification_extras">推送参数</param>
        /// <returns>非负 推送成功 负数 推送失败</returns>
        private static string SendNotification(int v_push_type, string v_push_key, HashSet<string> v_user_id, string v_notification_content, Dictionary<string, string> v_notification_extras, string v_notification_class = "", bool v_notification_state_reback = false)
        {
            int mIntSendNo = 0;

            string mStrPushResult = "";
            string mStrPushID = "";

            HashSet<string> mHashSetRegistrationIDs = new HashSet<string>();
            HashSet<string> mHashSetNoRegistrationIDs = new HashSet<string>();
            Dictionary<string, string> mDctUserRegistration = new Dictionary<string, string>();
            string mStrAppsiteKey = System.Configuration.ConfigurationSettings.AppSettings["appsite_code"].ToString();

            GJHF.Data.Interface.PUSH.IPushMessage iIPushMessage = GJHF.Data.Factory.PUSH.FPushMessage.Create();
            GJHF.Data.Interface.PUSH.IPushTarget iIPushTarget = GJHF.Data.Factory.PUSH.FPushTarget.Create();
            GJHF.Data.Interface.PUSH.IPushResult iIPushResult = GJHF.Data.Factory.PUSH.FPushResult.Create();
            GJHF.Business.SYS.SysPushClass BSysPushClass = new SYS.SysPushClass();

            GJHF.Data.Model.PUSH.MPushMessage mMPushMessage = new GJHF.Data.Model.PUSH.MPushMessage();
            try
            {

                //1.保存原始数据

                mStrPushID = iIPushMessage.SavePushMessage(v_push_type, v_push_key, v_notification_content, "", v_user_id);
                mIntSendNo = iIPushMessage.GetNewSendNO();

                //2.拆解employee_code 获取推送注册ID
                if (v_user_id != null && v_user_id.Count > 0)
                {
                    string m_user_ids = GJHF.Utility.Convert.ConvertHashSetToString(v_user_id, ",");
                    mDctUserRegistration = GJHF.Utility.Convert.ConvertJsonToDic(SSO.SSOLogin.GetRegistratorID(m_user_ids, ","));
                    if (mDctUserRegistration != null)
                    {
                        foreach (KeyValuePair<string, string> kv in mDctUserRegistration)
                        {
                            if (kv.Value != "")
                            {
                                mHashSetRegistrationIDs.Add(kv.Value);
                            }
                            else
                            {
                                mHashSetNoRegistrationIDs.Add(kv.Key);
                            }
                        }
                    }
                }
                //3.判断是否有推送目标，有，并记录推送信息

                if (mHashSetRegistrationIDs != null && mHashSetRegistrationIDs.Count > 0)
                {
                    string mStrIOSSound = "";
                    int mIntAndriodBuildID = 1;
                    if (v_notification_class != "")
                    {
                        mStrIOSSound = BSysPushClass.GetIosSoundByClassID(v_notification_class);
                        mIntAndriodBuildID = BSysPushClass.GetAndroidBuildIDByClassID(v_notification_class);
                    }
                    Dictionary<string, string> m_notification_extras = v_notification_extras;
                    if (m_notification_extras == null)
                    {
                        m_notification_extras = new Dictionary<string, string>();
                    }
                    if (!v_notification_state_reback)
                    {
                        m_notification_extras.Add("need_back", "false");
                        m_notification_extras.Add("push_id", mStrPushID);
                        m_notification_extras.Add("record_type", v_push_type.ToString());
                        m_notification_extras.Add("record_key", v_push_key);
                        m_notification_extras.Add("factory_type", mStrAppsiteKey);
                    }
                    else
                    {
                        m_notification_extras.Add("need_back", "true");
                        m_notification_extras.Add("push_id", mStrPushID);
                        m_notification_extras.Add("record_type", v_push_type.ToString());
                        m_notification_extras.Add("record_key", v_push_key);
                        m_notification_extras.Add("factory_type", mStrAppsiteKey);
                    }
                    mStrPushResult = GJHF.Push.Device.jiguangDevice.SendNotification(mIntSendNo, v_notification_content, mHashSetRegistrationIDs, m_notification_extras, mIntAndriodBuildID, mStrIOSSound);
                    mMPushMessage = (GJHF.Data.Model.PUSH.MPushMessage)JsonConvert.DeserializeObject<GJHF.Data.Model.PUSH.MPushMessage>(mStrPushResult);
                    if (mMPushMessage != null)
                    {
                        iIPushResult.SavePushInfo(v_push_type, v_push_key, mStrPushID, mMPushMessage.sendno, mMPushMessage.msg_id, mDctUserRegistration, mHashSetNoRegistrationIDs);
                    }
                }

            }
            catch (Exception ex)
            {
                mStrPushID = "";
            }
            return mStrPushID;
        }

        /// <summary>
        /// 广播发送一条推送
        /// </summary>
        /// <param name="v_notification_content">推送内容</param>
        /// <param name="v_notification_extras">推送参数</param>
        /// <returns>非负 推送成功 负数 推送失败</returns>
        [Obsolete("禁止广播")]
        public static string SendNotification(string v_notification_content, Dictionary<string, string> v_notification_extras)
        {
            return SendNotification(1, "", null, v_notification_content, null);
        }

        /// <summary>
        /// 按照某一类目标发送推送
        /// </summary>
        /// <param name="v_target_type">目标类别:①company 公司 ②branch 部门 ③job 岗位 ④major 点检类别 ⑥post 职务 ⑦userrole 用户角色 ⑧usergroup 用户组 ⑨employee 员工</param>
        /// <param name="v_target_value">目标编号合计，多个目标编号之间使用逗号分隔</param>
        /// <param name="v_notification_content">推送内容</param>
        /// <param name="v_notification_extras">扩展参数</param>
        /// <param name="v_notification_class">推送类别,可选参数，默认为系统默认推送</param>
        /// <param name="v_notification_state_reback">是否需要用户收到推送后有确认操作，默认为不需要用户的确认操作</param>
        /// <returns>非负 推送成功 负数 推送失败</returns>
        public static string SendNotification(int v_push_type, string v_push_key, string v_target_type, string v_target_value, string v_notification_content, Dictionary<string, string> v_notification_extras, string v_notification_class = "", bool v_notification_state_reback = false)
        {
            HashSet<string> m_user_id = new HashSet<string>();
            GJHF.Data.Interface.User.IGetUserID mIGetUserID = GJHF.Data.Factory.User.FGetUserID.Create();
            if (v_target_value != "" && v_target_type != "")
            {
                switch (v_target_type.ToLower())
                {
                    case "employee":
                        m_user_id = mIGetUserID.GetUserIDByEmployeeCodes(GJHF.Utility.Convert.ConvertStringToHashSet(v_target_value, ','));
                        break;
                    case "usergroup":
                        m_user_id = mIGetUserID.GetUserIDByUserGroup(GJHF.Utility.Convert.ConvertStringToHashSet(v_target_value, ','));
                        break;
                    case "userrole":
                        m_user_id = mIGetUserID.GetUserIDByUserRole(GJHF.Utility.Convert.ConvertStringToHashSet(v_target_value, ','));
                        break;
                    case "branch":
                        m_user_id = mIGetUserID.GetUserIDByBranchID(GJHF.Utility.Convert.ConvertStringToHashSet(v_target_value, ','));
                        break;
                    case "company":
                        m_user_id = mIGetUserID.GetUserIDByCompanyID(GJHF.Utility.Convert.ConvertStringToHashSet(v_target_value, ','));
                        break;
                    case "major":
                        m_user_id = mIGetUserID.GetUserIDByMajorCode(GJHF.Utility.Convert.ConvertStringToHashSet(v_target_value, ','));
                        break;
                    case "post":
                        m_user_id = mIGetUserID.GetUserIDByPostCode(GJHF.Utility.Convert.ConvertStringToHashSet(v_target_value, ','));
                        break;
                    case "job":
                        m_user_id = mIGetUserID.GetUserIDByJobCode(GJHF.Utility.Convert.ConvertStringToHashSet(v_target_value, ','));
                        break;
                    default:

                        break;
                }
            }
            return SendNotification(v_push_type, v_push_key, m_user_id, v_notification_content, v_notification_extras, v_notification_class, v_notification_state_reback);
        }

        /// <summary>
        /// 
        /// </summary>
        /// <param name="v_push_id"></param>
        /// <returns></returns>
        public static DataTable GetPushResultDetail(string v_push_id)
        {
            DataTable dt = null;

            //1.获取是否推送 
            GJHF.Data.Interface.PUSH.IPushMessage BPushMessage = GJHF.Data.Factory.PUSH.FPushMessage.Create();
            GJHF.Data.Interface.PUSH.IPushResult BPushResult = GJHF.Data.Factory.PUSH.FPushResult.Create();
            GJHF.Data.Model.PUSH.MPushMsg mMPushMsg = BPushMessage.GetPushMessageDetailByPushID(v_push_id);
            if (mMPushMsg.is_push == 1)
            {
                #region 基础查询
                //2.检查是否有获取推送结果
                string mStrResultID = mMPushMsg.result_id;
                if (string.IsNullOrEmpty(mStrResultID))
                {
                    try
                    {
                        string mStrPushResult = GJHF.Push.Device.jiguangDevice.GetPushResult(mMPushMsg.msg_id);
                        GJHF.Data.Model.PUSH.MPushResult mMPushResult = null;

                        List<GJHF.Data.Model.PUSH.MPushResult> m = (List<GJHF.Data.Model.PUSH.MPushResult>)Newtonsoft.Json.JsonConvert.DeserializeObject<List<GJHF.Data.Model.PUSH.MPushResult>>(mStrPushResult);
                        mMPushResult = m[0];
                        if (mMPushResult != null)
                        {
                            int mIntAndroidReceived = 0;
                            if (mMPushResult.android_received == null || int.TryParse(mMPushResult.android_received, out mIntAndroidReceived) == false)
                            {
                                mIntAndroidReceived = 0;
                            }
                            int mIntIOSApnsSent = 0;
                            if (mMPushResult.ios_apns_sent == null || int.TryParse(mMPushResult.ios_apns_sent, out mIntIOSApnsSent) == false)
                            {
                                mIntIOSApnsSent = 0;
                            }
                            int mIntIOSApnsReceived = 0;
                            if (mMPushResult.ios_apns_received == null || int.TryParse(mMPushResult.ios_apns_received, out mIntIOSApnsReceived) == false)
                            {
                                mIntIOSApnsReceived = 0;
                            }
                            int mIntIOSMsgReceived = 0;
                            if (mMPushResult.ios_msg_received == null || int.TryParse(mMPushResult.ios_msg_received, out mIntIOSMsgReceived) == false)
                            {
                                mIntIOSMsgReceived = 0;
                            }
                            int mIntWPMpnsSent = 0;
                            if (mMPushResult.wp_mpns_sent == null || int.TryParse(mMPushResult.wp_mpns_sent, out mIntWPMpnsSent) == false)
                            {
                                mIntWPMpnsSent = 0;
                            }
                            BPushResult.SavePushRecived(v_push_id, mIntAndroidReceived, mIntIOSApnsSent, mIntIOSApnsReceived, mIntIOSMsgReceived, mIntWPMpnsSent);
                        }
                    }
                    catch
                    {

                    }
                }
                //3.检查最后一次查询时间，如果和现在时间超过10分钟，并且和推送时间相差不大于10天，就重新查询一次
                DateTime mDtmNow = DateTime.Now;
                if (mMPushMsg.query_time.AddMinutes(10) < mDtmNow && (mDtmNow - mMPushMsg.push_time).Days < 10)
                {

                    List<string> mLstRegistrationIDs = new List<string>();
                    Dictionary<string, string> mDctPushTarget = null;
                    try
                    {
                        mDctPushTarget = (Dictionary<string, string>)Newtonsoft.Json.JsonConvert.DeserializeObject<Dictionary<string, string>>(mMPushMsg.employee_registration);
                        foreach (KeyValuePair<string, string> kv in mDctPushTarget)
                        {
                            if (!string.IsNullOrEmpty(kv.Value))
                            {
                                mLstRegistrationIDs.Add(kv.Value);
                            }
                        }
                        string mStrPushResultDetail = GJHF.Push.Device.jiguangDevice.GetReceiveDetail(mMPushMsg.msg_id, mLstRegistrationIDs);
                        //{"100d85590947a72e1b8":{"status":0},"140fe1da9ea318c87ed":{"status":1}}
                        Dictionary<string, object> mDic = (Dictionary<string, object>)Newtonsoft.Json.JsonConvert.DeserializeObject<Dictionary<string, object>>(mStrPushResultDetail);
                        string mStrRegistrationID = "";
                        foreach (KeyValuePair<string, object> kv in mDic)
                        {
                            mStrRegistrationID = kv.Key;
                            if (mLstRegistrationIDs.Contains(mStrRegistrationID))
                            {
                                Dictionary<string, int> mDicState = (Dictionary<string, int>)Newtonsoft.Json.JsonConvert.DeserializeObject<Dictionary<string, int>>(kv.Value.ToString());
                                foreach (KeyValuePair<string, int> kvState in mDicState)
                                {
                                    if (kvState.Key == "status")
                                    {
                                        int mIntReceivedState = kvState.Value;
                                        int mIntIsReceived = 0;
                                        if (mIntReceivedState == 1)
                                        {
                                            mIntIsReceived = 1;
                                        }
                                        BPushResult.SavePushResultDetail(v_push_id, mStrRegistrationID, mIntIsReceived);
                                    }
                                }
                            }
                        }
                        BPushMessage.UpdateQueryTime(v_push_id, mDtmNow);
                    }
                    catch
                    {

                    }
                }
                #endregion
                //返回当前推送结果状态
                dt = BPushResult.GetPushResultDetails(v_push_id);
            }
            else
            {
                dt = new DataTable("dt");
                DataColumn dc = null;
                dc = dt.Columns.Add("push_id", Type.GetType("System.String"));
                dc = dt.Columns.Add("push_state", Type.GetType("System.String"));
                DataRow dr;
                dr = dt.NewRow();
                dr["push_id"] = v_push_id;
                dr["push_state"] = "消息未推送或推送失败！请检查消息编号或接受者是否正确";
                dt.Rows.Add(dr);
            }
            return dt;
        }

        /// <summary>
        /// 确认推送信息
        /// </summary>
        /// <param name="v_push_id">推送编号</param>
        /// <param name="v_user_id">用户编号</param>
        /// <param name="v_confirm_time">确认时间</param>
        /// <returns></returns>
        public static int ConfirmPush(string v_push_id, string v_user_id, DateTime v_confirm_time)
        {
            GJHF.Data.Interface.PUSH.IPushResult BPushResult = GJHF.Data.Factory.PUSH.FPushResult.Create();
            return BPushResult.ConfirmPush(v_push_id, v_user_id, v_confirm_time);
        }
    }
}
