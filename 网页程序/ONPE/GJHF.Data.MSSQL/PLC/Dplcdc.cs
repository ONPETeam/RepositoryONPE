using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data.SqlClient;
using System.Data;

namespace GJHF.Data.MSSQL.PLC
{
    public class Dplcdc
    {
        //显示数据列表
        public static DataTable GetData(int rows, int pages, string vStrWhere)
        {
            DataTable dt = null;
            string mStrSQL = @"select  dIntGzID, dVchGzName, dVchGzXx, dVchGzYy, dVchGzCL, tZPLCGzFl.dIntGzType,dVchGzTypeName  from tZPLCGzCL 
                                                        left outer join tZPLCGzFl on tZPLCGzCL.dIntGzType = tZPLCGzFl.dIntGzType " + vStrWhere;
            dt = claSqlConnDB.ExecuteDataset(rows, pages, claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL).Tables[0];
            return dt;
        }
        //数据条数
        public static  int GetRecordCount(string vStrWhere)
        {
            int count = 0;
            string mStrSQL = @"select count(*) from tZPLCGzCL" + vStrWhere;
            count = claSqlConnDB.GetRecordCount(claSqlConnDB.gStrConnDefault, mStrSQL);
            return count;
        }
        //下拉框显示
        public static DataTable GetComboData(string vStrWhere)
        {
            DataTable dt = null;
            string mStrSQL = @"select dIntGzID,dVchGzName from tZPLCGzCL " + vStrWhere;
            dt = claSqlConnDB.ExecuteDataset(claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL).Tables[0];
            return dt;
        }

        public static void AddData(string vStrGzName, string vStrGzXx, string vStrGzyy, string vStrGzCL, int vIntGzType,out int voIntReturn)
        {
            SqlParameter[] myParameter = new SqlParameter[6]
             {
                  new SqlParameter("@viVchGzName",SqlDbType.VarChar,30),
                  new SqlParameter("@viVchGzXx",SqlDbType.VarChar,100),
                  new SqlParameter("@viVchGzYy",SqlDbType.VarChar,100),
                  new SqlParameter("@viVchGzCL",SqlDbType.VarChar,100),
                  new SqlParameter("@viIntGzType",SqlDbType.Int,4),
                  new SqlParameter("@voIntReturn",SqlDbType.Int,4)
             };
            myParameter[0].Value = vStrGzName;
            myParameter[1].Value = vStrGzXx;
            myParameter[2].Value = vStrGzyy;
            myParameter[3].Value = vStrGzCL;
            myParameter[4].Value = vIntGzType;
            myParameter[5].Direction = ParameterDirection.Output;
            claSqlConnDB.ExecuteNonQuery(claSqlConnDB.gStrConnDefault, CommandType.StoredProcedure, "pZPLCGzCLAdd", myParameter);
            voIntReturn = (int)myParameter[5].Value;
        }

        public static void EditData(int vIntGzID, string vStrGzName, string vStrGzXx, string vStrGzyy, string vStrGzCL, int vIntGzType, out int voIntReturn)
        {
            SqlParameter[] myParameter = new SqlParameter[7]
            {
                new SqlParameter("@viIntGzID",SqlDbType.Int,4),
                new SqlParameter("@viVchGzName",SqlDbType.VarChar,30),   
                new SqlParameter("@viVchGzXx",SqlDbType.VarChar,100),
                new SqlParameter("@viVchGzYy",SqlDbType.VarChar,100),
                new SqlParameter("@viVchGzCL",SqlDbType.VarChar,100),
                new SqlParameter("@viIntGzType",SqlDbType.VarChar,100),
                new SqlParameter("@voIntReturn",SqlDbType.Int,4),
            
            };

            myParameter[0].Value = vIntGzID;
            myParameter[1].Value = vStrGzName;
            myParameter[2].Value = vStrGzXx;
            myParameter[3].Value = vStrGzyy;
            myParameter[4].Value = vStrGzCL;
            myParameter[5].Value = vIntGzType;
            myParameter[6].Direction = ParameterDirection.Output;
            claSqlConnDB.ExecuteNonQuery(claSqlConnDB.gStrConnDefault, CommandType.StoredProcedure, "pZPLCGzCLEdit", myParameter);
            voIntReturn = (int)myParameter[6].Value;
        }

        public static void DelData(int vIntGzID, out int voIntReturn)
        {
            SqlParameter[] myParameter = new SqlParameter[2]
            {
                new SqlParameter("@viIntGzID",SqlDbType.Int,4),
                new SqlParameter("@voIntReturn",SqlDbType.Int,4),
            };

            myParameter[0].Value = vIntGzID;
            myParameter[1].Direction = ParameterDirection.Output;
            claSqlConnDB.ExecuteNonQuery(claSqlConnDB.gStrConnDefault, CommandType.StoredProcedure, "pZPLCGzCLDel", myParameter);
            voIntReturn = (int)myParameter[1].Value;
        }
    }
}
