using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using System.Data.SqlClient;

namespace GJHF.Data.MSSQL.PLC
{
    public class DPlcPushTemp
    {
        public static DataTable GetPushOneData()
        {
            DataTable dt = null;
//            string mStrSQL = @"select top (1)  tZplcPushTemp.dIntDataID,tZplcPushTemp.dVchCjdz,tZplcPushTemp.dVchValue,
//                                            tZplcPushTemp.dDeaSysTime,tZplcPushTemp.dIntDqbz,tZPlcHistoryJK.dVchAdress,tZPlcHistoryJK.dVchName  
//                                            from tZplcPushTemp left outer join tZPlcHistoryJK on tZplcPushTemp.dVchCjdz = tZPlcHistoryJK.dVchCjdz ";

            string mStrSQL = @"SELECT   TOP (1)  id, dVchCjdz, dVchPushMsg, dDeaSystime, dVchRemark  FROM  tZplcPushMsgTemp order by id";
            dt = claSqlConnDB.ExecuteDataset(claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL).Tables[0];
            return dt;

        }
        public static DataTable GetPushData()
        {
            DataTable dt = null;
            string mStrSQL = @"select   tZplcPushTemp.dIntDataID,tZplcPushTemp.dVchCjdz,tZplcPushTemp.dVchValue,
                                            tZplcPushTemp.dDeaSysTime,tZplcPushTemp.dIntDqbz,tZPlcHistoryJK.dVchAdress,tZPlcHistoryJK.dVchName,
                                            tZplcPushTemp.dIntDqbz,tZplcPushTemp.dIntTsbz,dIntCount
                                            from tZplcPushTemp left outer join tZPlcHistoryJK on tZplcPushTemp.dVchCjdz = tZPlcHistoryJK.dVchCjdz ";
            dt = claSqlConnDB.ExecuteDataset(claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL).Tables[0];
            return dt;
        }

        public static int GetDelete(int vIntDataID)
        {
            int result = 0;
            string mStrSQL = "delete from tZplcPushMsgTemp where id = " + vIntDataID + "";
            result = claSqlConnDB.ExecuteNonQuery(claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL);
            return result;
        }

        //查找推送人员
        public static DataTable  GetTsPeople(string vStrCjdz)
        {
            DataTable dt = null;
            string mStrSQL = "SELECT  dIntDataID, dIntdizhiID, dVchCjdz, employee_code FROM tZPlcddzAndPeopleMore where dVchCjdz = '" + vStrCjdz + "'";
            dt = claSqlConnDB.ExecuteDataset(claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL).Tables[0];
            return dt;
        }

        public static DataTable GetData(int rows,int pages,string vStrWhere)
        {
            DataTable dt = null;
            string mStrSQL = "SELECT dIntID, dVchpdMsg, dDeaGxTime, dVchRemark FROM tPLCpdmsgLs " + vStrWhere + " ORDER BY dIntID DESC";
            dt = claSqlConnDB.ExecuteDataset(rows,pages,claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL).Tables[0];
            return dt;
        }

        public static int GetRecord(string vStrWhere)
        {
            int count = 0;
            string mStrSQL = "select count(*) from tPLCpdmsgLs " + vStrWhere;
            count = claSqlConnDB.GetRecordCount(claSqlConnDB.gStrConnDefault,mStrSQL);
            return count;
        }

        public static int GetTsEnd(string vStrAllAddress ,int vIntState)
        {
            int voIntReturn = 0;
            string mStrSQL = "update  tZplcPushTemp set dIntCount = "+vIntState +" where dVchCjdz = '"+ vStrAllAddress + "'";
            voIntReturn = claSqlConnDB.ExecuteNonQuery(claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL);
            return voIntReturn;
        }
        //报警与推送关系表
        public static DataTable GetAlermAndPushData(int rows, int pages, string vStrWhere)
        {
            DataTable dt = null;
            string mStrSQL = "select * from tZplcAlermData left outer join tZPlcAlermAndPush on tZplcAlermData.dIntid = tZPlcAlermAndPush.dIntAlermid " + vStrWhere;
            dt = claSqlConnDB.ExecuteDataset(rows,pages,claSqlConnDB.gStrConnDefault,CommandType.Text,mStrSQL).Tables[0];
            return dt;
        }
            

    }
}
