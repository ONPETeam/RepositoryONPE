using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace GJHF.Data.Interface.TSD
{
    public interface IForm
    {
        int AddForm(int v_request_company, int v_request_branch, string v_request_people, DateTime v_request_time, int v_request_type, 
            string v_stop_equip, DateTime v_stop_time, float v_stop_duration, string v_request_remark);
        int EditForm(string v_request_id, int v_request_company, int v_request_branch, string v_request_people, DateTime v_request_time, int v_request_type,
            string v_stop_equip, DateTime v_stop_time, float v_stop_duration, string v_request_remark);
        int DelForm(string v_request_id);
        List<Model.TSD.Form> GetFormListData(string v_request_people, string v_request_branch, string v_request_company, string v_equip_code, DateTime v_request_start, DateTime v_request_end,
            DateTime v_stop_start, DateTime v_stop_end, int v_is_exec, int v_request_type);
        long GetFormCount(string v_request_people, string v_request_branch, string v_request_company, string v_equip_code, DateTime v_request_start, DateTime v_request_end,
            DateTime v_stop_start, DateTime v_stop_end, int v_is_exec, int v_request_type);
    }
}
