using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;

namespace GJHF.Business.PLC
{
    public class BPlcPointType
    {
        GJHF.Data.MSSQL.PLC.DPlcPointType mDPlcPointType = new Data.MSSQL.PLC.DPlcPointType();
        //业务逻辑层（BLL）对传送数据进行逻辑判断分折，并进行传送正确的值。 
        public static DataTable GetData(int rows, int pages, string vStrSArea, string vStrXTN)
        {
            string mStrWhere = " where dIntNoteID <> 1";
            string mStrOrd = " order by dIntSjNoteID,dIntPx";
            if (string.IsNullOrEmpty(vStrSArea) == false)
            {
                mStrWhere = mStrWhere + " and dIntSjNoteID in (" + vStrSArea + ")";
            }
            if (string.IsNullOrEmpty(vStrXTN) == false)
            {
                mStrWhere = mStrWhere + " and dIntNoteID in (" + vStrXTN + ")";
            }
            return GJHF.Data.MSSQL.PLC.DPlcPointType.GetData(rows, pages, mStrWhere + mStrOrd);
        }

        public static int GetRecordCount(string vStrSArea, string vStrXTN)
        {
            string mStrWhere = " where dIntNoteID <> 1";
            if (string.IsNullOrEmpty(vStrSArea) == false)
            {
                mStrWhere = mStrWhere + " and dIntSjNoteID in (" + vStrSArea + ")";
            }
            if (string.IsNullOrEmpty(vStrXTN) == false)
            {
                mStrWhere = mStrWhere + " and dIntNoteID in (" + vStrXTN + ")";
            }
            return GJHF.Data.MSSQL.PLC.DPlcPointType.GetRecordCount(mStrWhere);
        }

        //当有相同的数值也需要判断
        public static bool AddData(string vStrPointType, string vStrRemark, int vIntSjNoteID, int vIntPx, out string msg)
        {

            bool isSuccess = false;
            msg = "失败";
            if (GJHF.Data.MSSQL.PLC.DPlcPointType.AddData(vStrPointType, vStrRemark, vIntSjNoteID, vIntPx) >= 0)
            {
                isSuccess = true;
                msg = "成功";
            }
            return isSuccess;
        }
        public static bool EditData(int vIntNoteID, string vStrPointType, string vStrRemark, int vIntSjNoteID, int vIntPx, out string msg)
        {
            bool isSuccess = false;
            msg = "失败";
            if (GJHF.Data.MSSQL.PLC.DPlcPointType.EditData(vIntNoteID, vStrPointType, vStrRemark, vIntSjNoteID, vIntPx) >= 0)
            {
                isSuccess = true;
                msg = "成功";
            }
            return isSuccess;
        }

        public static bool DelData(int vIntNoteID, out string msg)
        {
            bool isSuccess = false;
            msg = "失败";
            if (GJHF.Data.MSSQL.PLC.DPlcPointType.DelData(vIntNoteID) >= 0)
            {
                isSuccess = true;
                msg = "成功";
            }
            return isSuccess;
        }

        //工艺参数下显示相关PLC点地址
        public DataTable GetddzByGycs(string vPointType,string sort,string order, int pagesize, int pageindex)
        {
            DataTable dt = null;
            dt = mDPlcPointType.GetddzByGycs(GetWhereByGycs(vPointType) + GetOrderByGycs(sort,order), pagesize, pageindex);
            return dt;
        }
        //工艺参数下显示相关PLC点地址条数
        public int GetRecordByGycs(string vPointType,string sort,string order )
        {
            int count = 0;
            count = mDPlcPointType.GetRecordByGycs(GetWhereByGycs(vPointType));
            return count;
        }
        //工艺参数下显示相关PLC点地址的查询条件
        private string GetWhereByGycs(string vPointType)
        {
            string mStrWhere = " where tZPlcPointType.dIntDataID <> -1 ";
            if (vPointType != "")
            {
                mStrWhere = mStrWhere + " and tZPlcPointType.dIntNoteID = " + vPointType;
            }
            else
            {
                mStrWhere = mStrWhere + " and tZPlcPointType.dIntNoteID = -100 ";
            }
            return mStrWhere;
        }
        //工艺参数下显示相关PLC点地址的排序条件
        private string GetOrderByGycs(string sort,string order)
        {
            string mStrOrder = " order by dIntShouJiPx ";
            if (sort != "")
            {
                mStrOrder = " order by " + sort;
                if (order != "")
                {
                    mStrOrder = mStrOrder + " " + order;
                }
            }
            return mStrOrder;
        }
             
         
    }


}
