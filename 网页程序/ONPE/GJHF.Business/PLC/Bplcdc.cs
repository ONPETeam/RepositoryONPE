using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using Newtonsoft.Json;

namespace GJHF.Business.PLC
{
    public class Bplcdc
    {
        
        public static DataTable GetData(int rows, int pages, string vStrWhere)
        {
            DataTable dt = null;
            dt =  Data.MSSQL.PLC.Dplcdc.GetData(rows, pages, vStrWhere);
            return dt;
        }

        public static int GetRecordCount(string vStrWhere)
        {
            int count = 0;
            count = Data.MSSQL.PLC.Dplcdc.GetRecordCount(vStrWhere);
            return count;
        }
        public static DataTable GetComboData(string vStrWhere)
        {
            DataTable dt = null;
            dt = Data.MSSQL.PLC.Dplcdc.GetComboData(vStrWhere);
            return dt;
        }
        public static void AddData(string vStrGzName, string vStrGzXx, string vStrGzyy, string vStrGzCL, int vIntGzType, out int voIntReturn)
        {
            Data.MSSQL.PLC.Dplcdc.AddData(vStrGzName, vStrGzXx, vStrGzyy, vStrGzCL, vIntGzType, out voIntReturn);
        }

        public static void EditData(int vIntGzID, string vStrGzName, string vStrGzXx, string vStrGzyy, string vStrGzCL, int vIntGzType, out int voIntReturn)
        {
            Data.MSSQL.PLC.Dplcdc.EditData(vIntGzID, vStrGzName, vStrGzXx, vStrGzyy, vStrGzCL, vIntGzType, out voIntReturn);
        }
        public static void DelData(int vIntGzID, out int voIntReturn)
        {
            Data.MSSQL.PLC.Dplcdc.DelData(vIntGzID,out voIntReturn);
        }
    }
}
