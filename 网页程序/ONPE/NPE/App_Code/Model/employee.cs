using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace ModelClass
{
    public class major
    {
        /// <summary>
        /// 员工专业分类编号
        /// </summary>
        public string major_code { get; set; }
        /// <summary>
        /// 员工专业分类自编码
        /// </summary>
        public string major_innum { get; set; }
        /// <summary>
        /// 员工专业分类名称
        /// </summary>
        public string major_name { get; set; }
    }

    /// <summary>
    ///employee 的摘要说明
    /// </summary>
    public class employee
    {
        public string company_id { get; set; }
        public string company_name { get; set; }
        public string branch_id { get; set; }
        public string branch_name { get; set; }
        /// <summary>
        /// 员工编号
        /// </summary>
        public string employee_code { get; set; }
        /// <summary>
        /// 员工编码
        /// </summary>
        public string employee_innum { get; set; }
        /// <summary>
        /// 员工姓名
        /// </summary>
        public string employee_name { get; set; }
        /// <summary>
        /// 员工生日
        /// </summary>
        public string birthday_date { get; set; }
        /// <summary>
        /// 员工年龄
        /// </summary>
        public string employee_age { get; set; }
        /// <summary>
        /// 员工性别
        /// </summary>
        public string employee_sex { get; set; }
        /// <summary>
        /// 身份证号码
        /// </summary>
        public string idcard_no { get; set; }
        /// <summary>
        /// 籍贯城市编号
        /// </summary>
        public long city_id { get; set; }
        /// <summary>
        /// 籍贯城市名称
        /// </summary>
        public string city_name { get; set; }
        /// <summary>
        /// 家庭住址
        /// </summary>
        public string home_address { get; set; }
        /// <summary>
        /// 民族编号
        /// </summary>
        public int nation_id { get; set; }
        /// <summary>
        /// 民族
        /// </summary>
        public string nation_name { get; set; }
        /// <summary>
        /// 政治面貌编号
        /// </summary>
        public int visagetype_id { get; set; }
        /// <summary>
        /// 政治面貌名称
        /// </summary>
        public string visagetype_name { get; set; }
        /// <summary>
        /// 婚姻状况
        /// </summary>
        public string marital_status { get; set; }
        /// <summary>
        /// 联系电话
        /// </summary>
        public string phone_no { get; set; }
        /// <summary>
        /// 手机号
        /// </summary>
        public string telphone_no { get; set; }
        /// <summary>
        /// 教育程度编号
        /// </summary>
        public int education_id { get; set; }
        /// <summary>
        /// 教育程度名称
        /// </summary>
        public string education_name { get; set; }
        /// <summary>
        /// 毕业时间
        /// </summary>
        public string graduate_time { get; set; }
        /// <summary>
        /// 毕业院校
        /// </summary>
        public string graduate_school { get; set; }
        /// <summary>
        /// 相关专业
        /// </summary>
        public string specialty_name { get; set; }
        /// <summary>
        /// 专业分类编码
        /// </summary>
        public string major_code { get; set; }
        /// <summary>
        /// 专业分类名称
        /// </summary>
        public string major_name { get; set; }
        /// <summary>
        /// 点巡检级别编号
        /// </summary>
        public string patrolgrade_id { get; set; }
        /// <summary>
        /// 点巡检级别名称
        /// </summary>
        public string patrolgrade_name { get; set; }
    }
    /// <summary>
    ///user 的摘要说明
    /// </summary>
    public class useremployee
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

        /// <summary>
        /// 员工年龄
        /// </summary>
        public string employee_age { get; set; }

        /// <summary>
        /// 员工性别
        /// </summary>
        public string employee_sex { get; set; }

        /// <summary>
        /// 专业分类编码
        /// </summary>
        public string major_code { get; set; }
        /// <summary>
        /// 专业分类名称
        /// </summary>
        public string major_name { get; set; }
        /// <summary>
        /// 点巡检级别编号
        /// </summary>
        public string patrolgrade_id { get; set; }
        /// <summary>
        /// 点巡检级别名称
        /// </summary>
        public string patrolgrade_name { get; set; }
    }
}