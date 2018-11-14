using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;

namespace GJHF.Business.PLC
{
    public class BPlcAndFile
    {
        public static DataTable GetData(int rows,int pages,string vStrddz)
        {
            DataTable dt = null;
            string mStrWhere = "";
            string mStrOrder = "";

            if (vStrddz != "")
            {
                mStrWhere = mStrWhere + " and dVchPLCAddress = '" + vStrddz + "'";
            }
            mStrOrder = "  order by dIntID";
            dt = GJHF.Data.MSSQL.PLC.DPlcAndFile.GetData(rows, pages, mStrWhere + mStrOrder);
            return dt;
        }

        public static int GetRecord(string vStrddz)
        {
            int count = 0;
            string mStrWhere = "";
            if (vStrddz != "")
            {
                mStrWhere = mStrWhere + " and dVchPLCAddress = '" + vStrddz + "'";
            }
            count = GJHF.Data.MSSQL.PLC.DPlcAndFile.GetRecord(mStrWhere);
            return count;
        }
    }
}
