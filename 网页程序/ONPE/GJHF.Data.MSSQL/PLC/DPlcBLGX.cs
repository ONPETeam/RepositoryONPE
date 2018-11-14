using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using System.Data.SqlClient;

namespace GJHF.Data.MSSQL.PLC
{
    public class DPlcBLGX
    {
        public static DataTable GetBlDdz(string vStrWhere)
        {
            DataTable dt = null;
            string mStrSQL = "SELECT dIntDataID, dVchVariable, dVchCollectAddress, dVchParameterNum FROM      tZPLCVariableAndAddress " + vStrWhere;
            dt = claSqlConnDB.ExecuteDataset(claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL).Tables[0];
            return dt;
        }
        public static int GetRecord(string vStrWhere)
        {
            int count = 0;
            string mStrSQL = "select count(*) from tZPLCVariableAndAddress " + vStrWhere;
            count = claSqlConnDB.GetRecordCount(claSqlConnDB.gStrConnDefault,mStrSQL);
            return count;
        }
        public static int AddData(string vStrVariable, string vStrCollectAddress, string vStrParameterNum)
        {
            int voIntReturn;
            SqlParameter[] mysqlParameter = new SqlParameter[4]
         {
             new SqlParameter("@viVchVariable",SqlDbType.VarChar,50),
             new SqlParameter("@viVchCollectAddress",SqlDbType.VarChar,50),
             new SqlParameter("@viVchParameterNum",SqlDbType.VarChar,10),
             new SqlParameter("@voIntReturn",SqlDbType.Int,4)
         };

            mysqlParameter[0].Value = vStrVariable;
            mysqlParameter[1].Value = vStrCollectAddress;
            mysqlParameter[2].Value = vStrParameterNum;
            mysqlParameter[3].Direction = ParameterDirection.Output;
            claSqlConnDB.ExecuteNonQuery(claSqlConnDB.gStrConnDefault, CommandType.StoredProcedure, "pZPLCVariableAndAddressAdd", mysqlParameter);
            voIntReturn = (int)mysqlParameter[3].Value;
            return voIntReturn;
        }

        public static int EditData(string vStrVariable, string vStrCollectAddress, string vStrParameterNum)
        {
            int voIntReturn;
            SqlParameter[] mysqlParameter = new SqlParameter[4]
         {
             new SqlParameter("@viVchVariable",SqlDbType.VarChar,50),
             new SqlParameter("@viVchCollectAddress",SqlDbType.VarChar,50),
             new SqlParameter("@viVchParameterNum",SqlDbType.VarChar,10),
             new SqlParameter("@voIntReturn",SqlDbType.Int,4)
         };


            mysqlParameter[0].Value = vStrVariable;
            mysqlParameter[1].Value = vStrCollectAddress;
            mysqlParameter[2].Value = vStrParameterNum;
            mysqlParameter[3].Direction = ParameterDirection.Output;
            claSqlConnDB.ExecuteNonQuery(claSqlConnDB.gStrConnDefault, CommandType.StoredProcedure, "pZPLCVariableAndAddressEdit", mysqlParameter);
            voIntReturn = (int)mysqlParameter[3].Value;
            return voIntReturn;
        }

        public static int DelData(string vStrVariable)
        {
            int voIntReturn;
            string mStrSQL = "delete from tZPLCVariableAndAddress where dVchVariable = '" + vStrVariable + "' ";
            voIntReturn = claSqlConnDB.ExecuteNonQuery(claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL);
            return voIntReturn;
        }

        //根据全地址a,b,c参数
        public static  DataTable  GetValues(string vStrVariable)
        {
            DataTable dt = null;
            string mStrSQL = @"select dVchCollectAddress,dVchParameterNum,tZPlcDtTemp.dVchValue from tZPLCVariableAndAddress  
                                        left outer join tZPlcDtTemp on tZPLCVariableAndAddress.dVchCollectAddress = tZPlcDtTemp.dVchCjdz 
                                        where dVchVariable = '" + vStrVariable + "' and dVchCollectAddress is not null and dVchCollectAddress <> ''";
            dt = claSqlConnDB.ExecuteDataset(claSqlConnDB.gStrConnDefault,CommandType.Text,mStrSQL).Tables[0];
            return dt;
        } 

        //变量类型下拉框
        public static DataTable GetVariableType(string vStrWhere)
        {
            DataTable dt = null;
            string mStrSQL = @"select dIntVariableID, dVchVariableCode, dVchVariableName FROM   tZPLCVariableType "+ vStrWhere +" order by dIntVariableID";
            dt = claSqlConnDB.ExecuteDataset(claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL).Tables[0];
            return dt;
        }

    }
}
