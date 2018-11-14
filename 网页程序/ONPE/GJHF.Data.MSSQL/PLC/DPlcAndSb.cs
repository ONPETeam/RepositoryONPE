using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using System.Data.SqlClient;

namespace GJHF.Data.MSSQL.PLC
{
    public class DPlcAndSb
    {
        public static  DataTable  GetCombobox(string vStrWhere)
        {
            DataTable dt = null;
            string mStrSQL = @"select dVchPLCAddress, tZPlcPointDiZhi.dVchAddress,tZPlcPointDiZhi.dVchAdressName,tZPlcPointDiZhi.dVchAllAdress, tZPlcPointDiZhi.dVchDescription,tZPLCManager.dVchPLCName + '-' + dVchIPAdress as plcqm,
                                                            tZPlcFactory.dVchFactoryName,tZPLCManager.dVchFactoryCode,tZPLCManager.dVchPLCbianma,dFltMoniMax,dFltMoniMin,dFltSjMax,dFltSjMin,tZPLCManager.dVchFwqdh,tZPlcPointDiZhi.dIntDataID,dVchDataType,tZPlcPointDiZhi.dIntJsBz,dVchFormula
                                                            from tZSbAndPLC 
                                                            left outer join tZPlcPointDiZhi on tZSbAndPLC.dVchPLCAddress = tZPlcPointDiZhi.dIntDataID 
                                                            left outer join tZPLCManager on tZPlcPointDiZhi.dIntPLCID = tZPLCManager.dIntPLCID 
                                                            left outer join tZPlcFactory on tZPLCManager.dVchFactoryCode = tZPlcFactory.dVchFactoryCode 
                                                            left outer join  tZPLCVariableFormula on tZPlcPointDiZhi.dVchAllAdress = tZPLCVariableFormula.dVchVariable " + vStrWhere;
            dt = claSqlConnDB.ExecuteDataset(claSqlConnDB.gStrConnDefault,CommandType.Text,mStrSQL).Tables[0];
            return dt;
        }
        public static int AddData(string vStrSbBianHao, string vStrPLCAddress)
        {
            int voIntReturn;
            SqlParameter[] l0lcParameter = new SqlParameter[3]
            {
                new SqlParameter("@viVchSbBianHao",SqlDbType.VarChar,30),
                new SqlParameter("@viVchPLCAddress",SqlDbType.VarChar,30),
                new SqlParameter("@voIntReturn",SqlDbType.Int,4),
            };
            l0lcParameter[0].Value = vStrSbBianHao;
            l0lcParameter[1].Value = vStrPLCAddress;
            l0lcParameter[2].Direction = System.Data.ParameterDirection.Output;
            claSqlConnDB.ExecuteNonQuery(claSqlConnDB.gStrConnDefault, CommandType.StoredProcedure, "pZSbAndPLCAdd", l0lcParameter);
            voIntReturn = (int)l0lcParameter[2].Value;
            return voIntReturn;
        }



        public static int DelData(string vStrSbBianHao, string vStrPLCAddress)
        {
            int voIntReturn;
            SqlParameter[] myParameter = new SqlParameter[3]
            {
                new SqlParameter("@viVchSbBianHao",SqlDbType.VarChar,30),
                new SqlParameter("@viVchPLCAddress",SqlDbType.VarChar,30),
                new SqlParameter("@voIntReturn",SqlDbType.Int,4)
            };
            myParameter[0].Value = vStrSbBianHao;
            myParameter[1].Value = vStrPLCAddress;
            myParameter[2].Direction = System.Data.ParameterDirection.Output;
            claSqlConnDB.ExecuteNonQuery(claSqlConnDB.gStrConnDefault, CommandType.StoredProcedure, "pZSbAndPLCDel", myParameter);
            voIntReturn = (int)myParameter[2].Value;
            return voIntReturn;
        }

        public static  int DelBindAll(string vStrPLCAddress)
        {
            int voIntReturn = 0;
            SqlParameter[] myParameter = new SqlParameter[2]
            {
                new SqlParameter("@viVchPLCAddress",SqlDbType.VarChar,30),
                new SqlParameter("@voIntReturn",SqlDbType.Int,4)
            };

            myParameter[0].Value = vStrPLCAddress;
            myParameter[1].Direction = System.Data.ParameterDirection.Output;
            claSqlConnDB.ExecuteNonQuery(claSqlConnDB.gStrConnDefault, CommandType.StoredProcedure, "pZSbAndPLCAllDel", myParameter);
            voIntReturn = (int)myParameter[1].Value;
            return voIntReturn;
        }

        public static DataTable GetGrid(int rows,int page,string vStrWhere)
        {
            DataTable dt = null;
            string mStrSQL = @"select dIntID,dVchSbBianHao,dVchPLCAddress,equip_code,equip_innum,equip_name,equip_mark,equip_type,equip_parent,
                            t_Equips.area_id,t_EquipArea.area_name  from tZSbAndPLC left outer join t_Equips on  tZSbAndPLC.dVchSbBianHao = t_Equips.equip_code 
                            left outer join t_EquipArea on t_Equips.area_id = t_EquipArea.area_id" + vStrWhere;

            dt = claSqlConnDB.ExecuteDataset(rows,page,claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL).Tables[0];
            return dt;
        }

        public static int GetRecord(string vStrWhere)
        {
            int count = 0;
            string mStrSQL = "select count(*) from tZSbAndPLC " + vStrWhere;
            count = claSqlConnDB.GetRecordCount(claSqlConnDB.gStrConnDefault, mStrSQL);
            return count;
        }

        public static DataTable GetGridbd(int rows, int page, string vStrWhere)
        {
            DataTable dt = null;
            string mStrSQL = @"SELECT  dIntID, dVchSbBianHao, dVchPLCAddress,tZPlcPointDiZhi.dVchAddress,tZPlcPointDiZhi.dVchAdressName,
                            tZPlcPointDiZhi.dVchDescription,dIntBaojingType,dVchDataValue FROM   tZSbAndPLC left outer join tZPlcPointDiZhi on tZSbAndPLC.dVchPLCAddress =   tZPlcPointDiZhi.dIntDataID 
                            left outer join tZPLCNowData on tZSbAndPLC.dVchPLCAddress = tZPLCNowData.dIntdizhiID" + vStrWhere;

            dt = claSqlConnDB.ExecuteDataset(claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL).Tables[0];
            return dt;
        }

        public static int GetRecordbd(string vStrWhere)
        {
            int count = 0;
            string mStrSQL = "select count(*) from tZSbAndPLC " + vStrWhere;
            count = claSqlConnDB.GetRecordCount(claSqlConnDB.gStrConnDefault, mStrSQL);
            return count;
        }

        public static int Delid(string vid)
        {
            int voIntReturn = -1;
            string mStrSQL = "delete from tZSbAndPLC where dIntID=@mIntbd";
            SqlParameter [] mySqlParameter = new SqlParameter[1]
            {
                new SqlParameter("@mIntbd",vid)
            };
            voIntReturn = claSqlConnDB.ExecuteNonQuery(claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL, mySqlParameter);
            return voIntReturn;
        }
    }
}
