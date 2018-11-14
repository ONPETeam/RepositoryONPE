using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.ComponentModel;

namespace GJHF.Data.Model.TSD
{
    [DisplayName("申请单")]
    public class Form
    {
        [DisplayName("申请单编号")]
        public string request_id { get; set; }
        [DisplayName("申请公司")]
        public int request_company { get; set; }
        [DisplayName("申请单位")]
        public int request_branch { get; set; }
        [DisplayName("申请人")]
        public string request_people { get; set; }
        [DisplayName("申请时间")]
        public DateTime request_time { get; set; }
        [DisplayName("申请类别 0 停电申请 1 送电申请")]
        public int request_type { get; set; }
        [DisplayName("停送电设备")]
        public string stop_equip { get; set; }
        [DisplayName("停送电时间")]
        public DateTime stop_time { get; set; }
        [DisplayName("停电时长(小时)")]
        public float stop_duration { get; set; }
        [DisplayName("备注说明")]
        public string request_remark { get; set; }
        [DisplayName("是否处理")]
        public int is_exec { get; set; }
    }
}
