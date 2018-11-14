using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;

namespace GJHF.Data.MSSQL.PLC
{
    public class DPlcNetXr
    {
        public static DataTable  GetData(int rows,int pages,string vStrWhere)
        {
            DataTable dt = null;
            string mStrSQL = @"SELECT  * FROM  tZplcXr " + vStrWhere;
            dt = claSqlConnDB.ExecuteDataset(claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL).Tables[0];
            return dt;
        }

        public static int GetRecord(string vStrWhere)
        {
            int count = 0;
            string mStrSQL = "select count(*) from tZplcXr " + vStrWhere;
            count = claSqlConnDB.GetRecordCount(claSqlConnDB.gStrConnDefault, mStrSQL);
            return count;
        }

        public static DataTable GetOneData(string vStrWhere)
        {
            DataTable dt = null;
            string mStrSQL = "SELECT  * FROM  tZplcXr " + vStrWhere;
            dt = claSqlConnDB.ExecuteDataset(claSqlConnDB.gStrConnDefault,CommandType.Text,mStrSQL).Tables[0];
            return dt;
        }

        public static int SetTsState(int vIntTsState)
        {
            string mStrSQL = "update tZplcXr set dIntTsState = " + vIntTsState;
            return claSqlConnDB.ExecuteNonQuery(claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL);
        }

    }
}
