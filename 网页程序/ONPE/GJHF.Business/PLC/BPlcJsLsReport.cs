using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;

namespace GJHF.Business.PLC
{
    public class BPlcJsLsReport
    {
        public static DataTable GetData(int rows, int pages, string vStrWhere)
        {
            return GJHF.Data.MSSQL.PLC.DPlcJsLsReport.GetData(rows,pages,vStrWhere);
        }

        public static bool AddData(string vStrName,int vIntHistoryReport_A, string vStrHistoryReport_A, string vStrHistoryReport_A_Value, int vIntHistoryReport_B, string vStrHistoryReport_B, string vStrHistoryReport_B_Value, int vIntHistoryReport_C, string vStrHistoryReport_C, string vStrHistoryReport_C_Value, string vStrFormula, string vStrValue, string vStrUser, int vIntRead,out string mStrMsg)
        {
            bool isSuccess = false;
            mStrMsg = "执行失败";
            int voIntReturn = -1;
            try
            {
                voIntReturn = GJHF.Data.MSSQL.PLC.DPlcJsLsReport.AddData(vStrName,vIntHistoryReport_A, vStrHistoryReport_A, vStrHistoryReport_A_Value, vIntHistoryReport_B, vStrHistoryReport_B, vStrHistoryReport_B_Value, vIntHistoryReport_C, vStrHistoryReport_C, vStrHistoryReport_C_Value, vStrFormula, vStrValue, vStrUser, vIntRead);
                if (voIntReturn >= 0)
                {
                    isSuccess = true;
                    mStrMsg = "执行成功!";
                }

                return isSuccess;
            }
            catch (Exception eee)
            {
                mStrMsg = eee.ToString();
                return false;
            }
            
        }

        public static bool EditData(int vIntDataID,string vStrName, int vIntHistoryReport_A, string vStrHistoryReport_A, string vStrHistoryReport_A_Value, int vIntHistoryReport_B, string vStrHistoryReport_B, string vStrHistoryReport_B_Value, int vIntHistoryReport_C, string vStrHistoryReport_C, string vStrHistoryReport_C_Value, string vStrFormula, string vStrValue, string vStrUser, int vIntRead,out string mStrMsg)
        {
            bool isSuccess = false;
            mStrMsg = "执行失败";
            int voIntReturn = -1;
            try
            {
                voIntReturn = GJHF.Data.MSSQL.PLC.DPlcJsLsReport.EditData(vIntDataID, vStrName,vIntHistoryReport_A, vStrHistoryReport_A, vStrHistoryReport_A_Value, vIntHistoryReport_B, vStrHistoryReport_B, vStrHistoryReport_B_Value, vIntHistoryReport_C, vStrHistoryReport_C, vStrHistoryReport_C_Value, vStrFormula, vStrValue, vStrUser, vIntRead);
                if (voIntReturn >= 0)
                {
                    isSuccess = true;
                    mStrMsg = "执行成功!";
                }

                return isSuccess;
            }
            catch (Exception eee)
            {
                mStrMsg = eee.ToString();
                return false;
            }
        }

        public static bool DelData(int vIntDataID, out string mStrMsg)
        {
            bool isSuccess = false;
            mStrMsg = "执行失败";
            int voIntReturn = -1;
            try
            {
                voIntReturn = GJHF.Data.MSSQL.PLC.DPlcJsLsReport.DelData(vIntDataID);
                if (voIntReturn >= 0)
                {
                    isSuccess = true;
                    mStrMsg = "执行成功!";
                }

                return isSuccess;
            }
            catch (Exception eee)
            {
                mStrMsg = eee.ToString();
                return false;
            }
        }

        public static DataTable GetCombogrid(string vStrWhere)
        {
            return GJHF.Data.MSSQL.PLC.DPlcJsLsReport.GetCombogrid(vStrWhere);
        }
    }
}
