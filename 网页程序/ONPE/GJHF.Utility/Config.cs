using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace GJHF.Utility
{
    public class Config
    {
        public static string DAOClassPath = "GJHF.Data.MSSQL";

        /// <summary>
        /// 日期格式
        /// </summary>
        public static string DateFormat
        {
            get
            {
                return "yyyy-MM-dd";
            }
        }

        /// <summary>
        /// 日期时间格式
        /// </summary>
        public static string DateTimeFormat
        {
            get
            {
                return "yyyy-MM-dd HH:mm";
            }
        }

        /// <summary>
        /// 日期时间格式(带秒)
        /// </summary>
        public static string DateTimeFormatS
        {
            get
            {
                return "yyyy-MM-dd HH:mm:ss";
            }
        }
        public static DateTime DefaultDateTime= DateTime.Parse("1900-01-01 00:00:00");
        
    }
}
