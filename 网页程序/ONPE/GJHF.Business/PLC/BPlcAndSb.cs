using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using System.Data.SqlClient;

namespace GJHF.Business.PLC
{
    public class BPlcAndSb
    {
        public static DataTable GetCombobox(string vStreqd)
        {
            DataTable dt = null;
            string aaa = "";
            string mStrWhere = " where dVchPLCAddress <> '-10'";
            if (vStreqd != "")
            {
                mStrWhere = mStrWhere + " and dVchSbBianHao = '" + vStreqd + "'";
            }
            else
            {
                mStrWhere = mStrWhere + " and dVchSbBianHao = '-10'" + aaa;
            }
            dt = GJHF.Data.MSSQL.PLC.DPlcAndSb.GetCombobox(mStrWhere);
            return dt;
        }
        public static bool AddData(string vStrSbBianHao, string vStrPLCAddress,out string msg)
        {
            bool isSuccess = false;
            msg = "失败";
            if (GJHF.Data.MSSQL.PLC.DPlcAndSb.AddData(vStrSbBianHao, vStrPLCAddress) >=0)
            {
                isSuccess = true;
                msg = "成功";
            }
            return isSuccess;
        }

        public static bool DelData(string vStrSbBianHao, string vStrPLCAddress,out string msg)
        {
            bool isSuccess = false;
            msg = "失败";
            if (GJHF.Data.MSSQL.PLC.DPlcAndSb.DelData(vStrSbBianHao, vStrPLCAddress) >=0)
            {
                isSuccess = true;
                msg = "成功";
            }
            return isSuccess;
        }

        public static  bool DelBindAll(string vStrPLCAddress, out string msg)
        {
            bool isSuccess = false;
            msg = "失败";
            if (GJHF.Data.MSSQL.PLC.DPlcAndSb.DelBindAll(vStrPLCAddress) >=0)
            {
                isSuccess = true;
                msg = "成功";
            }
            return isSuccess;
        }

        public static DataTable GetGrid(int rows,int page,string vStrddz)
        {
            DataTable dt = null;
            string mStrWhere = "";
            string mStrOrder = "  order by dIntID";
            if (vStrddz != "")
            {
                mStrWhere = mStrWhere + " and dVchPLCAddress = '" + vStrddz + "'";
            }
            dt = GJHF.Data.MSSQL.PLC.DPlcAndSb.GetGrid(rows, page, mStrWhere + mStrOrder);
            return dt;
        }

        public static int GetRecord(string vStrddz)
        {
            int count = 0;
            string mStrWhere = " where dVchPLCAddress <> 'aaasdfasd111'";
            if(vStrddz != "")
            {
                mStrWhere = mStrWhere + " and dVchPLCAddress = '" + vStrddz + "'";
            }
            count = GJHF.Data.MSSQL.PLC.DPlcAndSb.GetRecord(mStrWhere);
            return count;
        }

        public static DataTable GetGridbd(int rows, int page, string vStreqd)
        {
            DataTable dt = null;
            string mStrWhere = " where dVchSbBianHao <> '1111122223'";
            string mStrOrder = " order by dIntID";
            if (vStreqd != "")
            {
                mStrWhere = mStrWhere + " and dVchSbBianHao = '" + vStreqd + "'";
            }
            dt = GJHF.Data.MSSQL.PLC.DPlcAndSb.GetGridbd(rows, page, mStrWhere);
            return dt;
        }

        public static int GetRecordbd(string vStreqd)
        {
            int count = 0;
            string mStrWhere = "where dVchSbBianHao <> '11123123123'";
            if (vStreqd != "")
            {
                mStrWhere = mStrWhere + " and dVchSbBianHao = '" + vStreqd + "'"; 
            }

            count = GJHF.Data.MSSQL.PLC.DPlcAndSb.GetRecordbd(mStrWhere);
            return count;
        }

        public static bool Delid(string vid,out string msg)
        {
            bool isSuccess = false;
            msg = "失败";
            if (GJHF.Data.MSSQL.PLC.DPlcAndSb.Delid(vid) >= 0)
            {
                isSuccess = true;
                msg = "成功!";
            }

            return isSuccess;
        }

    }
}
