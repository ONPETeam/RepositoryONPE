using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;



namespace ModelClass
{
    /// <summary>
    ///plcgzbj 的摘要说明
    /// </summary>
    public class plcgzbj
    {
        public plcgzbj()
        {
            //
            //TODO: 在此处添加构造函数逻辑
            //
        }

        public int dIntID { get; set; }
        public int dIntPLCdianID { get; set; }
        public string dVchAddress { get; set; }
        public string dVchBaojingValue { get; set; }
        public string dVchBaojingMiaoshu { get; set; }
        public int dIntBiaozhi { get; set; }
        public DateTime dDaeBaojingShijian { get; set; }
        public string dVchBanbie { get; set; }
        public string dVchBanci { get; set; }
        public int dIntBaojingID { get; set; }
        public string dVchGzCsYy { get; set; }
        public string dVchCLBF { get; set; }

    }
}