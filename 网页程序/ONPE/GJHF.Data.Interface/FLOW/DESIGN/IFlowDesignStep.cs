using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;

namespace GJHF.Data.Interface.FLOW.DESIGN
{
    public interface IFlowDesignStep
    {
        int AddStep(string v_step_id, string v_step_name, string v_flow_id, string v_version_id, string v_step_type, float v_step_x,
                float v_step_y, int v_base_OpinionDisplay, int v_base_ExpiredPrompt, int v_base_SignatureType, float v_base_WorkTime,
                int v_base_Archives, string v_send_message, string v_back_message, string v_form_forms, string v_base_SubFlow, string v_base_Note,
                int v_behavior_FlowType, int v_behavior_RunSelect, int v_behavior_HandlerType, string v_behavior_SelectRange, string v_behavior_HandlerStep,
                string v_behavior_ValueField, string v_behavior_DefaultHandler, int v_behavior_BackModel, int v_behavior_HanlderModel, int v_behavior_BackType,
                float v_behavior_Percentage, string v_behavior_BackStep, int v_behavior_Countersignature, float v_behavior_CountersignaturePercentage,
                string v_behavior_CopyFor, int v_behavior_SubFlowStrategy, string v_event_SubFlowActivationBefore, string v_event_SubFlowCompletedBefore,
                string v_event_SubmitBefore, string v_event_SubmitAfter, string v_event_BackBefore, string v_event_BackAfter);
        int UpdateStep(string v_step_id, string v_step_name, string v_flow_id, string v_version_id, string v_step_type, float v_step_x,
                float v_step_y, int v_base_OpinionDisplay, int v_base_ExpiredPrompt, int v_base_SignatureType, float v_base_WorkTime,
                int v_base_Archives, string v_send_message, string v_back_message, string v_form_forms, string v_base_SubFlow, string v_base_Note,
                int v_behavior_FlowType, int v_behavior_RunSelect, int v_behavior_HandlerType, string v_behavior_SelectRange, string v_behavior_HandlerStep,
                string v_behavior_ValueField, string v_behavior_DefaultHandler, int v_behavior_BackModel, int v_behavior_HanlderModel, int v_behavior_BackType,
                float v_behavior_Percentage, string v_behavior_BackStep, int v_behavior_Countersignature, float v_behavior_CountersignaturePercentage,
                string v_behavior_CopyFor, int v_behavior_SubFlowStrategy, string v_event_SubFlowActivationBefore, string v_event_SubFlowCompletedBefore,
                string v_event_SubmitBefore, string v_event_SubmitAfter, string v_event_BackBefore, string v_event_BackAfter);
        int DelStep(string v_step_id);

        Dictionary<string, object> GetStepDetail(string v_step_id);

        int GetStepCount(string v_flow_id, string v_version_id);

        DataTable GetStep(int v_page, int v_rows, string v_flow_id, string v_version_id, string v_sort, string v_order);

        DataTable GetStep(string v_flow_id, string v_version_id, string v_sort, string v_order);

        DataTable GetStep(string v_flow_id, string v_version_id);
    }
}
