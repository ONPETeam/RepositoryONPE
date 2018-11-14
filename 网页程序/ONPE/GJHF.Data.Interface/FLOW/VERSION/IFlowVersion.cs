using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;

namespace GJHF.Data.Interface.FLOW.VERSION
{
    public interface IFlowVersion
    {
        int AddFlowVersion(string v_flow_id, DateTime v_update_time, string v_update_people, string v_update_remark);
        int EditFlowVersion(string v_version_id, string v_flow_id, DateTime v_update_time, string v_update_people, string v_update_remark);
        int DelFlowVersion(string v_version_id);
        int GetFlowVersionCount(string v_flow_id);
        DataTable GetFlowVersion(string v_flow_id);
        DataTable GetFlowVersion(string v_flow_id, string v_sort, string v_order);
        DataTable GetFlowVersion(int v_page,int v_rows,string v_flow_id, string v_sort, string v_order);
        Dictionary<string, object> GetFlowVersionDetail(string v_version_id);
    }
}
