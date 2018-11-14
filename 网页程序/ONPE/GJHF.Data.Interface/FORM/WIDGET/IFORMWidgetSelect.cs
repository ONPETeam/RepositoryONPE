using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using GJHF.Data.Model.FORM.WIDGET;

namespace GJHF.Data.Interface.FORM.WIDGET
{
    public interface IFORMWidgetSelect
    {
        int AddWidgetSelectData( string v_id, string v_name, float v_width, float v_height,
            float v_fontsize, int v_align, int v_selecttype, int v_mutilselect, float v_panelwidth, float v_panelheight,
            int v_datatype, string v_datadictionary, string v_datacustom, string v_datafrom, string v_dataview,
            string v_datafiled, string v_defaultvalue, int v_editable, int v_required, string v_placehold);
        int EditWidgetSelectData(string v_No, string v_id, string v_name, float v_width, float v_height,
            float v_fontsize, int v_align, int v_selecttype, int v_mutilselect, float v_panelwidth, float v_panelheight,
            int v_datatype, string v_datadictionary, string v_datacustom, string v_datafrom, string v_dataview,
            string v_datafiled, string v_defaultvalue, int v_editable, int v_required, string v_placehold);
        int DelWidgetSelectData(string v_No);
        int GetWidgetSelectCount(string v_id, string v_name);
        DataTable GetWidgetSelectData(string v_id, string v_name);
        DataTable GetWidgetSelectData(string v_id, string v_name, string v_sort, string v_order);
        DataTable GetWidgetSelectData(int v_page, int v_rows, string v_id, string v_name, string v_sort, string v_order);
        Dictionary<string, object> GetWidgetSelectDetail(string v_No); 
    }
}
