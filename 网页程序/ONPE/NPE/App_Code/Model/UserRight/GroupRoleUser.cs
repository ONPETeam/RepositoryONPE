using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
///GroupRoleUser 的摘要说明
/// </summary>
public class group
{
    /// <summary>
    /// group_code
    /// </summary>		
    public string group_code { get; set; }
    /// <summary>
    /// group_name
    /// </summary>		
    public string group_name { get; set; }
    /// <summary>
    /// group_type
    /// </summary>		
    public int group_type { get; set; }
    /// <summary>
    /// group_discript
    /// </summary>		
    public string group_discript { get; set; }
    /// <summary>
    /// create_time
    /// </summary>		
    public DateTime create_time { get; set; }
    /// <summary>
    /// flag_valid
    /// </summary>		
    public int flag_valid { get; set; }
    /// <summary>
    /// lost_time
    /// </summary>		
    public DateTime lost_time { get; set; }

}
public class userGroup
{
    /// <summary>
    /// 用户编码
    /// </summary>		
    public string user_code { get; set; }
    /// <summary>
    /// 用户名
    /// </summary>
    public string user_name { get; set; }
    /// <summary>
    /// 是否自动锁定
    /// </summary>
    public int auto_lock { get; set; }
    /// <summary>
    /// 用户状态
    /// </summary>
    public int user_state { get; set; }
    /// <summary>
    /// 创建时间
    /// </summary>
    public string user_create_time { get; set; }
    /// <summary>
    /// 最后登录时间
    /// </summary>
    public string lastlogin_time { get; set; }
    /// <summary>
    /// 总计登录次数
    /// </summary>
    public string login_num { get; set; }
    /// <summary>
    /// 用户组编号
    /// </summary>		
    public string group_code { get; set; }
    /// <summary>
    /// 用户组名称
    /// </summary>		
    public string group_name { get; set; }
    
    /// <summary>
    /// 用户组描述
    /// </summary>		
    public string group_discript { get; set; }
    /// <summary>
    /// 用户组创建时间
    /// </summary>		
    public string group_create_time { get; set; }
    /// <summary>
    /// 是否长期有效
    /// </summary>		
    public int flag_valid { get; set; }
    /// <summary>
    /// 失效时间
    /// </summary>		
    public string lost_time { get; set; }

}
public class role
{
    /// <summary>
    /// 角色编码
    /// </summary>
    public string role_code { get; set; }
    /// <summary>
    /// 角色名称
    /// </summary>
    public string role_name { get; set; }
    /// <summary>
    /// 角色描述
    /// </summary>
    public string role_discript { get; set; }
    /// <summary>
    /// 创建时间
    /// </summary>
    public string create_time { get; set; }
    /// <summary>
    /// 是否永久有效
    /// </summary>
    public string flag_valid { get; set; }
    /// <summary>
    /// 失效时间
    /// </summary>
    public string lost_time { get; set; }
}

public class roleuser
{
    /// <summary>
    /// 角色编码
    /// </summary>
    public string role_code { get; set; }
    /// <summary>
    /// 角色名称
    /// </summary>
    public string role_name { get; set; }
    /// <summary>
    /// 角色描述
    /// </summary>
    public string role_discript { get; set; }
    /// <summary>
    /// 创建时间
    /// </summary>
    public string role_create_time { get; set; }
    /// <summary>
    /// 是否永久有效
    /// </summary>
    public string flag_valid { get; set; }
    /// <summary>
    /// 失效时间
    /// </summary>
    public string lost_time { get; set; }
    /// <summary>
    /// user_code
    /// </summary>		
    public string user_code { get; set; }
    /// <summary>
    /// 用户名
    /// </summary>
    public string user_name { get; set; }
    /// <summary>
    /// 是否自动锁定
    /// </summary>
    public string auto_lock { get; set; }
    /// <summary>
    /// 用户状态
    /// </summary>
    public string user_state { get; set; }
    /// <summary>
    /// 创建时间
    /// </summary>
    public string user_create_time { get; set; }
    /// <summary>
    /// 最后登录时间
    /// </summary>
    public string lastlogin_time { get; set; }
    /// <summary>
    /// 总计登录次数
    /// </summary>
    public string login_num { get; set; }

}
/// <summary>
///user 的摘要说明
/// </summary>
public class user
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
    /// 用户密码
    /// </summary>
    public string user_pwd { get; set; }
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
    public string create_time { get; set; }
    /// <summary>
    /// 本次登陆时间
    /// </summary>
    public string login_time { get; set; }
    /// <summary>
    /// 上次登录时间
    /// </summary>
    public string lastlogin_time { get; set; }
    /// <summary>
    /// 总计登陆次数
    /// </summary>
    public string login_num { get; set; }
    /// <summary>
    /// 登陆IP
    /// </summary>
    public string login_address { get; set; }
    /// <summary>
    /// 用户备注
    /// </summary>
    public string user_remark { get; set; }
    
}
