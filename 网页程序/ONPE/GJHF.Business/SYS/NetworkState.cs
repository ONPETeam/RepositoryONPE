using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace GJHF.Business.SYS
{
    public class NetworkState
    {
        private readonly static string m_network_alarm_key = "networkalarm";
        private Data.Interface.SYS.ISystemSet BSystemSet;
        public NetworkState()
        {
            this.BSystemSet = Data.Factory.SYS.FSystemSet.Create();
        }
        public string GetNetworkSet()
        {
            return this.BSystemSet.GetSystemSet(m_network_alarm_key);
        }
        public GJHF.Data.Model.SYS.MNetworkAlarmSet GetNetworkSetModel()
        {
            GJHF.Data.Model.SYS.MNetworkAlarmSet mMNetworkAlarmSet = null;
            try
            {
                mMNetworkAlarmSet = (GJHF.Data.Model.SYS.MNetworkAlarmSet)Newtonsoft.Json.JsonConvert.DeserializeObject<GJHF.Data.Model.SYS.MNetworkAlarmSet>(GetNetworkSet());
            }
            catch (Exception e)
            {
 
            }
            return mMNetworkAlarmSet;
        }
        public int SaveNetworkSet(int v_alarm_when_disconnect,long v_alarm_time_span,string v_disconnect_employee_code, string v_disconnect_employee_name, int v_alarm_when_connect, string v_connect_employee_code, string v_connect_employee_name)
        {
            GJHF.Data.Model.SYS.MNetworkAlarmSet mMNetworkAlarmSet = new Data.Model.SYS.MNetworkAlarmSet();
            mMNetworkAlarmSet.alarm_when_disconnect = v_alarm_when_disconnect;
            mMNetworkAlarmSet.alarm_time_span = v_alarm_time_span;
            mMNetworkAlarmSet.disconnect_employee_code = v_disconnect_employee_code;
            mMNetworkAlarmSet.disconnect_employee_name = v_disconnect_employee_name;
            mMNetworkAlarmSet.alarm_when_connect = v_alarm_when_connect;
            mMNetworkAlarmSet.connect_employee_code = v_connect_employee_code;
            mMNetworkAlarmSet.connect_employee_name = v_connect_employee_name;
            string mStrNetworkSet = Newtonsoft.Json.JsonConvert.SerializeObject(mMNetworkAlarmSet);
            return this.BSystemSet.SaveSystemSet(m_network_alarm_key, mStrNetworkSet);
        }

        public DateTime GetLastWriteTime()
        {
            GJHF.Data.Model.SYS.MNetworkWriteContext mMNetworkWriteContext = BSystemSet.GetLastWriteContext();
            if (mMNetworkWriteContext != null && mMNetworkWriteContext.alarm_last_write_time != null)
            {
                return mMNetworkWriteContext.alarm_last_write_time;
            }
            else
            {
                return DateTime.Parse("2000-01-01");
            }
        }
    }
}
