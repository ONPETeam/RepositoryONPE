using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using GJHF.Data.Model.FLOW.DB;
using System.Data;

namespace GJHF.Data.Interface.FLOW.DB
{
    public interface IFLOWValueType
    {
        int AddValueTypeData(string v_type_name, string v_type_remark);

        int EditValueTypeData(int v_type_id,string v_type_name, string v_type_remark);

        int DelValueTypeData(int v_type_id);

        MFLOWValueType GetValueTypeDetail(int v_type_id);

        DataTable GetValueTypeData(int v_rows, int v_page, string v_type_name, string v_type_remark, string v_sort, string v_order);
        DataTable GetValueTypeData(string v_type_name, string v_type_remark, string v_sort, string v_order);
        int GetValueTypeCount(string v_type_name, string v_type_remark);
    }
}
