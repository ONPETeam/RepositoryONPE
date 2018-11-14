using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;

namespace GJHF.Business.PLC
{
    public  class BPlcNetXr
    {
        public static DataTable GetData(int rows,int pages,string vStrWhere)
        {
            return GJHF.Data.MSSQL.PLC.DPlcNetXr.GetData(rows, pages, vStrWhere);
        }
        public static int GetRecord(string vStrWhere)
        {
            return GJHF.Data.MSSQL.PLC.DPlcNetXr.GetRecord(vStrWhere);
        }

        public static bool GetNetDis()
        {
            bool isSuccess = false;
            DataTable dt = GJHF.Data.MSSQL.PLC.DPlcNetXr.GetOneData("");
            TimeSpan ts;
            if (dt.Rows.Count > 0)
            {
                DateTime sdt = DateTime.Parse(dt.Rows[0]["dDaeGengxinTime"].ToString());
                if (string.IsNullOrEmpty(dt.Rows[0]["dDaeGengxinTime"].ToString()) == false)
                {
                    ts = System.DateTime.Now - sdt;
                    if (ts.TotalSeconds > 120.0)
                    {
                        isSuccess = true;
                    }
                }
            }
            return isSuccess;
        }

        public static bool SetTsState(int vIntTsState)
        {
            bool isSuccess = false;
            if (GJHF.Data.MSSQL.PLC.DPlcNetXr.SetTsState(vIntTsState) >= 0)
            {
                isSuccess = true;
            }
            return isSuccess;
        }
    }
}
