using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace GJHF.Data.Model.FLOW.DESIGN
{
    public class MFlowDesignStep
    {
        public string step_id { get; set; }
        public string step_name { get; set; }
        public string flow_id { get; set; }
        public string version_id { get; set; }
        public string step_type { get; set; }
        public string step_x { get; set; }
        public string step_y { get; set; }
        public string base_OpinionDisplay { get; set; }
        public string base_ExpiredPrompt { get; set; }
        public string base_SignatureType { get; set; }
        public string base_WorkTime { get; set; }
        public string base_Archives { get; set; }
        public string send_message { get; set; }
        public string back_message { get; set; }
        public string form_forms { get; set; }
        public string base_SubFlow { get; set; }
        public string base_Note { get; set; }
        public string behavior_FlowType { get; set; }
        public string behavior_RunSelect { get; set; }
        public string behavior_HandlerType { get; set; }
        public string behavior_SelectRange { get; set; }
        public string behavior_HandlerStep { get; set; }
        public string behavior_ValueField { get; set; }
        public string behavior_DefaultHandler { get; set; }
        public string behavior_BackModel { get; set; }
        public string behavior_HanlderModel { get; set; }
        public string behavior_BackType { get; set; }
        public string behavior_Percentage { get; set; }
        public string behavior_BackStep { get; set; }
        public string behavior_Countersignature { get; set; }
        public string behavior_CountersignaturePercentage { get; set; }
        public string behavior_CopyFor { get; set; }
        public string behavior_SubFlowStrategy { get; set; }
        public string event_SubFlowActivationBefore { get; set; }
        public string event_SubFlowCompletedBefore { get; set; }
        public string event_SubmitBefore { get; set; }
        public string event_SubmitAfter { get; set; }
        public string event_BackBefore { get; set; }
        public string event_BackAfter { get; set; }
    }
}
