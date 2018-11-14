using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;

namespace GJHF.Business.TSD
{
    public class TSDQuery
    {
        private GJHF.Data.Interface.TSD.IRequestUnit BRequestUnit;
        private GJHF.Data.Interface.TSD.IExamineUnit BExamineUnit;
        private GJHF.Data.Interface.TSD.IConfirmUnit BConfirmUnit;
        private GJHF.Data.Interface.TSD.ITSDFlow BTSDFlow;

        public TSDQuery()
        {
            this.BRequestUnit = GJHF.Data.Factory.TSD.FRequestUnit.Create();
            this.BExamineUnit = GJHF.Data.Factory.TSD.FExamineUnit.Create();
            this.BConfirmUnit = GJHF.Data.Factory.TSD.FConfirmUnit.Create();
            this.BTSDFlow = GJHF.Data.Factory.TSD.FTSDFlow.Create();
        }

        #region 停电申请相关
        /// <summary>
        /// 获取停电申请单记录数
        /// </summary>
        /// <param name="v_request_status">停电申请单状态 -99 已撤销/0 正常/1 已审核/2 已停电/3	已申请送电/4 已审核送电/5 已送电 -1 所有</param>
        /// <param name="v_request_company">停电申请公司</param>
        /// <param name="v_request_branch">停电申请部门</param>
        /// <param name="v_request_people">停电申请人</param>
        /// <param name="v_request_start">申请时间开始</param>
        /// <param name="v_request_end">申请时间结束</param>
        /// <param name="v_stop_equip">停电设备</param>
        /// <param name="v_stop_start">停电时间开始</param>
        /// <param name="v_stop_end">停电时间结束</param>
        /// <param name="v_stop_duration">停电时长</param>
        /// <returns></returns>
        public int GetPowerOffRequestCount(int v_request_status, int v_request_company, int v_request_branch, string v_request_people, DateTime v_request_start, DateTime v_request_end,
            string v_stop_equip, DateTime v_stop_start, DateTime v_stop_end, float v_stop_duration)
        {
            return BRequestUnit.GetPowerOffRequestCount(v_request_status, v_request_company, v_request_branch, v_request_people, v_request_start, v_request_end, v_stop_equip, v_stop_start, v_stop_end, v_stop_duration);
        }

        /// <summary>
        /// 获取停电申请单记录
        /// </summary>
        /// <param name="v_request_status">停电申请单状态 -99 已撤销/0 正常/1 已审核/2 已停电/3	已申请送电/4 已审核送电/5 已送电 -1 所有</param>
        /// <param name="v_request_company">停电申请公司</param>
        /// <param name="v_request_branch">停电申请部门</param>
        /// <param name="v_request_people">停电申请人</param>
        /// <param name="v_request_start">申请时间开始</param>
        /// <param name="v_request_end">申请时间结束</param>
        /// <param name="v_stop_equip">停电设备</param>
        /// <param name="v_stop_start">停电时间开始</param>
        /// <param name="v_stop_end">停电时间结束</param>
        /// <param name="v_stop_duration">停电时长</param>
        /// <returns></returns>
        public DataTable GetPowerOffRequest(int v_request_status, int v_request_company, int v_request_branch, string v_request_people, DateTime v_request_start,
            DateTime v_request_end, string v_stop_equip, DateTime v_stop_start, DateTime v_stop_end, float v_stop_duration)
        {
            return BRequestUnit.GetPowerOffRequest(v_request_status, v_request_company, v_request_branch, v_request_people, v_request_start, v_request_end, v_stop_equip, v_stop_start, v_stop_end, v_stop_duration);
        }

        /// <summary>
        /// 获取停电申请单记录
        /// </summary>
        /// <param name="v_page">分页查询时第几页</param>
        /// <param name="v_rows">分页查询时每页容量</param>
        /// <param name="v_request_status">停电申请单状态 -99 已撤销/0 正常/1 已审核/2 已停电/3	已申请送电/4 已审核送电/5 已送电 -1 所有</param>
        /// <param name="v_request_company">停电申请公司</param>
        /// <param name="v_request_branch">停电申请部门</param>
        /// <param name="v_request_people">停电申请人</param>
        /// <param name="v_request_start">申请时间开始</param>
        /// <param name="v_request_end">申请时间结束</param>
        /// <param name="v_stop_equip">停电设备</param>
        /// <param name="v_stop_start">停电时间开始</param>
        /// <param name="v_stop_end">停电时间结束</param>
        /// <param name="v_stop_duration">停电时长</param>
        /// <returns></returns>
        public DataTable GetPowerOffRequest(int v_page, int v_rows, int v_request_status, int v_request_company, int v_request_branch, string v_request_people, DateTime v_request_start,
            DateTime v_request_end, string v_stop_equip, DateTime v_stop_start, DateTime v_stop_end, float v_stop_duration)
        {
            return BRequestUnit.GetPowerOffRequest(v_page, v_rows, v_request_status, v_request_company, v_request_branch, v_request_people, v_request_start, v_request_end, v_stop_equip, v_stop_start, v_stop_end, v_stop_duration);
        }

        /// <summary>
        /// 获取停电申请单记录
        /// </summary>
        /// <param name="v_page">分页查询时第几页</param>
        /// <param name="v_rows">分页查询时每页容量</param>
        /// <param name="v_request_status">停电申请单状态 -99 已撤销/0 正常/1 已审核/2 已停电/3	已申请送电/4 已审核送电/5 已送电 -1 所有</param>
        /// <param name="v_request_company">停电申请公司</param>
        /// <param name="v_request_branch">停电申请部门</param>
        /// <param name="v_request_people">停电申请人</param>
        /// <param name="v_request_start">申请时间开始</param>
        /// <param name="v_request_end">申请时间结束</param>
        /// <param name="v_stop_equip">停电设备</param>
        /// <param name="v_stop_start">停电时间开始</param>
        /// <param name="v_stop_end">停电时间结束</param>
        /// <param name="v_stop_duration">停电时长</param>
        /// <param name="v_sort">排序列名</param>
        /// <param name="v_order">排序方式 desc 倒序 默认正序</param>
        /// <returns></returns>
        public DataTable GetPowerOffRequest(int v_page, int v_rows, int v_request_status, int v_request_company, int v_request_branch, string v_request_people, DateTime v_request_start,
            DateTime v_request_end, string v_stop_equip, DateTime v_stop_start, DateTime v_stop_end, float v_stop_duration, string v_sort, string v_order)
        {
            return BRequestUnit.GetPowerOffRequest(v_page, v_rows, v_request_status, v_request_company, v_request_branch, v_request_people, v_request_start, v_request_end, v_stop_equip, v_stop_start, v_stop_end, v_stop_duration, v_sort, v_order);
        }
        #endregion

        #region 送电申请相关
        /// <summary>
        /// 获取送电申请单记录数
        /// </summary>
        /// <param name="v_request_status">送电申请单状态 -99 已撤销/0 正常/1 已审核/2 已送电 </param>
        /// <param name="v_request_company">送电申请公司</param>
        /// <param name="v_request_branch">送电申请部门</param>
        /// <param name="v_request_people">送电申请人</param>
        /// <param name="v_request_start">申请时间开始</param>
        /// <param name="v_request_end">申请时间结束</param>
        /// <param name="v_stop_equip">送电设备</param>
        /// <param name="v_poweron_start">送电时间开始</param>
        /// <param name="v_poweron_end">送电时间开始</param>
        /// <returns></returns>
        public int GetPowerOnRequestCount(int v_request_status, int v_request_company, int v_request_branch, string v_request_people, DateTime v_request_start, DateTime v_request_end,
            string v_stop_equip, DateTime v_poweron_start, DateTime v_poweron_end)
        {
            return BRequestUnit.GetPowerOnRequestCount(v_request_status, v_request_company, v_request_branch, v_request_people, v_request_start, v_request_end, v_stop_equip, v_poweron_start, v_poweron_end);
        }

        /// <summary>
        /// 获取送电申请单记录
        /// </summary>
        /// <param name="v_page">分页查询时第几页</param>
        /// <param name="v_rows">分页查询时页面容量</param>
        /// <param name="v_request_status">送电申请单状态 -99 已撤销/0 正常/1 已审核/2 已送电</param>
        /// <param name="v_request_company">送电申请公司</param>
        /// <param name="v_request_branch">送电申请部门</param>
        /// <param name="v_request_people">送电申请人</param>
        /// <param name="v_request_start">申请时间开始</param>
        /// <param name="v_request_end">申请时间结束</param>
        /// <param name="v_stop_equip">送电设备</param>
        /// <param name="v_poweron_start">送电时间开始</param>
        /// <param name="v_poweron_end">送电时间结束</param>
        /// <param name="v_sort">排序列名</param>
        /// <param name="v_order">排序方式 默认或者为“”时正序 desc 倒序</param>
        /// <returns></returns>
        public DataTable GetPowerOnRequest(int v_page, int v_rows, int v_request_status, int v_request_company, int v_request_branch, string v_request_people, DateTime v_request_start,
            DateTime v_request_end, string v_stop_equip, DateTime v_poweron_start, DateTime v_poweron_end, string v_sort, string v_order)
        {
            return BRequestUnit.GetPowerOnRequest(v_page, v_rows, v_request_status, v_request_company, v_request_branch, v_request_people, v_request_start, v_request_end, v_stop_equip, v_poweron_start, v_poweron_end, v_sort, v_order);
        }

        /// <summary>
        /// 获取送电申请单记录
        /// </summary>
        /// <param name="v_page">分页查询时第几页</param>
        /// <param name="v_rows">分页查询时页面容量</param>
        /// <param name="v_request_status">送电申请单状态 -99 已撤销/0 正常/1 已审核/2 已送电</param>
        /// <param name="v_request_company">送电申请公司</param>
        /// <param name="v_request_branch">送电申请部门</param>
        /// <param name="v_request_people">送电申请人</param>
        /// <param name="v_request_start">申请时间开始</param>
        /// <param name="v_request_end">申请时间结束</param>
        /// <param name="v_stop_equip">送电设备</param>
        /// <param name="v_poweron_start">送电时间开始</param>
        /// <param name="v_poweron_end">送电时间结束</param>
        /// <returns></returns>
        public DataTable GetPowerOnRequest(int v_page, int v_rows, int v_request_status, int v_request_company, int v_request_branch, string v_request_people, DateTime v_request_start,
            DateTime v_request_end, string v_stop_equip, DateTime v_poweron_start, DateTime v_poweron_end)
        {
            return BRequestUnit.GetPowerOnRequest(v_page, v_rows, v_request_status, v_request_company, v_request_branch, v_request_people, v_request_start, v_request_end, v_stop_equip, v_poweron_start, v_poweron_end);
        }

        /// <summary>
        /// 获取送电申请单记录
        /// </summary>
        /// <param name="v_request_status">送电申请单状态 -99 已撤销/0 正常/1 已审核/2 已送电</param>
        /// <param name="v_request_company">送电申请公司</param>
        /// <param name="v_request_branch">送电申请部门</param>
        /// <param name="v_request_people">送电申请人</param>
        /// <param name="v_request_start">申请时间开始</param>
        /// <param name="v_request_end">申请时间结束</param>
        /// <param name="v_stop_equip">送电设备</param>
        /// <param name="v_poweron_start">送电时间开始</param>
        /// <param name="v_poweron_end">送电时间结束</param>
        /// <returns></returns>
        public DataTable GetPowerOnRequest(int v_request_status, int v_request_company, int v_request_branch, string v_request_people, DateTime v_request_start,
            DateTime v_request_end, string v_stop_equip, DateTime v_poweron_start, DateTime v_poweron_end)
        {
            return BRequestUnit.GetPowerOnRequest(v_request_status, v_request_company, v_request_branch, v_request_people, v_request_start, v_request_end, v_stop_equip, v_poweron_start, v_poweron_end);
        }
        public Dictionary<string, object> GetPowerOffDetailByID(string v_poweroff_id)
        {
            return BRequestUnit.GetPowerOffDetailByID(v_poweroff_id);
        }
        #endregion

        #region 审核相关
        /// <summary>
        /// 获取审核单记录数
        /// </summary>
        /// <param name="v_request_type">审核单类别 0 停电审核 1 送电审核</param>
        /// <param name="v_examine_start">审核时间开始</param>
        /// <param name="v_examine_end">审核时间结束</param>
        /// <param name="v_examine_people">审核人</param>
        /// <param name="v_equip_code">设备编号</param>
        /// <param name="v_examine_result">审核结果</param>
        /// <param name="v_examine_remark">审核结果说明</param>
        /// <returns></returns>
        public int GetExamineCount(int v_request_type, DateTime v_examine_start, DateTime v_examine_end, string v_examine_people, string v_equip_code,
            int v_examine_result, string v_examine_remark)
        {
            return BExamineUnit.GetExamineCount(v_request_type, v_examine_start, v_examine_end, v_examine_people, v_equip_code, v_examine_result, v_examine_remark);
        }

        /// <summary>
        /// 获取审核单记录
        /// </summary>
        /// <param name="v_page">第几页</param>
        /// <param name="v_rows">一页多少条</param>
        /// <param name="v_request_type">审核单类别 0 停电审核 1 送电审核</param>
        /// <param name="v_examine_start">审核时间开始</param>
        /// <param name="v_examine_end">审核时间结束</param>
        /// <param name="v_examine_people">审核人</param>
        /// <param name="v_equip_code">设备编号</param>
        /// <param name="v_examine_result">审核结果</param>
        /// <param name="v_examine_remark">审核结果说明</param>
        /// <param name="v_sort">排序列名</param>
        /// <param name="v_order">排序方式</param>
        /// <returns></returns>
        public DataTable GetExamineData(int v_page, int v_rows, int v_request_type, DateTime v_examine_start, DateTime v_examine_end, string v_examine_people, string v_equip_code,
            int v_examine_result, string v_examine_remark, string v_sort, string v_order)
        {
            return BExamineUnit.GetExamineData(v_page, v_rows, v_request_type, v_examine_start, v_examine_end, v_examine_people, v_equip_code, v_examine_result, v_examine_remark, v_sort, v_order);
        }

        /// <summary>
        /// 获取审核单记录
        /// </summary>
        /// <param name="v_page">第几页</param>
        /// <param name="v_rows">一页多少条</param>
        /// <param name="v_request_type">审核单类别 0 停电审核 1 送电审核</param>
        /// <param name="v_examine_start">审核时间开始</param>
        /// <param name="v_examine_end">审核时间结束</param>
        /// <param name="v_examine_people">审核人</param>
        /// <param name="v_equip_code">设备编号</param>
        /// <param name="v_examine_result">审核结果</param>
        /// <param name="v_examine_remark">审核结果说明</param>
        /// <returns></returns>
        public DataTable GetExamineData(int v_page, int v_rows, int v_request_type, DateTime v_examine_start, DateTime v_examine_end, string v_examine_people, string v_equip_code,
            int v_examine_result, string v_examine_remark)
        {
            return BExamineUnit.GetExamineData(v_page, v_rows, v_request_type, v_examine_start, v_examine_end, v_examine_people, v_equip_code, v_examine_result, v_examine_remark);
        }

        /// <summary>
        /// 获取审核单记录
        /// </summary>
        /// <param name="v_request_type">审核单类别 0 停电审核 1 送电审核</param>
        /// <param name="v_examine_start">审核时间开始</param>
        /// <param name="v_examine_end">审核时间结束</param>
        /// <param name="v_examine_people">审核人</param>
        /// <param name="v_equip_code">设备编号</param>
        /// <param name="v_examine_result">审核结果</param>
        /// <param name="v_examine_remark">审核结果说明</param>
        /// <returns></returns>
        public DataTable GetExamineData(int v_request_type, DateTime v_examine_start, DateTime v_examine_end, string v_examine_people, string v_equip_code,
            int v_examine_result, string v_examine_remark)
        {
            return BExamineUnit.GetExamineData(v_request_type, v_examine_start, v_examine_end, v_examine_people, v_equip_code, v_examine_result, v_examine_remark);
        }
        #endregion

        #region 流程相关

        /// <summary>
        /// 获取停送电流程记录数
        /// </summary>
        /// <param name="v_equip_code">设备编号</param>
        /// <param name="v_flow_status">流程状态 -99 已删除/0 申请中/1 已人工确认未停电/2 已停电/3 已送电/4 已归档</param>
        /// <param name="v_poweroff_branch">停电部门</param>
        /// <param name="v_poweroff_employee">停电执行人</param>
        /// <param name="v_poweroff_start">停电时间开始</param>
        /// <param name="v_poweroff_end">停电时间结束</param>
        /// <param name="v_poweron_branch">送电部门</param>
        /// <param name="v_poweron_employee">送电执行人</param>
        /// <param name="v_poweron_start">送电时间开始</param>
        /// <param name="v_poweron_end">送电时间结束</param>
        /// <param name="v_timespan_min">停电时长最小</param>
        /// <param name="v_timespan_max">停电时长最大</param>
        /// <returns></returns>
        public int GetTSDFlowCount(string v_equip_code, int v_flow_status, int v_poweroff_branch, string v_poweroff_employee, DateTime v_poweroff_start, DateTime v_poweroff_end, int v_poweron_branch, string v_poweron_employee, DateTime v_poweron_start, DateTime v_poweron_end, float v_timespan_min, float v_timespan_max)
        {
            return BTSDFlow.GetTSDFlowCount(v_equip_code, v_flow_status, v_poweroff_branch, v_poweroff_employee, v_poweroff_start, v_poweroff_end, v_poweron_branch, v_poweron_employee, v_poweron_start, v_poweron_end, v_timespan_min, v_timespan_max);
        }

        /// <summary>
        /// 获取停送电流程记录
        /// </summary>
        /// <param name="v_page">第几页</param>
        /// <param name="v_rows">每页多少条</param>
        /// <param name="v_equip_code">设备编号</param>
        /// <param name="v_flow_status">流程状态 -99 已删除/0 申请中/1 已人工确认未停电/2 已停电/3 已送电/4 已归档</param>
        /// <param name="v_poweroff_branch">停电部门</param>
        /// <param name="v_poweroff_employee">停电执行人</param>
        /// <param name="v_poweroff_start">停电时间开始</param>
        /// <param name="v_poweroff_end">停电时间结束</param>
        /// <param name="v_poweron_branch">送电部门</param>
        /// <param name="v_poweron_employee">送电执行人</param>
        /// <param name="v_poweron_start">送电时间开始</param>
        /// <param name="v_poweron_end">送电时间结束</param>
        /// <param name="v_timespan_min">停电时长最小</param>
        /// <param name="v_timespan_max">停电时长最大</param>
        /// <param name="v_sort">排序列名</param>
        /// <param name="v_order">排序方式</param>
        /// <returns></returns>
        public DataTable GetTSDFlowData(int v_page, int v_rows, string v_equip_code, int v_flow_status, int v_poweroff_branch, string v_poweroff_employee, DateTime v_poweroff_start, DateTime v_poweroff_end, int v_poweron_branch, string v_poweron_employee, DateTime v_poweron_start, DateTime v_poweron_end, float v_timespan_min, float v_timespan_max, string v_sort, string v_order)
        {
            return BTSDFlow.GetTSDFlowData(v_page, v_rows, v_equip_code, v_flow_status, v_poweroff_branch, v_poweroff_employee, v_poweroff_start, v_poweroff_end, v_poweron_branch, v_poweron_employee, v_poweron_start, v_poweron_end, v_timespan_min, v_timespan_max, v_sort, v_order);
        }

        /// <summary>
        /// 获取停送电流程记录
        /// </summary>
        /// <param name="v_page">第几页</param>
        /// <param name="v_rows">每页多少条</param>
        /// <param name="v_equip_code">设备编号</param>
        /// <param name="v_flow_status">流程状态 -99 已删除/0 申请中/1 已人工确认未停电/2 已停电/3 已送电/4 已归档</param>
        /// <param name="v_poweroff_branch">停电部门</param>
        /// <param name="v_poweroff_employee">停电执行人</param>
        /// <param name="v_poweroff_start">停电时间开始</param>
        /// <param name="v_poweroff_end">停电时间结束</param>
        /// <param name="v_poweron_branch">送电部门</param>
        /// <param name="v_poweron_employee">送电执行人</param>
        /// <param name="v_poweron_start">送电时间开始</param>
        /// <param name="v_poweron_end">送电时间结束</param>
        /// <param name="v_timespan_min">停电时长最小</param>
        /// <param name="v_timespan_max">停电时长最大</param>
        /// <returns></returns>
        public DataTable GetTSDFlowData(int v_page, int v_rows, string v_equip_code, int v_flow_status, int v_poweroff_branch, string v_poweroff_employee, DateTime v_poweroff_start, DateTime v_poweroff_end, int v_poweron_branch, string v_poweron_employee, DateTime v_poweron_start, DateTime v_poweron_end, float v_timespan_min, float v_timespan_max)
        {
            return BTSDFlow.GetTSDFlowData(v_page,v_rows,v_equip_code, v_flow_status, v_poweroff_branch, v_poweroff_employee, v_poweroff_start, v_poweroff_end, v_poweron_branch, v_poweron_employee, v_poweron_start, v_poweron_end, v_timespan_min, v_timespan_max);
        }

        /// <summary>
        /// 获取停送电流程记录
        /// </summary>
        /// <param name="v_equip_code">设备编号</param>
        /// <param name="v_flow_status">流程状态 -99 已删除/0 申请中/1 已人工确认未停电/2 已停电/3 已送电/4 已归档</param>
        /// <param name="v_poweroff_branch">停电部门</param>
        /// <param name="v_poweroff_employee">停电执行人</param>
        /// <param name="v_poweroff_start">停电时间开始</param>
        /// <param name="v_poweroff_end">停电时间结束</param>
        /// <param name="v_poweron_branch">送电部门</param>
        /// <param name="v_poweron_employee">送电执行人</param>
        /// <param name="v_poweron_start">送电时间开始</param>
        /// <param name="v_poweron_end">送电时间结束</param>
        /// <param name="v_timespan_min">停电时长最小</param>
        /// <param name="v_timespan_max">停电时长最大</param>
        /// <returns></returns>
        public DataTable GetTSDFlowData(string v_equip_code, int v_flow_status, int v_poweroff_branch, string v_poweroff_employee, DateTime v_poweroff_start, DateTime v_poweroff_end, int v_poweron_branch, string v_poweron_employee, DateTime v_poweron_start, DateTime v_poweron_end, float v_timespan_min, float v_timespan_max)
        {
            return BTSDFlow.GetTSDFlowData(v_equip_code, v_flow_status, v_poweroff_branch, v_poweroff_employee, v_poweroff_start, v_poweroff_end, v_poweron_branch, v_poweron_employee, v_poweron_start, v_poweron_end, v_timespan_min, v_timespan_max);
        }

        /// <summary>
        /// 获取详情数据总数
        /// </summary>
        /// <param name="v_flow_id"></param>
        /// <returns></returns>
        public int GetTSDFlowDetailCount(string v_flow_id)
        {
            return BTSDFlow.GetTSDFlowDetailCount(v_flow_id);
        }

        /// <summary>
        /// 获取详情数据
        /// </summary>
        /// <param name="v_page"></param>
        /// <param name="v_rows"></param>
        /// <param name="v_flow_id"></param>
        /// <param name="v_sort"></param>
        /// <param name="v_order"></param>
        /// <returns></returns>
        public DataTable GetTSDFlowDetail(int v_page, int v_rows, string v_flow_id, string v_sort, string v_order)
        {
            return BTSDFlow.GetTSDFlowDetail(v_page, v_rows, v_flow_id, v_sort, v_order);
        }

        #endregion

        
    }
}
