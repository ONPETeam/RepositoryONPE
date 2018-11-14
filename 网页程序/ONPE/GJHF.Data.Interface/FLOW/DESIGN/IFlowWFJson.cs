using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace GJHF.Data.Interface.FLOW.DESIGN
{
    public interface IFlowWFJson
    {
        GJHF.Data.Model.FLOW.DESIGN.MFlowWFJson GetWFJson(string v_flow_id, string v_version_id = "");
        int SaveWFJson(string v_flow_id, string v_version_id,GJHF.Data.Model.FLOW.DESIGN.MFlowWFJson v_wf_json);
    }
}
