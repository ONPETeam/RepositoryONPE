using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using GJHF.Data.Factory.FLOW.CLASS;
using GJHF.Data.Interface.FLOW.CLASS;
using GJHF.Data.Model.FLOW.CLASS;
using System.Data;
using GJHF.Utility.WEBUI;
using Newtonsoft.Json;

namespace GJHF.Business.FLOW
{
    public class FlowClass
    {
        private IFLOWFlowClass iIFLOWFlowClass;
        public FlowClass()
        {
            this.iIFLOWFlowClass = FFLOWFlowClass.Create();
        }
        public int AddFlowClassData(string v_class_name, string v_class_remark)
        {
            return iIFLOWFlowClass.AddFlowClassData(v_class_name, v_class_remark);
        }
        public int EditFlowClassData(int v_class_id, string v_class_name, string  v_class_remark)
        {
            return iIFLOWFlowClass.EditFlowClassData(v_class_id, v_class_name, v_class_remark);
        }
        public int DelFlowClassData(int v_class_id)
        {
            return iIFLOWFlowClass.DelFlowClassData(v_class_id);
        }
        public int GetFlowClassCount(string v_class_name, string v_class_remark)
        {
            return iIFLOWFlowClass.GetFlowClassCount(v_class_name, v_class_remark);
        }
        public DataTable GetFlowClass(int v_rows, int v_page, string v_class_name, string v_class_remark, string v_sort, string v_order)
        {
            return iIFLOWFlowClass.GetFlowClassData(v_rows, v_page, v_class_name, v_class_remark, v_sort, v_order);
        }
        public DataTable GetFlowClass(string v_class_name, string v_class_remark, string v_sort, string v_order)
        {
            return iIFLOWFlowClass.GetFlowClassData(v_class_name, v_class_remark, v_sort, v_order);
        }
        public DataTable GetFlowClass(string v_class_name, string v_class_remark)
        {
            return iIFLOWFlowClass.GetFlowClassData(v_class_name, v_class_remark);
        }
        public Dictionary<string, object> GetFlowClassDetail(int v_class_id)
        {
            return iIFLOWFlowClass.GetFlowClassDetail(v_class_id);
        }

    }
}
