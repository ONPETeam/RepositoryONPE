using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.ComponentModel;

namespace GJHF.Data.Model.FLOW.DESIGN
{
    public class MFlowDesignLine
    {
        [DisplayName("设计条件编号")]
        public string line_id { get; set; }
        [DisplayName("流程编号")]
        public string flow_id { get; set; }
        [DisplayName("版本编号")]
        public string version_id { get; set; }
        [DisplayName("开始步骤")]
        public string step_start { get; set; }
        [DisplayName("结束步骤")]
        public string step_stop { get; set; }
        [DisplayName("条件类型")]
        public string line_style { get; set; }
        [DisplayName("流转方式")]
        public string start_type { get; set; }
        [DisplayName("事件代码")]
        public string event_code { get; set; }
        [DisplayName("定时事件")]
        public DateTime start_time { get; set; }
        [DisplayName("数据库链接")]
        public string database_connect { get; set; }
        [DisplayName("表/(视图)名")]
        public string table_name { get; set; }
        [DisplayName("字段")]
        public string field_name { get; set; }
        [DisplayName("值")]
        public string set_value { get; set; }

    }
}
