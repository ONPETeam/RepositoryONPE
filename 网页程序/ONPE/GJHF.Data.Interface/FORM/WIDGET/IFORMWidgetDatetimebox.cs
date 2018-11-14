using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using GJHF.Data.Model.FORM.WIDGET;

namespace GJHF.Data.Interface.FORM.WIDGET
{
    public interface IFORMWidgetDatetimebox
    {
        int AddWidgetDatetimeboxData(string v_id, string v_name, float v_width, float v_height,
            float v_fontsize, int v_align, int v_datetype, int v_secondshow, string v_timeseparator, string v_format,
            string v_datafrom, string v_dataview, string v_datafiled, string v_defaultvalue, int v_editable,
            int v_required, string v_placehold);
        int EditWidgetDatetimeboxData(string v_No, string v_id, string v_name, float v_width, float v_height,
            float v_fontsize, int v_align, int v_datetype, int v_secondshow, string v_timeseparator, string v_format,
            string v_datafrom, string v_dataview, string v_datafiled, string v_defaultvalue, int v_editable,
            int v_required, string v_placehold);
        int DelWidgetDatetimeboxData(string v_No);
        int GetWidgetDatetimeboxCount(string v_id, string v_name);
        DataTable GetWidgetDatetimeboxData(string v_id, string v_name);
        DataTable GetWidgetDatetimeboxData(string v_id, string v_name, string v_sort, string v_order);
        DataTable GetWidgetDatetimeboxData(int v_page, int v_rows, string v_id, string v_name, string v_sort, string v_order);
        Dictionary<string, object> GetWidgetDatetimeboxDetail(string v_No);
    }
}
