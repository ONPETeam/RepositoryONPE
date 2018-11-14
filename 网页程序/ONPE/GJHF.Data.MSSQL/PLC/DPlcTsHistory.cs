using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using System.Data.SqlClient;

namespace GJHF.Data.MSSQL.PLC
{
    public class DPlcTsHistory
    {
        public static DataTable GetData(int rows,int pages,string vStrWhere)
        {
            DataTable dt = null;
            string mStrSQL = "select * from tZPlcTsHistory " + vStrWhere;
            dt = claSqlConnDB.ExecuteDataset(claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL).Tables[0];
            return dt;
        }

        public static int GetRecord(string vStrWhere)
        {
            int count = 0;
            string mStrSQL = "select count(*) from tZPlcTsHistory";
            count = claSqlConnDB.GetRecordCount(claSqlConnDB.gStrConnDefault, mStrSQL);
            return count;
        }

        public static int AddData(string vStrTsContent,string vStrTsPeople,int vIntTsType,DateTime vDeaTsDate,string vStrRemark)
        {
            int voIntReturn = -1;
            SqlParameter[] MySqlParameter = new SqlParameter[6]
            {
                new SqlParameter("@viVchTsContent",SqlDbType.VarChar,100),
                new SqlParameter("@viVchTsPeople",SqlDbType.VarChar,100),
                new SqlParameter("@viIntTsType",SqlDbType.Int,4),
                new SqlParameter("@viDeaTsDate",SqlDbType.DateTime,30),
                new SqlParameter("@viVchRemark",SqlDbType.VarChar,100),
                new SqlParameter("@voIntReturn",SqlDbType.Int,4)
            };

            MySqlParameter[0].Value = vStrTsContent;
            MySqlParameter[1].Value = vStrTsPeople;
            MySqlParameter[2].Value = vIntTsType;
            MySqlParameter[3].Value = vDeaTsDate;
            MySqlParameter[4].Value = vStrRemark;
            MySqlParameter[5].Direction = ParameterDirection.Output;
            claSqlConnDB.ExecuteNonQuery(claSqlConnDB.gStrConnDefault, CommandType.StoredProcedure, "pZPlcTsHistoryAdd", MySqlParameter);
            voIntReturn = (int)MySqlParameter[5].Value;
            return voIntReturn;
        }

        public static int EditData(int vIntTsId,string vStrTsContent,string vStrTsPeople,int vIntTsType,DateTime vDeaTsDate,string vStrRemark)
        {
            int voIntReturn = -1;
            SqlParameter[] MySqlParameter = new SqlParameter[7]
            {
                new SqlParameter("@viIntTsId",SqlDbType.Int,8),
                new SqlParameter("@viVchTsContent",SqlDbType.VarChar,100),
                new SqlParameter("@viVchTsPeople",SqlDbType.VarChar,100),
                new SqlParameter("@viIntTsType",SqlDbType.Int,4),
                new SqlParameter("@viDeaTsDate",SqlDbType.DateTime,30),
                new SqlParameter("@viVchRemark",SqlDbType.VarChar,100),
                new SqlParameter("@voIntReturn",SqlDbType.Int,4)
            };

            MySqlParameter[0].Value = vIntTsId;
            MySqlParameter[1].Value = vStrTsContent;
            MySqlParameter[2].Value = vStrTsPeople;
            MySqlParameter[3].Value = vIntTsType;
            MySqlParameter[4].Value = vDeaTsDate;
            MySqlParameter[5].Value = vStrRemark;
            MySqlParameter[6].Direction = ParameterDirection.Output;
            claSqlConnDB.ExecuteNonQuery(claSqlConnDB.gStrConnDefault, CommandType.StoredProcedure, "pZPlcTsHistoryEdit", MySqlParameter);
            voIntReturn = (int)MySqlParameter[6].Value;
            return voIntReturn;
        }

        public static int DelData(int vIntTsId)
        {
            int voIntReturn = -1; 
            SqlParameter[] MySqlParameter = new SqlParameter[2]
            {
                new SqlParameter("@viIntTsId",SqlDbType.Int,8),
                new SqlParameter("@voIntReturn",SqlDbType.Int,4)
            };

            MySqlParameter[0].Value = vIntTsId;
            MySqlParameter[1].Direction = ParameterDirection.Output;
            claSqlConnDB.ExecuteNonQuery(claSqlConnDB.gStrConnDefault, CommandType.StoredProcedure, "pZPlcTsHistoryDel", MySqlParameter);
            voIntReturn = (int)MySqlParameter[1].Value;
            return voIntReturn;
        }


    }
}
