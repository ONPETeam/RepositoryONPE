using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;

namespace GJHF.Data.Interface.TSD
{
    public  interface IExamineUnit
    {
        /// <summary>
        /// 中控审核申请
        /// </summary>
        /// <param name="v_request_type">申请单类别 0 停电单，1 送电单</param>
        /// <param name="v_request_id">申请单编号</param>
        /// <param name="v_examine_time">审核时间</param>
        /// <param name="v_examine_people">审核人</param>
        /// <param name="v_equip_code">设备编号</param>
        /// <param name="v_equip_value">设备值</param>
        /// <param name="v_value_time">取值时间</param>
        /// <param name="v_examine_result">审核结果 0 审核不通过 1 审核通过</param>
        /// <param name="v_examine_remark">审核结果说明</param>
        /// <returns></returns>
        int ExamineRequest(int v_request_type,string v_request_id, DateTime v_examine_time, string v_examine_people, string v_equip_code,
           string v_equip_value,DateTime v_value_time, int v_examine_result,string v_examine_remark);

        ///// <summary>
        ///// 撤销审核
        ///// </summary>
        ///// <param name="v_examine_id">审核单</param>
        ///// <returns>撤销结果 0 失败 1 成功</returns>
        //int CancelExamine(int v_examine_id);

        int GetExamineCount(int v_request_type, DateTime v_examine_start, DateTime v_examine_end, string v_examine_people, string v_equip_code,
            int v_examine_result, string v_examine_remark);

        DataTable GetExamineData(int v_page, int v_rows, int v_request_type, DateTime v_examine_start, DateTime v_examine_end, string v_examine_people, string v_equip_code,
            int v_examine_result, string v_examine_remark, string v_sort, string v_order);
        DataTable GetExamineData(int v_page, int v_rows, int v_request_type, DateTime v_examine_start, DateTime v_examine_end, string v_examine_people, string v_equip_code,
            int v_examine_result, string v_examine_remark);
        DataTable GetExamineData(int v_request_type, DateTime v_examine_start, DateTime v_examine_end, string v_examine_people, string v_equip_code,
            int v_examine_result, string v_examine_remark);
    }
}
