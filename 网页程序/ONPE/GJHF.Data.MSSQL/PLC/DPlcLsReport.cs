using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using System.Data.SqlClient;

namespace GJHF.Data.MSSQL.PLC
{
    public class DPlcLsReport
    {
        public static DataTable GetData(int rows, int pages, string vStrWhere)
        {
            DataTable dt = null;
            string mStrSQL = @"select * from tPlcHistoryReportRequest " + vStrWhere;
            dt = claSqlConnDB.ExecuteDataset(rows, pages, claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL).Tables[0];
            return dt;
        }
        public static int AddData(string vDeaStartTime, string vDeaEndTime, string vStrName, int vIntCjdzId, string vStrAddress, string vStrCjdz, int vIntalgorithm, string vStrValue, string vStrUser, int vIntRead)
        {
            int voIntReturn = -1;

            SqlParameter[] myParameter = new SqlParameter[11]
            {
                new SqlParameter("@viVchStartTime",SqlDbType.VarChar,100),
                new SqlParameter("@viVchEndTime",SqlDbType.VarChar,100),
                new SqlParameter("@viVchName",SqlDbType.VarChar,100),
                new SqlParameter("@viIntCjdzId",SqlDbType.Int,4),
                new SqlParameter("@viVchAddress",SqlDbType.VarChar,50),
                new SqlParameter("@viVchCjdz",SqlDbType.VarChar,100),
                new SqlParameter("@viIntalgorithm",SqlDbType.Int,4),
                new SqlParameter("@viVchValue",SqlDbType.VarChar,30),
                new SqlParameter("@viVchUser",SqlDbType.VarChar,30),
                new SqlParameter("@viIntRead",SqlDbType.Int,4),
                new SqlParameter("@voIntReturn",SqlDbType.Int,4)
            };
            myParameter[0].Value = vDeaStartTime;
            myParameter[1].Value = vDeaEndTime;
            myParameter[2].Value = vStrName;
            myParameter[3].Value = vIntCjdzId;
            myParameter[4].Value = vStrAddress;
            myParameter[5].Value = vStrCjdz;
            myParameter[6].Value = vIntalgorithm;
            myParameter[7].Value = vStrValue;
            myParameter[8].Value = vStrUser;
            myParameter[9].Value = vIntRead;
            myParameter[10].Direction = System.Data.ParameterDirection.Output;
            claSqlConnDB.ExecuteNonQuery(claSqlConnDB.gStrConnDefault, CommandType.StoredProcedure, "pPlcHistoryReportRequestAdd", myParameter);
            voIntReturn = (int)myParameter[10].Value;
            return voIntReturn;
        }

        public static int EditData(int vIntHistoryReportRequestId, string vDeaStartTime, string vDeaEndTime, string vStrName, int vIntCjdzId, string vStrAddress, string vStrCjdz, int vIntalgorithm, string vStrValue, string vStrUser, int vIntRead)
        {
            int voIntReturn = -1;
            SqlParameter[] myParameter = new SqlParameter[12]
            {
                new SqlParameter("@viIntHistoryReportRequestId",SqlDbType.Int,4),
                new SqlParameter("@viVchStartTime",SqlDbType.VarChar,100),
                new SqlParameter("@viVchEndTime",SqlDbType.VarChar,100),
                new SqlParameter("@viVchName",SqlDbType.VarChar,100),
                new SqlParameter("@viIntCjdzId",SqlDbType.Int,4),
                new SqlParameter("@viVchAddress",SqlDbType.VarChar,50),
                new SqlParameter("@viVchCjdz",SqlDbType.VarChar,100),
                new SqlParameter("@viIntalgorithm",SqlDbType.Int,4),
                 new SqlParameter("@viVchValue",SqlDbType.VarChar,30),
                new SqlParameter("@viVchUser",SqlDbType.VarChar,30),
                new SqlParameter("@viIntRead",SqlDbType.Int,4),
                new SqlParameter("@voIntReturn",SqlDbType.Int,4)
            };
            myParameter[0].Value = vIntHistoryReportRequestId;
            myParameter[1].Value = vDeaStartTime;
            myParameter[2].Value = vDeaEndTime;
            myParameter[3].Value = vStrName;
            myParameter[4].Value = vIntCjdzId;
            myParameter[5].Value = vStrAddress;
            myParameter[6].Value = vStrCjdz;
            myParameter[7].Value = vIntalgorithm;
            myParameter[8].Value = vStrValue;
            myParameter[9].Value = vStrUser;
            myParameter[10].Value = vIntRead;
            myParameter[11].Direction = System.Data.ParameterDirection.Output;
            claSqlConnDB.ExecuteNonQuery(claSqlConnDB.gStrConnDefault, CommandType.StoredProcedure, "pPlcHistoryReportRequestEdit", myParameter);
            voIntReturn = (int)myParameter[11].Value;
            return voIntReturn;
        }

        public static int DelData(int vIntHistoryReportRequestId)
        {
            int voIntReturn = -1;
            SqlParameter[] myParameter = new SqlParameter[2]
            {
                new SqlParameter("@viIntHistoryReportRequestId",SqlDbType.Int,4),
                new SqlParameter("@voIntReturn",SqlDbType.Int,4)
            };
            myParameter[0].Value = vIntHistoryReportRequestId;
            myParameter[1].Direction = System.Data.ParameterDirection.Output;
            claSqlConnDB.ExecuteNonQuery(claSqlConnDB.gStrConnDefault, CommandType.StoredProcedure, "pPlcHistoryReportRequestDel", myParameter);
            voIntReturn = (int)myParameter[1].Value;
            return voIntReturn;
        }

        public static DataTable GetCombogrid(string vStrWhere)
        {
            DataTable dt = null;
            string mStrSQL = @"select * from tZPlcHistoryDataSet_Cloud " + vStrWhere;
            dt = claSqlConnDB.ExecuteDataset(claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL).Tables[0];
            return dt;
        }
        public static int ChangeReadBiaoshi(int vIntState)
        {
            string mStrSQL = "update tZPlcLsReportBiaoshi set  dIntLsReportTotalBz =" + vIntState;
            int mIntResult = claSqlConnDB.ExecuteNonQuery(claSqlConnDB.gStrConnDefault,CommandType.Text,mStrSQL);
            return mIntResult;
        }
    }
}
