using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Newtonsoft.Json;

namespace GJHF.Business.FLOW
{
    public class FlowWFJson
    {
        private GJHF.Data.Interface.FLOW.DESIGN.IFlowWFJson bIFlowWFJson;
        public FlowWFJson()
        {
            this.bIFlowWFJson = GJHF.Data.Factory.FLOW.DESIGN.FFlowWFJson.Create();
        }
        public int SaveWFJson(string v_flow_id, string v_version_id, string v_wf_json)
        {
            GJHF.Data.Model.FLOW.DESIGN.MFlowWFJson mMFlowWFJson = (GJHF.Data.Model.FLOW.DESIGN.MFlowWFJson)JsonConvert.DeserializeObject<GJHF.Data.Model.FLOW.DESIGN.MFlowWFJson>(v_wf_json);
            return bIFlowWFJson.SaveWFJson(v_flow_id, v_version_id, mMFlowWFJson);
        }
    }
}
