using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;

namespace GJHF.Business.PLC
{
    public class BPlcTsHistory
    {
        public static DataTable GetData(int rows, int pages, string vStrWhere)
        {
            return GJHF.Data.MSSQL.PLC.DPlcTsHistory.GetData(rows,pages,vStrWhere);
        }

        public static int GetRecord(string vStrWhere)
        {
            return GJHF.Data.MSSQL.PLC.DPlcTsHistory.GetRecord(vStrWhere);
        }

        public static bool AddData(string vStrTsContent, string vStrTsPeople, int vIntTsType, DateTime vDeaTsDate, string vStrRemark, out string msg)
        {
            bool isSuccess = false;
            msg = "失败";
            if (GJHF.Data.MSSQL.PLC.DPlcTsHistory.AddData(vStrTsContent, vStrTsPeople, vIntTsType, vDeaTsDate, vStrRemark) >= 0)
            {
                isSuccess = true;
                msg = "成功";
            }
            return isSuccess;
        }

        public static bool EditData(int vIntTsId, string vStrTsContent, string vStrTsPeople, int vIntTsType, DateTime vDeaTsDate, string vStrRemark,out string msg)
        {
            bool isSuccess = false;
            msg = "失败";
            if (GJHF.Data.MSSQL.PLC.DPlcTsHistory.EditData(vIntTsId, vStrTsContent, vStrTsPeople, vIntTsType, vDeaTsDate, vStrRemark) >= 0)
            {
                isSuccess = true;
                msg = "成功";
            }

            return isSuccess;
        }

        public static bool DelData(int vIntTsId, out string msg)
        {
            bool isSuccess = false;
            msg = "失败";
            if (GJHF.Data.MSSQL.PLC.DPlcTsHistory.DelData(vIntTsId) >= 0)
            {
                isSuccess = true;
                msg = "成功";
            }
            return isSuccess;
        }
    }
}
