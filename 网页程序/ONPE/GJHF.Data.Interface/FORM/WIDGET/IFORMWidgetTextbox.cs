using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using GJHF.Data.Model.FORM.WIDGET;

namespace GJHF.Data.Interface.FORM.WIDGET
{
    public interface IFORMWidgetTextbox
    {
        int AddWidgetTextboxData( string v_id, string v_name, int v_hide, float v_width, float v_height,
            float v_fontsize, int v_align, int v_input_type, string v_dataform, string v_dataview,
            string v_datafiled, string v_defaultvalue, int v_editable, int v_required, string v_placehold);
        int EditWidgetTextboxData(string v_No, string v_id, string v_name, int v_hide, float v_width, float v_height,
            float v_fontsize, int v_align, int v_input_type, string v_dataform, string v_dataview,
            string v_datafiled, string v_defaultvalue, int v_editable, int v_required, string v_placehold);
        int DelWidgetTextboxData(string v_No);
        int GetWidgetTextboxCount(string v_id, string v_name);
        DataTable GetWidgetTextboxData(string v_id, string v_name);
        DataTable GetWidgetTextboxData(string v_id, string v_name, string v_sort, string v_order);
        DataTable GetWidgetTextboxData(int v_page, int v_rows, string v_id, string v_name, string v_sort, string v_order);
        Dictionary<string, object> GetWidgetTextboxDetail(string v_No);
    }
}
