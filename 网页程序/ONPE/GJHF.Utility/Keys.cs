using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace GJHF.Utility
{
    public class Keys
    {
        /// <summary>
        /// SESSION键
        /// </summary>
        public enum SessionKeys
        {
            /// <summary>
            /// 登录用户编号
            /// </summary>
            UserCode,
            /// <summary>
            /// 当前用户对应员工编号
            /// </summary>
            EmployeeCode,
            /// <summary>
            /// 登录用户名
            /// </summary>
            UserName,
            /// <summary>
            /// 员工名
            /// </summary>
            EmployeeName,

            Theme,
            BaseUrl
        }
    }
}
