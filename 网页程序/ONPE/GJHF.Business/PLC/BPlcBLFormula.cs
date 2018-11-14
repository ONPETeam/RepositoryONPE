using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using System.Data.SqlClient;

namespace GJHF.Business.PLC
{
    public class BPlcBLFormula
    {
        public static DataTable GetFormula(string vCjdz)
        {
            DataTable dt = null;
            dt = GJHF.Data.MSSQL.PLC.DPlcBLFormula.GetFormula(vCjdz);
            return dt;
        }

        public static bool AddData(string vStrVariable, string vStrFormula,out string msg)
        {
            bool isSuccess = false;
            msg = "失败";
            if (GJHF.Data.MSSQL.PLC.DPlcBLFormula.AddData(vStrVariable, vStrFormula) >=0)
            {
                isSuccess = true;
                msg = "成功";
            }
            return isSuccess;
        }

        public static bool EditData(string vStrVariable, string vStrFormula, out string msg)
        {
            bool isSuccess = false;
            msg = "失败";
            if (GJHF.Data.MSSQL.PLC.DPlcBLFormula.EditData(vStrVariable, vStrFormula) >=0)
            {
                isSuccess = true;
                msg = "成功";
            }
            return isSuccess;
        }

        public static bool DelData(string vStrVariable,out string msg)
        {
            bool isSuccess = false;
            msg = "失败";
            if (GJHF.Data.MSSQL.PLC.DPlcBLFormula.DelData(vStrVariable) >=0)
            {
                isSuccess = true;
                msg = "成功";
            }
            return isSuccess;
        }
    }
}
