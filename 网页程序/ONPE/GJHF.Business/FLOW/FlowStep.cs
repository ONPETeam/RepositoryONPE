using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;

namespace GJHF.Business.FLOW
{
    public class FlowStep
    {
        private GJHF.Data.Interface.FLOW.DESIGN.IFlowDesignStep iIFlowDesignStep;
        public FlowStep()
        {
            this.iIFlowDesignStep = GJHF.Data.Factory.FLOW.DESIGN.FFlowDesignStep.Create();
        }
        public int SaveStep(string v_step_id, string v_step_name, string v_flow_id, string v_version_id, string v_step_type, float v_step_x,
                float v_step_y, int v_base_OpinionDisplay, int v_base_ExpiredPrompt, int v_base_SignatureType, float v_base_WorkTime,
                int v_base_Archives, string v_send_message, string v_back_message, string v_form_forms, string v_base_SubFlow, string v_base_Note,
                int v_behavior_FlowType, int v_behavior_RunSelect, int v_behavior_HandlerType, string v_behavior_SelectRange, string v_behavior_HandlerStep,
                string v_behavior_ValueField, string v_behavior_DefaultHandler, int v_behavior_BackModel, int v_behavior_HanlderModel, int v_behavior_BackType,
                float v_behavior_Percentage, string v_behavior_BackStep, int v_behavior_Countersignature, float v_behavior_CountersignaturePercentage,
                string v_behavior_CopyFor, int v_behavior_SubFlowStrategy, string v_event_SubFlowActivationBefore, string v_event_SubFlowCompletedBefore,
                string v_event_SubmitBefore, string v_event_SubmitAfter, string v_event_BackBefore, string v_event_BackAfter)
        {
            Dictionary<string, object> mDic = new Dictionary<string, object>();
            mDic = iIFlowDesignStep.GetStepDetail(v_step_id);
            if (mDic["step_id"]!="")
            {
                return iIFlowDesignStep.UpdateStep(v_step_id, v_step_name, v_flow_id, v_version_id, v_step_type, v_step_x,
                 v_step_y, v_base_OpinionDisplay, v_base_ExpiredPrompt, v_base_SignatureType, v_base_WorkTime,
                 v_base_Archives, v_send_message, v_back_message, v_form_forms, v_base_SubFlow, v_base_Note,
                 v_behavior_FlowType, v_behavior_RunSelect, v_behavior_HandlerType, v_behavior_SelectRange, v_behavior_HandlerStep,
                 v_behavior_ValueField, v_behavior_DefaultHandler, v_behavior_BackModel, v_behavior_HanlderModel, v_behavior_BackType,
                 v_behavior_Percentage, v_behavior_BackStep, v_behavior_Countersignature, v_behavior_CountersignaturePercentage,
                 v_behavior_CopyFor, v_behavior_SubFlowStrategy, v_event_SubFlowActivationBefore, v_event_SubFlowCompletedBefore,
                 v_event_SubmitBefore, v_event_SubmitAfter, v_event_BackBefore, v_event_BackAfter);
            }
            else
            {
                return iIFlowDesignStep.AddStep(v_step_id, v_step_name, v_flow_id, v_version_id, v_step_type, v_step_x,
                                v_step_y, v_base_OpinionDisplay, v_base_ExpiredPrompt, v_base_SignatureType, v_base_WorkTime,
                                v_base_Archives, v_send_message, v_back_message, v_form_forms, v_base_SubFlow, v_base_Note,
                                v_behavior_FlowType, v_behavior_RunSelect, v_behavior_HandlerType, v_behavior_SelectRange, v_behavior_HandlerStep,
                                v_behavior_ValueField, v_behavior_DefaultHandler, v_behavior_BackModel, v_behavior_HanlderModel, v_behavior_BackType,
                                v_behavior_Percentage, v_behavior_BackStep, v_behavior_Countersignature, v_behavior_CountersignaturePercentage,
                                v_behavior_CopyFor, v_behavior_SubFlowStrategy, v_event_SubFlowActivationBefore, v_event_SubFlowCompletedBefore,
                                v_event_SubmitBefore, v_event_SubmitAfter, v_event_BackBefore, v_event_BackAfter);
            }
        }
        public int AddStep(string v_step_id, string v_step_name, string v_flow_id, string v_version_id, string v_step_type, float v_step_x,
                float v_step_y, int v_base_OpinionDisplay, int v_base_ExpiredPrompt, int v_base_SignatureType, float v_base_WorkTime,
                int v_base_Archives, string v_send_message, string v_back_message, string v_form_forms, string v_base_SubFlow, string v_base_Note,
                int v_behavior_FlowType, int v_behavior_RunSelect, int v_behavior_HandlerType, string v_behavior_SelectRange, string v_behavior_HandlerStep,
                string v_behavior_ValueField, string v_behavior_DefaultHandler, int v_behavior_BackModel, int v_behavior_HanlderModel, int v_behavior_BackType,
                float v_behavior_Percentage, string v_behavior_BackStep, int v_behavior_Countersignature, float v_behavior_CountersignaturePercentage,
                string v_behavior_CopyFor, int v_behavior_SubFlowStrategy, string v_event_SubFlowActivationBefore, string v_event_SubFlowCompletedBefore,
                string v_event_SubmitBefore, string v_event_SubmitAfter, string v_event_BackBefore, string v_event_BackAfter)
        {
            return iIFlowDesignStep.AddStep(v_step_id, v_step_name, v_flow_id, v_version_id, v_step_type, v_step_x,
                 v_step_y, v_base_OpinionDisplay, v_base_ExpiredPrompt, v_base_SignatureType, v_base_WorkTime,
                 v_base_Archives, v_send_message, v_back_message, v_form_forms, v_base_SubFlow, v_base_Note,
                 v_behavior_FlowType, v_behavior_RunSelect, v_behavior_HandlerType, v_behavior_SelectRange, v_behavior_HandlerStep,
                 v_behavior_ValueField, v_behavior_DefaultHandler, v_behavior_BackModel, v_behavior_HanlderModel, v_behavior_BackType,
                 v_behavior_Percentage, v_behavior_BackStep, v_behavior_Countersignature, v_behavior_CountersignaturePercentage,
                 v_behavior_CopyFor, v_behavior_SubFlowStrategy, v_event_SubFlowActivationBefore, v_event_SubFlowCompletedBefore,
                 v_event_SubmitBefore, v_event_SubmitAfter, v_event_BackBefore, v_event_BackAfter);
        }
        public int UpdateStep(string v_step_id, string v_step_name, string v_flow_id, string v_version_id, string v_step_type, float v_step_x,
                float v_step_y, int v_base_OpinionDisplay, int v_base_ExpiredPrompt, int v_base_SignatureType, float v_base_WorkTime,
                int v_base_Archives, string v_send_message, string v_back_message, string v_form_forms, string v_base_SubFlow, string v_base_Note,
                int v_behavior_FlowType, int v_behavior_RunSelect, int v_behavior_HandlerType, string v_behavior_SelectRange, string v_behavior_HandlerStep,
                string v_behavior_ValueField, string v_behavior_DefaultHandler, int v_behavior_BackModel, int v_behavior_HanlderModel, int v_behavior_BackType,
                float v_behavior_Percentage, string v_behavior_BackStep, int v_behavior_Countersignature, float v_behavior_CountersignaturePercentage,
                string v_behavior_CopyFor, int v_behavior_SubFlowStrategy, string v_event_SubFlowActivationBefore, string v_event_SubFlowCompletedBefore,
                string v_event_SubmitBefore, string v_event_SubmitAfter, string v_event_BackBefore, string v_event_BackAfter)
        {
            return iIFlowDesignStep.UpdateStep(v_step_id, v_step_name, v_flow_id, v_version_id, v_step_type, v_step_x,
                 v_step_y, v_base_OpinionDisplay, v_base_ExpiredPrompt, v_base_SignatureType, v_base_WorkTime,
                 v_base_Archives, v_send_message, v_back_message, v_form_forms, v_base_SubFlow, v_base_Note,
                 v_behavior_FlowType, v_behavior_RunSelect, v_behavior_HandlerType, v_behavior_SelectRange, v_behavior_HandlerStep,
                 v_behavior_ValueField, v_behavior_DefaultHandler, v_behavior_BackModel, v_behavior_HanlderModel, v_behavior_BackType,
                 v_behavior_Percentage, v_behavior_BackStep, v_behavior_Countersignature, v_behavior_CountersignaturePercentage,
                 v_behavior_CopyFor, v_behavior_SubFlowStrategy, v_event_SubFlowActivationBefore, v_event_SubFlowCompletedBefore,
                 v_event_SubmitBefore, v_event_SubmitAfter, v_event_BackBefore, v_event_BackAfter);
        }
        public int DelStep(string v_step_id)
        {
            return iIFlowDesignStep.DelStep(v_step_id);
        }

        public Dictionary<string, object> GetStepDetail(string v_step_id)
        {
            return iIFlowDesignStep.GetStepDetail(v_step_id);
        }

        public int GetStepCount(string v_flow_id, string v_version_id)
        {
            return iIFlowDesignStep.GetStepCount(v_flow_id, v_version_id);
        }

        public DataTable GetStep(int v_page, int v_rows, string v_flow_id, string v_version_id, string v_sort, string v_order)
        {
            return iIFlowDesignStep.GetStep(v_page, v_rows, v_flow_id, v_version_id, v_sort, v_order);
        }

        public DataTable GetStep(string v_flow_id, string v_version_id, string v_sort, string v_order)
        {
            return iIFlowDesignStep.GetStep(v_flow_id, v_version_id, v_sort, v_order);
        }

        public DataTable GetStep(string v_flow_id, string v_version_id)
        {
            return iIFlowDesignStep.GetStep(v_flow_id, v_version_id);
        }
    }
}
