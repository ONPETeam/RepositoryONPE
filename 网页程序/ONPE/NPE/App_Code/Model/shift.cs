using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
///shift 的摘要说明
/// </summary>
public class shift
{
    /// <summary>
    /// 交接班编号
    /// </summary>
    public string shift_code { get; set; }
    /// <summary>
    /// 初始化时间
    /// </summary>
    public string inti_time { get; set; }
    /// <summary>
    /// 记录日期
    /// </summary>
    public string shift_date { get; set; }
    /// <summary>
    /// 部门编号
    /// </summary>
    public string branch_id { get; set; }
    /// <summary>
    /// 部门名称
    /// </summary>
    public string branch_name { get; set; }
    /// <summary>
    /// 班别编号
    /// </summary>
    public string classtype_code { get; set; }
    /// <summary>
    /// 班别名称
    /// </summary>
    public string classtype_name { get; set; }
    /// <summary>
    /// 班次编号
    /// </summary>
    public string classnum_code { get; set; }
    /// <summary>
    /// 班次名称
    /// </summary>
    public string classnum_name { get; set; }
    /// <summary>
    /// 应到人数
    /// </summary>
    public string must_num { get; set; }
    /// <summary>
    /// 应到人员编号
    /// </summary>
    public string must_peop_id { get; set; }
    /// <summary>
    /// 应到人员名称
    /// </summary>
    public string must_peop_name { get; set; }
    /// <summary>
    /// 实到人数
    /// </summary>
    public string attend_num { get; set; }
    /// <summary>
    /// 实到人员编号
    /// </summary>
    public string attend_peop_id { get; set; }
    /// <summary>
    /// 实到人员名称
    /// </summary>
    public string attend_peop_name { get; set; }
    /// <summary>
    /// 缺席人员编号
    /// </summary>
    public string absente_peop_id { get; set; }
    /// <summary>
    /// 缺席人员名称
    /// </summary>
    public string absente_peop_name { get; set; }
    /// <summary>
    /// 缺席原因
    /// </summary>
    public string absente_reason { get; set; }
    /// <summary>
    /// 交班人员编号
    /// </summary>
    public string hand_peop_id { get; set; }
    /// <summary>
    /// 交班人员名称
    /// </summary>
    public string hand_peop_name { get; set; }
    /// <summary>
    /// 交班时间
    /// </summary>
    public string hand_time { get; set; }
    /// <summary>
    /// 接班人员编号
    /// </summary>
    public string duty_peop_id { get; set; }
    /// <summary>
    /// 接班人员名称
    /// </summary>
    public string duty_peop_name { get; set; }
    /// <summary>
    /// 接班时间
    /// </summary>
    public string duty_time { get; set; }
    /// <summary>
    /// 影响台时
    /// </summary>
    public string effect_time { get; set; }
    /// <summary>
    /// 设备运行状态
    /// </summary>
    public string run_state { get; set; }
    /// <summary>
    /// 工作总结
    /// </summary>
    public string work_context { get; set; }
    /// <summary>
    /// 设备缺陷
    /// </summary>
    public string mater_defect { get; set; }
    /// <summary>
    /// 工具仪表
    /// </summary>
    public string instrument_state { get; set; }
    /// <summary>
    /// 交接班备注
    /// </summary>
    public string shift_remark { get; set; }
    /// <summary>
    /// 交接班状态
    /// </summary>
    public string jiaojie_flag { get; set; }
}