using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using GJHF.Data.Model.FORM.WIDGET;

namespace GJHF.Data.Interface.FORM.WIDGET
{
    public interface IFORMWidgetValidatebox
    {
        int AddWidgetValidateboxData(string v_id, string v_name, float v_width, float v_height, 
            float v_fontsize, int v_align, int v_regtype, string v_regcode, string v_datafrom, string v_dataview,
            string v_datafiled, string v_defaultvalue, int v_editable, int v_required, string v_placehold);
        int EditWidgetValidateboxData(string v_No, string v_id, string v_name, float v_width, float v_height,
            float v_fontsize, int v_align, int v_regtype, string v_regcode, string v_datafrom, string v_dataview,
            string v_datafiled, string v_defaultvalue, int v_editable, int v_required, string v_placehold);
        int DelWidgetValidateboxData(string v_No);
        int GetWidgetValidateboxCount(string v_id,string v_name);
        DataTable GetWidgetValidateboxData(string v_id,string v_name);
        DataTable GetWidgetValidateboxData(string v_id,string v_name, string v_sort, string v_order);
        DataTable GetWidgetValidateboxData(int v_page ,int v_rows,string v_id,string v_name,string v_sort,string v_order);
        Dictionary<string, object> GetWidgetValidateboxDetail(string v_No);
    }
}
