using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace ModelClass
{
    public class TCName
    {
        public int dIntNameNote { get; set; }
        public string dVchName { get; set; }
        public string dVchRemark { get; set; }

    }
    public class TCBW
    {
        public int dIntPartNote { get; set; }
        public string dVchPartName { get; set; }
        public string dVchRemark { get; set; }

        public int dIntNameNote { get; set; }
        public string dVchName { get; set; }
    }

    public class TCContent
    {
        public int dIntPartNote { get; set; }
        public string dVchPartName { get; set; }

        public int dIntContentNote { get; set; }
        public string dVchContentName { get; set; }
        public string dVchRemark { get; set; }

        public string LineNode { get; set; }
    }

    public class TCStandard
    {
        public int dIntContentNote { get; set; }
        public string dVchContentName { get; set; }

        public int dIntStandardNote { get; set; }
        public string dVchStandardName { get; set; }
        public int dIngCheckType1 { get; set; }
        public int dIngCheckType2 { get; set; }
        public int dIngCheckType3 { get; set; }
        public int dIngCheckType4 { get; set; }
        public string dVchCheckMethod { get; set; }
        public int dIntCheckDay { get; set; }
        public string dVchPostName { get; set; }
        public string dVchCheckState { get; set; }
        public string dVchExMethod { get; set; }
        public string dVchSafeMethod { get; set; }
        public string dIntBranchID { get; set; }
        public string dIntCompanyID { get; set; }
        public string dVchBranchName { get; set; }
        public string dVchCompanyName { get; set; }

        public string dVchLevel { get; set; }
    }

    public class ActionLine
    {
        public int dIntLineNote { get; set; }
        public string dVchLine { get; set; }
    }
    public class ActionNode
    {
        public int dIntNodeNote { get; set; }
        public string dVchNode { get; set; }
    }

    public class LineNode
    {
        public int dIntLineNote { get; set; }
        public string dVchLine { get; set; }
        public int dIntNodeNote { get; set; }
        public string dVchNode { get; set; }
        public int dIntNodeIndex { get; set; }
    }

    public class ContentNode
    {
        public string dVchLine { get; set; }
        public string dVchNode { get; set; }
        public string dVchContentName { get; set; }
        public int dIntNodeNote { get; set; }
        public int dIntContentNote { get; set; }
    }
}