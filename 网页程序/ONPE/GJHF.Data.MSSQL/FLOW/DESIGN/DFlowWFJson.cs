using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using System.Data.SqlClient;

namespace GJHF.Data.MSSQL.FLOW.DESIGN
{
    public class DFlowWFJson:GJHF.Data.Interface.FLOW.DESIGN.IFlowWFJson
    {
        public Model.FLOW.DESIGN.MFlowWFJson GetWFJson(string v_flow_id, string v_version_id = "")
        {
            Model.FLOW.DESIGN.MFlowWFJson mMFlowWFJson = new Model.FLOW.DESIGN.MFlowWFJson();
            mMFlowWFJson.steps = new List<Model.FLOW.DESIGN.MFlowWFStep>();
            mMFlowWFJson.lines = new List<Model.FLOW.DESIGN.MFlowWFLine>();
            DFlowDesignStep mDFlowDesignStep=new DFlowDesignStep();
            DataTable dtStep = mDFlowDesignStep.GetStep(v_flow_id, v_version_id);
            for (int i = 0; i < dtStep.Rows.Count; i++)
            {
                Model.FLOW.DESIGN.MFlowWFStep mMFlowWFStep = new Model.FLOW.DESIGN.MFlowWFStep();
                mMFlowWFStep.id = dtStep.Rows[i][0].ToString();
                mMFlowWFStep.name = dtStep.Rows[i][1].ToString();
                mMFlowWFStep.type = dtStep.Rows[i][4].ToString() != "subflow" ? "normal" : "subflow";
                Model.FLOW.DESIGN.MFlowWFPosition mMFlowWFPosition = new Model.FLOW.DESIGN.MFlowWFPosition();
                mMFlowWFPosition.x = dtStep.Rows[i][5] == null ? 0 : float.Parse(dtStep.Rows[i][5].ToString());
                mMFlowWFPosition.y = dtStep.Rows[i][6] == null ? 0 : float.Parse(dtStep.Rows[i][6].ToString());
                mMFlowWFStep.position = mMFlowWFPosition;
                mMFlowWFJson.steps.Add(mMFlowWFStep);
            }
            DFLOWDesignLine mDFLOWDesignLine=new DFLOWDesignLine();
            DataTable dtLine = mDFLOWDesignLine.GetDesignLinesData(v_flow_id, v_version_id);
            for (int i = 0; i < dtLine.Rows.Count; i++)
            {
                Model.FLOW.DESIGN.MFlowWFLine mMFlowWFLine = new Model.FLOW.DESIGN.MFlowWFLine();
                mMFlowWFLine.id = dtLine.Rows[i][0].ToString();
                mMFlowWFLine.text = "";
                mMFlowWFLine.from = dtLine.Rows[i][3].ToString();
                mMFlowWFLine.to = dtLine.Rows[i][4].ToString();
                mMFlowWFJson.lines.Add(mMFlowWFLine);
            }
            return mMFlowWFJson;
        }


        public int SaveWFJson(string v_flow_id, string v_version_id, Model.FLOW.DESIGN.MFlowWFJson v_wf_json)
        {
            int mIntReturn = 1;
            DFlowDesignStep mDFlowDesignStep=new DFlowDesignStep();
            DFLOWDesignLine mDFLOWDesignLine=new DFLOWDesignLine();
            if (v_wf_json != null)
            {
                foreach (Model.FLOW.DESIGN.MFlowWFStep mMFlowWFStep in v_wf_json.steps)
                {
                    Dictionary<string,object> mDic=mDFlowDesignStep.GetStepDetail(mMFlowWFStep.id);
                    if (mDic["step_id"].ToString() == "")
                    {
                        if(mDFlowDesignStep.AddStepLayout(mMFlowWFStep.id, v_flow_id, v_version_id, mMFlowWFStep.type, mMFlowWFStep.position.x, mMFlowWFStep.position.y)!=1)
                        {
                            mIntReturn -= 1;
                        }
                    }
                    else
                    {
                        if (mDFlowDesignStep.UpdateStepLayout(mMFlowWFStep.id, v_flow_id, v_version_id, mMFlowWFStep.type, mMFlowWFStep.position.x, mMFlowWFStep.position.y) != 1)
                        {
                            mIntReturn -= 1;
                        }
                    }
                }
                foreach (Model.FLOW.DESIGN.MFlowWFLine mMFlowWFLine in v_wf_json.lines)
                {
                    Dictionary<string, object> mDic = mDFLOWDesignLine.GetLine(mMFlowWFLine.id);
                    if (mDic["line_id"].ToString() == "")
                    {
                        if (mDFLOWDesignLine.AddLineLayout(mMFlowWFLine.id, v_flow_id, v_version_id, mMFlowWFLine.from, mMFlowWFLine.to) != 1)
                        {
                            mIntReturn -= 1;
                        }
                    }
                    else
                    {
                        if (mDFLOWDesignLine.UpdateLineLayout(mMFlowWFLine.id, v_flow_id, v_version_id, mMFlowWFLine.from, mMFlowWFLine.to) != 1)
                        {
                            mIntReturn -= 1;
                        }
                    }
                }
            }
            return mIntReturn;
        }

    }
}
