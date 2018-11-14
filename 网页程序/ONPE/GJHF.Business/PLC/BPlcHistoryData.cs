using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;

namespace GJHF.Business.PLC
{
    public class BPlcHistoryData
    {
        public DataTable GetData(int rows, int pages, string vStrWhere)
        {
            return GJHF.Data.MSSQL.PLC.DPlcHistoryData.GetData(rows,pages,vStrWhere);
        }

        public static DataTable GetData(int vIntDataid)
        {
            return GJHF.Data.MSSQL.PLC.DPlcHistoryData.GetData(vIntDataid);
        }

        public static bool AddData(string vStrAllAdress, string vStrAdressName, string vStrAddress, int vIntDataType, int vIntGongType, int vIntIsCollect, int vIntCollectSec, int vIntCollectType, int vIntCollectIndex,out string mStrMsg)
        {
            bool isSuccess = false;
            mStrMsg = "失败";
            try
            {
                int voIntReturn = GJHF.Data.MSSQL.PLC.DPlcHistoryData.AddData( vStrAllAdress,  vStrAdressName,  vStrAddress,  vIntDataType,  vIntGongType,  vIntIsCollect,  vIntCollectSec,  vIntCollectType,  vIntCollectIndex);
                if (voIntReturn >= 0)
                {
                    isSuccess = true;
                    mStrMsg = "成功";
                }
                return isSuccess;
            }
            catch (Exception eee)
            {
                isSuccess = false;
                mStrMsg = eee.ToString();
                return isSuccess;
            }
        }

        public static bool EditData(int vIntHistoryDataSet_Cloudid,string vStrAllAdress, string vStrAdressName, string vStrAddress, int vIntDataType, int vIntGongType, int vIntIsCollect, int vIntCollectSec, int vIntCollectType, int vIntCollectIndex, out string mStrMsg)
        {
            bool isSuccess = false;
            mStrMsg = "失败";
            try
            {
                int voIntReturn = GJHF.Data.MSSQL.PLC.DPlcHistoryData.EditData(vIntHistoryDataSet_Cloudid, vStrAllAdress, vStrAdressName, vStrAddress, vIntDataType, vIntGongType, vIntIsCollect, vIntCollectSec, vIntCollectType, vIntCollectIndex);
                if (voIntReturn >= 0)
                {
                    isSuccess = true;
                    mStrMsg = "成功";
                }
                return isSuccess;
            }
            catch (Exception eee)
            {
                isSuccess = false;
                mStrMsg = eee.ToString();
                return isSuccess;
            }
        }

        public static bool DelData(int vIntCollectIndex, out string mStrMsg)
        {
            bool isSuccess = false;
            mStrMsg = "失败";
            try
            {
                int voIntReturn = GJHF.Data.MSSQL.PLC.DPlcHistoryData.DelData(vIntCollectIndex);
                if (voIntReturn >= 0)
                {
                    isSuccess = true;
                    mStrMsg = "成功";
                }
                return isSuccess;
            }
            catch (Exception eee)
            {
                isSuccess = false;
                mStrMsg = eee.ToString();
                return isSuccess;
            }
        }
    }
}
