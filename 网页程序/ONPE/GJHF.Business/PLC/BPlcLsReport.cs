using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;

namespace GJHF.Business.PLC
{
    public class BPlcLsReport
    {
        public static DataTable GetData(int rows, int pages, string vStrUser)
        {
            string mStrWhere = "where dIntHistoryReportRequestId <> -1";
            if (!string.IsNullOrEmpty(vStrUser))
            {
                mStrWhere = mStrWhere + " and dVchUser = '" + vStrUser + "'";
            }
            return GJHF.Data.MSSQL.PLC.DPlcLsReport.GetData(rows, pages, mStrWhere);
        }

        public static bool AddData(string vDeaStartTime, string vDeaEndTime, string vStrName,int vIntCjdzId,string vStrAddress, string vStrCjdz, int vIntalgorithm, string vStrValue, string vStrUser, int vIntRead,out string mStrMsg)
        {
            bool isSuccess = false;
            mStrMsg = "执行失败";
            int voIntReturn = -1;
            try
            {
                voIntReturn = GJHF.Data.MSSQL.PLC.DPlcLsReport.AddData(vDeaStartTime, vDeaEndTime, vStrName, vIntCjdzId,vStrAddress, vStrCjdz, vIntalgorithm, vStrValue, vStrUser, vIntRead);
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

        public static bool EditData(int vIntHistoryReportRequestId, string vDeaStartTime, string vDeaEndTime, string vStrName,int vIntCjdzId, string vStrAddress, string vStrCjdz, int vIntalgorithm, string vStrValue, string vStrUser, int vIntRead, out string mStrMsg)
        {
            bool isSuccess = false;
            mStrMsg = "执行失败";
            int voIntReturn = -1;
            try
            {
                voIntReturn = GJHF.Data.MSSQL.PLC.DPlcLsReport.EditData(vIntHistoryReportRequestId, vDeaStartTime, vDeaEndTime, vStrName,vIntCjdzId, vStrAddress, vStrCjdz, vIntalgorithm, vStrValue, vStrUser, vIntRead);
                if (voIntReturn >= 0)
                {
                    isSuccess = true;
                    mStrMsg = "执行成功！";
                }
                return isSuccess;
            }
            catch (Exception eee)
            {
                mStrMsg = eee.ToString();
                return false;
            }

        }

        public static bool DelData(int vIntHistoryReportRequestId, out string mStrMsg)
        {
            bool isSuccess = false;
            mStrMsg = "执行失败";
            int voIntReturn = -1;
            try
            {
                voIntReturn = GJHF.Data.MSSQL.PLC.DPlcLsReport.DelData(vIntHistoryReportRequestId);
                if (voIntReturn >= 0)
                {
                    isSuccess = true;
                    mStrMsg = "执行成功";
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
            DataTable dt = null;
            dt = GJHF.Data.MSSQL.PLC.DPlcLsReport.GetCombogrid(vStrWhere);
            return dt;
        }

        public static bool ChangeReadBiaoshi(int vIntState,out string Msg)
        {
            bool isSuccess = false;
            Msg = "执行失败！";
            try
            {
                if (GJHF.Data.MSSQL.PLC.DPlcLsReport.ChangeReadBiaoshi(vIntState) >= 0)
                {
                    isSuccess = true;
                    Msg = "执行成功！";
                }
                return isSuccess;
            }
            catch (Exception eee)
            {
                return isSuccess;
                Msg = eee.ToString();
            }
        }
            
            
        

    }
}
