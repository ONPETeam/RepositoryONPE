using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace GJHF.Data.Model.HR
{
    public class Branch
    {
        public int branch_id { get; set; }
        public string branch_name { get; set; }
        public string branch_innum { get; set; }
        public int branch_parent_id { get; set; }
        public string branch_parent_name { get; set; }
        public int company_id { get; set; }
        public string company_name { get; set; }
    }
}
