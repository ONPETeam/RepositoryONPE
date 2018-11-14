using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.ComponentModel;

namespace GJHF.Data.Model.FLOW.VERSION
{
    public class MFlowVersion
    {
        public string version_id { get; set; }
        public string flow_id { get; set; }
        public string flow_name { get; set; }
        public string flow_type { get; set; }
        public string flow_type_name { get; set; }
        public string flow_descript { get; set; }
        public DateTime datetime { get; set; }
        public string update_people { get; set; }
        public string version_remark { get; set; }
        [DisplayName("是否有设计内容 0 未设计 1 已设计")]
        public int is_design { get; set; }
        [DisplayName("是否为运行版本 0 未运行 1 已运行")]
        public int is_run { get; set; }

        public DESIGN.MFlowWFJson wf_json { get; set; }
    }
}
