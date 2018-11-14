using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace GJHF.Data.Model.FLOW.DESIGN
{
    public class MFLOWDesignFlow
    {
        private string mflow_id;
        /// <summary>
        /// 设计流程编号
        /// </summary>
        public string flow_id
        {
            get { return mflow_id; }
            set { mflow_id = value; }
        }
        private string mflow_name;
        /// <summary>
        /// 流程名称
        /// </summary>
        public string flow_name
        {
            get { return mflow_name; }
            set { mflow_name = value; }
        }
        private int mflow_class;
        /// <summary>
        /// 流程类型
        /// </summary>
        public int flow_class
        {
            get { return mflow_class; }
            set { mflow_class = value; }
        }
        private int mflow_order;
        /// <summary>
        /// 流程排序号
        /// </summary>
        public int flow_order
        {
            get { return mflow_order; }
            set { mflow_order = value; }
        }
        private int mflow_type;
        /// <summary>
        /// 流程分类编号
        /// </summary>
        public int flow_type
        {
            get { return mflow_type; }
            set { mflow_type = value; }
        }
        private int mversion_control;
        /// <summary>
        /// 是否启用版本控制
        /// </summary>
        public int version_control
        {
            get { return mversion_control; }
            set { mversion_control = value; }
        }
        private DateTime mcreate_time;
        /// <summary>
        /// 创建时间
        /// </summary>
        public DateTime create_time
        {
            get { return mcreate_time; }
            set { mcreate_time = value; }
        }
        private string mflow_creator;
        /// <summary>
        /// 创建人
        /// </summary>
        public string flow_creator
        {
            get { return mflow_creator; }
            set { mflow_creator = value; }
        }
        private string mcurrent_version;
        /// <summary>
        /// 最新版本号
        /// </summary>
        public string current_version
        {
            get { return mcurrent_version; }
            set { mcurrent_version = value; }
        }
        private DateTime mlast_update;
        /// <summary>
        /// 最后更新时间
        /// </summary>
        public DateTime last_update
        {
            get { return mlast_update; }
            set { mlast_update = value; }
        }
        private string mlast_writter;
        /// <summary>
        /// 最后更新人
        /// </summary>
        public string last_writter
        {
            get { return mlast_writter; }
            set { mlast_writter = value; }
        }
        private string mrun_version;
        /// <summary>
        /// 启用版本
        /// </summary>
        public string run_version
        {
            get { return mrun_version; }
            set { mrun_version = value; }
        }
        private DateTime mrun_time;
        /// <summary>
        /// 启用时间
        /// </summary>
        public DateTime run_time
        {
            get { return mrun_time; }
            set { mrun_time = value; }
        }
        private string mrun_people;
        /// <summary>
        /// 启用人
        /// </summary>
        public string run_people
        {
            get { return mrun_people; }
            set { mrun_people = value; }
        }
        private string mflow_remark;
        /// <summary>
        /// 流程描述
        /// </summary>
        public string flow_remark
        {
            get { return mflow_remark; }
            set { mflow_remark = value; }
        }
        /// <summary>
        /// 设计信息
        /// </summary>
        public MFlowWFJson wf_json
        {
            get;
            set;
        }
    }
}
