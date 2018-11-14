using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using System.Data.SqlClient;
using System.Data.Entity;
using GJHF.Data.Model.PLC;

namespace GJHF.Business.PLC
{
    public class BPlcPushTemp
    {
        ONPE_SJEntitiesModel contextDB = new ONPE_SJEntitiesModel();
        public static DataTable  GetPushOneData()
        {
            DataTable dt = null;
            dt = GJHF.Data.MSSQL.PLC.DPlcPushTemp.GetPushOneData();
            return dt;
        }
        public static DataTable GetPushData()
        {
            return GJHF.Data.MSSQL.PLC.DPlcPushTemp.GetPushData();
        }
        public static bool DelData(int vIntDataID, out string msg)
        {
            bool isSuccess = false;
            msg = "失败";
            if (GJHF.Data.MSSQL.PLC.DPlcPushTemp.GetDelete(vIntDataID) >= 0)
            {
                isSuccess = true;
                msg = "成功";
            }
            return isSuccess;
        }

        public static string GetTsPeople(string vStrCjdz)
        {
            string mStrTsPeople = "";
            DataTable dt = null;
            dt = GJHF.Data.MSSQL.PLC.DPlcPushTemp.GetTsPeople(vStrCjdz);
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                mStrTsPeople = mStrTsPeople + dt.Rows[i][3].ToString() + ",";
            }
            if (mStrTsPeople.Length > 0)
            {
                mStrTsPeople = mStrTsPeople.Remove(mStrTsPeople.Length - 1, 1);
            }
            return mStrTsPeople;
        }

        public static DataTable GetData(int rows, int pages, string vStrWhere)
        {
            return GJHF.Data.MSSQL.PLC.DPlcPushTemp.GetData(rows,pages,vStrWhere);
        }
        public static int GetRecord(string vStrWhere)
        {
            return GJHF.Data.MSSQL.PLC.DPlcPushTemp.GetRecord(vStrWhere);
        }
        public static int GetTsEnd(string vStrAllAddress, int vIntState)
        {
            return GJHF.Data.MSSQL.PLC.DPlcPushTemp.GetTsEnd(vStrAllAddress,vIntState);
        }

        public  List<tZPlcPointDiZhi> GetdzNameEF(string vStrCjdz)
        {
            List<tZPlcPointDiZhi> mlist = new List<tZPlcPointDiZhi>();
            var data = (from u in contextDB.tZPlcPointDiZhi
                               where u.dVchAllAdress == vStrCjdz
                               select u).Take(1);
            
            foreach(var aa in data)
            {
                mlist.Add(aa);
            }
            return mlist;
            
        }

        public static DataTable GetAlermAndPushData(int rows, int pages,string vStrBeginTime,string vStrEndTime,string vStrCjdz)
        {
            string lStrWhere = "where tZplcAlermData.dIntid <> -1 ";
            if (!string.IsNullOrEmpty(vStrCjdz))
            {
                lStrWhere = lStrWhere + " and dVchCjdz = '" + vStrCjdz + "'";
            }
            if (!string.IsNullOrEmpty(vStrBeginTime))
            {
                lStrWhere = lStrWhere + " and dDeaSysTime > '" + vStrBeginTime + "'";
            }
            if (!string.IsNullOrEmpty(vStrEndTime))
            {
                lStrWhere = lStrWhere + " and dDeaSysTime < '" + vStrEndTime + "'";
            }
            string lStrOrder = "  order by dDeaSysTime desc";
            return GJHF.Data.MSSQL.PLC.DPlcPushTemp.GetAlermAndPushData(rows, pages, lStrWhere + lStrOrder);
        }

    }
}
