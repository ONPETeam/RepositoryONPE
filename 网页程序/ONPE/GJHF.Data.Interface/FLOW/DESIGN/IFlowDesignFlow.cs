using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using GJHF.Data.Model.FLOW.DESIGN;
using System.Data;

namespace GJHF.Data.Interface.FLOW.DESIGN
{
    public interface IFlowDesignFlow
    {
        int AddFlowDesignData(string v_flow_name, int v_flow_class, int v_flow_order, int v_flow_type, int v_version_control, string v_flow_creator, string v_flow_remark);

        int EditFlowDesignData(string v_flow_id, string v_flow_name, int v_flow_class, int v_flow_order, int v_flow_type, string v_flow_remark);

        int DeleteFlowDesignData(string v_flow_id);

        int GetFlowDesignCount(string v_flow_name, int v_flow_class, int v_flow_order, int v_flow_type);

        DataTable GetListFlowDesignData(int v_page, int v_rows, string v_flow_name, int v_flow_class, int v_flow_order, int v_flow_type, string v_sort, string v_order);

        DataTable GetListFlowDesignData(string v_flow_name, int v_flow_class, int v_flow_order, int v_flow_type, string v_sort, string v_order);

        DataTable GetListFlowDesignData(string v_flow_name, int v_flow_class, int v_flow_order, int v_flow_type);

        Dictionary<string,object> GetFlowDesignDetail(string v_flow_id);
    }
}
