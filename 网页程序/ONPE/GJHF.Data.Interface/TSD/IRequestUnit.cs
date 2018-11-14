using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;

namespace GJHF.Data.Interface.TSD
{
    public interface IRequestUnit
    {
        #region 停电相关
        /// <summary>
        /// 添加停电申请单
        /// </summary>
        /// <param name="v_request_company">申请公司</param>
        /// <param name="v_request_branch">部门</param>
        /// <param name="v_request_people">申请人</param>
        /// <param name="v_request_time">申请时间</param>
        /// <param name="v_stop_equip">停电设备</param>
        /// <param name="v_stop_time">停电时间</param>
        /// <param name="v_stop_duration">停电时长（小时）</param>
        /// <param name="v_request_remark">停电备注</param>
        /// <returns>添加成功 返回申请单号 添加失败 返回空</returns>
        string AddPowerOffRequest(int v_request_company, int v_request_branch, string v_request_people, DateTime v_request_time,
            string v_stop_equip, DateTime v_stop_time, float v_stop_duration, string v_request_remark);
        /// <summary>
        /// 撤销停电申请单
        /// </summary>
        /// <param name="v_poweroff_id">停电申请单编号</param>
        /// <returns>撤销是否成功  -1 已审核，不可撤销  1 撤销成功</returns>
        int CancelPowerOffRequest(string v_poweroff_id);

        int GetPowerOffRequestCount(int v_request_status, int v_request_company, int v_request_branch, string v_request_people, DateTime v_request_start, DateTime v_request_end,
            string v_stop_equip, DateTime v_stop_start, DateTime v_stop_end, float v_stop_duration);
        DataTable GetPowerOffRequest(int v_page, int v_rows, int v_request_status, int v_request_company, int v_request_branch, string v_request_people, DateTime v_request_start,
            DateTime v_request_end, string v_stop_equip, DateTime v_stop_start, DateTime v_stop_end, float v_stop_duration, string v_sort, string v_order);
        DataTable GetPowerOffRequest(int v_page, int v_rows, int v_request_status, int v_request_company, int v_request_branch, string v_request_people, DateTime v_request_start,
            DateTime v_request_end, string v_stop_equip, DateTime v_stop_start, DateTime v_stop_end, float v_stop_duration);
        DataTable GetPowerOffRequest(int v_request_status, int v_request_company, int v_request_branch, string v_request_people, DateTime v_request_start,
            DateTime v_request_end, string v_stop_equip, DateTime v_stop_start, DateTime v_stop_end, float v_stop_duration);
        Dictionary<string, object> GetPowerOffDetailByID(string v_poweroff_id);
        #endregion

        #region 送电相关
        /// <summary>
        /// 添加送电申请单
        /// </summary>
        /// <param name="v_request_id">停电申请单编号</param>
        /// <param name="v_request_company">送电申请公司</param>
        /// <param name="v_request_branch">送电申请部门</param>
        /// <param name="v_request_people">送电申请人</param>
        /// <param name="v_request_time">请求时间</param>
        /// <param name="v_star_time">送电时间</param>
        /// <param name="v_request_remark">送电备注</param>
        /// <returns>添加成功 返回申请单号 添加失败 返回空</returns>
        string AddPowerOnRequest(string v_poweroff_id,int v_request_company, int v_request_branch, string v_request_people, DateTime v_request_time,
            DateTime v_star_time, string v_request_remark);
        /// <summary>
        /// 撤销送电申请单
        /// </summary>
        /// <param name="v_poweron_id">送电申请单编号</param>
        /// <returns>撤销是否成功  -1 已审核，不可撤销  1 撤销成功</returns>
        int CancelPowerOnRequest(string v_poweron_id);

        int GetPowerOnRequestCount(int v_request_status, int v_request_company, int v_request_branch, string v_request_people, DateTime v_request_start, DateTime v_request_end,
            string v_stop_equip, DateTime v_poweron_start, DateTime v_poweron_end);
        DataTable GetPowerOnRequest(int v_page, int v_rows, int v_request_status, int v_request_company, int v_request_branch, string v_request_people, DateTime v_request_start,
            DateTime v_request_end, string v_stop_equip, DateTime v_poweron_start, DateTime v_poweron_end, string v_sort, string v_order);
        DataTable GetPowerOnRequest(int v_page, int v_rows, int v_request_status, int v_request_company, int v_request_branch, string v_request_people, DateTime v_request_start,
            DateTime v_request_end, string v_stop_equip, DateTime v_poweron_start, DateTime v_poweron_end);
        DataTable GetPowerOnRequest(int v_request_status, int v_request_company, int v_request_branch, string v_request_people, DateTime v_request_start,
            DateTime v_request_end, string v_stop_equip, DateTime v_poweron_start, DateTime v_poweron_end);
        
        #endregion
    }
}
