using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace GJHF.Data.Model.TSD
{
    public class MPowerOffRequest
    {
        public string poweroff_id { get; set; }
        public int request_status { get; set; }
        public int request_company { get; set; }
        public int request_branch { get; set; }
        public string request_people { get; set; }
        public DateTime request_time { get; set; }
        public string stop_equip { get; set; }
        public DateTime stop_time { get; set; }
        public float stop_duration { get; set; }
        public string request_remark { get; set; }
        public string company_name { get; set; }
        public string branch_name { get; set; }
        public string employee_name { get; set; }
        public string equip_name { get; set; }
    }
}
