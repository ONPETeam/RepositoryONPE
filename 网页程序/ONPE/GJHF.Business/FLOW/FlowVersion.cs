using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using GJHF.Data.Interface.FLOW.VERSION;
using GJHF.Data.Factory.FLOW.VERSION;
using System.Data;

namespace GJHF.Business.FLOW
{
    public class FlowVersion
    {
        private IFlowVersion iIFlowVersion;
        public FlowVersion()
        {
            this.iIFlowVersion = FFlowVersion.Create();
        }
        public int AddFlowVersion(string v_flow_id, DateTime v_update_time, string v_update_people, string v_update_remark)
        {
            return iIFlowVersion.AddFlowVersion(v_flow_id, v_update_time, v_update_people, v_update_remark);
        }
        public int EditFlowVersion(string v_version_id, string v_flow_id, DateTime v_update_time, string v_update_people, string v_update_remark)
        {
            return iIFlowVersion.EditFlowVersion(v_version_id,v_flow_id, v_update_time, v_update_people, v_update_remark);
        }
        public int DelFlowVersion(string v_version_id)
        {
            return iIFlowVersion.DelFlowVersion(v_version_id);
        }
        public int GetFlowVersionCount(string v_flow_id)
        {
            return iIFlowVersion.GetFlowVersionCount(v_flow_id);
        }
        public DataTable GetFlowVersion(string v_flow_id)
        {
            return iIFlowVersion.GetFlowVersion(v_flow_id);
        }
        public DataTable GetFlowVersion(string v_flow_id, string v_sort, string v_order)
        {
            return iIFlowVersion.GetFlowVersion(v_flow_id, v_sort, v_order);
        }
        public DataTable GetFlowVersion(int v_page, int v_rows, string v_flow_id, string v_sort, string v_order)
        {
            return iIFlowVersion.GetFlowVersion(v_page, v_rows,v_flow_id, v_sort, v_order);
        }
        public Dictionary<string, object> GetFlowVersionDetail(string v_version_id)
        {
            return iIFlowVersion.GetFlowVersionDetail(v_version_id);
        }
    }
}
