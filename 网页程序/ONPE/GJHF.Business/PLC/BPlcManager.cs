using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using System.Data.SqlClient;

namespace GJHF.Business.PLC
{
    public class BPlcManager
    {
        //显示数据列表
        public static DataTable GetData(int rows, int pages, string vStrWhere)
        {
            DataTable dt = null;
            dt = GJHF.Data.MSSQL.PLC.DPlcManager.GetData(rows,pages,vStrWhere).Tables[0];
            return dt;
        }
        //数据条数
        public static int GetRecordCount(string vStrWhere)
        {
            int count = 0;
            count = GJHF.Data.MSSQL.PLC.DPlcManager.GetRecordCount(vStrWhere);
            return count;
        }
        //下拉框显示
        public static DataTable GetComboData(string vStrWhere)
        {
            DataTable dt = null;
            
            dt = GJHF.Data.MSSQL.PLC.DPlcManager.GetComboData(vStrWhere).Tables[0];
            //DataRow newRow;
            //newRow = dt.NewRow();
            //newRow["dIntPLCID"] = "0";
            //newRow["dVchPLCName"] = "---未选择---";
            //newRow["dVchArea"] = "未定义分组";
            //dt.Rows.Add(newRow);
            //dt.DefaultView.Sort = "dVchArea ASC";
            //dt = dt.DefaultView.ToTable();
            return dt;
        }
        //IO输出信息下拉框
        public static DataTable GetComboIOData(string vStrWhere)
        {
            DataTable dt = null;
            dt = GJHF.Data.MSSQL.PLC.DPlcManager.GetComboIOData(vStrWhere).Tables[0];
            return dt;
        }

        public static int AddData(string vStrPLCName, string vStrIPAdress, int vIntPLCPinPaiID, int vIntGongYiXitongID, string vStrRemark, string vStrPlcCode)
        {
            int top = 0;
            int mIntResult = 0;
            top = GJHF.Data.MSSQL.PLC.DPlcManager.GetTop();
            mIntResult = GJHF.Data.MSSQL.PLC.DPlcManager.AddData(top,vStrPLCName,vStrIPAdress,vIntPLCPinPaiID,vIntGongYiXitongID,vStrRemark,vStrPlcCode);
            return mIntResult;
        }

        public static int  EditData(int vIntPLCID, string vStrPLCName, string vStrIPAdress, int vIntPLCPinPaiID, int vIntGongYiXitongID, string vStrRemark, string vStrPlcCode)
        {
            int mIntResult = 0;
            mIntResult = GJHF.Data.MSSQL.PLC.DPlcManager.EditData(vIntPLCID, vStrPLCName, vStrIPAdress, vIntPLCPinPaiID, vIntGongYiXitongID, vStrRemark, vStrPlcCode);
            return mIntResult;
        }

        public static int DelData(int vIntPLCID)
        {
            int mIntResult = 0;
            mIntResult = GJHF.Data.MSSQL.PLC.DPlcManager.DelData(vIntPLCID);
            return mIntResult;
        }
        public static void GetPlcCode(int vIntPlcID, out string voStrPlcCode, out int voIntPlcXiTong)
        {
            GJHF.Data.MSSQL.PLC.DPlcManager.GetPlcCode(vIntPlcID, out voStrPlcCode, out voIntPlcXiTong);
        }

        public static List<GJHF.Data.Model.PLC.MPlcManage_Combox> GetComboxPlc(string vStrCb)
        {
            DataTable dt = null;
            string lStrWhere = "where dVchPLCbianma <> '-11111'";
            if (vStrCb != "")
            {
                lStrWhere = lStrWhere + " and dIntGongYiXitongID =  " + vStrCb;

            }
            string mStrOrd = " order by dVchPLCName";
            lStrWhere = lStrWhere + mStrOrd;
            List<GJHF.Data.Model.PLC.MPlcManage_Combox> mList = new List<Data.Model.PLC.MPlcManage_Combox>();
            using (dt = GJHF.Data.MSSQL.PLC.DPlcManager.GetComboxPlc(lStrWhere))
            {
                for(int i =0;i<dt.Rows.Count;i++)
                {
                    GJHF.Data.Model.PLC.MPlcManage_Combox mModel = new Data.Model.PLC.MPlcManage_Combox();
                    mModel.dVchPLCbianma = dt.Rows[i][0].ToString();
                    mModel.dVchPLCName = dt.Rows[i][1].ToString();
                    mModel.dVchIPAdress = dt.Rows[i][2].ToString();
                    mModel.dVchRemark = dt.Rows[i][1].ToString() + '-' + dt.Rows[i][2].ToString();
                    mModel.dVchState = dt.Rows[i][3].ToString();
                    if (dt.Rows[i][3].ToString() == "在线")
                    {
                        mModel.icon = "html.png";
                    }
                    else
                    {
                        mModel.icon = "ppt.png";
                    }
                    mList.Add(mModel);
                }
               
            }
            return mList;
        }

        public static List<GJHF.Data.Model.Control.TreeNode> GetXitongData(string vStrParent)
        {
            
            List<GJHF.Data.Model.Control.TreeNode> mlist = new List<Data.Model.Control.TreeNode>();
            DataTable dt=null;
            using(dt=GJHF.Data.MSSQL.PLC.DPlcManager.GetXitongData(vStrParent))
            {
                for (int i = 0; i <= dt.Rows.Count; i++)
                {
                    GJHF.Data.Model.Control.TreeNode mModel = new Data.Model.Control.TreeNode();
                    mModel.id = dt.Rows[i][0].ToString();
                    mModel.text = dt.Rows[i][1].ToString();
                    mModel.state = "closed";
                    mModel.attributes = "plc";
                    mlist.Add(mModel);
                }
            }
            return mlist;
        }
    }
}
