using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using GJHF.Data.Model.FORM.WIDGET;

namespace GJHF.Data.Interface.FORM.WIDGET
{
    public interface IFORMWidgetTextarea
    {
        int AddWidgetTextareaData( string v_id, string v_name, float v_width, float v_height, int v_rows,
            float v_fontsize, int v_align, string v_datafrom, string v_dataview, string v_datafiled, string v_defaultvalue,
            int v_editable, int v_required, string v_placehold);
        int EditWidgetTextareaData(string v_No, string v_id, string v_name, float v_width, float v_height, int v_rows,
            float v_fontsize, int v_align, string v_datafrom, string v_dataview, string v_datafiled, string v_defaultvalue,
            int v_editable, int v_required, string v_placehold);
        int DelWidgetTextareaData(string v_No);
        int GetWidgetTextareaCount(string v_id, string v_name);
        DataTable GetWidgetTextareaData(string v_id, string v_name);
        DataTable GetWidgetTextareaData(string v_id, string v_name, string v_sort, string v_order);
        DataTable GetWidgetTextareaData(int v_page, int v_rows, string v_id, string v_name, string v_sort, string v_order);
        Dictionary<string, object> GetWidgetTextareaDetail(string v_No); 
    }
}
