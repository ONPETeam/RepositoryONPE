using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;

namespace GJHF.Business.PLC
{
    public class BPlcBaojing
    {
        public static DataTable GetOneBjfwData(string vStrAllAddress)
        {
            string mStrWhere = " where dIntDataID <> -1 ";
            string mStrOrd = " order by dIntDataID desc";
            DataTable dt = null;
            
            mStrWhere = mStrWhere + " and dVchAllAdress = '" + vStrAllAddress + "'";
            mStrWhere = mStrWhere + mStrOrd;
            
            
            dt = GJHF.Data.MSSQL.PLC.DPlcBaojing.GetOneBjfwData(mStrWhere);
            return dt;
        }


        public static int AddBjData(string vStrFactoryCode, string vStrPLCCode, string vStrAdress, string vStrCjdz, string vStrValue, string vStrSjValue, string vStrUnit,
            int vIntDqBz, float vFltSjMax, float vFltSjMin, float vFltBdMax, float vFltBdMin,
            string vStrfwqdh, string vStrName, int vIntdizhiID, string vStrequip_code, string vStrVariableType)
        {
            return GJHF.Data.MSSQL.PLC.DPlcBaojing.AddBjData( vStrFactoryCode,  vStrPLCCode,  vStrAdress,  vStrCjdz,  vStrValue,  vStrSjValue,  vStrUnit,
             vIntDqBz,  vFltSjMax,  vFltSjMin,  vFltBdMax,  vFltBdMin, vStrfwqdh,  vStrName,  vIntdizhiID,  vStrequip_code,  vStrVariableType);
        }

        public static int GetBJBZ(string vStrCjdz, int vIntBjBz)
        {
            return GJHF.Data.MSSQL.PLC.DPlcBaojing.GetBJBZ(vStrCjdz,vIntBjBz);
        }

        public static int AddBjFw(string vStrSbbm, string vStrcjdz, int vIntdzlb, float vfltMax, float vfltMin, string vStrKgl, int vIntBaojingJBID, string vStrRemark)
        {
            return GJHF.Data.MSSQL.PLC.DPlcBaojing.AddBjFw( vStrSbbm,  vStrcjdz,  vIntdzlb,  vfltMax,  vfltMin,  vStrKgl,  vIntBaojingJBID, vStrRemark);
        }

        public static int SetTsPeople(int vIntdizhiID, string vStrcjdz, string vStrpeople)
        {
            return GJHF.Data.MSSQL.PLC.DPlcBaojing.SetTsPeople(vIntdizhiID, vStrcjdz, vStrpeople);
        }
        public static int DelAlermRange(string vStrCjdz)
        {
            return GJHF.Data.MSSQL.PLC.DPlcBaojing.DelAlermRange(vStrCjdz);
        }
    }
}
