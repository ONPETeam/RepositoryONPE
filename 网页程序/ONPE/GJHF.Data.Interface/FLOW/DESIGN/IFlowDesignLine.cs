using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using GJHF.Data.Model.FLOW.DESIGN;
using System.Data;

namespace GJHF.Data.Interface.FLOW.DESIGN
{
    public interface IFlowDesignLine
    {
        int SaveNewLine(string v_line_id, string v_flow_id, string v_version_id, string v_step_start, string v_step_stop ,int v_line_style, int v_start_type, 
            string v_event_code,DateTime v_start_time,string v_database_connect,string v_table_name,string v_field_name,string set_value);

        int UpdateLine(string v_line_id, string v_flow_id, string v_version_id, string v_step_start, string v_step_stop, int v_line_style, int v_start_type,
            string v_event_code, DateTime v_start_time, string v_database_connect, string v_table_name, string v_field_name, string set_value);

        int DeleteLine(string v_line_id);

        Dictionary<string,object> GetLine(string v_line_id);

        DataTable GetDesignLinesData(int v_page, int v_rows, string v_flow_id, string v_version_id, string v_sort, string v_order);

        DataTable GetDesignLinesData(string v_flow_id, string v_version_id, string v_sort, string v_order);

        DataTable GetDesignLinesData(string v_flow_id, string v_version_id);

        int GetLinesCount(string v_flow_id, string v_version_id);
    }
}
