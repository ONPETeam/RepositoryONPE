using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using System.Data.SqlClient;

namespace GJHF.Data.MSSQL.PLC
{
    public class DPlcDtTemp
    {
        public static DataTable GetData(int rows, int pages, string vStrWhere)
        {
            DataTable dt = null;
            string mStrSQL = @"SELECT  tZPlcDtTemp.dIntDataID, tZPlcFactory.dVchFactoryCode, dVchPLCCode, dVchAdress, dVchCjdz, dVchValue, 
                            dVchUnit, dIntDqBz,tZPlcFactory.dVchFactoryName,tZPLCManager.dVchRemark,tZPlcDtTemp.dFltSjMax,tZPlcDtTemp.dFltSjMin,tZPlcDtTemp.dFltBdMax,tZPlcDtTemp.dFltBdMin,
                            tZPLCManager.dVchPLCName,tZPLCManager.dVchIPAdress,dVchName,tZPlcPointDiZhi.dVchDescription,equip_name,dVchVariableType,dDaeCurrentTime,dIntBjState,tZPlcDtTemp.dIntJsBz,tZPLCVariableFormula.dVchFormula,tZPlcDtTemp.dVchSjValue FROM   tZPlcDtTemp 
                            left outer join tZPlcPointDiZhi on tZPlcDtTemp.dIntdizhiID = tZPlcPointDiZhi.dIntDataID
                            left outer join t_Equips on  tZPlcDtTemp.equip_code = t_Equips.equip_code
                            left outer join tZPlcFactory on tZPlcDtTemp.dVchFactoryCode = tZPlcFactory.dVchFactoryCode 
                            left outer join tZPLCManager on tZPlcDtTemp.dVchPLCCode = tZPLCManager.dVchPLCbianma
                            left outer join tZPLCVariableFormula on tZPlcDtTemp.dVchCjdz = tZPLCVariableFormula.dVchVariable " + vStrWhere;
            dt = claSqlConnDB.ExecuteDataset(rows,pages,claSqlConnDB.gStrConnDefault,CommandType.Text,mStrSQL).Tables[0];
            return dt;
        }

        public static int GetRecord(string vStrWhere)
        {
            int count = 0;
            string mStrSQL = @"select count(*)  FROM   tZPlcDtTemp 
                            left outer join tZPlcPointDiZhi on tZPlcDtTemp.dIntdizhiID = tZPlcPointDiZhi.dIntDataID
                            left outer join t_Equips on  tZPlcDtTemp.equip_code = t_Equips.equip_code
                            left outer join tZPlcFactory on tZPlcDtTemp.dVchFactoryCode = tZPlcFactory.dVchFactoryCode 
                            left outer join tZPLCManager on tZPlcDtTemp.dVchPLCCode = tZPLCManager.dVchPLCbianma
                            left outer join tZPLCVariableFormula on tZPlcDtTemp.dVchCjdz = tZPLCVariableFormula.dVchVariable " + vStrWhere;
            count = claSqlConnDB.GetRecordCount(claSqlConnDB.gStrConnDefault, mStrSQL);
            return count;
        }

        public static int AddData(string vStrFactoryCode, string vStrPLCCode, string vStrAdress, string vStrCjdz, string vStrValue, string vStrSjValue, string vStrUnit, int vIntDqBz,
        float vFltSjMaX, float vFltSjMin, float vFltBdMax, float vFltBdMin, string vStrfwqdh, string vStrName, int vIntdizhiID, string vStrequip_code, string vStrVariableType)
        {
            int voIntReturn;

            SqlParameter[] myParameter = new SqlParameter[18]
        {
              new SqlParameter("@viVchFactoryCode",SqlDbType.VarChar,50),
              new SqlParameter("@viVchPLCCode",SqlDbType.VarChar,50),
              new SqlParameter("@viVchAdress",SqlDbType.VarChar,50),
              new SqlParameter("@viVchCjdz",SqlDbType.VarChar,150),
              new SqlParameter("@viVchValue",SqlDbType.VarChar,50),
              new SqlParameter("@viVchSjValue",SqlDbType.VarChar,50),
              new SqlParameter("@viVchUnit",SqlDbType.VarChar,50),
              new SqlParameter("@viIntDqBz",SqlDbType.VarChar,50),
              new SqlParameter("@viFltSjMaX",SqlDbType.VarChar,50),
              new SqlParameter("@viFltSjMin",SqlDbType.VarChar,50),
              new SqlParameter("@viFltBdMax",SqlDbType.VarChar,50),
              new SqlParameter("@viFltBdMin",SqlDbType.VarChar,50),
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
            myParameter[8].Value = vFltSjMaX;
            myParameter[9].Value = vFltSjMin;
            myParameter[10].Value = vFltBdMax;
            myParameter[11].Value = vFltBdMin;
            myParameter[12].Value = vStrfwqdh;
            myParameter[13].Value = vStrName;
            myParameter[14].Value = vIntdizhiID;
            myParameter[15].Value = vStrequip_code;
            myParameter[16].Value = vStrVariableType;
            myParameter[17].Direction = ParameterDirection.Output;
            claSqlConnDB.ExecuteNonQuery(claSqlConnDB.gStrConnDefault, CommandType.StoredProcedure, "pZPlcDtTempAdd", myParameter);
            voIntReturn = (int)myParameter[17].Value;
            return voIntReturn;
        }

        public static int DelData(int vIntid)
        {
            int voIntReturn;
            string mStrSQL = "delete from tZPlcDtTemp where dIntDataID = " + vIntid;
            voIntReturn = claSqlConnDB.ExecuteNonQuery(claSqlConnDB.gStrConnDefault,CommandType.Text,mStrSQL);
            return voIntReturn;
        }

        public static int EditJsl(int vIntid,int vIntJsBz)
        {
            int voIntReturn;
            string mStrSQL = "update tZPlcDtTemp set dIntJsBz = " + vIntJsBz + " where dIntDataID = " + vIntid;
            voIntReturn = claSqlConnDB.ExecuteNonQuery(claSqlConnDB.gStrConnDefault,CommandType.Text,mStrSQL);
            return voIntReturn;
        }
        public static DataTable GetDataLS(string vStrWhere)
        {
            DataTable dt = null;
            string mStrSQL = @"SELECT dIntDataID,dVchCjdz,dVchValue,dVchSjValue,dDaeCurrentTime,dFltSjMax, dFltSjMin, dFltBdMax, dFltBdMin from tZPlcDtTempLS " + vStrWhere;
            dt = claSqlConnDB.ExecuteDataset(claSqlConnDB.gStrConnDefault,CommandType.Text,mStrSQL).Tables[0];
            return dt;
        }
        public static int GetRecordLS(string vStrWhere)
        {
            int count = 0;
            string mStrSQL = "select count(*) from tZPlcDtTempLS " + vStrWhere;
            count = claSqlConnDB.GetRecordCount(claSqlConnDB.gStrConnDefault, mStrSQL);
            return count;
        }

        //给定退出状态
        public static int GetCancel(int vIntId)
        {
            int voIntReturn;
            string mStrSQL = "update tZPlcDtTemp set dIntDqBz = -1 where dIntDataID = " + vIntId;
            voIntReturn = claSqlConnDB.ExecuteNonQuery(claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL);
            return voIntReturn;
        }

        public  static int GetUpdate()
        {
            int vIntReturn = -1;
            SqlParameter[] mySqlParameter = new SqlParameter[3]
            {
                new SqlParameter("@viDaeGXSJ",SqlDbType.DateTime,16),
                new SqlParameter("@viVchRemark",SqlDbType.VarChar,30),
                new SqlParameter("@voIntReturn",SqlDbType.Int,4)
            };

            //mySqlParameter[0].Value = "";
            //mySqlParameter[1].Value = "";
            mySqlParameter[2].Direction = ParameterDirection.Output;
            claSqlConnDB.ExecuteNonQuery(claSqlConnDB.gStrConnDefault, CommandType.StoredProcedure, "pZPLCClearAdd", mySqlParameter);
            vIntReturn = (int)mySqlParameter[2].Value;
            return vIntReturn;
        }
        public static DataTable GetCjData()
        {
            string mStrSQL = "select * from tZPlcRealTimeData where dIntId = 1";
            return claSqlConnDB.ExecuteDataset(claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL).Tables[0];
        }

    
    }
}
