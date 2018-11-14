using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using GJHF.Data.Model.FORM.TYPE;
using System.Data;

namespace GJHF.Data.Interface.FORM.TYPE
{
    public interface IFORMFormType
    {
        int AddFormTypeData(string v_type_name, int v_type_order, int v_type_parent);
        int EditFormTypeData(int v_type_id, string v_type_name, int v_type_order, int v_type_parent);
        int DelFormTypeData(int v_type_id);
        MFORMFormType GetFormTypeDetail(int v_type_id);
        DataTable GetFormTypeData(int v_rows, int v_page, string v_type_name, int v_type_parent, string v_sort, string v_order);
        DataTable GetFormTypeData(string v_type_name, int v_type_parent, string v_sort, string v_order);
        DataTable GetFormTypeData(string v_type_name, int v_type_parent);
        int GetFormTypeCount(string v_type_name, int v_type_parent);
    }
}
