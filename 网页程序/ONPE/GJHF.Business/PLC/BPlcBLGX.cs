using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;

namespace GJHF.Business.PLC
{
    public class BPlcBLGX
    {
        
        public static DataTable GetBlDdz(string vStrCjdz)
        {
            string mStrWhere = " where dVchVariable = '" + vStrCjdz + "'";
            return GJHF.Data.MSSQL.PLC.DPlcBLGX.GetBlDdz(mStrWhere);
        }
        public static int GetRecord(string vStrCjdz)
        {
            string mStrWhere = " where dVchVariable = '" + vStrCjdz + "'";
            return GJHF.Data.MSSQL.PLC.DPlcBLGX.GetRecord(mStrWhere);
        }
        public static bool AddData(string vStrVariable, string vStrCollectAddress, string vStrParameterNum,out string msg)
        {
            bool isSuccess = false;
            msg = "失败";
            if(GJHF.Data.MSSQL.PLC.DPlcBLGX.AddData(vStrVariable,vStrCollectAddress,vStrParameterNum)>=0)
            {
                isSuccess = true;
                msg = "成功";
            }
            return isSuccess;
        }

        public static bool EditData(string vStrVariable, string vStrCollectAddress, string vStrParameterNum, out string msg)
        {
            bool isSuccess = false;
            msg = "失败";
            if (GJHF.Data.MSSQL.PLC.DPlcBLGX.EditData(vStrVariable, vStrCollectAddress, vStrParameterNum) >=0)
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
            if (GJHF.Data.MSSQL.PLC.DPlcBLGX.DelData(vStrVariable) >=0)
            {
                isSuccess = true;
                msg = "成功";
            }
            return isSuccess;
        }
        public static string GetValues(string vStrVariable, string vStrfoumal)
        {
            string mStrABC = "";
            DataTable dt = null;
            string a = "";
            string b = "";
            string c = "";
            string para = "";
            formulaDll.GsComputer gs = new formulaDll.GsComputer();
            using (dt = GJHF.Data.MSSQL.PLC.DPlcBLGX.GetValues(vStrVariable))
            {
                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    para = dt.Rows[i][1].ToString();
                    if (para == "a")
                    {
                        a = dt.Rows[i][2].ToString();
                    }
                    if (para == "b")
                    {
                        b = dt.Rows[i][2].ToString();
                    }
                    if (para == "c")
                    {
                        c = dt.Rows[i][2].ToString();
                    }
                }
                
                mStrABC =gs.jx(vStrfoumal, a, b, c);
            }
            return mStrABC;

        }

        public static DataTable GetVariableType(string vStrWhere)
        {
            return GJHF.Data.MSSQL.PLC.DPlcBLGX.GetVariableType(vStrWhere);
        }
        
    }
}
