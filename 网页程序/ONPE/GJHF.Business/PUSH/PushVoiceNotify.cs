using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace GJHF.Business.PUSH
{
    /// <summary>
    /// 推送语音通知
    /// </summary>
    public class PushVoiceNotify
    {
        public static string SendVoiceNotify(int v_push_type, string v_push_key, string v_target_type, List<string> v_target_value, string v_template_id, List<string> v_template_param)
        {
            string mStrReturn = "";
            GJHF.Data.Interface.PUSH.IPushVoiceNotify mPushVoiceNotify = GJHF.Data.Factory.PUSH.FPushVoiceNotify.Create();
            GJHF.Data.Interface.SYS.ISysVoiceTemplate mSysVoiceTemplate = GJHF.Data.Factory.SYS.FSysVoiceTemplate.Create();
            GJHF.Data.Interface.PUSH.IPushVoiceNotifyResult mPushVoiceNotifyResult = GJHF.Data.Factory.PUSH.FPushVoiceNotifyResult.Create();
            try
            {
                Dictionary<string, string> mDicTargetPhoneNo = GetTargetPhone(v_target_type, v_target_value);
                Dictionary<string, string> mDicSetPhoneNo = new Dictionary<string, string>();
                HashSet<string> mHashSetNoPhoneTarget = new HashSet<string>();
                foreach (KeyValuePair<string, string> kv in mDicTargetPhoneNo)
                {
                    if (kv.Value.ToString() == "")
                    {
                        mHashSetNoPhoneTarget.Add(kv.Key.ToString());
                    }
                    else
                    {
                        mDicSetPhoneNo.Add(kv.Key.ToString(), kv.Value.ToString());
                    }
                }
                int mIntTemplateNo = mSysVoiceTemplate.GetTemplateNoByID(v_template_id);
                if (mIntTemplateNo == 0) return "";
                //1.保存记录
                string mStrNotifyID = mPushVoiceNotify.AddPushVoiceNotify(DateTime.Now, v_push_type, v_push_key, mIntTemplateNo, Newtonsoft.Json.JsonConvert.SerializeObject(v_template_param),
                    Newtonsoft.Json.JsonConvert.SerializeObject(v_target_value), Newtonsoft.Json.JsonConvert.SerializeObject(mDicTargetPhoneNo), Newtonsoft.Json.JsonConvert.SerializeObject(mHashSetNoPhoneTarget));
                if (mStrNotifyID == "") return "";

                //2.拆分手机号，分别语音通知
                foreach (KeyValuePair<string, string> kv in mDicSetPhoneNo)
                {
                    string mStrGUID = Guid.NewGuid().ToString();
                    if (GJHF.Sms._139130.Interface.Function.SendNotify(kv.Value.ToString(), mIntTemplateNo.ToString(), v_template_param, mStrGUID) == 0)
                    {
                        //保存语音通知单条记录  状态为“1 成功”
                        mPushVoiceNotifyResult.AddVoiceNotifyResult(v_push_type, v_push_key, mStrNotifyID, kv.Key.ToString(), kv.Value.ToString(), 1, "已创建语音通知", mStrGUID);
                    }
                    else
                    {
                        //保存语音通知单条记录  状态为“-1 失败”
                        mPushVoiceNotifyResult.AddVoiceNotifyResult(v_push_type, v_push_key, mStrNotifyID, kv.Key.ToString(), kv.Value.ToString(), -1, "创建语音通知失败", mStrGUID);
                    }
                }
                //3.保存未搜索到手机号的语音通知详情记录 状态为“0 未呼叫”
                foreach (string mStrTarget in mHashSetNoPhoneTarget)
                {
                    string mStrGUID = Guid.NewGuid().ToString();
                    mPushVoiceNotifyResult.AddVoiceNotifyResult(v_push_type, v_push_key, mStrTarget, mStrTarget, "", 0, "未找到用户手机号", mStrGUID);
                }

                mStrReturn = mStrNotifyID;
            }
            catch (Exception ex)
            {

            }
            return mStrReturn;
        }

        private static Dictionary<string, string> GetTargetPhone(string v_target_type, List<string> v_target_value)
        {
            Dictionary<string, string> mDicEmployeePhone = new Dictionary<string, string>();
            GJHF.Data.Interface.HR.IEmployeeGetPhone mEmployeeGetPhone = GJHF.Data.Factory.HR.FEmployeeGetPhone.Create();
            if (v_target_type != null && v_target_type != "")
            {
                switch (v_target_type.ToLower())
                {
                    case "employee":
                        mDicEmployeePhone = mEmployeeGetPhone.GetEmployeePhoneNoByCode(v_target_value);
                        break;
                    case "usergroup":
                        mDicEmployeePhone = mEmployeeGetPhone.GetPhoneByUserGroup(v_target_value);
                        break;
                    case "userrole":
                        mDicEmployeePhone = mEmployeeGetPhone.GetPhoneByUserRole(v_target_value);
                        break;
                    case "branch":
                        mDicEmployeePhone = mEmployeeGetPhone.GetPhoneByBranchID(v_target_value);
                        break;
                    case "company":
                        mDicEmployeePhone = mEmployeeGetPhone.GetPhoneByCompanyID(v_target_value);
                        break;
                    case "major":
                        mDicEmployeePhone = mEmployeeGetPhone.GetPhoneByMajorCode(v_target_value);
                        break;
                    case "post":
                        mDicEmployeePhone = mEmployeeGetPhone.GetPhoneByPostCode(v_target_value);
                        break;
                    case "job":
                        mDicEmployeePhone = mEmployeeGetPhone.GetPhoneByJobCode(v_target_value);
                        break;
                    default:

                        break;
                }
            }

            return mDicEmployeePhone;
        }
    }
}
