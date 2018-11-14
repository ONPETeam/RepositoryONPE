using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using GJHF.Data.Model.FORM.WIDGET;

namespace GJHF.Data.Interface.FORM.WIDGET
{
    public interface IFORMWidgetCheck
    {
        int AddWidgetCheckData(string v_id, string v_name, float v_fontsize, int v_selecttype, int v_showtype, int v_datatype,
            string v_datadictionary, string v_datacustom, string v_datafrom, string v_dataview, string v_datafiled, string v_defaultvalue,
            int v_editable, int v_required, string v_placehold);
        int EditWidgetCheckData(string v_No, string v_id, string v_name, float v_fontsize, int v_selecttype, int v_showtype, int v_datatype,
            string v_datadictionary, string v_datacustom, string v_datafrom, string v_dataview, string v_datafiled, string v_defaultvalue,
            int v_editable, int v_required, string v_placehold);
        int DelWidgetCheckData(string v_No);
        int GetWidgetCheckCount(string v_id, string v_name);
        DataTable GetWidgetCheckData(string v_id, string v_name);
        DataTable GetWidgetCheckData(string v_id, string v_name, string v_sort, string v_order);
        DataTable GetWidgetCheckData(int v_page, int v_rows, string v_id, string v_name, string v_sort, string v_order);
        Dictionary<string, object> GetWidgetCheckDetail(string v_No);
    }
}
