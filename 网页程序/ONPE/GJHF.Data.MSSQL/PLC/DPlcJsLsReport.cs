using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using System.Data.SqlClient;

namespace GJHF.Data.MSSQL.PLC
{
    public class DPlcJsLsReport
    {
        public static DataTable GetData(int rows, int pages, string vStrWhere)
        {
            DataTable dt = null;
            string mStrSQL = @"select * from tPlcHistoryReportRequestJs " + vStrWhere;
            dt = claSqlConnDB.ExecuteDataset(rows, pages, claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL).Tables[0];
            return dt;
        }
        public static int AddData(string vStrName, int vIntHistoryReport_A, string vStrHistoryReport_A, string vStrHistoryReport_A_Value, int vIntHistoryReport_B, string vStrHistoryReport_B, string vStrHistoryReport_B_Value, int vIntHistoryReport_C, string vStrHistoryReport_C, string vStrHistoryReport_C_Value, string vStrFormula, string vStrValue, string vStrUser, int vIntRead)
        {
            int voIntReturn = -1;

            SqlParameter[] myParameter = new SqlParameter[15]
            {
                new SqlParameter("@viVchName",SqlDbType.VarChar,30),
                new SqlParameter("@viIntHistoryReport_A",SqlDbType.Int,4),
                new SqlParameter("@viVchHistoryReport_A",SqlDbType.VarChar,10),
                new SqlParameter("@viVchHistoryReport_A_Value",SqlDbType.VarChar,20),
                new SqlParameter("@viIntHistoryReport_B",SqlDbType.Int,4),
                new SqlParameter("@viVchHistoryReport_B",SqlDbType.VarChar,10),
                new SqlParameter("@viVchHistoryReport_B_Value",SqlDbType.VarChar,20),
                 new SqlParameter("@viIntHistoryReport_C",SqlDbType.Int,4),
                new SqlParameter("@viVchHistoryReport_C",SqlDbType.VarChar,10),
                new SqlParameter("@viVchHistoryReport_C_Value",SqlDbType.VarChar,20),
                new SqlParameter("@viVchFormula",SqlDbType.VarChar,50),
                new SqlParameter("@viVchValue",SqlDbType.VarChar,20),
                new SqlParameter("@viVchUser",SqlDbType.VarChar,30),
                new SqlParameter("@viIntRead",SqlDbType.Int,4),
                new SqlParameter("@voIntReturn",SqlDbType.Int,4)
            };
            myParameter[0].Value = vStrName;
            myParameter[1].Value = vIntHistoryReport_A;
            myParameter[2].Value = vStrHistoryReport_A;
            myParameter[3].Value = vStrHistoryReport_A_Value;
            myParameter[4].Value = vIntHistoryReport_B;
            myParameter[5].Value = vStrHistoryReport_B;
            myParameter[6].Value = vStrHistoryReport_B_Value;
            myParameter[7].Value = vIntHistoryReport_C;
            myParameter[8].Value = vStrHistoryReport_C;
            myParameter[9].Value = vStrHistoryReport_C_Value;
            myParameter[10].Value = vStrFormula;
            myParameter[11].Value = vStrValue;
            myParameter[12].Value = vStrUser;
            myParameter[13].Value = vIntRead;
            myParameter[14].Direction = System.Data.ParameterDirection.Output;
            claSqlConnDB.ExecuteNonQuery(claSqlConnDB.gStrConnDefault, CommandType.StoredProcedure, "pPlcHistoryReportRequestJsAdd", myParameter);
            voIntReturn = (int)myParameter[14].Value;
            return voIntReturn;
        }

        public static int EditData(int vIntDataID,string vStrName, int vIntHistoryReport_A, string vStrHistoryReport_A, string vStrHistoryReport_A_Value, int vIntHistoryReport_B, string vStrHistoryReport_B, string vStrHistoryReport_B_Value, int vIntHistoryReport_C, string vStrHistoryReport_C, string vStrHistoryReport_C_Value, string vStrFormula, string vStrValue, string vStrUser, int vIntRead)
        {
            int voIntReturn = -1;
            SqlParameter[] myParameter = new SqlParameter[16]
            {
                new SqlParameter("@viIntDataID",SqlDbType.Int,4),
                new SqlParameter("@viVchName",SqlDbType.VarChar,30),
               new SqlParameter("@viIntHistoryReport_A",SqlDbType.Int,4),
                new SqlParameter("@viVchHistoryReport_A",SqlDbType.VarChar,10),
                new SqlParameter("@viVchHistoryReport_A_Value",SqlDbType.VarChar,20),
                new SqlParameter("@viIntHistoryReport_B",SqlDbType.Int,4),
                new SqlParameter("@viVchHistoryReport_B",SqlDbType.VarChar,10),
                new SqlParameter("@viVchHistoryReport_B_Value",SqlDbType.VarChar,20),
                 new SqlParameter("@viIntHistoryReport_C",SqlDbType.Int,4),
                new SqlParameter("@viVchHistoryReport_C",SqlDbType.VarChar,10),
                new SqlParameter("@viVchHistoryReport_C_Value",SqlDbType.VarChar,20),
                new SqlParameter("@viVchFormula",SqlDbType.VarChar,50),
                new SqlParameter("@viVchValue",SqlDbType.VarChar,20),
                new SqlParameter("@viVchUser",SqlDbType.VarChar,30),
                new SqlParameter("@viIntRead",SqlDbType.Int,4),
                new SqlParameter("@voIntReturn",SqlDbType.Int,4)
            };
            myParameter[0].Value = vIntDataID;
            myParameter[1].Value = vStrName;
            myParameter[2].Value = vIntHistoryReport_A;
            myParameter[3].Value = vStrHistoryReport_A;
            myParameter[4].Value = vStrHistoryReport_A_Value;
            myParameter[5].Value = vIntHistoryReport_B;
            myParameter[6].Value = vStrHistoryReport_B;
            myParameter[7].Value = vStrHistoryReport_B_Value;
            myParameter[8].Value = vIntHistoryReport_C;
            myParameter[9].Value = vStrHistoryReport_C;
            myParameter[10].Value = vStrHistoryReport_C_Value;
            myParameter[11].Value = vStrFormula;
            myParameter[12].Value = vStrValue;
            myParameter[13].Value = vStrUser;
            myParameter[14].Value = vIntRead;
            myParameter[15].Direction = System.Data.ParameterDirection.Output;
            claSqlConnDB.ExecuteNonQuery(claSqlConnDB.gStrConnDefault, CommandType.StoredProcedure, "pPlcHistoryReportRequestJsEdit", myParameter);
            voIntReturn = (int)myParameter[15].Value;
            return voIntReturn;
        }

        public static int DelData(int vIntDataID)
        {
            int voIntReturn = -1;
            SqlParameter[] myParameter = new SqlParameter[2]
            {
                new SqlParameter("@viIntDataID",SqlDbType.Int,4),
                new SqlParameter("@voIntReturn",SqlDbType.Int,4)
            };
            myParameter[0].Value = vIntDataID;
            myParameter[1].Direction = System.Data.ParameterDirection.Output;
            claSqlConnDB.ExecuteNonQuery(claSqlConnDB.gStrConnDefault, CommandType.StoredProcedure, "pPlcHistoryReportRequestJsDel", myParameter);
            voIntReturn = (int)myParameter[1].Value;
            return voIntReturn;
        }

        public static DataTable GetCombogrid(string vStrWhere)
        {
            DataTable dt = null;
            string mStrSQL = @"select * from tPlcHistoryReportRequest " + vStrWhere;
            dt = claSqlConnDB.ExecuteDataset(claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL).Tables[0];
            return dt;
        }


        //public static int ChangeReadBiaoshi(int vIntState)
        //{
        //    string mStrSQL = "update tZPlcLsReportBiaoshi set  dIntLsReportTotalBz =" + vIntState;
        //    int mIntResult = claSqlConnDB.ExecuteNonQuery(claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL);
        //    return mIntResult;
        //}
    }
}
