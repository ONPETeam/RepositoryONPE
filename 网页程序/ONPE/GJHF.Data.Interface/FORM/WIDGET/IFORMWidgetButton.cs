using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using GJHF.Data.Model.FORM.WIDGET;

namespace GJHF.Data.Interface.FORM.WIDGET
{
    public interface IFORMWidgetButton
    {
        int AddWidgetButtonData(string v_id, string v_name, int v_style, int v_plain, string v_icon, int v_align, int v_eventtype, string v_eventcontext);
        int EditWidgetButtonData(string v_No, string v_id, string v_name, int v_style, int v_plain, string v_icon, int v_align, int v_eventtype, string v_eventcontext);
        int DelWidgetButtonData(string v_No);
        int GetWidgetButtonCount(string v_id, string v_name);
        DataTable GetWidgetButtonData(string v_id, string v_name);
        DataTable GetWidgetButtonData(string v_id, string v_name, string v_sort, string v_order);
        DataTable GetWidgetButtonData(int v_page, int v_rows, string v_id, string v_name, string v_sort, string v_order);
        Dictionary<string, object> GetWidgetButtonDetail(string v_No);
    }
}
