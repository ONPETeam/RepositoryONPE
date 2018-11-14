using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using System.Data.SqlClient;

namespace GJHF.Data.MSSQL.PLC
{
    public class DPlcBaojing
    {
        public static DataTable GetOneBjfwData(string vStrWhere)
        {
            string mStrSQL = @"select top (1) dIntDataID, dVchSbCode, dVchAllAdress, dIntAdressTypeID, dfltMax, dfltMin, dVchKgAlermValue, dIntBaojingJBID, dVchRemark from tZSbBaojingFanwei " + vStrWhere;
            DataTable dt = claSqlConnDB.ExecuteDataset(claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL).Tables[0];
            return dt;
        }

        public static int AddBjData(string vStrFactoryCode, string vStrPLCCode, string vStrAdress, string vStrCjdz, string vStrValue, string vStrSjValue, string vStrUnit, 
            int vIntDqBz, float vFltSjMax, float vFltSjMin, float vFltBdMax, float vFltBdMin, 
            string vStrfwqdh, string vStrName, int vIntdizhiID, string vStrequip_code, string vStrVariableType)
        {
            int voIntReturn = -1;
            SqlParameter[] myParameter = new SqlParameter[18]
        {
            new SqlParameter("@viVchFactoryCode",SqlDbType.VarChar,50),
            new SqlParameter("@viVchPLCCode",SqlDbType.VarChar,50),
            new SqlParameter("@viVchAdress",SqlDbType.VarChar,50),
            new SqlParameter("@viVchCjdz",SqlDbType.VarChar,100),
            new SqlParameter("@viVchValue",SqlDbType.VarChar,50),
            new SqlParameter("@viVchSjValue",SqlDbType.VarChar,50),
            new SqlParameter("@viVchUnit",SqlDbType.VarChar,50),
            new SqlParameter("@viIntDqBz",SqlDbType.Int,4),
            new SqlParameter("@viFltSjMax",SqlDbType.Float,8),
            new SqlParameter("@viFltSjMin",SqlDbType.Float,8),
            new SqlParameter("@viFltBdMax",SqlDbType.Float,8),
            new SqlParameter("@viFltBdMin",SqlDbType.Float,8),
            new SqlParameter("@viVchfwqdh",SqlDbType.VarChar,50),
            new SqlParameter("@viVchName",SqlDbType.VarChar,50),
            new SqlParameter("@viIntdizhiID",SqlDbType.Int,4),
            new SqlParameter("@viequip_code",SqlDbType.VarChar,50),
            new SqlParameter("@viVchVariableType",SqlDbType.VarChar,20),
            new SqlParameter("@voIntReturn",SqlDbType.Int,4)
              
        };

            myParameter[0].Value = vStrFactoryCode;
            myParameter[1].Value = vStrPLCCode;
            myParameter[2].Value = vStrAdress;
            myParameter[3].Value = vStrCjdz;
            myParameter[4].Value = vStrValue;
            myParameter[5].Value = vStrSjValue;
            myParameter[6].Value = vStrUnit;
            myParameter[7].Value = vIntDqBz;
            myParameter[8].Value = vFltSjMax;
            myParameter[9].Value = vFltSjMin;
            myParameter[10].Value = vFltBdMax;
            myParameter[11].Value = vFltBdMin;
            myParameter[12].Value = vStrfwqdh;
            myParameter[13].Value = vStrName;
            myParameter[14].Value = vIntdizhiID;
            myParameter[15].Value = vStrequip_code;
            myParameter[16].Value = vStrVariableType;
            myParameter[17].Direction = ParameterDirection.Output;
            claSqlConnDB.ExecuteNonQuery(claSqlConnDB.gStrConnDefault, CommandType.StoredProcedure, "pZPlcHistoryJKAdd", myParameter);
            voIntReturn = (int)myParameter[17].Value;
            return voIntReturn;
        }

        public static int GetBJBZ(string vStrCjdz, int vIntBjBz)
        {
            int voIntReturn = -1;
            string mStrSQL = "update tZPlcHistoryJK set dIntBjBz = " + vIntBjBz + " where dVchCjdz = '" + vStrCjdz + "'";
            voIntReturn = claSqlConnDB.ExecuteNonQuery(claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL);
            return voIntReturn;
        }

        public static int AddBjFw(string vStrSbbm, string vStrcjdz, int vIntdzlb, float vfltMax, float vfltMin, string vStrKgl, int vIntBaojingJBID, string vStrRemark)
        {
            int voIntReturn = -1;
            SqlParameter[] myparamter = new SqlParameter[9]
        {
            new SqlParameter("@viVchSbCode",SqlDbType.VarChar,50),
            new SqlParameter("@viVchAllAdress",SqlDbType.VarChar,50),
            new SqlParameter("@viIntAdressTypeID",SqlDbType.Int,4),
            new SqlParameter("@vifltMax",SqlDbType.Float,8),
            new SqlParameter("@vifltMin",SqlDbType.Float,8),
            new SqlParameter("@viVchKgAlermValue",SqlDbType.VarChar,50),
            new SqlParameter("@viIntBaojingJBID",SqlDbType.Int,4),
            new SqlParameter("@viVchRemark",SqlDbType.VarChar,50),
            new SqlParameter("@voIntReturn",SqlDbType.Int,4)
        };

            myparamter[0].Value = vStrSbbm;
            myparamter[1].Value = vStrcjdz;
            myparamter[2].Value = vIntdzlb;
            myparamter[3].Value = vfltMax;
            myparamter[4].Value = vfltMin;
            myparamter[5].Value = vStrKgl;
            myparamter[6].Value = vIntBaojingJBID;
            myparamter[7].Value = vStrRemark;
            myparamter[8].Direction = ParameterDirection.Output;
            voIntReturn = claSqlConnDB.ExecuteNonQuery(claSqlConnDB.gStrConnDefault, CommandType.StoredProcedure, "pZSbBaojingFanweiAdd", myparamter);
            return voIntReturn;
        }

        public static int SetTsPeople(int vIntdizhiID, string vStrcjdz, string vStrpeople)
        {
            int voIntReturn = -1;
            SqlParameter[] myparameter = new SqlParameter[4]
             {
                 new SqlParameter("@viIntdizhiID",SqlDbType.Int,8),
                 new SqlParameter("@viVchCjdz",SqlDbType.VarChar,50),
                 new SqlParameter("@viVchMbValue",SqlDbType.VarChar,5000),
                 new SqlParameter("@voIntReturn",SqlDbType.Int,4)
             };
            //地址id暂时给0，预留字段
            myparameter[0].Value = vIntdizhiID;
            myparameter[1].Value = vStrcjdz;
            myparameter[2].Value = vStrpeople;
            myparameter[3].Direction = ParameterDirection.Output;
            voIntReturn = claSqlConnDB.ExecuteNonQuery(claSqlConnDB.gStrConnDefault, CommandType.StoredProcedure, "pZPlcddzAndPeople", myparameter);
            return voIntReturn;
        }

        public static int DelAlermRange(string vStrCjdz)
        {
            int voIntReturn = -1;
            string mStrSQL = "delete from tZSbBaojingFanwei where dVchAllAdress = '" + vStrCjdz + "'";
            voIntReturn = claSqlConnDB.ExecuteNonQuery(claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL);
            return voIntReturn;
        }


    }
}
