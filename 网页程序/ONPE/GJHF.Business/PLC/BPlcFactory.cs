using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;

namespace GJHF.Business.PLC
{
    public class BPlcFactory
    {
        public static DataTable GetComboxData(string vStrWhere)
        {
            return GJHF.Data.MSSQL.PLC.DPlcFactory.GetComboxData(vStrWhere);
        }
        public static int GetComboxRecord(string vStrWhere)
        {
            return GJHF.Data.MSSQL.PLC.DPlcFactory.GetRecordCombox(vStrWhere);
        }
        public static DataTable GetAreaComboxData(string vStrWhere)
        {
            return GJHF.Data.MSSQL.PLC.DPlcFactory.GetAreaComboxData(vStrWhere);
        }
    }
}
