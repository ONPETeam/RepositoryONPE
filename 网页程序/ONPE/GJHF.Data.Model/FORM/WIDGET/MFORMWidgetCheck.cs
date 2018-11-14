using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace GJHF.Data.Model.FORM.WIDGET
{
    public class MFORMWidgetCheck
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
        /// 字体大小
        /// </summary>
        public float fontsize { get; set; }

        private int _selecttype = 0;
        /// <summary>
        /// 选择方式 0 单选 1 复选
        /// </summary>
        public int selecttype 
        {
            get { return _selecttype; }
            set { _selecttype = value; }
        }

        private int _showtype = 0;
        /// <summary>
        /// 显示方式 0 横排 1 竖排
        /// </summary>
        public int showtype 
        {
            get { return _showtype; }
            set { _showtype = value; }
        }

        private int _datatype = 2;
        /// <summary>
        /// 数据源类型 1 数据库 2 数据字典 3 自定义
        /// </summary>
        public int datatype {
            get { return _datatype; }
            set { _datatype = value; }
        }

        /// <summary>
        /// 数据字典
        /// </summary>
        public string datadictionary { get; set; }

        /// <summary>
        /// 自定义项
        /// </summary>
        public string datacustom { get; set; }

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
