using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Collections;

namespace GJHF.Data.Model.FLOW.DESIGN
{
    public class MFlowWFJson
    {
        public List<MFlowWFStep> steps { get; set; }
        public List<MFlowWFLine> lines { get; set; }
    }
    public class MFlowWFStep
    {
        public string id { get; set; }
        public string type{get;set;}
        public string name { get; set; }
        public MFlowWFPosition position { get; set; }
    }
    public class MFlowWFPosition{
        public float x{get;set;}
        public float y { get; set; }
        public float width { get; set; }
        public float height { get; set; }
    }
    public class MFlowWFLine {
        public string id { get; set; }
        public string text { get; set; }
        public string from { get; set; }
        public string to { get; set; }
    }
}
