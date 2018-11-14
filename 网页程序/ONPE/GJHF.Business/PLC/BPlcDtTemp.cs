using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;

namespace GJHF.Business.PLC
{
    public class BPlcDtTemp
    {
        public static List<GJHF.Data.Model.PLC.MPlcDtTemp> GetData(int rows, int pages)
        {
            DataTable dt = null;
            List<GJHF.Data.Model.PLC.MPlcDtTemp> mlist = new List<Data.Model.PLC.MPlcDtTemp>();
            string mStrWhere = " order by dIntDataID";
            dt = GJHF.Data.MSSQL.PLC.DPlcDtTemp.GetData(rows,pages,mStrWhere);

            for (int i = 0; i < dt.Rows.Count; i++)
            {
                GJHF.Data.Model.PLC.MPlcDtTemp mModel = new Data.Model.PLC.MPlcDtTemp();
                if (dt.Rows[i][0].ToString() != "")
                {
                    mModel.dIntDataID = (int)dt.Rows[i][0];
                }
                mModel.dVchFactoryCode = dt.Rows[i][1].ToString();
                mModel.dVchPLCCode = dt.Rows[i][2].ToString();
                mModel.dVchAdress = dt.Rows[i][3].ToString();
                mModel.dVchCjdz = dt.Rows[i][4].ToString();
                mModel.dVchValue = dt.Rows[i][5].ToString();
                if (dt.Rows[i][22].ToString() == "1")
                {
                    //string abc = Getabc(mModel.dVchCjdz);
                    //string c = abc.Split(',')[0].ToString();
                    //string b = abc.Split(',')[1].ToString();
                    //string a = abc.Split(',')[2].ToString();
                    //string foumal = dt.Rows[i][23].ToString();
                    string foumal = dt.Rows[i][23].ToString();
                    mModel.dVchValue = GJHF.Business.PLC.BPlcBLGX.GetValues(mModel.dVchCjdz, foumal);
                    mModel.dVchSjValue = mModel.dVchValue;
                }
                else
                {
                    if (GJHF.Utility.MyCommon.isNumberic(dt.Rows[i][5].ToString()) == true)
                    {
                        mModel.dVchValue = Math.Round(double.Parse(dt.Rows[i][5].ToString()), 2).ToString();
                        mModel.dVchSjValue = GJHF.Utility.MyCommon.GetSjValue(float.Parse(dt.Rows[i][10].ToString()), float.Parse(dt.Rows[i][11].ToString()), float.Parse(dt.Rows[i][12].ToString()), float.Parse(dt.Rows[i][13].ToString()), float.Parse(mModel.dVchValue));
                    }
                    else
                    {
                        mModel.dVchSjValue = dt.Rows[i][5].ToString();
                    }
                }
                mModel.dVchUnit = dt.Rows[i][6].ToString();
                if (dt.Rows[i][6].ToString() != "")
                {
                    mModel.dIntDqBz = (int)dt.Rows[i][7];
                }
                mModel.dVchFactoryName = dt.Rows[i][8].ToString();
                mModel.dVchRemark = dt.Rows[i][14].ToString() + "-" + dt.Rows[i][15].ToString();
                mModel.dFltSjMax = dt.Rows[i][10].ToString();
                mModel.dFltSjMin = dt.Rows[i][11].ToString();
                mModel.dFltBdMax = dt.Rows[i][12].ToString();
                mModel.dFltBdMin = dt.Rows[i][13].ToString();
                mModel.dVchName = dt.Rows[i][16].ToString();
                mModel.dVchDescription = dt.Rows[i][17].ToString();
                mModel.equip_name = dt.Rows[i][18].ToString();
                mModel.dVchVariableType = dt.Rows[i][19].ToString();
                mModel.dDaeCurrentTime = dt.Rows[i][20].ToString();
                if (string.IsNullOrEmpty(dt.Rows[i][21].ToString()) == false)
                {
                    mModel.dIntBjState = Int32.Parse(dt.Rows[i][21].ToString());
                }
                mlist.Add(mModel);
            }
            return mlist;
        }

        public static int GetRecourd(string vStrWhere)
        {
            return GJHF.Data.MSSQL.PLC.DPlcDtTemp.GetRecord(vStrWhere);
        }

        public static bool AddData(string vStrFactoryCode, string vStrPLCCode, string vStrAdress, string vStrCjdz, string vStrValue, string vStrSjValue, string vStrUnit, int vIntDqBz,
        float vFltSjMaX, float vFltSjMin, float vFltBdMax, float vFltBdMin, string vStrfwqdh, string vStrName, int vIntdizhiID, string vStrequip_code, string vStrVariableType, out string msg)
        {
            bool isSuccess = false;
            msg = "失败";
            if (GJHF.Data.MSSQL.PLC.DPlcDtTemp.AddData(vStrFactoryCode, vStrPLCCode, vStrAdress, vStrCjdz, vStrValue, vStrSjValue, vStrUnit, vIntDqBz,
               vFltSjMaX,  vFltSjMin,  vFltBdMax,  vFltBdMin,  vStrfwqdh,  vStrName,  vIntdizhiID,  vStrequip_code,  vStrVariableType)>=0)
            {
                isSuccess = true;
                msg = "成功";
            }

            return isSuccess;
        }

        public static bool DelData(int vIntId,out string msg)
        {
            bool isSuccess = false;
            msg = "失败";
            if (GJHF.Data.MSSQL.PLC.DPlcDtTemp.DelData(vIntId) >= 0)
            {
                isSuccess = true;
                msg = "成功";
            }

            return isSuccess;
        }

        public static bool EditJsl(int vIntid, int vIntJsBz,out string msg)
        {
            bool isSuccess = false;
            msg = "失败";
            if (GJHF.Data.MSSQL.PLC.DPlcDtTemp.EditJsl(vIntid, vIntJsBz) >= 0)
            {
                isSuccess = true;
                msg = "成功";
            }
            return isSuccess;
        }
        public static List<GJHF.Data.Model.PLC.MPlcDtTempLS> GetDataLS(string vStrWhere)
        {
            DataTable dt = null;
            List<GJHF.Data.Model.PLC.MPlcDtTempLS> mList = new List<Data.Model.PLC.MPlcDtTempLS>();
            string mStrWhere =  vStrWhere + " order by dDaeCurrentTime ";
            using (dt = GJHF.Data.MSSQL.PLC.DPlcDtTemp.GetDataLS(mStrWhere))
            {
                
                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    GJHF.Data.Model.PLC.MPlcDtTempLS mModel = new Data.Model.PLC.MPlcDtTempLS();
                    if (dt.Rows[i][0].ToString() != "")
                    {
                        mModel.dIntDataID = (int)dt.Rows[i][0];
                    }
                    mModel.dVchCjdz = dt.Rows[i][1].ToString();
                    mModel.dVchValue = dt.Rows[i][2].ToString();
                    mModel.dFltSjMax = dt.Rows[i][5].ToString();
                    mModel.dFltSjMin = dt.Rows[i][6].ToString();
                    mModel.dFltBdMax = dt.Rows[i][7].ToString();
                    mModel.dFltBdMin = dt.Rows[i][8].ToString();

                    if (GJHF.Utility.MyCommon.isNumberic(dt.Rows[i][2].ToString()) == true)
                    {
                        mModel.dVchValue = Math.Round(double.Parse(dt.Rows[i][2].ToString()), 2).ToString();
                        mModel.dVchSjValue =GJHF.Utility.MyCommon.GetSjValue(float.Parse(dt.Rows[i][5].ToString()), float.Parse(dt.Rows[i][6].ToString()), float.Parse(dt.Rows[i][7].ToString()), float.Parse(dt.Rows[i][8].ToString()), float.Parse(mModel.dVchValue));

                    }
                    else
                    {
                        mModel.dVchSjValue = dt.Rows[i][2].ToString();
                    }
                    if (dt.Rows[i][4].ToString() != "")
                    {
                        mModel.dDaeCurrentTime = dt.Rows[i][4].ToString();
                    }
                    mList.Add(mModel);
                }
            }
            return mList;
        }

        public static int GetRecordLS(string vStrWhere)
        {
            return GJHF.Data.MSSQL.PLC.DPlcDtTemp.GetRecordLS(vStrWhere);
        }

        public static bool GetCancel(int vIntId,out string msg)
        {
            bool isSuccess = false;
            msg = "失败";
            if (GJHF.Data.MSSQL.PLC.DPlcDtTemp.GetCancel(vIntId) >= 0)
            {
                isSuccess = true;
                msg = "成功";
            }
            return isSuccess;
        }

        public static bool GetUpdate(out string msg)
        {
            bool isSuccess = false;
            msg = "失败";
            if (GJHF.Data.MSSQL.PLC.DPlcDtTemp.GetUpdate() >= 0)
            {
                isSuccess = true;
                msg = "成功";
            }
            return isSuccess;
        }

        public static DataTable GetCjData()
        {
            return GJHF.Data.MSSQL.PLC.DPlcDtTemp.GetCjData();
        }

    }
}
