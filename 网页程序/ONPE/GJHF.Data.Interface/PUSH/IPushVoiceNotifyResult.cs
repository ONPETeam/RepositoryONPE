using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;

namespace GJHF.Data.Interface.PUSH
{
    public  interface IPushVoiceNotifyResult
    {
        int AddVoiceNotifyResult(int v_record_type, string v_record_key, string v_notify_id, string v_user_id, string v_user_phone, int v_notify_state, string v_state_remark, string v_notify_key);

        int GetVoiceNotifyResultCount(int v_record_type, string v_record_key);

        DataTable GetVoiceNotifyResultData(int v_record_type, string v_record_key);
    }
}
