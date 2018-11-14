using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;

namespace GJHF.Data.MSSQL.PLC
{
    public class DPlcFactory
    {
        public static DataTable GetComboxData(string vStrWhere)
        {
            string mStrSQL = "select dVchFactoryCode,dVchFactoryName from tZPlcFactory " + vStrWhere;
            DataTable dt = claSqlConnDB.ExecuteDataset(claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL).Tables[0];
            return dt;
        }

        public static int GetRecordCombox(string vStrWhere)
        {
            string mStrSQL = "select count(*) from tZPlcFactory " + vStrWhere;
            int count = claSqlConnDB.GetRecordCount(claSqlConnDB.gStrConnDefault, mStrSQL);
            return count;
        }

        public static DataTable GetAreaComboxData(string vStrWhere)
        {
            string mStrSQL = @"SELECT  dIntAreaID, dVchArea, dIntSJAreaID FROM  tZPLCArea " + vStrWhere;
            DataTable dt = claSqlConnDB.ExecuteDataset(claSqlConnDB.gStrConnDefault,CommandType.Text,mStrSQL).Tables[0];
            return dt;
        }

    }
}
