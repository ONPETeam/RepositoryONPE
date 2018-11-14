using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;

namespace GJHF.Data.MSSQL.PLC
{
    public class DPlcAndFile
    {
        public static DataTable GetData(int rows,int pages,string vStrWhere)
        {
            DataTable dt = null;
            string mStrSQL = @"select dIntID,dVchSbBianHao,dVchPLCAddress,t_EquipFile.equip_code,t_File.file_code,file_name,file_type,file_size,file_time,file_people,file_context  from tZSbAndPLC left outer join t_EquipFile on  tZSbAndPLC.dVchSbBianHao = t_EquipFile.equip_code 
                                             left outer join t_File on t_EquipFile.file_code = t_File.file_code" + vStrWhere;
            dt = claSqlConnDB.ExecuteDataset(rows, pages, claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL).Tables[0];
            return dt;
        }

        public static int GetRecord(string vStrWhere)
        {
            int count = 0;
            string mStrSQL = @"select count(*)  from tZSbAndPLC left outer join t_EquipFile on  tZSbAndPLC.dVchSbBianHao = t_EquipFile.equip_code 
                                             left outer join t_File on t_EquipFile.file_code = t_File.file_code" + vStrWhere;
            count = claSqlConnDB.GetRecordCount(claSqlConnDB.gStrConnDefault,mStrSQL);
            return count;
        }
    }
}
