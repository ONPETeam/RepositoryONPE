using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using System.Data.SqlClient;

namespace GJHF.Data.MSSQL.PLC
{
    public class DPlcHistoryData
    {
        public static DataTable GetData(int rows,int pages,string vStrWhere)
        {
            DataTable dt = null;
            string mStrSQL = "select * from tZPlcHistoryDataSet_Cloud " + vStrWhere;
            dt = claSqlConnDB.ExecuteDataset(claSqlConnDB.gStrConnDefault,CommandType.Text,mStrSQL).Tables[0];
            return dt;
        }

        public static DataTable GetData(int vIntDataid)
        {
            DataTable dt = null;
            string mStrSQL = "select * from tZPlcHistoryDataSet_Cloud where dIntCollectIndex = " + vIntDataid + "";
            dt = claSqlConnDB.ExecuteDataset(claSqlConnDB.gStrConnDefault,CommandType.Text,mStrSQL).Tables[0];
            return dt;
        }

        public static int AddData(string vStrAllAdress, string vStrAdressName, string vStrAddress, int vIntDataType, int vIntGongType, int vIntIsCollect, int vIntCollectSec, int vIntCollectType, int vIntCollectIndex)
        {
            int voIntReturn = -1;
            SqlParameter[] myParameter = new SqlParameter[10] 
            { 
                new SqlParameter("@viVchAllAdress",SqlDbType.VarChar,100),
                new SqlParameter("@viVchAdressName",SqlDbType.VarChar,30),
                new SqlParameter("@viVchAddress",SqlDbType.VarChar,30),
                new SqlParameter("@viIntDataType",SqlDbType.Int,4),
                new SqlParameter("@viIntGongType",SqlDbType.Int,4),
                new SqlParameter("@viIntIsCollect",SqlDbType.Int,4),
                new SqlParameter("@viIntCollectSec",SqlDbType.Int ,4),
                new SqlParameter("@viIntCollectType",SqlDbType.Int,4),
                new SqlParameter("@viIntCollectIndex",SqlDbType.Int,4),
                new SqlParameter("@voIntReturn",SqlDbType.Int,4)

            };
            myParameter[0].Value = vStrAllAdress;
            myParameter[1].Value = vStrAdressName;
            myParameter[2].Value = vStrAddress;
            myParameter[3].Value = vIntDataType;
            myParameter[4].Value = vIntGongType;
            myParameter[5].Value = vIntIsCollect;
            myParameter[6].Value = vIntCollectSec;
            myParameter[7].Value = vIntCollectType;
            myParameter[8].Value = vIntCollectIndex;
            myParameter[9].Direction = System.Data.ParameterDirection.Output;
            claSqlConnDB.ExecuteNonQuery(claSqlConnDB.gStrConnDefault, CommandType.StoredProcedure, "pZPlcHistoryDataSet_CloudAdd", myParameter);
            voIntReturn = (int)myParameter[9].Value;
            return voIntReturn;
        }


        public static int EditData(int vIntHistoryDataSet_Cloudid, string vStrAllAdress, string vStrAdressName, string vStrAddress, int vIntDataType, int vIntGongType, int vIntIsCollect, int vIntCollectSec, int vIntCollectType, int vIntCollectIndex)
        {
            int voIntReturn = -1;
            SqlParameter[] myParameter = new SqlParameter[11] 
            { 
                new SqlParameter("@viIntHistoryDataSet_Cloudid",SqlDbType.Int,4),
                new SqlParameter("@viVchAllAdress",SqlDbType.VarChar,100),
                new SqlParameter("@viVchAdressName",SqlDbType.VarChar,30),
                new SqlParameter("@viVchAddress",SqlDbType.VarChar,30),
                new SqlParameter("@viIntDataType",SqlDbType.Int,4),
                new SqlParameter("@viIntGongType",SqlDbType.Int,4),
                new SqlParameter("@viIntIsCollect",SqlDbType.Int,4),
                new SqlParameter("@viIntCollectSec",SqlDbType.Int ,4),
                new SqlParameter("@viIntCollectType",SqlDbType.Int,4),
                new SqlParameter("@viIntCollectIndex",SqlDbType.Int,4),
                new SqlParameter("@voIntReturn",SqlDbType.Int,4)

            };
            myParameter[0].Value = vIntHistoryDataSet_Cloudid;
            myParameter[1].Value = vStrAllAdress;
            myParameter[2].Value = vStrAdressName;
            myParameter[3].Value = vStrAddress;
            myParameter[4].Value = vIntDataType;
            myParameter[5].Value = vIntGongType;
            myParameter[6].Value = vIntIsCollect;
            myParameter[7].Value = vIntCollectSec;
            myParameter[8].Value = vIntCollectType;
            myParameter[9].Value = vIntCollectIndex;
            myParameter[10].Direction = System.Data.ParameterDirection.Output;
            claSqlConnDB.ExecuteNonQuery(claSqlConnDB.gStrConnDefault, CommandType.StoredProcedure, "pZPlcHistoryDataSet_CloudEdit", myParameter);
            voIntReturn = (int)myParameter[10].Value;
            return voIntReturn;
        }

        public static int DelData(int vIntCollectIndex)
        {
            int voIntReturn = -1;
            SqlParameter[] myParameter = new SqlParameter[2] 
            { 
                new SqlParameter("@viIntCollectIndex",SqlDbType.Int,4),
                new SqlParameter("@voIntReturn",SqlDbType.Int,4)

            };
            myParameter[0].Value = vIntCollectIndex;
           
            myParameter[1].Direction = System.Data.ParameterDirection.Output;
            claSqlConnDB.ExecuteNonQuery(claSqlConnDB.gStrConnDefault, CommandType.StoredProcedure, "pZPlcHistoryDataSet_CloudDel", myParameter);
            voIntReturn = (int)myParameter[1].Value;
            return voIntReturn;
        }

    }
}
