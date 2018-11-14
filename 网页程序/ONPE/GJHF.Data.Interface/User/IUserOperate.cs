using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace GJHF.Data.Interface.User
{
    public interface IUserOperate
    {
        /// <summary>
        /// 添加用户操作记录（菜单级别）
        /// </summary>
        /// <param name="v_user_id">用户编号</param>
        /// <param name="v_employee_name">员工姓名</param>
        /// <param name="v_operate_time">操作时间</param>
        /// <param name="v_equip_type">设备类型 1 电脑 2 手机 3 其他</param>
        /// <param name="v_equip_sign">设备标识</param>
        /// <param name="v_way_type">访问方式 1 浏览器 2 应用程序 3 其他</param>
        /// <param name="v_way_sign">访问标识</param>
        /// <param name="v_menu_link">菜单链接</param>
        /// <param name="v_menu_title">菜单名称</param>
        /// <param name="v_menu_extra">菜单扩展</param>
        /// <param name="v_operate_remark">操作备注</param>
        /// <returns>记录保存结果 1 成功 0 失败</returns>
        int AddUserOperateRecord(string v_user_id,string v_employee_name,DateTime v_operate_time, int v_equip_type, string v_equip_sign, int v_way_type, string v_way_sign, string v_menu_link, string v_menu_title, string v_menu_extra, string v_operate_remark);
    }
}
