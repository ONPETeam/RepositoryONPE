using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace GJHF.Data.Model.SYS
{
    public class MNetworkAlarmSet
    {
        public long alarm_time_span { get; set; }
        public int alarm_when_disconnect { get; set; }
        public string disconnect_employee_code { get; set; }
        public string disconnect_employee_name { get; set; }
        public int alarm_when_connect { get; set; }
        public string connect_employee_code { get; set; }
        public string connect_employee_name { get; set; }
    }
    public class MNetworkWriteContext
    {
        public int alarm_id { get; set; }
        public string alarm_server_code { get; set; }
        public DateTime alarm_last_write_time { get; set; }
        public string alarm_remark { get; set; }
        public int alarm_state { get; set; }
    }

    
}
