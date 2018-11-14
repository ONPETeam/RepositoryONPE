using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using System.Data.SqlClient;

namespace GJHF.Data.MSSQL.PLC
{
    public class DPlcArea
    {
        //显示数据列表
        public static DataTable GetData(int rows, int pages, string vStrWhere)
        {
            DataTable dt = null;
            string mStrSQL = @"select  dIntAreaID,dVchArea,dIntSJAreaID from  tZPLCArea " + vStrWhere;
            dt = claSqlConnDB.ExecuteDataset(rows, pages, claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL).Tables[0];
            return dt;
        }
        //数据条数
        public static int GetRecordCount(string vStrWhere)
        {
            int count = 0;
            string mStrSQL = @"select count(*) FROM  tZPLCArea" + vStrWhere;
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

        public static int AddData(string vStrArea, int vIntSJAreaID, int vIntPx)
        {
            int voIntReturn = -1;
            SqlParameter[] myParameter = new SqlParameter[4]
            {
                  new SqlParameter("@viVchArea",SqlDbType.VarChar,50),
                  new SqlParameter("@viIntSJAreaID",SqlDbType.Int,4),
                  new SqlParameter("@viIntPX",SqlDbType.Int,4),
                  new SqlParameter("@voIntReturn",SqlDbType.Int,4)
              
            };
            myParameter[0].Value = vStrArea;
            myParameter[1].Value = vIntSJAreaID;
            myParameter[2].Value = vIntPx;
            myParameter[3].Direction = ParameterDirection.Output;
            claSqlConnDB.ExecuteNonQuery(claSqlConnDB.gStrConnDefault, CommandType.StoredProcedure, "pZPLCAreaAdd", myParameter);
            voIntReturn = (int)myParameter[3].Value;
            return voIntReturn;
        }

        public static int EditData(int vIntAreaID,string vStrArea, int vIntSJAreaID, int vIntPx)
        {
            int voIntReturn = -1;
            SqlParameter[] myParameter = new SqlParameter[5]
            {
                new SqlParameter("@viIntAreaID",SqlDbType.Int,4),
                new SqlParameter("@viVchArea",SqlDbType.VarChar,50),
                new SqlParameter("@viIntSJAreaID",SqlDbType.Int,4),
                new SqlParameter("@viIntPX",SqlDbType.Int,4),
                new SqlParameter("@voIntReturn",SqlDbType.Int,4),
            
            };

            myParameter[0].Value = vIntAreaID;
            myParameter[1].Value = vStrArea;
            myParameter[2].Value = vIntSJAreaID;
            myParameter[3].Value = vIntPx;
            myParameter[4].Direction = ParameterDirection.Output;
            claSqlConnDB.ExecuteNonQuery(claSqlConnDB.gStrConnDefault, CommandType.StoredProcedure, "PLCAreaEdit", myParameter);
            voIntReturn = (int)myParameter[4].Value;
            return voIntReturn;
        }

        public static int DelData(int vIntAreaID)
        {
            int voIntReturn = -1;
            SqlParameter[] myParameter = new SqlParameter[2]
            {
                new SqlParameter("@viIntAreaID",SqlDbType.Int,4),
                new SqlParameter("@voIntReturn",SqlDbType.Int,4),
            };

            myParameter[0].Value = vIntAreaID;
            myParameter[1].Direction = ParameterDirection.Output;
            claSqlConnDB.ExecuteNonQuery(claSqlConnDB.gStrConnDefault, CommandType.StoredProcedure, "pZPLCAreaDel", myParameter);
            voIntReturn = (int)myParameter[1].Value;
            return voIntReturn;
        }
    }
}
