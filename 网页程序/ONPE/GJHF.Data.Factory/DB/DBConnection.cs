using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace GJHF.Data.Factory.DB
{
    [Serializable]
    public class DBConnection
    {
        /// <summary>
        /// 数据连接编号
        /// </summary>
        public string connect_id { get; set; }

        /// <summary>
        /// 数据连接名称
        /// </summary>
        public string connect_name { get; set; }

        /// <summary>
        /// 数据连接类型
        /// </summary>
        public int connect_type { get; set; }

        /// <summary>
        /// 连接字符串
        /// </summary>
        public string connect_string { get; set; }

        /// <summary>
        ///  数据连接备注
        /// </summary>
        public string connect_remark { get; set; }
    }
}
