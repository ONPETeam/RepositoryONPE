using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using GJHF.Data.Model.FLOW.TYPE;

namespace GJHF.Data.Interface.FLOW.TYPE
{
    public interface IFLOWFlowType
    {
        int AddFlowTypeData(string v_type_name, int v_type_order, int v_type_parent);
        int EditFlowTypeData(int v_type_id,string v_type_name, int v_type_order, int v_type_parent);
        int DelFlowTypeData(int v_type_id);
        Dictionary<string,object> GetFlowTypeDetail(int v_type_id);
        DataTable GetFlowTypeData(int v_rows, int v_page, string v_type_name, int v_type_parent, string v_sort, string v_order);
        DataTable GetFlowTypeData(string v_type_name, int v_type_parent, string v_sort, string v_order);
        DataTable GetFlowTypeData(string v_type_name, int v_type_parent);
        int GetFlowTypeCount(string v_type_name, int v_type_parent);
    }
}
