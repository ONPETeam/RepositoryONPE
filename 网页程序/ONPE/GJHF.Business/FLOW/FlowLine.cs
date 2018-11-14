using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace GJHF.Business.FLOW
{
    public class FlowLine
    {
        private GJHF.Data.Interface.FLOW.DESIGN.IFlowDesignLine iIFlowDesignLine;
        public FlowLine()
        {
            this.iIFlowDesignLine = GJHF.Data.Factory.FLOW.DESIGN.FFlowDesignLine.Create();
        }
        public int SaveLine(string v_line_id, string v_flow_id, string v_version_id, string v_step_start, string v_step_stop, int v_line_style, int v_start_type,
            string v_event_code, DateTime v_start_time, string v_database_connect, string v_table_name, string v_field_name, string v_set_value)
        {
            Dictionary<string, object> mDic = new Dictionary<string, object>();
            mDic = iIFlowDesignLine.GetLine(v_line_id);
            if (mDic["line_id"].ToString() == "")
            {
                return iIFlowDesignLine.SaveNewLine(v_line_id, v_flow_id, v_version_id, v_step_start, v_step_stop, v_line_style, v_start_type, v_event_code, 
                    v_start_time, v_database_connect, v_table_name, v_field_name, v_set_value);
            }
            else
            {
                return iIFlowDesignLine.UpdateLine(v_line_id, v_flow_id, v_version_id, v_step_start, v_step_stop, v_line_style, v_start_type, v_event_code,
                    v_start_time, v_database_connect, v_table_name, v_field_name, v_set_value);
            }
        }
        public Dictionary<string, object> GetLineDetail(string v_line_id)
        {
            return iIFlowDesignLine.GetLine(v_line_id);
        }
    }
}
