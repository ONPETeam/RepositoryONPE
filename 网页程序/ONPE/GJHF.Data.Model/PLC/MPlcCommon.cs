using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace GJHF.Data.Model.PLC
{
    public class MPlcCommon
    {
        /// <summary>
        /// 点地址id
        /// </summary>
        public int dIntDataID { get; set; }
        /// <summary>
        /// 点地址
        /// </summary>
        public string dVchAddress { get; set; }
        /// <summary>
        /// 名称
        /// </summary>
        public string dVchAdressName { get; set; }
        /// <summary>
        /// 描述
        /// </summary>
        public string dVchDescription { get; set; }
        /// <summary>
        /// 模拟量或开关量
        /// </summary>
        public int dIntGongType { get; set; }
        /// <summary>
        /// PLCID
        /// </summary>
        public int dIntPLCID { get; set; }
        /// <summary>
        /// PLC拼接显示名称
        /// </summary>
        public string plcqm { get; set; }
        /// <summary>
        /// 变量类型名称
        /// </summary>
        public string dVchVariableName { get; set; }

        public int dIntIOType { get; set; }
        /// <summary>
        /// IO类型名称
        /// </summary>
        public string dVchIOTypeName { get; set; }
        /// <summary>
        /// 手机系统名称
        /// </summary>
        public string dVchPointType { get; set; }
        /// <summary>
        /// 排序序号
        /// </summary>
        public int dIntShouJiPx { get; set; }
        /// <summary>
        /// 计量单位
        /// </summary>
        public string dVchDanwei { get; set; }
        /// <summary>
        /// 全地址
        /// </summary>
        public string dVchAllAdress { get; set; }
        /// <summary>
        /// 系统id以逗号隔开
        /// </summary>
        public string gStrPointTypeid { get; set; }
        /// <summary>
        /// 系统名称以逗号分隔开
        /// </summary>
        public string gStrPointType { get; set; }
        /// <summary>
        /// 变量类型
        /// </summary>
        public string dVchDataType { get; set; }
        /// <summary>
        /// 报警标识
        /// </summary>
        public int dIntBjBz { get; set; }
        /// <summary>
        /// 设备编号
        /// </summary>
        public string dVchSbBianHao { get; set; }
        /// <summary>
        /// 报警最大值
        /// </summary>
        public float dfltMax { get; set; }
        /// <summary>
        /// 报警最小值
        /// </summary>
        public float dfltMin { get; set; }
        /// <summary>
        /// 开关量报警值
        /// </summary>
        public string dVchKgAlermValue { get; set; }
        /// <summary>
        /// 报警备注信息
        /// </summary>
        public string dVchRemark { get; set; }
        /// <summary>
        /// 地址类别 
        /// </summary>
        public int dIntAdressTypeID { get; set; }
        /// <summary>
        /// 计算标识
        /// </summary>
        public int dIntJsBz { get; set; }

        public int dIntIsCollect { get; set; }
        public int dIntCollectSec { get; set; }
        public int dIntCollectType { get; set; }

    }
}
