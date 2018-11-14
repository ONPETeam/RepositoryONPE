using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using System.Data.SqlClient;

namespace GJHF.Data.MSSQL.PLC
{
    public class DPlcDdz
    {
        //显示数据列表
        public static DataTable GetData(int rows, int pages, string vStrWhere)
        {
            DataTable dt = null;
            string mStrSQL = @"select tZPlcPointDiZhi.dIntDataID, tZPlcPointDiZhi.dVchAdressName, tZPlcPointDiZhi.dVchAddress, tZPlcPointDiZhi.dVchAllAdress, dVchDescription, tZPlcPointDiZhi.dIntDataType, dFltBeishu,
                                            dVchDanwei, tZPlcPointDiZhi.dIntGongType, tZPlcPointDiZhi.dIntPLCXitong, dVchDataType, tZPLCIOType.dIntIOType, 
                                            tZPlcPointDiZhi.dIntPLCID,tZPLCIOType.dVchIOTypeName,tZPLCManager.dVchPLCName + '-' + tZPLCManager.dVchIPAdress as plcqm ,dIntPointType,dIntShouJiPx,
                                            tZPLCVariableType.dVchVariableName,dVchSbBianHao,dfltMax,dfltMin,dVchKgAlermValue,tZSbBaojingFanwei.dVchRemark,tZSbBaojingFanwei.dIntAdressTypeID,dIntJsBz, 
                                            tZPlcHistoryJK.dIntHsBz,tZPlcHistoryJK.dIntBjBz,tZPlcHistoryJK.dIntDxjBz,tZPlcHistoryJK.dIntTsdBz,dIntIsCollect,dIntCollectSec,dIntCollectType from tZPlcPointDiZhi 
                                            left outer join tZPLCIOType on tZPlcPointDiZhi.dIntIOType = tZPLCIOType.dIntIOType
                                            left outer join tZPLCManager on tZPlcPointDiZhi.dIntPLCID = tZPLCManager.dIntPLCID
                                            left outer join tZSbAndPLC on tZPlcPointDiZhi.dIntDataID = tZSbAndPLC.dVchPLCAddress 
                                            left outer join tZPLCVariableType on tZPlcPointDiZhi.dVchDataType = tZPLCVariableType.dVchVariableCode 
                                            left outer join tZSbBaojingFanwei on tZPlcPointDiZhi.dVchAllAdress = tZSbBaojingFanwei.dVchAllAdress 
                                            left outer join tZPlcHistoryJK on tZPlcPointDiZhi.dVchAllAdress = tZPlcHistoryJK.dVchCjdz 
                                            left outer join tZPlcPointTypeOne on tZPlcPointDiZhi.dIntDataID = tZPlcPointTypeOne.dIntDataID  
                                            left outer join tZPlcHistoryDataSet_Cloud on  tZPlcPointDiZhi.dIntDataID = tZPlcHistoryDataSet_Cloud.dIntCollectIndex  " + vStrWhere;
                                            
            dt = claSqlConnDB.ExecuteDataset(rows, pages, claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL).Tables[0];
            return dt;
        }
        
        //public static DataTable GetData(int rows, int pages, string vStrWhere)
//        {
//            DataTable dt = null;
//            string mStrSQL = @"select tZPlcPointDiZhi.dIntDataID, tZPlcPointDiZhi.dVchAdressName, tZPlcPointDiZhi.dVchAddress, tZPlcPointDiZhi.dVchAllAdress, dVchDescription, dIntDataType, dFltBeishu, dFltMoniMax, dFltMoniMin, tZPlcPointDiZhi.dFltSjMax, tZPlcPointDiZhi.dFltSjMin, 
//                                            dVchDanwei, tZPlcPointDiZhi.dIntGongType, dIntNengYuanType, tZPlcPointDiZhi.dIntPLCXitong, dVchDataType, dIntZongGZ, dVchSheBei1, dVchSheBei2, dVchNeiBuBL1, dVchNeiBuBL2, tZPLCIOType.dIntIOType, 
//                                            tZPlcPointDiZhi.dIntPLCID,tZPLCIOType.dVchIOTypeName,tZPLCManager.dVchPLCName + '-' + tZPLCManager.dVchIPAdress as plcqm ,dIntGzOrQd,dVchDataValue,dIntBaojingType,dIntPointType,dIntShouJiPx,
//                                            t_XJPointType.dVchPointType,t_XJPointType.dVchRemark,tZPLCVariableType.dVchVariableName,dVchSbBianHao,dfltMax,dfltMin,dVchKgAlermValue,tZSbBaojingFanwei.dVchRemark,tZSbBaojingFanwei.dIntAdressTypeID,dIntJsBz, 
//                                            tZPlcHistoryJK.dIntHsBz,tZPlcHistoryJK.dIntBjBz,tZPlcHistoryJK.dIntDxjBz,tZPlcHistoryJK.dIntTsdBz   from tZPlcPointDiZhi 
//                                            left outer join tZPLCIOType on tZPlcPointDiZhi.dIntIOType = tZPLCIOType.dIntIOType
//                                            left outer join tZPLCManager on tZPlcPointDiZhi.dIntPLCID = tZPLCManager.dIntPLCID
//                                            left outer join tZSbAndPLC on tZPlcPointDiZhi.dIntDataID = tZSbAndPLC.dVchPLCAddress 
//                                            left outer join tZPLCNowData on tZPlcPointDiZhi.dIntDataID = tZPLCNowData.dIntdizhiID
//                                            left outer join t_XJPointType on tZPlcPointDiZhi.dIntPointType = t_XJPointType.dIntNoteID 
//                                            left outer join tZPLCVariableType on tZPlcPointDiZhi.dVchDataType = tZPLCVariableType.dVchVariableCode 
//                                            left outer join tZSbBaojingFanwei on tZPlcPointDiZhi.dVchAllAdress = tZSbBaojingFanwei.dVchAllAdress 
//                                            left outer join tZPlcHistoryJK on tZPlcPointDiZhi.dVchAllAdress = tZPlcHistoryJK.dVchCjdz " + vStrWhere;
//            dt = claSqlConnDB.ExecuteDataset(rows, pages, claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL).Tables[0];
//            return dt;
//        }

        //数据条数
        public static int GetRecordCount(string vStrWhere)
        {
            int count = 0;
            string mStrSQL = @"SELECT  count(*)  FROM tZPlcPointDiZhi left outer join tZPLCIOType on tZPlcPointDiZhi.dIntIOType = tZPLCIOType.dIntIOType
                                            left outer join tZPLCManager on tZPlcPointDiZhi.dIntPLCID = tZPLCManager.dIntPLCID
                                            left outer join tZSbAndPLC on tZPlcPointDiZhi.dIntDataID = tZSbAndPLC.dVchPLCAddress 
                                            left outer join tZPLCNowData on tZPlcPointDiZhi.dIntDataID = tZPLCNowData.dIntdizhiID
                                            left outer join t_XJPointType on tZPlcPointDiZhi.dIntPointType = t_XJPointType.dIntNoteID 
                                            left outer join tZPLCVariableType on tZPlcPointDiZhi.dVchDataType = tZPLCVariableType.dVchVariableCode 
                                            left outer join tZSbBaojingFanwei on tZPlcPointDiZhi.dVchAllAdress = tZSbBaojingFanwei.dVchAllAdress 
                                            left outer join tZPlcHistoryJK on tZPlcPointDiZhi.dVchAllAdress = tZPlcHistoryJK.dVchCjdz 
                                            left outer join tZPlcHistoryDataSet_Cloud on  tZPlcPointDiZhi.dIntDataID = tZPlcHistoryDataSet_Cloud.dIntCollectIndex " + vStrWhere;
            count = claSqlConnDB.GetRecordCount(claSqlConnDB.gStrConnDefault, mStrSQL);
            return count;
        }
        //下拉框显示
        //public static DataTable GetComboData(string vStrWhere)
        //{
        //    DataTable dt = null;
        //    string mStrSQL = @"select dIntGzID,dVchGzName from tZPLCGzCL " + vStrWhere;
        //    dt = claSqlConnDB.ExecuteDataset(claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL).Tables[0];
        //    return dt;
        //}

        public static int AddData(string vStrAdressName, string vStrAddress, string vStrAllAdress, string vStrDescription, int vIntDataType, float vFltBeishu, float vFltMoniMax, float vFltMoniMin, float vFltSjMax, float vFltSjMin,
            string vStrDanwei, int vIntGongType, int vIntNY, int vIntPLCXitong, string vStrDataType, int vIntZongGZ, string vStrSheBei1, string vStrSheBei2, string vStrNeiBuBL1, string vStrNeiBuBL2, int vIntIOType, int vIntPLCID,
            int vIntGzorQd, int vIntSjXitong, int vIntXS, int vIntjsl,out int voIntdizhi)
        {
            int voIntReturn = -1;

            SqlParameter[] l0lcParameter = new SqlParameter[28]
            {
                new SqlParameter("@viVchAdressName",SqlDbType.VarChar,30),
                new SqlParameter("@viVchAddress",SqlDbType.VarChar,30),
                new SqlParameter("@viVchAllAdress",SqlDbType.VarChar,100),
                new SqlParameter("@viVchDescription",SqlDbType.VarChar,50),
                new SqlParameter("@viIntDataType",SqlDbType.Int,4),
                new SqlParameter("@viFltBeishu",SqlDbType.Float,8),
                new SqlParameter("@viFltMoniMax",SqlDbType.Float,8),
                new SqlParameter("@viFltMoniMin",SqlDbType.Float,8),
                new SqlParameter("@viFltSjMax",SqlDbType.Float,8),
                new SqlParameter("@viFltSjMin",SqlDbType.Float,8),
                new SqlParameter("@viVchDanwei",SqlDbType.VarChar,30),
                new SqlParameter("@viIntGongType",SqlDbType.Int,4),
                new SqlParameter("@viIntNengYuanType",SqlDbType.Int,4),
                new SqlParameter("@viIntPLCXitong",SqlDbType.Int,4),
                new SqlParameter("@viVchDataType",SqlDbType.VarChar,30),
                new SqlParameter("@viIntZongGZ",SqlDbType.Int,4), 
                new SqlParameter("@viVchSheBei1",SqlDbType.VarChar,30),
                new SqlParameter("@viVchSheBei2",SqlDbType.VarChar,30),
                new SqlParameter("@viVchNeiBuBL1",SqlDbType.VarChar,30),
                new SqlParameter("@viVchNeiBuBL2",SqlDbType.VarChar,30),
                new SqlParameter("@viIntIOType",SqlDbType.Int,4),
                new SqlParameter("@viIntPLCID",SqlDbType.Int,4),
                new SqlParameter("@viIntGzOrQd",SqlDbType.Int,4),
                new SqlParameter("@viIntPointType",SqlDbType.Int,4),
                new SqlParameter("@viIntShouJiPx",SqlDbType.Int,4),
                new SqlParameter("@viIntJsBz",SqlDbType.Int,4),
                new SqlParameter("@voIntReturns",SqlDbType.Int,4),
                new SqlParameter("@voIntdizhiID",SqlDbType.Int,4)

            };
            //默认值为0
            vIntDataType = 0;
            l0lcParameter[0].Value = vStrAdressName;
            l0lcParameter[1].Value = vStrAddress;
            l0lcParameter[2].Value = vStrAllAdress;
            l0lcParameter[3].Value = vStrDescription;
            l0lcParameter[4].Value = vIntDataType;
            l0lcParameter[5].Value = vFltBeishu;
            l0lcParameter[6].Value = vFltMoniMax;
            l0lcParameter[7].Value = vFltMoniMin;
            l0lcParameter[8].Value = vFltSjMax;
            l0lcParameter[9].Value = vFltSjMin;
            l0lcParameter[10].Value = vStrDanwei;
            l0lcParameter[11].Value = vIntGongType;
            l0lcParameter[12].Value = vIntNY;
            l0lcParameter[13].Value = vIntPLCXitong;
            l0lcParameter[14].Value = vStrDataType;
            l0lcParameter[15].Value = vIntZongGZ;
            l0lcParameter[16].Value = vStrSheBei1;
            l0lcParameter[17].Value = vStrSheBei2;
            l0lcParameter[18].Value = vStrNeiBuBL1;
            l0lcParameter[19].Value = vStrNeiBuBL2;
            l0lcParameter[20].Value = vIntIOType;
            l0lcParameter[21].Value = vIntPLCID;
            l0lcParameter[22].Value = vIntGzorQd;
            l0lcParameter[23].Value = vIntSjXitong;
            l0lcParameter[24].Value = vIntXS;
            l0lcParameter[25].Value = vIntjsl;
            l0lcParameter[26].Direction = System.Data.ParameterDirection.Output;
            l0lcParameter[27].Direction = System.Data.ParameterDirection.Output;
            claSqlConnDB.ExecuteNonQuery(claSqlConnDB.gStrConnDefault, CommandType.StoredProcedure, "pZPlcPointDiZhiAdd", l0lcParameter);
            voIntReturn = (int)l0lcParameter[26].Value;
            voIntdizhi = (int)l0lcParameter[27].Value;
            return voIntReturn;
        }

        public static int EditData(int viIntDataID,string vStrAdressName, string vStrAddress, string vStrAllAdress, string vStrDescription, int vIntDataType, float vFltBeishu, float vFltMoniMax, float vFltMoniMin, float vFltSjMax, float vFltSjMin,
            string vStrDanwei, int vIntGongType, int vIntNY, int vIntPLCXitong, string vStrDataType, int vIntZongGZ, string vStrSheBei1, string vStrSheBei2, string vStrNeiBuBL1, string vStrNeiBuBL2, int vIntIOType, int vIntPLCID,
            int vIntGzorQd, int vIntSjXitong, int vIntXS, int vIntjsl)
        {
            int voIntReturn = -1;
            SqlParameter[] l0lcParameter = new SqlParameter[28]
            {
                new SqlParameter("@viIntDataID",SqlDbType.Int,4),
                new SqlParameter("@viVchAdressName",SqlDbType.VarChar,30),
                new SqlParameter("@viVchAddress",SqlDbType.VarChar,30),
                new SqlParameter("@viVchAllAdress",SqlDbType.VarChar,100),
                new SqlParameter("@viVchDescription",SqlDbType.VarChar,50),
                new SqlParameter("@viIntDataType",SqlDbType.Int,4),
                new SqlParameter("@viFltBeishu",SqlDbType.Float,8),
                new SqlParameter("@viFltMoniMax",SqlDbType.Float,8),
                new SqlParameter("@viFltMoniMin",SqlDbType.Float,8),
                new SqlParameter("@viFltSjMax",SqlDbType.Float,8),
                new SqlParameter("@viFltSjMin",SqlDbType.Float,8),
                new SqlParameter("@viVchDanwei",SqlDbType.VarChar,30),
                new SqlParameter("@viIntGongType",SqlDbType.Int,4),
                new SqlParameter("@viIntNengYuanType",SqlDbType.Int,4),
                new SqlParameter("@viIntPLCXitong",SqlDbType.Int,4),
                new SqlParameter("@viVchDataType",SqlDbType.VarChar,30),
                new SqlParameter("@viIntZongGZ",SqlDbType.Int,4), 
                new SqlParameter("@viVchSheBei1",SqlDbType.VarChar,30),
                new SqlParameter("@viVchSheBei2",SqlDbType.VarChar,30),
                new SqlParameter("@viVchNeiBuBL1",SqlDbType.VarChar,30),
                new SqlParameter("@viVchNeiBuBL2",SqlDbType.VarChar,30),
                new SqlParameter("@viIntIOType",SqlDbType.Int,4),
                new SqlParameter("@viIntPLCID",SqlDbType.Int,4),
                new SqlParameter("@viIntGzOrQd",SqlDbType.Int,4),
                new SqlParameter("@viIntPointType",SqlDbType.Int,4),
                new SqlParameter("@viIntShouJiPx",SqlDbType.Int,4),
                new SqlParameter("@viIntJsBz",SqlDbType.Int,4),
                new SqlParameter("@voIntReturns",SqlDbType.Int,4),
            };
            l0lcParameter[0].Value = viIntDataID;
            l0lcParameter[1].Value = vStrAdressName;
            l0lcParameter[2].Value = vStrAddress;
            l0lcParameter[3].Value = vStrAllAdress;
            l0lcParameter[4].Value = vStrDescription;
            l0lcParameter[5].Value = vIntDataType;
            l0lcParameter[6].Value = vFltBeishu;
            l0lcParameter[7].Value = vFltMoniMax;
            l0lcParameter[8].Value = vFltMoniMin;
            l0lcParameter[9].Value = vFltSjMax;
            l0lcParameter[10].Value = vFltSjMin;
            l0lcParameter[11].Value = vStrDanwei;
            l0lcParameter[12].Value = vIntGongType;
            l0lcParameter[13].Value = vIntNY;
            l0lcParameter[14].Value = vIntPLCXitong;
            l0lcParameter[15].Value = vStrDataType;
            l0lcParameter[16].Value = vIntZongGZ;
            l0lcParameter[17].Value = vStrSheBei1;
            l0lcParameter[18].Value = vStrSheBei2;
            l0lcParameter[19].Value = vStrNeiBuBL1;
            l0lcParameter[20].Value = vStrNeiBuBL2;
            l0lcParameter[21].Value = vIntIOType;
            l0lcParameter[22].Value = vIntPLCID;
            l0lcParameter[23].Value = vIntGzorQd;
            l0lcParameter[24].Value = vIntSjXitong;
            l0lcParameter[25].Value = vIntXS;
            l0lcParameter[26].Value = vIntjsl;
            l0lcParameter[27].Direction = System.Data.ParameterDirection.Output;
            claSqlConnDB.ExecuteNonQuery(claSqlConnDB.gStrConnDefault, CommandType.StoredProcedure, "pZPlcPointDiZhiEdit", l0lcParameter);
            voIntReturn = (int)l0lcParameter[27].Value;
            return voIntReturn;
        }

        public static int DelData(int viIntDataID)
        {
            int voIntReturn = -1;
            SqlParameter[] l0lcParameter = new SqlParameter[2]
            {
                new SqlParameter("@viIntDataID",SqlDbType.Int,4),
                new SqlParameter("@voIntReturn",SqlDbType.Int,4)
            };
            l0lcParameter[0].Value = viIntDataID;
            l0lcParameter[1].Direction = System.Data.ParameterDirection.Output;
            claSqlConnDB.ExecuteNonQuery(claSqlConnDB.gStrConnDefault, CommandType.StoredProcedure, "pZPlcPointDiZhiDel", l0lcParameter);
            voIntReturn = (int)l0lcParameter[1].Value;
            return voIntReturn;
        }

        public static string GetStrResult(string vStrDdz)
        {
            string mStrResult = "";
            string mStrFactory = "";
            string mStrPlc = "";
            string mStrAddress = "";
            string mStrCaiji = "";
            string mStrBdMax = "";
            string mStrBdMin = "";
            string mStrSjMax = "";
            string mStrSjMin = "";
            string mStrFwq = "";
            string mStrSQL = @"SELECT  top 1  dIntDataID, tZPLCManager.dVchFactoryCode,tZPLCManager.dVchPLCbianma, dVchAddress, dVchAllAdress,dFltMoniMax,dFltMoniMin,dFltSjMax, dFltSjMin,tZPLCManager.dVchfwqdh
                            FROM tZPlcPointDiZhi left outer join tZPLCManager on  tZPlcPointDiZhi.dIntPLCID = tZPLCManager.dIntPLCID where dIntDataID = " + vStrDdz;

            DataTable dt = claSqlConnDB.ExecuteDataset(claSqlConnDB.gStrConnDefault,CommandType.Text,mStrSQL).Tables[0];
            if (dt.Rows.Count > 0)
            {
                mStrFactory = dt.Rows[0][1].ToString();
                mStrPlc = dt.Rows[0][2].ToString();
                mStrAddress = dt.Rows[0][3].ToString();
                mStrCaiji = dt.Rows[0][4].ToString();
                mStrSjMax = dt.Rows[0][5].ToString();
                mStrSjMin = dt.Rows[0][6].ToString();
                mStrBdMax = dt.Rows[0][7].ToString();
                mStrBdMin = dt.Rows[0][8].ToString();
                mStrFwq = dt.Rows[0][9].ToString();
            }
            mStrResult = mStrFactory + "," + mStrPlc + "," + mStrAddress + "," + mStrCaiji + "," + mStrSjMax + "," + mStrSjMin + "," + mStrBdMax + "," + mStrBdMin + "," + mStrFwq;
            return mStrResult;
        }

        public static DataTable GetOneData(int vIntDataID)
        {
            string mStrSQL = @"SELECT   TOP (1) dVchFactoryCode,dVchPLCbianma,dVchAddress, dVchAllAdress, dVchDanwei,dFltMoniMax, dFltMoniMin, dFltSjMax, dFltSjMin,
                            dVchFwqdh,dVchDescription,dIntDataID,dVchSbBianHao,dVchDataType
                            FROM      tZPlcPointDiZhi 
                            left outer join tZPLCManager on tZPlcPointDiZhi.dIntPLCID = tZPLCManager.dIntPLCID
                            left outer join tZSbAndPLC on tZPlcPointDiZhi.dIntDataID = tZSbAndPLC.dVchPLCAddress
                            where dIntDataID = " + vIntDataID;
            DataTable dt = claSqlConnDB.ExecuteDataset(claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL).Tables[0];
            return dt;
        }
        
    }
}
