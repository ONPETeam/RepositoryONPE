using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;

namespace GJHF.Data.Interface.SYS
{
    public interface ISysState
    {
        int AddSysState(string v_sys_state_name, string v_sys_state_code, string v_sys_state_remark);
        int UpdateSysState(int v_sys_state_id, string v_sys_state_name, string v_sys_state_code, string v_sys_state_remark);
        int UpdateSysState(int v_sys_state_id, int v_sys_state_value);
        int DelSysState(int v_sys_state_id);
        int GetSysStateValue(int v_sys_state_id);
        int GetSysStateCount(string v_sys_state_name, string v_sys_state_code);
        DataTable GetSysState(string v_sys_state_name, string v_sys_state_code);
        DataTable GetSysState(string v_sys_state_name, string v_sys_state_code,string v_sort,string v_order);
        DataTable GetSysState(int v_page, int v_rows, string v_sys_state_name, string v_sys_state_code, string v_sort, string v_order);
    }
}
