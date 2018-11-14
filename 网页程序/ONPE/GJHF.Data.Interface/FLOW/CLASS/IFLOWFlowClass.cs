using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using GJHF.Data.Model.FLOW.CLASS;
using System.Data;

namespace GJHF.Data.Interface.FLOW.CLASS
{
    public interface IFLOWFlowClass
    {
        int AddFlowClassData(string v_class_name, string v_class_remark);
        int EditFlowClassData(int v_class_id, string v_class_name, string v_class_remark);
        int DelFlowClassData(int v_class_id);
        Dictionary<string,object> GetFlowClassDetail(int v_class_id);
        int GetFlowClassCount(string v_class_name, string v_class_remark);

        DataTable GetFlowClassData(int v_rows, int v_page, string v_class_name, string v_class_remark, string v_sort, string v_order);

        DataTable GetFlowClassData(string v_class_name, string v_class_remark, string v_sort, string v_order);
        DataTable GetFlowClassData(string v_class_name, string v_class_remark);
    }
}
