using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace GJHF.Business.TSD
{
    public class TSDOperate
    {
        private GJHF.Data.Interface.TSD.IRequestUnit BRequestUnit;
        private GJHF.Data.Interface.TSD.IExamineUnit BExamineUnit;
        private GJHF.Data.Interface.TSD.IConfirmUnit BConfirmUnit;
        private GJHF.Data.Interface.TSD.ITSDFlow BTSDFlow;

        public TSDOperate()
        {
            this.BRequestUnit = GJHF.Data.Factory.TSD.FRequestUnit.Create();
            this.BExamineUnit = GJHF.Data.Factory.TSD.FExamineUnit.Create();
            this.BConfirmUnit = GJHF.Data.Factory.TSD.FConfirmUnit.Create();
            this.BTSDFlow = GJHF.Data.Factory.TSD.FTSDFlow.Create();
        }

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
        /// <returns>添加成功 返回1 添加失败 返回0</returns>
        public int AddPowerOffRequest(int v_request_company, int v_request_branch, string v_request_people, DateTime v_request_time,
            string v_stop_equip, DateTime v_stop_time, float v_stop_duration, string v_request_remark)
        {
            string mStrPowerOffRequestId = BRequestUnit.AddPowerOffRequest(v_request_company, v_request_branch, v_request_people, v_request_time, v_stop_equip, v_stop_time, v_stop_duration, v_request_remark);
            if (mStrPowerOffRequestId != "")
            {
                return 1;
            }
            else
            {
                return 0;
            }
        }

        /// <summary>
        /// 撤销停电申请单
        /// </summary>
        /// <param name="v_poweroff_id">停电申请单编号</param>
        /// <returns>撤销是否成功  0 撤销失败  1 撤销成功</returns>
        public int CancelPowerOffRequest(string v_poweroff_id)
        {
            return BRequestUnit.CancelPowerOffRequest(v_poweroff_id);
        }

        /// <summary>
        /// 中控审核停电申请单
        /// </summary>
        /// <param name="v_poweroff_id">申请单编号</param>
        /// <param name="v_examine_time">审核时间</param>
        /// <param name="v_examine_people">审核人</param>
        /// <param name="v_equip_code">设备编号</param>
        /// <param name="v_equip_value">设备值</param>
        /// <param name="v_value_time">取值时间</param>
        /// <param name="v_examine_result">审核结果 0 审核不通过 1 审核通过</param>
        /// <param name="v_examine_remark">审核结果说明</param>
        /// <returns></returns>
        public int ExaminePowerOffRequest(string v_poweroff_id, DateTime v_examine_time, string v_examine_people, string v_equip_code,
           string v_equip_value, DateTime v_value_time, int v_examine_result, string v_examine_remark)
        {
            int mIntReturn = BExamineUnit.ExamineRequest(0, v_poweroff_id, v_examine_time, v_examine_people, v_equip_code, v_equip_value, v_value_time, v_examine_result, v_examine_remark);
            if (mIntReturn >= 0)
            {
                return 1;
            }
            else
            {
                return 0;
            }
        }

        /// <summary>
        /// 停电确认
        /// </summary>
        /// <param name="v_flow_id">停送电流程编号</param>
        /// <param name="v_confirm_people">确认人</param>
        /// <param name="v_confirm_time">确认时间</param>
        /// <param name="v_location_info">地理信息</param>
        /// <param name="v_equip_code">设备编号</param>
        /// <param name="v_equip_status">设备状态</param>
        /// <param name="v_confirm_remark">确认备注</param>
        /// <returns>提交成功 返回1 提交失败，返回0</returns>
        public int ConfirmPowerOff(string v_flow_id, string v_confirm_people, DateTime v_confirm_time, string v_location_info, string v_equip_code
            , int v_equip_status, string v_confirm_remark)
        {
            string mStrConfirmID = BConfirmUnit.ConfirmPowerOff(v_flow_id, v_confirm_people, v_confirm_time, v_location_info, v_equip_code, v_equip_status, v_confirm_remark);
            if (mStrConfirmID != "")
            {
                return 1;
            }
            else
            {
                return 0;
            }
        }

        /// <summary>
        /// 停电
        /// </summary>
        /// <param name="v_flow_id">停送电流程编号</param>
        /// <param name="v_poweroff_time">停电时间</param>
        /// <param name="v_poweroff_branch">停电部门</param>
        /// <param name="v_poweroff_employee">停电人</param>
        /// <returns>返回 1 停电成功 0 停电失败  </returns>
        public int PowerOff(string v_flow_id, DateTime v_poweroff_time, int v_poweroff_branch, string v_poweroff_employee)
        {
            int mIntReturn= BConfirmUnit.PowerOff(v_flow_id, v_poweroff_time, v_poweroff_branch, v_poweroff_employee);
            if (mIntReturn >= 0)
            {
                return 1;
            }
            else
            {
                return 0;
            }
        }

        /// <summary>
        /// 添加送电申请单
        /// </summary>
        /// <param name="v_poweroff_id">停电申请单编号</param>
        /// <param name="v_request_company">送电申请公司</param>
        /// <param name="v_request_branch">送电申请部门</param>
        /// <param name="v_request_people">送电申请人</param>
        /// <param name="v_request_time">请求时间</param>
        /// <param name="v_star_time">送电时间</param>
        /// <param name="v_request_remark">送电备注</param>
        /// <returns>添加成功 返回1 添加失败 返回0</returns>
        public int AddPowerOnRequest(string v_poweroff_id, int v_request_company, int v_request_branch, string v_request_people, DateTime v_request_time,
            DateTime v_star_time, string v_request_remark)
        {
            string mStrPowerOnId = BRequestUnit.AddPowerOnRequest(v_poweroff_id, v_request_company, v_request_branch, v_request_people, v_request_time, v_star_time, v_request_remark);
            if (mStrPowerOnId != "")
            {
                return 1;
            }
            else
            {
                return 0;
            }
        }

        /// <summary>
        /// 撤销送电申请单
        /// </summary>
        /// <param name="v_poweron_id">送电申请单编号</param>
        /// <returns>撤销是否成功  0 撤销失败 1 撤销成功</returns>
        public int CancelPowerOnRequest(string v_poweron_id)
        {
            return BRequestUnit.CancelPowerOnRequest(v_poweron_id);
        }

        /// <summary>
        /// 中控审核送电申请单
        /// </summary>
        /// <param name="v_poweron_id">送电申请单编号</param>
        /// <param name="v_examine_time">审核时间</param>
        /// <param name="v_examine_people">审核人</param>
        /// <param name="v_equip_code">设备编号</param>
        /// <param name="v_equip_value">设备值</param>
        /// <param name="v_value_time">取值时间</param>
        /// <param name="v_examine_result">审核结果 0 审核不通过 1 审核通过</param>
        /// <param name="v_examine_remark">审核结果说明</param>
        /// <returns></returns>
        public int ExaminePowerOnRequest(string v_poweron_id, DateTime v_examine_time, string v_examine_people, string v_equip_code,
           string v_equip_value, DateTime v_value_time, int v_examine_result, string v_examine_remark)
        {
            int mIntReturn = BExamineUnit.ExamineRequest(1, v_poweron_id, v_examine_time, v_examine_people, v_equip_code, v_equip_value, v_value_time, v_examine_result, v_examine_remark);
            if (mIntReturn >=0)
            {
                return 1;
            }
            else
            {
                return 0;
            }
        }

        /// <summary>
        /// 送电确认
        /// </summary>
        /// <param name="v_flow_id">停送电流程编号</param>
        /// <param name="v_confirm_people">确认人</param>
        /// <param name="v_confirm_time">确认时间</param>
        /// <param name="v_location_info">地理信息</param>
        /// <param name="v_equip_code">设备编号</param>
        /// <param name="v_equip_status">设备状态</param>
        /// <param name="v_confirm_remark">确认备注</param>
        /// <returns>提交成功 返回1 提交失败，返回0</returns>
        public int ConfirmPowerOn(string v_flow_id, string v_confirm_people, DateTime v_confirm_time, string v_location_info, string v_equip_code
            , int v_equip_status, string v_confirm_remark)
        {
            string mStrConfirmID = BConfirmUnit.ConfirmPowerOn(v_flow_id, v_confirm_people, v_confirm_time, v_location_info, v_equip_code, v_equip_status, v_confirm_remark);
            if (mStrConfirmID != "")
            {
                return 1;
            }
            else
            {
                return 0;
            }
        }

        /// <summary>
        /// 送电
        /// </summary>
        /// <param name="v_flow_id">停送电流程编号</param>
        /// <param name="v_poweron_time">送电时间</param>
        /// <param name="v_poweron_branch">送电部门</param>
        /// <param name="v_poweron_employee">送电人</param>
        /// <returns>返回 0 提交成功 其他 提交失败</returns>
        public int PowerOn(string v_flow_id, DateTime v_poweron_time, int v_poweron_branch, string v_poweron_employee)
        {
            int mIntReturn = BConfirmUnit.PowerOn(v_flow_id, v_poweron_time, v_poweron_branch, v_poweron_employee);
            if (mIntReturn >= 0)
            {
                return 1;
            }
            else
            {
                return 0;
            }
        }
        
        /// <summary>
        /// 归档停送电流程
        /// </summary>
        /// <param name="v_flow_id">停送电流程编号</param>
        /// <returns>是否归档成功 1 成功 0 失败</returns>
        public int ArchiveFlow(string v_flow_id)
        {
            int mIntRetun = BTSDFlow.ArchiveTsdFlow(v_flow_id);
            if (mIntRetun >= 0)
            {
                return 1;
            }
            else
            {
                return 0;
            }
        }
    }
}
