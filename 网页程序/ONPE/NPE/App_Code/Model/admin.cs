using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace ModelClass
{
    public class updateapp
    {
        public string record_id { get; set; }
        public string record_time { get; set; }
        public string platform_type { get; set; }
        public string platform_guid { get; set; }
        public string app_name { get; set; }
        public string region_name { get; set; }
        public string region_code { get; set; }
        public string low_region_code { get; set; }
        public string force_update { get; set; }
        public string update_time { get; set; }
        public string update_address { get; set; }
        public string update_context { get; set; }
    }
}