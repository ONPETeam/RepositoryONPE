using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;

namespace GJHF.Business.SYS
{
    public class SysState
    {
        private Data.Interface.SYS.ISysState BSysState;
        public SysState()
        {
            this.BSysState = Data.Factory.SYS.FSysState.Create();
        }
        public int AddSysState(string v_sys_state_name, string v_sys_state_code, string v_sys_state_remark)
        {
            return BSysState.AddSysState(v_sys_state_name, v_sys_state_code, v_sys_state_remark);
        }
        public int UpdateSysState(int v_sys_state_id, string v_sys_state_name, string v_sys_state_code, string v_sys_state_remark)
        {
            return BSysState.UpdateSysState(v_sys_state_id, v_sys_state_name, v_sys_state_code, v_sys_state_remark);
        }
        public int UpdateSysState(int v_sys_state_id, int v_sys_state_value)
        {
            return BSysState.UpdateSysState(v_sys_state_id, v_sys_state_value);
        }
        public int GetSysStateValue(int v_sys_state_id)
        {
            return BSysState.GetSysStateValue(v_sys_state_id);
        }
        public int DelSysState(int v_sys_state_id)
        {
            return BSysState.DelSysState(v_sys_state_id);
        }
        public int GetSysStateCount(string v_sys_state_name, string v_sys_state_code)
        {
            return BSysState.GetSysStateCount(v_sys_state_name, v_sys_state_code);
        }
        public DataTable GetSysState(string v_sys_state_name, string v_sys_state_code)
        {
            return BSysState.GetSysState(v_sys_state_name, v_sys_state_code);
        }
        public DataTable GetSysState(string v_sys_state_name, string v_sys_state_code, string v_sort, string v_order)
        {
            return BSysState.GetSysState(v_sys_state_name, v_sys_state_code, v_sort, v_order);
        }
        public DataTable GetSysState(int v_page, int v_rows, string v_sys_state_name, string v_sys_state_code, string v_sort, string v_order)
        {
            return BSysState.GetSysState(v_page, v_rows, v_sys_state_name, v_sys_state_code, v_sort, v_order);
        }
    }
}
