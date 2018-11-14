using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace ModelClass
{
    /// <summary>
    ///tsd 的摘要说明
    /// </summary>
    public class tsd
    {
        public string dIntNote { get; set; }
        public string dVchWorkNote { get; set; }
        public string equip_code { get; set; }
        public string equip_name { get; set; }
        public string equip_cdh { get; set; }
        public string requestUnit { get; set; }
        public string requestPeo { get; set; }
        public string requestStopTime { get; set; }
        public string actionStopTime { get; set; }
        public string actionStopPeo { get; set; }

        public string requestEndUnit { get; set; }
        public string requestEndPeo { get; set; }
        public string requestEndTime { get; set; }
        public string actionEndTime { get; set; }
        public string actionEndPeo { get; set; }
        public string dVchRemark { get; set; }
    }
}