using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace ModelClass
{
    /// <summary>
    ///Company 的摘要说明
    /// </summary>
    public class Company
    {
        public int dIntCompanyID { get; set; }
        public string dVchCompanyName { get; set; }
        public string dVchShortName { get; set; }
        public string dVchZZJGDM { get; set; }
        public string dVchAddress { get; set; }
        public string dVchPhone { get; set; }
        public string dVchWeb { get; set; }
        public string dVchEmail { get; set; }
        public int dIntFlagSelf { get; set; }
    }
}