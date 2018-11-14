using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using System.Data.SqlClient;
using GJHF.Data.Model.PLC;

namespace GJHF.Business.PLC
{
    public class BPlcDdz
    {
        BPLCPointPhoneType mBPLCPointPhoneType = new BPLCPointPhoneType();
        BPlcPointType mBPlcPointType = new BPlcPointType();
        
        public static DataTable GetData(int rows, int pages,string vStreqd,string vStrplc,string vStrsxt,string vStrSb,string vStrddz,string vStrlsOrbj)
        {
            DataTable dt = null;
            string mStrWhere = " where tZPlcPointDiZhi.dIntDataID <> -10";
            
            if (vStrsxt != "")
            {
                mStrWhere = mStrWhere + " and tZPlcPointTypeOne.dVchPointTypePj like  '%," + vStrsxt + ",%'";
            }

            if (vStreqd != "")
            {
                mStrWhere = mStrWhere + " and dVchSbBianHao = '" + vStreqd + "'";
            }
            if (vStrplc != "" && vStrplc != "0")
            {
                mStrWhere = mStrWhere + " and  tZPlcPointDiZhi.dIntPLCID = " + vStrplc;
            }

            if (vStrSb != "")
            {
                mStrWhere = mStrWhere + " and  tZSbAndPLC.dVchSbBianHao = '" + vStrSb + "'";
            }
            if (vStrddz != "")
            {
                mStrWhere = mStrWhere + " and isnull(tZPlcPointDiZhi.dVchAddress,'') + isnull(dVchAdressName,'') +  isnull(dVchDescription,'') like '%" + vStrddz + "%'";
            }
            if (vStrlsOrbj != "pt")
            {
                
                if (vStrlsOrbj == "ls")
                {
                    mStrWhere = mStrWhere + " and tZPlcHistoryDataSet_Cloud.dIntIsCollect is not null";
                }
                else if (vStrlsOrbj == "bj")
                {
                    mStrWhere = mStrWhere + " and tZPlcHistoryJK.dIntBjBz = 1";
                }
            }
            mStrWhere = mStrWhere + " order by tZPlcPointDiZhi.dIntDataID desc";
            dt = GJHF.Data.MSSQL.PLC.DPlcDdz.GetData(rows, pages, mStrWhere);
            return dt;
        }

        //public static DataTable GetData(int rows, int pages, string vStreqd, string vStrplc, string vStrsxt, string vStrSb, string vStrddz)
        //{
        //    DataTable dt = null;
        //    string mStrWhere = " where tZPlcPointDiZhi.dIntDataID <> -10";

        //    if (vStrsxt != "")
        //    {
        //        mStrWhere = mStrWhere + " and  tZPlcPointDiZhi.dIntPointType = " + vStrsxt;
        //    }

        //    if (vStreqd != "")
        //    {
        //        mStrWhere = mStrWhere + " and dVchSbBianHao = '" + vStreqd + "'";
        //    }
        //    if (vStrplc != "" && vStrplc != "0")
        //    {
        //        mStrWhere = mStrWhere + " and  tZPlcPointDiZhi.dIntPLCID = " + vStrplc;
        //    }

        //    if (vStrSb != "")
        //    {
        //        mStrWhere = mStrWhere + " and  tZSbAndPLC.dVchSbBianHao = '" + vStrSb + "'";
        //    }
        //    if (vStrddz != "")
        //    {
        //        mStrWhere = mStrWhere + " and isnull(tZPlcPointDiZhi.dVchAddress,'') + isnull(dVchAdressName,'') +  isnull(dVchDescription,'') like '%" + vStrddz + "%'";
        //    }
        //    mStrWhere = mStrWhere + " order by tZPlcPointDiZhi.dIntDataID desc";
        //    dt = GJHF.Data.MSSQL.PLC.DPlcDdz.GetData(rows, pages, mStrWhere);
        //    return dt;
        //}
        //把datatable中的数据转成list，并进行数据处理返回正确数据
        public  List<MPlcCommon> GetListData(int rows, int pages,string vStreqd,string vStrplc,string vStrsxt,string vStrSb,string vStrddz,string vStrlsOrbj)
        {

            DataTable dt = GetData(rows, pages, vStreqd, vStrplc, vStrsxt, vStrSb, vStrddz, vStrlsOrbj);
            
            List<MPlcCommon> mlist = new List<MPlcCommon>();
            
            int mIntResult=0;
            float mfltResult = 0f;
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                MPlcCommon mModel = new MPlcCommon();
                if (int.TryParse(dt.Rows[i]["dIntDataID"].ToString(), out mIntResult) == true)
                {
                    mModel.dIntDataID = Int32.Parse(dt.Rows[i]["dIntDataID"].ToString());
                }
                else
                {
                    mModel.dIntDataID = 0;
                }

                mModel.dVchAddress = dt.Rows[i]["dVchAddress"].ToString();
                mModel.dVchAdressName = dt.Rows[i]["dVchAdressName"].ToString();
                mModel.dVchDescription = dt.Rows[i]["dVchDescription"].ToString();
                if (int.TryParse(dt.Rows[i]["dIntGongType"].ToString(), out mIntResult) == true)
                {
                    mModel.dIntGongType = Int32.Parse(dt.Rows[i]["dIntGongType"].ToString());
                }
                else
                {
                    mModel.dIntGongType = 0;
                }

                if (int.TryParse(dt.Rows[i]["dIntPLCID"].ToString(), out mIntResult) == true)
                {
                    mModel.dIntPLCID = Int32.Parse(dt.Rows[i]["dIntPLCID"].ToString());
                }
                else
                {
                    mModel.dIntPLCID = 0;
                }

                mModel.plcqm = dt.Rows[i]["plcqm"].ToString();

                mModel.dVchVariableName = dt.Rows[i]["dVchVariableName"].ToString();

                if (int.TryParse(dt.Rows[i]["dIntIOType"].ToString(), out mIntResult) == true)
                {
                    mModel.dIntIOType = Int32.Parse(dt.Rows[i]["dIntIOType"].ToString());
                }
                else
                {
                    mModel.dIntIOType = 0;
                }

                mModel.dVchIOTypeName = dt.Rows[i]["dVchIOTypeName"].ToString();

                mModel.dVchPointType = "";

                if (int.TryParse(dt.Rows[i]["dIntShouJiPx"].ToString(), out mIntResult) == true)
                {
                    mModel.dIntShouJiPx = Int32.Parse(dt.Rows[i]["dIntShouJiPx"].ToString());
                }
                else
                {
                    mModel.dIntShouJiPx = 999;
                }
                mModel.dVchDanwei = dt.Rows[i]["dVchDanwei"].ToString();
                mModel.dVchAllAdress = dt.Rows[i]["dVchAllAdress"].ToString();
                mModel.dVchDataType = dt.Rows[i]["dVchDataType"].ToString();
                mModel.gStrPointType = mBPLCPointPhoneType.DataTableToString(mModel.dIntDataID,"n");
                mModel.gStrPointTypeid = mBPLCPointPhoneType.DataTableToString(mModel.dIntDataID, "i");
                if (int.TryParse(dt.Rows[i]["dIntBjBz"].ToString(), out mIntResult) == true)
                {
                    mModel.dIntBjBz = Int32.Parse(dt.Rows[i]["dIntBjBz"].ToString());
                }
                else
                {
                    mModel.dIntBjBz = 0;
                }
                mModel.dVchSbBianHao = dt.Rows[i]["dVchSbBianHao"].ToString();
                if (float.TryParse(dt.Rows[i]["dfltMax"].ToString(), out mfltResult) == true)
                {
                    mModel.dfltMax = float.Parse(dt.Rows[i]["dfltMax"].ToString());
                }
                else
                {
                    mModel.dfltMax = 0f;
                }

                if (float.TryParse(dt.Rows[i]["dfltMin"].ToString(), out mfltResult) == true)
                {
                    mModel.dfltMin = float.Parse(dt.Rows[i]["dfltMin"].ToString());
                }
                else
                {
                    mModel.dfltMin = 0f;
                }
                mModel.dVchKgAlermValue = dt.Rows[i]["dVchKgAlermValue"].ToString();
                mModel.dVchRemark = dt.Rows[i]["dVchRemark"].ToString();
                if (int.TryParse(dt.Rows[i]["dIntAdressTypeID"].ToString(), out mIntResult) == true)
                {
                    mModel.dIntAdressTypeID = Int32.Parse(dt.Rows[i]["dIntAdressTypeID"].ToString());
                }
                else
                {
                    mModel.dIntAdressTypeID = 0;
                }
                if (int.TryParse(dt.Rows[i]["dIntJsBz"].ToString(), out mIntResult) == true)
                {
                    mModel.dIntJsBz = Int32.Parse(dt.Rows[i]["dIntJsBz"].ToString());
                }
                else
                {
                    mModel.dIntJsBz = 0;
                }
                if (int.TryParse(dt.Rows[i]["dIntIsCollect"].ToString(), out mIntResult) == true)
                {
                    mModel.dIntIsCollect = Int32.Parse(dt.Rows[i]["dIntIsCollect"].ToString());
                }
                else
                {
                    mModel.dIntIsCollect = 0;
                }
                if (int.TryParse(dt.Rows[i]["dIntCollectSec"].ToString(), out mIntResult) == true)
                {
                    mModel.dIntCollectSec = Int32.Parse(dt.Rows[i]["dIntCollectSec"].ToString());
                }
                else
                {
                    mModel.dIntCollectSec = 0;
                }
                if (int.TryParse(dt.Rows[i]["dIntCollectType"].ToString(), out mIntResult) == true)
                {
                    mModel.dIntCollectType = Int32.Parse(dt.Rows[i]["dIntCollectType"].ToString());
                }
                else
                {
                    mModel.dIntCollectType = 0;
                }
                mlist.Add(mModel);
            }
            return mlist;
        }
        public static int GetRecordCount(string vStreqd, string vStrplc, string vStrsxt, string vStrSb, string vStrddz, string vStrlsOrbj)
        {
            int count = 0;
            string mStrWhere = " where tZPlcPointDiZhi.dIntDataID <> -10";
            if (vStreqd != "")
            {
                mStrWhere = mStrWhere + " and dVchSbBianHao = '" + vStreqd + "'";
            }
            if (vStrplc != "" && vStrplc != "0")
            {
                mStrWhere = mStrWhere + " and  tZPlcPointDiZhi.dIntPLCID = " + vStrplc;
            }
            if (vStrsxt != "")
            {
                mStrWhere = mStrWhere + " and  tZPlcPointDiZhi.dIntPointType = " + vStrsxt;
            }
            if (vStrSb != "")
            {
                mStrWhere = mStrWhere + " and  tZSbAndPLC.dVchSbBianHao = '" + vStrSb + "'";
            }
            if (vStrddz != "")
            {
                mStrWhere = mStrWhere + " and isnull(tZPlcPointDiZhi.dVchAddress,'') + isnull(dVchAdressName,'') +  isnull(dVchDescription,'') like '%" + vStrddz + "%'";
            }
            if (vStrlsOrbj != "pt")
            {

                if (vStrlsOrbj == "ls")
                {
                    mStrWhere = mStrWhere + " and tZPlcHistoryDataSet_Cloud.dIntIsCollect is not null";
                }
                else if (vStrlsOrbj == "bj")
                {
                    mStrWhere = mStrWhere + " and tZPlcHistoryJK.dIntBjBz = 1";
                }
            }

            count = GJHF.Data.MSSQL.PLC.DPlcDdz.GetRecordCount(mStrWhere);
            return count;
        }
        //public static bool AddData(string vStrAdressName, string vStrAddress, string vStrAllAdress, string vStrDescription, int vIntDataType, float vFltBeishu, float vFltMoniMax, float vFltMoniMin, float vFltSjMax, float vFltSjMin,
        //    string vStrDanwei, int vIntGongType, int vIntNY, int vIntPLCXitong, string vStrDataType, int vIntZongGZ, string vStrSheBei1, string vStrSheBei2, string vStrNeiBuBL1, string vStrNeiBuBL2, int vIntIOType, int vIntPLCID,
        //    int vIntGzorQd, int vIntSjXitong, int vIntXS, int vIntjsl,out int voIntdizhi,out string msg)
        //{
            //bool isSuccess = false;
            //msg = "失败";
            //if (GJHF.Data.MSSQL.PLC.DPlcDdz.AddData(vStrAdressName, vStrAddress, vStrAllAdress, vStrDescription, vIntDataType, vFltBeishu, vFltMoniMax, vFltMoniMin, vFltSjMax, vFltSjMin,
            //     vStrDanwei, vIntGongType, vIntNY, vIntPLCXitong, vStrDataType, vIntZongGZ, vStrSheBei1, vStrSheBei2, vStrNeiBuBL1, vStrNeiBuBL2, vIntIOType, vIntPLCID,
            //     vIntGzorQd, vIntSjXitong, vIntXS, vIntjsl, out  voIntdizhi) >= 0)
            //{
            //    isSuccess = true;
            //    msg = "成功";

            //}
            //return isSuccess;
        //}
        public static bool AddData(string vStrAdressName, string vStrAddress, string vStrAllAdress, string vStrDescription, int vIntDataType, float vFltBeishu, float vFltMoniMax, float vFltMoniMin, float vFltSjMax, float vFltSjMin,
            string vStrDanwei, int vIntGongType, int vIntNY, int vIntPLCXitong, string vStrDataType, int vIntZongGZ, string vStrSheBei1, string vStrSheBei2, string vStrNeiBuBL1, string vStrNeiBuBL2, int vIntIOType, int vIntPLCID,
            int vIntGzorQd, string vStrSjXitong,char vChrPhoneIDSeparator, int vIntXS, int vIntjsl,out int voIntdizhi,out string msg)
        {
            GJHF.Business.PLC.BPLCPointPhoneType bBPLCPointPhoneType = new BPLCPointPhoneType();
            bool isSuccess = false;
            msg = "失败";
            int mIntReturn = GJHF.Data.MSSQL.PLC.DPlcDdz.AddData(vStrAdressName, vStrAddress, vStrAllAdress, vStrDescription, vIntDataType, vFltBeishu, vFltMoniMax, vFltMoniMin, vFltSjMax, vFltSjMin,
                 vStrDanwei, vIntGongType, vIntNY, vIntPLCXitong, vStrDataType, vIntZongGZ, vStrSheBei1, vStrSheBei2, vStrNeiBuBL1, vStrNeiBuBL2, vIntIOType, vIntPLCID,
                 vIntGzorQd, 0, vIntXS, vIntjsl, out  voIntdizhi);
            if ( mIntReturn>= 0)
            {
                int mIntPLCPointAddressID = voIntdizhi;
                int mIntBindReturn = bBPLCPointPhoneType.SavePLCPointPhoneType(mIntPLCPointAddressID, vStrSjXitong, vChrPhoneIDSeparator);
                if (mIntBindReturn == 1)
                {
                    isSuccess = true;
                    msg = "成功";
                }
            }
            return isSuccess;


        }
        //public static bool EditData(int viIntDataID, string vStrAdressName, string vStrAddress, string vStrAllAdress, string vStrDescription, int vIntDataType, float vFltBeishu, float vFltMoniMax, float vFltMoniMin, float vFltSjMax, float vFltSjMin,
        //    string vStrDanwei, int vIntGongType, int vIntNY, int vIntPLCXitong, string vStrDataType, int vIntZongGZ, string vStrSheBei1, string vStrSheBei2, string vStrNeiBuBL1, string vStrNeiBuBL2, int vIntIOType, int vIntPLCID,
        //    int vIntGzorQd, int vIntSjXitong, int vIntXS, int vIntjsl,out string msg)
        //{
        //    bool isSuccess = false;
        //    msg = "失败";
        //    if (GJHF.Data.MSSQL.PLC.DPlcDdz.EditData(viIntDataID, vStrAdressName, vStrAddress, vStrAllAdress, vStrDescription, vIntDataType, vFltBeishu, vFltMoniMax, vFltMoniMin, vFltSjMax, vFltSjMin,
        //         vStrDanwei, vIntGongType, vIntNY, vIntPLCXitong, vStrDataType, vIntZongGZ, vStrSheBei1, vStrSheBei2, vStrNeiBuBL1, vStrNeiBuBL2, vIntIOType, vIntPLCID,
        //         vIntGzorQd, vIntSjXitong, vIntXS, vIntjsl) >= 0)
        //    {
        //        isSuccess = true;
        //        msg = "成功";
        //    }
        //    return isSuccess;
        //}

        //以前的不能用，我改了
        public static bool EditData(int viIntDataID, string vStrAdressName, string vStrAddress, string vStrAllAdress, string vStrDescription, int vIntDataType, float vFltBeishu, float vFltMoniMax, float vFltMoniMin, float vFltSjMax, float vFltSjMin,
            string vStrDanwei, int vIntGongType, int vIntNY, int vIntPLCXitong, string vStrDataType, int vIntZongGZ, string vStrSheBei1, string vStrSheBei2, string vStrNeiBuBL1, string vStrNeiBuBL2, int vIntIOType, int vIntPLCID,
            int vIntGzorQd, string vStrSjXitong,char vChrPhoneIDSeparator, int vIntXS, int vIntjsl, out string msg)
        {
            GJHF.Business.PLC.BPLCPointPhoneType bBPLCPointPhoneType = new BPLCPointPhoneType();
            bool isSuccess = false;
            msg = "失败";
            int mIntEditReturn=GJHF.Data.MSSQL.PLC.DPlcDdz.EditData(viIntDataID, vStrAdressName, vStrAddress, vStrAllAdress, vStrDescription, vIntDataType, vFltBeishu, vFltMoniMax, vFltMoniMin, vFltSjMax, vFltSjMin,
                 vStrDanwei, vIntGongType, vIntNY, vIntPLCXitong, vStrDataType, vIntZongGZ, vStrSheBei1, vStrSheBei2, vStrNeiBuBL1, vStrNeiBuBL2, vIntIOType, vIntPLCID,
                 vIntGzorQd, 0, vIntXS, vIntjsl);
            if (mIntEditReturn >= 0)
            {
                int mIntPLCPointAddressID = viIntDataID;
                int mIntBindReturn = bBPLCPointPhoneType.SavePLCPointPhoneType(mIntPLCPointAddressID, vStrSjXitong, vChrPhoneIDSeparator);
                if (mIntBindReturn == 1)
                {
                    isSuccess = true;
                    msg = "成功";
                }
            }
            return isSuccess;
        }

        public static bool DelData(int viIntDataID,out string msg)
        {
            bool isSuccess = false;
            msg = "失败";
            try
            {
                GJHF.Business.PLC.BPLCPointPhoneType bBPLCPointPhoneType = new BPLCPointPhoneType();
                if (GJHF.Data.MSSQL.PLC.DPlcDdz.DelData(viIntDataID) >= 0)
                {
                    //删除点地址与系统关系
                    if (bBPLCPointPhoneType.DelPLCPointPhoneType(viIntDataID, out msg) == true)
                    {
                        isSuccess = true;
                        msg = "成功";
                    }
                }
                return isSuccess;
            }
            catch (Exception eee)
            {
                isSuccess = false;
                msg = eee.ToString();
                return isSuccess;
            }
        }

        public static  string GetStrResult(string vStrDdz)
        {
            return GJHF.Data.MSSQL.PLC.DPlcDdz.GetStrResult(vStrDdz);
        }

        public static DataTable GetOneData(int vIntDataID)
        {
            return GJHF.Data.MSSQL.PLC.DPlcDdz.GetOneData(vIntDataID);
        }
    }
}
