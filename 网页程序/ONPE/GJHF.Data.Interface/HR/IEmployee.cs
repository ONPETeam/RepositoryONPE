using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;

namespace GJHF.Data.Interface.HR
{
    public interface IEmployee
    {
        /// <summary>
        /// 查询员工数
        /// </summary>
        /// <param name="v_employee_name">员工姓名，支持模糊查询</param>
        /// <param name="v_idcard_no">身份证，支持模糊查询</param>
        /// <param name="v_employee_innum">员工编号，支持模糊查询</param>
        /// <param name="v_telphone_no">手机号，支持模糊查询</param>
        /// <param name="v_visagetype_id">政治面貌编号</param>
        /// <param name="v_nation_id">民族编号</param>
        /// <param name="v_marital_status">婚姻状况</param>
        /// <param name="v_education_id">教育程度编号</param>
        /// <param name="v_specialty_name">相关专业，支持模糊查询</param>
        /// <returns>员工数</returns>
        int GetEmployeeCount(string v_employee_name, string v_idcard_no, string v_employee_innum, string v_telphone_no, int v_visagetype_id,
            int v_nation_id, string v_marital_status, int v_education_id, string v_specialty_name);
        /// <summary>
        /// 添加新员工，接受从用户管理服务器传输过来的员工基础数据
        /// </summary>
        /// <param name="v_employee_name">员工姓名</param>
        /// <param name="v_user_id">用户编号</param>
        /// <param name="v_telphone_no">手机号</param>
        /// <param name="v_mail_address">邮箱</param>
        /// <returns></returns>
        int AddNewEmployee(string v_employee_name, string v_user_id, string v_telphone_no, string v_mail_address);
        /// <summary>
        /// 修改员工基础信息，用户管理服务器数据更改时执行此方法
        /// </summary>
        /// <param name="v_user_id">用户编号</param>
        /// <param name="v_employee_name">员工姓名</param>
        /// <param name="v_telphone_no">手机号</param>
        /// <param name="v_mail_address">邮箱</param>
        /// <returns></returns>
        int UpdateEmployee(string v_user_id, string v_employee_name, string v_telphone_no, string v_mail_address);
        /// <summary>
        /// 更新员工扩展信息
        /// </summary>
        /// <param name="v_employee_code">员工编号</param>
        /// <param name="v_employee_innum">员工编码，预留给系统设定</param>
        /// <param name="v_employee_sex">员工性别</param>
        /// <param name="v_idcard_no">身份证号码</param>
        /// <param name="v_city_id">籍贯城市编号</param>
        /// <param name="v_home_address">家庭住址</param>
        /// <param name="v_nation_id">民族编号</param>
        /// <param name="v_visagetype_id">政治面貌编号</param>
        /// <param name="v_marital_status">婚姻状况</param>
        /// <param name="v_education_id">教育程度编号</param>
        /// <param name="v_graduate_time">毕业时间</param>
        /// <param name="v_graduate_school">毕业院校</param>
        /// <param name="v_specialty_name">所学专业</param>
        /// <returns></returns>
        int UpdateEmployee(string v_employee_code, string v_employee_innum, string v_employee_sex, string v_idcard_no, long v_city_id,
            string v_home_address, int v_nation_id, int v_visagetype_id, string v_marital_status, int v_education_id, DateTime v_graduate_time, 
            string v_graduate_school, string v_specialty_name);
        /// <summary>
        /// 设置员工部门信息
        /// </summary>
        /// <param name="v_employee_code">员工编号</param>
        /// <param name="v_branch_id">部门编号</param>
        /// <returns></returns>
        int SetBranch(string v_employee_code, int v_branch_id);
        /// <summary>
        /// 删除员工信息，用户管理服务器端删除用户后执行此方法
        /// </summary>
        /// <param name="v_user_id">用户编号</param>
        /// <returns></returns>
        int DelEmployee(string v_user_id);

        /// <summary>
        /// 分页查询员工，支持按字段排序
        /// </summary>
        /// <param name="v_page">页码</param>
        /// <param name="v_rows">页容量</param>
        /// <param name="v_employee_name">员工姓名，支持模糊查询</param>
        /// <param name="v_idcard_no">身份证，支持模糊查询</param>
        /// <param name="v_employee_innum">员工编号，支持模糊查询</param>
        /// <param name="v_telphone_no">手机号，支持模糊查询</param>
        /// <param name="v_visagetype_id">政治面貌编号</param>
        /// <param name="v_nation_id">民族编号</param>
        /// <param name="v_marital_status">婚姻状况</param>
        /// <param name="v_education_id">教育程度编号</param>
        /// <param name="v_specialty_name">相关专业，支持模糊查询</param>
        /// <param name="v_sort">排序列名称</param>
        /// <param name="v_order">排序方式，DESC ESC</param>
        /// <returns></returns>
        DataTable GetEmployee(int v_page, int v_rows, string v_employee_name, string v_idcard_no, string v_employee_innum, string v_telphone_no, int v_visagetype_id,
            int v_nation_id, string v_marital_status, int v_education_id, string v_specialty_name, string v_sort, string v_order);

        /// <summary>
        /// 查询员工，支持按字段排序
        /// </summary>
        /// <param name="v_employee_name">员工姓名，支持模糊查询</param>
        /// <param name="v_idcard_no">身份证，支持模糊查询</param>
        /// <param name="v_employee_innum">员工编号，支持模糊查询</param>
        /// <param name="v_telphone_no">手机号，支持模糊查询</param>
        /// <param name="v_visagetype_id">政治面貌编号</param>
        /// <param name="v_nation_id">民族编号</param>
        /// <param name="v_marital_status">婚姻状况</param>
        /// <param name="v_education_id">教育程度编号</param>
        /// <param name="v_specialty_name">相关专业，支持模糊查询</param>
        /// <param name="v_sort">排序列名称</param>
        /// <param name="v_order">排序方式，DESC ESC</param>
        /// <returns></returns>
        DataTable GetEmployee(string v_employee_name, string v_idcard_no, string v_employee_innum, string v_telphone_no, int v_visagetype_id,
            int v_nation_id, string v_marital_status, int v_education_id, string v_specialty_name, string v_sort, string v_order);

        /// <summary>
        /// 查询员工
        /// </summary>
        /// <param name="v_employee_name">员工姓名，支持模糊查询</param>
        /// <param name="v_idcard_no">身份证，支持模糊查询</param>
        /// <param name="v_employee_innum">员工编号，支持模糊查询</param>
        /// <param name="v_telphone_no">手机号，支持模糊查询</param>
        /// <param name="v_visagetype_id">政治面貌编号</param>
        /// <param name="v_nation_id">民族编号</param>
        /// <param name="v_marital_status">婚姻状况</param>
        /// <param name="v_education_id">教育程度编号</param>
        /// <param name="v_specialty_name">相关专业，支持模糊查询</param>
        /// <returns></returns>
        DataTable GetEmployee(string v_employee_name, string v_idcard_no, string v_employee_innum, string v_telphone_no, int v_visagetype_id,
            int v_nation_id, string v_marital_status, int v_education_id, string v_specialty_name);

        Dictionary<string, object> GetEmployeeByUserID(string mStrUserID);

        Dictionary<string, object> GetEmployeeByEmployeeCode(string v_employee_code);

        DataTable GetEmployee(int v_branch_id);

        int GetEmployeeCount(int v_branch_id);
    }
}
