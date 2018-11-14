using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace GJHF.Data.Interface.TSD
{
    public interface IConfirmUnit
    {
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
        /// <returns>提交成功 返回确认编号 提交失败，返回空</returns>
        string ConfirmPowerOff(string v_flow_id, string v_confirm_people, DateTime v_confirm_time, string v_location_info, string v_equip_code
            , int v_equip_status, string v_confirm_remark);
        
        /// <summary>
        /// 停电
        /// </summary>
        /// <param name="v_flow_id">停送电流程编号</param>
        /// <param name="v_poweroff_time">停电时间</param>
        /// <param name="v_poweroff_branch">停电部门</param>
        /// <param name="v_poweroff_employee">停电人</param>
        /// <returns>返回 0 提交成功 其他 提交失败  </returns>
        int PowerOff(string v_flow_id, DateTime v_poweroff_time, int v_poweroff_branch, string v_poweroff_employee);
        
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
        /// <returns>提交成功 返回确认编号 提交失败，返回空</returns>
        string ConfirmPowerOn(string v_flow_id, string v_confirm_people, DateTime v_confirm_time, string v_location_info, string v_equip_code
            , int v_equip_status, string v_confirm_remark);

        /// <summary>
        /// 送电
        /// </summary>
        /// <param name="v_flow_id">停送电流程编号</param>
        /// <param name="v_poweron_time">送电时间</param>
        /// <param name="v_poweron_branch">送电部门</param>
        /// <param name="v_poweron_employee">送电人</param>
        /// <returns>返回 0 提交成功 其他 提交失败</returns>
        int PowerOn(string v_flow_id, DateTime v_poweron_time, int v_poweron_branch, string v_poweron_employee);
    } 
}
