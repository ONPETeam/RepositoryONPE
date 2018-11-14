using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace GJHF.Data.Model.SYS
{
    public class MSysPushClass
    {
        /// <summary>
        /// 等级编号
        /// </summary>
        public string class_id
        {
            get;
            set;
        }
        /// <summary>
        /// 等级名称
        /// </summary>
        public string class_name
        {
            get;
            set;
        }
        /// <summary>
        /// 等级说明
        /// </summary>
        public string class_remark
        {
            get;
            set;
        }
        /// <summary>
        /// Android样式
        /// </summary>
        public int android_build_id
        {
            get;
            set;
        }
        /// <summary>
        /// IOS声音
        /// </summary>
        public string ios_sound_code
        {
            get;
            set;
        }
    }
}
