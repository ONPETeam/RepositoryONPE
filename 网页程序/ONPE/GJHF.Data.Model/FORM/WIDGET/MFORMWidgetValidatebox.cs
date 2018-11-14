﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace GJHF.Data.Model.FORM.WIDGET
{
    public class MFORMWidgetValidatebox
    {
        /// <summary>
        /// 编号
        /// </summary>
        public string No { get; set; }

        /// <summary>
        /// ID
        /// </summary>
        public string id { get; set; }

        /// <summary>
        /// 名称
        /// </summary>
        public string name { get; set; }

        /// <summary>
        /// 宽度
        /// </summary>
        public float width { get; set; }

        /// <summary>
        /// 高度
        /// </summary>
        public float height { get; set; }

        /// <summary>
        /// 字体大小
        /// </summary>
        public float fontsize { get; set; }

        /// <summary>
        /// 对齐方式 1 左对齐 2 居中对齐 3 右对齐
        /// </summary>
        public int align { get; set; }

        /// <summary>
        /// 验证方式 
        /// </summary>
        public int regtype { get; set; }

        /// <summary>
        /// 自定义验证正则表达式
        /// </summary>
        public string regcode { get; set; }

        /// <summary>
        /// 数据源
        /// </summary>
        public string datafrom { get; set; }

        /// <summary>
        /// 表或视图
        /// </summary>
        public string dataview { get; set; }

        /// <summary>
        /// 绑定字段
        /// </summary>
        public string datafiled { get; set; }

        /// <summary>
        /// 默认值
        /// </summary>
        public string defaultvalue { get; set; }

        private int _editable = 0;
        /// <summary>
        /// 是否可编辑 0 可编辑 1 不可编辑
        /// </summary>
        public int editable
        {
            get { return _editable; }
            set { _editable = value; }
        }

        private int _required = 0;
        /// <summary>
        /// 是否必填 0 可空，1 必填
        /// </summary>
        public int required
        {
            get { return _required; }
            set { _required = value; }
        }

        private string _placehold = "";
        /// <summary>
        /// 缺失提示
        /// </summary>
        public string placehold
        {
            get { return _placehold; }
            set { _placehold = value; }
        }
    }
}
