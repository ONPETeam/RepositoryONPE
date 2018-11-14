using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace GJHF.Data.Model.HR
{
    public class Employee
    {
        /// <summary>
        /// 公司编号
        /// </summary>
        public string company_id { get; set; }
        /// <summary>
        /// 公司名称
        /// </summary>
        public string company_name { get; set; }
        /// <summary>
        /// 部门编号
        /// </summary>
        public string branch_id { get; set; }
        /// <summary>
        /// 部门名称
        /// </summary>
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
        /// 用户编号
        /// </summary>
        public string user_id { get; set; }
        /// <summary>
        /// 员工姓名
        /// </summary>
        public string employee_name { get; set; }
        /// <summary>
        /// 手机号
        /// </summary>
        public string telphone_no { get; set; }
        /// <summary>
        /// 邮箱
        /// </summary>
        public string mail_address { get; set; }
        /// <summary>
        /// 员工性别
        /// </summary>
        public string employee_sex { get; set; }
        /// <summary>
        /// 员工生日
        /// </summary>
        public string birthday_date { get; set; }
        /// <summary>
        /// 员工年龄
        /// </summary>
        public string employee_age { get; set; }
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
        public DateTime graduate_time { get; set; }
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
}
