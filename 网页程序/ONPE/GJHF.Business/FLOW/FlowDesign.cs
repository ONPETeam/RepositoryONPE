using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;

namespace GJHF.Business.FLOW
{
    public class FlowDesign
    {
        private GJHF.Data.Interface.FLOW.DESIGN.IFlowDesignFlow iIFLOWDesignFlow;
        public FlowDesign()
        {
            this.iIFLOWDesignFlow = GJHF.Data.Factory.FLOW.DESIGN.FFlowDesignFlow.Create();
        }
        public int AddFlowDesign( string v_flow_name, int v_flow_class, int v_flow_order, int v_flow_type, int v_version_control, string v_flow_creator,string v_flow_remark)
        {
            return iIFLOWDesignFlow.AddFlowDesignData(v_flow_name, v_flow_class, v_flow_order, v_flow_type, v_version_control, v_flow_creator, v_flow_remark);
        }
        public int EditFlowDesign(string v_flow_id, string v_flow_name, int v_flow_class, int v_flow_order, int v_flow_type, string v_flow_remark)
        {
            return iIFLOWDesignFlow.EditFlowDesignData(v_flow_id, v_flow_name, v_flow_class, v_flow_order, v_flow_type,v_flow_remark);
        }
        public int DelFlowDesign(string v_flow_id)
        {
            return iIFLOWDesignFlow.DeleteFlowDesignData(v_flow_id);
        }
        public int GetFlowDesignCount(string v_flow_name, int v_flow_class, int v_flow_order, int v_flow_type)
        {
            return iIFLOWDesignFlow.GetFlowDesignCount(v_flow_name, v_flow_class, v_flow_order, v_flow_type);
        }
        public DataTable GetListFlowDesignData(int v_page, int v_rows, string v_flow_name, int v_flow_class, int v_flow_order, int v_flow_type, string v_sort, string v_order) 
        {
            return iIFLOWDesignFlow.GetListFlowDesignData(v_page, v_rows, v_flow_name, v_flow_class, v_flow_order, v_flow_type, v_sort, v_order);
        }

        public DataTable GetListFlowDesignData(string v_flow_name, int v_flow_class, int v_flow_order, int v_flow_type, string v_sort, string v_order)
        {
            return iIFLOWDesignFlow.GetListFlowDesignData( v_flow_name, v_flow_class, v_flow_order, v_flow_type, v_sort, v_order);
        }

        public DataTable GetListFlowDesignData(string v_flow_name, int v_flow_class, int v_flow_order, int v_flow_type)
        {
            return iIFLOWDesignFlow.GetListFlowDesignData(v_flow_name, v_flow_class, v_flow_order, v_flow_type);
        }

        public Dictionary<string, object> GetFlowDesignDetail(string v_flow_id)
        {
            return iIFLOWDesignFlow.GetFlowDesignDetail(v_flow_id);
        }
    }
}
