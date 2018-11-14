using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;

namespace GJHF.Data.Interface.TSD
{
    public interface ITSDFlow
    {
        /// <summary>
        /// 获取未填写送电申请数
        /// </summary>
        /// <param name="v_flow_id">停送电流程编号</param>
        /// <returns>未填写送电申请数</returns>
        int GetNoRequestPowerOn(string v_flow_id);

        /// <summary>
        /// 归档停送电流程
        /// </summary>
        /// <param name="v_flow_id">停送电流程编号</param>
        /// <returns>是否归档成功 0 成功 1 失败</returns>
        int ArchiveTsdFlow(string v_flow_id);


        int GetTSDFlowCount(string v_equip_code, int v_flow_status, int v_poweroff_branch, string v_poweroff_employee, DateTime v_poweroff_start,
            DateTime v_poweroff_end, int v_poweron_branch, string v_poweron_employee, DateTime v_poweron_start, DateTime v_poweron_end,
            float v_timespan_min, float v_timespan_max);

        DataTable GetTSDFlowData(int v_page,int v_rows,string v_equip_code, int v_flow_status, int v_poweroff_branch, string v_poweroff_employee, DateTime v_poweroff_start,
            DateTime v_poweroff_end, int v_poweron_branch, string v_poweron_employee, DateTime v_poweron_start, DateTime v_poweron_end,
            float v_timespan_min, float v_timespan_max,string v_sort,string v_order);

        DataTable GetTSDFlowData(int v_page, int v_rows, string v_equip_code, int v_flow_status, int v_poweroff_branch, string v_poweroff_employee, DateTime v_poweroff_start,
            DateTime v_poweroff_end, int v_poweron_branch, string v_poweron_employee, DateTime v_poweron_start, DateTime v_poweron_end,
            float v_timespan_min, float v_timespan_max);

        DataTable GetTSDFlowData(string v_equip_code, int v_flow_status, int v_poweroff_branch, string v_poweroff_employee, DateTime v_poweroff_start,
            DateTime v_poweroff_end, int v_poweron_branch, string v_poweron_employee, DateTime v_poweron_start, DateTime v_poweron_end,
            float v_timespan_min, float v_timespan_max);

        int GetTSDFlowDetailCount(string v_flow_id);

        DataTable GetTSDFlowDetail(int v_page, int v_rows, string v_flow_id, string v_sort, string v_order);
    }
}
