using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using GJHF.Data.Model.FLOW.DB;
using System.Data;

namespace GJHF.Data.Interface.FLOW.DB
{
    public interface IFLOWValueFrom
    {
        int AddValueFromData(string v_value_from_name, int v_type_id, string v_analyze_function, string v_return_type, string v_value_from_remark);
        int EditValueFromData(int v_value_from_id, string v_value_from_name, int v_type_id, string v_analyze_function, string v_return_type, string v_value_from_remark);
        int DelValueFromData(int v_value_from_id);
        MFLOWValueFrom GetValueFromDetail(int v_value_from_id);
        int GetValueFromCount(string v_value_from_name, int v_type_id, string v_analyze_function, string v_return_type);
        DataTable GetValueFromData(int v_rows, int v_page, string v_value_from_name, int v_type_id, string v_analyze_function, string v_return_type, string v_sort, string v_order);
        DataTable GetValueFromData(string v_value_from_name, int v_type_id, string v_analyze_function, string v_return_type, string v_sort, string v_order);
    }
}
