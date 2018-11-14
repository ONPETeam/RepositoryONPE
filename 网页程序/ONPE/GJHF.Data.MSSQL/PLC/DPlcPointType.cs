using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using System.Data.SqlClient;

namespace GJHF.Data.MSSQL.PLC
{
    public class DPlcPointType
    {
        //显示数据列表
        public static DataTable GetData(int rows, int pages, string vStrWhere)
        {
            DataTable dt = null;
            string mStrSQL = @"SELECT     dIntNoteID, dVchPointType, dVchRemark, dIntSjNoteID,dIntPx FROM t_XJPointType " + vStrWhere;
            dt = claSqlConnDB.ExecuteDataset(rows, pages, claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL).Tables[0];
            return dt;
        }
        //数据条数
        public static int GetRecordCount(string vStrWhere)
        {
            int count = 0;
            string mStrSQL = @"SELECT  count(*)  FROM t_XJPointType " + vStrWhere;
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

        public static int AddData(string vStrPointType, string vStrRemark, int vIntSjNoteID, int vIntPx)
        {
            int voIntReturn = -1;
            SqlParameter[] myParameter = new SqlParameter[5]
        {
              
              new SqlParameter("@viVchPointType",SqlDbType.VarChar,50),
              new SqlParameter("@viVchRemark",SqlDbType.VarChar,100),
              new SqlParameter("@viIntSjNoteID",SqlDbType.Int,4),
              new SqlParameter("@viIntPX",SqlDbType.Int,4),
              new SqlParameter("@voIntReturn",SqlDbType.Int,4),
        };

            myParameter[0].Value = vStrPointType;
            myParameter[1].Value = vStrRemark;
            myParameter[2].Value = vIntSjNoteID;
            myParameter[3].Value = vIntPx;
            myParameter[4].Direction = ParameterDirection.Output;
            claSqlConnDB.ExecuteNonQuery(claSqlConnDB.gStrConnDefault, CommandType.StoredProcedure, "pZPLCXJPointTypeAdd", myParameter);
            voIntReturn = (int)myParameter[4].Value;
            return voIntReturn;
        }

        public static int EditData(int vIntNoteID,string vStrPointType, string vStrRemark, int vIntSjNoteID, int vIntPx)
        {
            int voIntReturn = -1;
            SqlParameter[] myParameter = new SqlParameter[6]
        {
            new SqlParameter("@viIntNoteID",SqlDbType.Int,4),
            new SqlParameter("@viVchPointType",SqlDbType.VarChar,50),
            new SqlParameter("@viVchRemark",SqlDbType.VarChar,100),
            new SqlParameter("@viIntSjNoteID",SqlDbType.Int,4),
            new SqlParameter("@viIntPX",SqlDbType.Int,4),
            new SqlParameter("@voIntReturn",SqlDbType.Int,4),
        };

            myParameter[0].Value = vIntNoteID;
            myParameter[1].Value = vStrPointType;
            myParameter[2].Value = vStrRemark;
            myParameter[3].Value = vIntSjNoteID;
            myParameter[4].Value = vIntPx;
            myParameter[5].Direction = ParameterDirection.Output;
            claSqlConnDB.ExecuteNonQuery(claSqlConnDB.gStrConnDefault, CommandType.StoredProcedure, "pZPLCXJPointTypeEdit", myParameter);
            voIntReturn = (int)myParameter[5].Value;
            return voIntReturn;
        }

        public static int DelData(int vIntNoteID)
        {
            int voIntReturn = -1;
            SqlParameter[] myParameter = new SqlParameter[2]
        {
            new SqlParameter("@viIntNoteID",SqlDbType.Int,4),
            new SqlParameter("@voIntReturn",SqlDbType.Int,4),
        };

            myParameter[0].Value = vIntNoteID;
            myParameter[1].Direction = ParameterDirection.Output;
            claSqlConnDB.ExecuteNonQuery(claSqlConnDB.gStrConnDefault, CommandType.StoredProcedure, "pZPLCXJPointTypeDel", myParameter);
            voIntReturn = (int)myParameter[1].Value;
            return voIntReturn;
        }

        //工艺参数下显示相关PLC点地址
        public DataTable GetddzByGycs(string vStrWhere,int pagesize,int pageindex)
        {
            DataTable dt = null;
            string mStrSQL = @"select tZPlcPointDiZhi.dIntDataID, dVchAdressName, dVchAddress, tZPlcPointDiZhi.dVchAllAdress, dVchDescription, dIntDataType, 
                                                dVchDanwei, dVchDataType,dIntJsBz,dVchFormula,dfltMax,dfltMin,dVchKgAlermValue,tZSbBaojingFanwei.dVchRemark,tZSbBaojingFanwei.dIntAdressTypeID,tZPlcHistoryJK.dIntBjBz 
                                                from tZPlcPointType left outer join tZPlcPointDiZhi on tZPlcPointType.dIntDataID = tZPlcPointDiZhi.dIntDataID
                                                left outer join tZPLCVariableFormula on tZPlcPointDiZhi.dVchAllAdress = tZPLCVariableFormula.dVchVariable 
                                                left outer join tZSbBaojingFanwei on tZPlcPointDiZhi.dVchAllAdress = tZSbBaojingFanwei.dVchAllAdress 
                                                left outer join tZPlcHistoryJK on tZPlcPointDiZhi.dVchAllAdress = tZPlcHistoryJK.dVchCjdz " + vStrWhere;

            dt = claSqlConnDB.ExecuteDataset(pagesize, pageindex,claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL).Tables[0];
            return dt;
        }

        //工艺参数下显示PLC点地址的总个数
        public int GetRecordByGycs(string vStrWhere)
        {
            int count = 0;
            string mStrSQL = "select count(*) from tZPlcPointType " + vStrWhere;
            count = claSqlConnDB.GetRecordCount(claSqlConnDB.gStrConnDefault,mStrSQL);
            return count;
        }


    }
}
