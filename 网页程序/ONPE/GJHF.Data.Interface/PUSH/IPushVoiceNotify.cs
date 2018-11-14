using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;

namespace GJHF.Data.Interface.PUSH
{
    public interface IPushVoiceNotify
    {
        int GetPushVoiceNotifyCount(int v_record_type = -100, string v_record_key = "", int v_template_no = -1, DateTime? v_query_starttime = null, DateTime? v_query_endtime = null);

        DataTable GetPushVoiceNotifyData(int v_record_type = -100, string v_record_key = "", int v_template_no = -1, DateTime? v_query_starttime = null, DateTime? v_query_endtime = null);

        DataTable GetPushVoiceNotifyData(int v_record_type = -100, string v_record_key = "", int v_template_no = -1, DateTime? v_query_starttime = null, DateTime? v_query_endtime = null, string v_sort = "", string v_order = "");

        DataTable GetPushVoiceNotifyData(int v_page = 1, int v_rows = 10, int v_record_type = -100, string v_record_key = "", int v_template_no = -1, DateTime? v_query_starttime = null, DateTime? v_query_endtime = null, string v_sort = "", string v_order = "");

        string AddPushVoiceNotify(DateTime v_record_time, int v_record_type, string v_record_key, int v_template_no, string v_notify_params, string v_notify_employees, string v_employee_phone, string v_employee_nophone);
    }
}
