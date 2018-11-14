using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using System.Data.SqlClient;

namespace GJHF.Business.PLC
{
    //业务逻辑层（BLL）对传送数据进行逻辑判断分折，并进行传送正确的值。 
    public class BPlcArea
    {
        public static DataTable GetData(int rows, int pages, string vStrSArea)
        {
            string mStrWhere = " where dIntAreaID <> -1";
            string mStrOrd = " order by dIntAreaID";
            if (string.IsNullOrEmpty(vStrSArea) == false)
            {
                mStrWhere = mStrWhere + " and dIntAreaID in (" + vStrSArea + ")";
            }
            return GJHF.Data.MSSQL.PLC.DPlcArea.GetData(rows, pages, mStrWhere + mStrOrd);
        }

        public static int GetRecordCount(string  vStrSArea)
        {
            string mStrWhere = " where dIntAreaID <> -1";
            
            if (string.IsNullOrEmpty(vStrSArea) == false)
            {
                mStrWhere = mStrWhere + " and dIntAreaID in (" + vStrSArea + ")";
            }
            return GJHF.Data.MSSQL.PLC.DPlcArea.GetRecordCount(mStrWhere);
        }
        //public static string GetWhere()
        //{
 
        //}
        //当有相同的数值也需要判断
        public static bool AddData(string vStrArea, int vIntSJAreaID, int vIntPx,out string msg)
        {
            
            bool isSuccess = false;
            msg = "失败";
            if (GJHF.Data.MSSQL.PLC.DPlcArea.AddData(vStrArea, vIntSJAreaID, vIntPx) >= 0)
            {
                isSuccess = true;
                msg = "成功";
            }

            return isSuccess;
        }
        public static bool EditData(int vIntAreaID, string vStrArea, int vIntSJAreaID, int vIntPx, out string msg)
        {
            bool isSuccess = false;
            msg = "失败";
            if (GJHF.Data.MSSQL.PLC.DPlcArea.EditData(vIntAreaID, vStrArea, vIntSJAreaID, vIntPx) >= 0)
            {
                isSuccess = true;
                msg = "成功";
            }
            return isSuccess;
        }

        public static bool DelData(int vIntAreaID,out string msg)
        {
            bool isSuccess = false;
            msg = "失败";
            if (GJHF.Data.MSSQL.PLC.DPlcArea.DelData(vIntAreaID) >= 0)
            {
                isSuccess = true;
                msg = "成功";
            }
            return isSuccess;
        }
    }
}
