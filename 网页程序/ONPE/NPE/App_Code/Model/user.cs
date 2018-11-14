using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
///user 的摘要说明
/// </summary>
public class employeeuser
{
    /// <summary>
    /// 用户编号
    /// </summary>
    public string user_code { get; set; }
    /// <summary>
    /// 用户账号
    /// </summary>
    public string user_name { get; set; }
    /// <summary>
    /// 是否自动锁定  N>0    验证N次失败锁定该帐号  0  不锁定
    /// </summary>
    public int auto_lock { get; set; }
    /// <summary>
    /// 用户状态   0  正常 1 锁定  -1  注销
    /// </summary>
    public int user_state { get; set; }
    /// <summary>
    /// 用户创建时间
    /// </summary>
    public DateTime create_time { get; set; }
    /// <summary>
    /// 本次登陆时间
    /// </summary>
    public DateTime login_time { get; set; }
    /// <summary>
    /// 上次登录时间
    /// </summary>
    public DateTime lastlogin_time { get; set; }
    /// <summary>
    /// 总计登陆次数
    /// </summary>
    public long login_num { get; set; }
    /// <summary>
    /// 登陆IP
    /// </summary>
    public string login_address { get; set; }
    /// <summary>
    /// 用户备注
    /// </summary>
    public string user_remark { get; set; }
    /// <summary>
    /// 员工编号
    /// </summary>
    public string employee_code { get; set; }
    /// <summary>
    /// 员工姓名
    /// </summary>
    public string employee_name { get; set; }
    /// <summary>
    /// 部门编号
    /// </summary>
    public string branch_id { get; set; }
    /// <summary>
    /// 部门名称
    /// </summary>
    public string branch_name { get; set; }
    /// <summary>
    /// 公司编号
    /// </summary>
    public string company_id { get; set; }
    /// <summary>
    /// 公司名称
    /// </summary>
    public string company_name { get; set; }
}