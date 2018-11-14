using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using System.Data.SqlClient;

namespace GJHF.Data.MSSQL.PLC
{
    public class DPlcBLFormula
    {
        public static DataTable GetFormula(string vCjdz)
        {
            DataTable dt = null;
            string mStrSQL = "SELECT  dVchVariable, dVchFormula FROM      tZPLCVariableFormula where dVchVariable = '" + vCjdz + "'";
            dt = claSqlConnDB.ExecuteDataset(claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL).Tables[0];
            return dt;
        }
        public static int AddData(string vStrVariable, string vStrFormula)
        {
            int voIntReturn;
            SqlParameter[] mysqlParameter = new SqlParameter[3]
             {
                 new SqlParameter("@viVchVariable",SqlDbType.VarChar,50),
                 new SqlParameter("@viVchFormula",SqlDbType.VarChar,50),
                 new SqlParameter("@voIntReturn",SqlDbType.Int,4)
             };

            mysqlParameter[0].Value = vStrVariable;
            mysqlParameter[1].Value = vStrFormula;
            mysqlParameter[2].Direction = ParameterDirection.Output;
            claSqlConnDB.ExecuteNonQuery(claSqlConnDB.gStrConnDefault, CommandType.StoredProcedure, "pZPLCVariableFormulaAdd", mysqlParameter);
            voIntReturn = (int)mysqlParameter[2].Value;
            return voIntReturn;
        }

        public static int EditData(string vStrVariable, string vStrFormula)
        {
            int voIntReturn;
            SqlParameter[] mysqlParameter = new SqlParameter[3]
         {
             new SqlParameter("@viVchVariable",SqlDbType.VarChar,50),
             new SqlParameter("@viVchFormula",SqlDbType.VarChar,50),
             new SqlParameter("@voIntReturn",SqlDbType.Int,4)
         };

            mysqlParameter[0].Value = vStrVariable;
            mysqlParameter[1].Value = vStrFormula;
            mysqlParameter[2].Direction = ParameterDirection.Output;
            claSqlConnDB.ExecuteNonQuery(claSqlConnDB.gStrConnDefault, CommandType.StoredProcedure, "pZPLCVariableFormulaEdit", mysqlParameter);
            voIntReturn = (int)mysqlParameter[2].Value;
            return voIntReturn;
        }

        public static int DelData(string vStrVariable)
        {
            int voIntReturn;
            SqlParameter[] mysqlParameter = new SqlParameter[2]
         {
             new SqlParameter("@viVchVariable",SqlDbType.VarChar,50),
             new SqlParameter("@voIntReturn",SqlDbType.Int,4)
         };
            mysqlParameter[0].Value = vStrVariable;
            mysqlParameter[1].Direction = ParameterDirection.Output;
            claSqlConnDB.ExecuteNonQuery(claSqlConnDB.gStrConnDefault, CommandType.StoredProcedure, "pZPLCVariableFormulaDel", mysqlParameter);
            voIntReturn = (int)mysqlParameter[1].Value;
            return voIntReturn;
        }
    }
}
