using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;


namespace ModelClass
{
    public class basePara
    {
        public int dIntPointID { get; set; }
        public string dVchPointName { get; set; }
        public float dFatPointValue { get; set; }
        public string dVchRemark { get; set; }

    }
    public class TCNote
    {
        public string dVchTCNote { get; set; }
        public string equip_code { get; set; }
        public string equip_name { get; set; }
        public string area_id { get; set; }
        public string area_name { get; set; }
        public string dVchTCType { get; set; }
        public string dVchTCUnit { get; set; }
        public string dVchTCSpecialty { get; set; }
        public string branch_id { get; set; }
        public string branch_name { get; set; }
        public string employee_code { get; set; }
        public string dVchTCPeople { get; set; }
        public DateTime dDaeTCDate { get; set; }
        public string dVchRemark { get; set; }
    }
    public class TCDetail
    {
        public string dVchTCNote { get; set; }
        public string dVchTCDetail { get; set; }
        public string dVchPartName { get; set; }
        public string dVchContentName { get; set; }
        public string dVchStandardName { get; set; }

        public string dVchPartID { get; set; }
        public string dVchContentID { get; set; }
        public string dVchStandardID { get; set; }

        public string dVchTCResult { get; set; }

        public string dVchTCPic { get; set; }
        public string dVchTCAvi { get; set; }

        public DateTime dDaeTCDetailDate { get; set; }
        public DateTime dDaeTCNextDate { get; set; }

        public string dVchXYZ { get; set; }
    }
    public class TCPlanDetail
    {
        public string dVchPlanData { get; set; }
        public string dVchTCPlan { get; set; }
        public string dVchName { get; set; }
        public string equip_code { get; set; }
        public string equip_name { get; set; }
        public string dVchPartName { get; set; }

        public string dVchContentName { get; set; }
        public string dVchStandardName { get; set; }

        public string dVchPartID { get; set; }
        public string dVchContentID { get; set; }
        public string dVchStandardID { get; set; }

        public DateTime dDaeTCDetailDate { get; set; }
        public DateTime dDaeTCNextDate { get; set; }

        public string dVchUser { get; set; }

        public string employee_code { get; set; }

        public string dVchCheckState { get; set; }

        public int dIntStandardCheck { get; set; }
        public string dVchMajorCode { get; set; }
        public string dVchMajorName { get; set; }
        public string employee_name { get; set; }
    }
    public class TCBadNote
    {
        public string dVchTCNote { get; set; }
        public string dVchTCDetail { get; set; }
        public string dVchPartName { get; set; }
        public string dVchContentName { get; set; }
        public string dVchStandardName { get; set; }

        public string dVchPartID { get; set; }
        public string dVchContentID { get; set; }
        public string dVchStandardID { get; set; }

        public string dVchBanContent { get; set; }

    }
    public class SCYuanStone
    {
        public string dIntgStoneID { get; set; }
        public DateTime dDaeInDate { get; set; }
        public string dVchStoneNum { get; set; }
        public float dFatStoneWeight { get; set; }
        public string dVchSongJianPeo { get; set; }
        public string dVchJianYanPeo { get; set; }
        public float dFatCaO { get; set; }
        public float dFatMgO { get; set; }
        public float dFatSiO2 { get; set; }
        public float dFatLiDu { get; set; }
        public string dVchStonePic { get; set; }
    }

    public class SCProductor
    {
        public string dIntgProductorID { get; set; }
        public DateTime dDaeInDate { get; set; }
        public string dVchProductoNum { get; set; }
        public float dFatProductoWeight { get; set; }
        public string dVchSongJianPeo { get; set; }
        public string dVchJianYanPeo { get; set; }
        public float dFatCaO { get; set; }
        public float dFatMgO { get; set; }
        public float dFatSiO2 { get; set; }
        public float dFatHuoxingDu { get; set; }
        public float dFatFailLv { get; set; }
        public string dVchStonePic { get; set; }
    }
    public class CircleData : basePara
    {
        public DateTime dDaeGetTime { get; set; }
    }

}