using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using GJHF.Data.Factory.FLOW.TYPE;
using GJHF.Data.Interface.FLOW.TYPE;
using GJHF.Data.Model.FLOW.TYPE;
using System.Data;
using GJHF.Utility.WEBUI;
using Newtonsoft.Json;

namespace GJHF.Business.FLOW
{
    public class FlowType
    {
        private IFLOWFlowType iIFLOWFlowType;
        public FlowType() {
            this.iIFLOWFlowType = FFLOWFlowType.Create();
        }
        public int AddFlowTypeData(string v_type_name,int v_type_order,int v_type_parent)
        {
            return iIFLOWFlowType.AddFlowTypeData(v_type_name, v_type_order, v_type_parent);
        }
        public int EditFlowTypeData(int v_type_id, string v_type_name, int v_type_order, int v_type_parent)
        {
            return iIFLOWFlowType.EditFlowTypeData(v_type_id, v_type_name, v_type_order, v_type_parent);
        }
        public int DelFlowTypeData(int v_type_id)
        {
            return iIFLOWFlowType.DelFlowTypeData(v_type_id);
        }
        public int GetFlowTypeCount(string v_type_name, int v_type_parent)
        {
            return iIFLOWFlowType.GetFlowTypeCount(v_type_name, v_type_parent);
        }
        public DataTable GetFlowType(int v_rows, int v_page, string v_type_name, int v_type_parent, string v_sort, string v_order)
        {
            return iIFLOWFlowType.GetFlowTypeData(v_rows, v_page, v_type_name, v_type_parent, v_sort, v_order);
        }
        public DataTable GetFlowType(string v_type_name, int v_type_parent, string v_sort, string v_order)
        {
            return iIFLOWFlowType.GetFlowTypeData(v_type_name, v_type_parent, v_sort, v_order);
        }
        public DataTable GetFlowType(string v_type_name, int v_type_parent)
        {
            return iIFLOWFlowType.GetFlowTypeData( v_type_name, v_type_parent);
        }
        public Dictionary<string, object> GetFlowTypeDetail(int v_type_id)
        {
            return iIFLOWFlowType.GetFlowTypeDetail(v_type_id);
        }
        
    }
}
