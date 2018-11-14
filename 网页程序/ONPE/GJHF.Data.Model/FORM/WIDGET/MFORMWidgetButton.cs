using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace GJHF.Data.Model.FORM.WIDGET
{
    /// <summary>
    /// 按钮
    /// </summary>
    public class MFORMWidgetButton
    {
        /// <summary>
        /// 编号
        /// </summary>
        public string No { get; set; }
        /// <summary>
        /// id
        /// </summary>
        public string id { get; set; }
        /// <summary>
        /// 按钮文本
        /// </summary>
        public string name { get; set; }
        /// <summary>
        /// 类型  0 图标和文本  1 文本  2 图标
        /// </summary>
        public int style { get; set; }
        /// <summary>
        /// 风格  0 3D 1 平面
        /// </summary>
        public int plain { get; set; }
        /// <summary>
        /// 图标
        /// </summary>
        public string icon { get; set; }
        /// <summary>
        /// 图标位置  0 文本前 1 文本后
        /// </summary>
        public int align { get; set; }
        /// <summary>
        /// 链接类型  1 脚本事件 2 页面
        /// </summary>
        public int eventtype { get; set; }
        /// <summary>
        /// 链接内容
        /// </summary>
        public string eventcontext { get; set; }
    }
}
