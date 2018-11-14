using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data.SqlClient;
using System.Data;

namespace GJHF.Data.MSSQL.PLC
{
    public class DPlcManager
    {
        //显示数据列表
        public static DataSet GetData(int rows, int pages, string vStrWhere)
        {
            DataSet ds = null;
            string mStrSQL = @"select dIntPLCID, dVchPLCName, dVchIPAdress, tZPLCManager.dIntPLCPinPaiID, dIntGongYiXitongID, tZPLCManager.dVchRemark,
                                                tZPLCPinpai.dVchPLCPinPaiName,tZPLCArea.dVchArea,dVchPLCbianma
                                                from tZPLCManager left outer join tZPLCArea on tZPLCManager.dIntGongYiXitongID = tZPLCArea.dIntAreaID
                                                left outer join tZPLCPinpai on tZPLCManager.dIntPLCPinPaiID = tZPLCPinpai.dIntPLCPinPaiID " + vStrWhere;
            ds = claSqlConnDB.ExecuteDataset(rows, pages, claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL);
            return ds;
        }
        //数据条数
        public static int GetRecordCount(string vStrWhere)
        {
            int count = 0;
            string mStrSQL = @"select COUNT(*) from tZPLCManager left outer join tZGongyiXitong on tZPLCManager.dIntGongYiXitongID = tZGongyiXitong.dIntPLCXitong
                                            left outer join tZPLCPinpai on tZPLCManager.dIntPLCPinPaiID = tZPLCPinpai.dIntPLCPinPaiID " + vStrWhere;
            count = claSqlConnDB.GetRecordCount(claSqlConnDB.gStrConnDefault, mStrSQL);
            return count;
        }
        //plc信息下拉框显示
        public static DataSet GetComboData(string vStrWhere)
        {
            DataSet ds = null;
            string mStrSQL = @"select dIntPLCID,dVchPLCName,tZPLCArea.dVchArea  from tZPLCManager left outer join tZPLCArea on tZPLCManager.dIntGongYiXitongID = tZPLCArea.dIntAreaID  " + vStrWhere;
            ds = claSqlConnDB.ExecuteDataset(claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL);
            return ds;
        }
        //IO输出信息下拉框
        public static DataSet GetComboIOData(string vStrWhere)
        {
            DataSet ds = null;
            string mStrSQL = @"select dIntIOType,dVchIOTypeName from tZPLCIOType " + vStrWhere;
            ds = claSqlConnDB.ExecuteDataset(claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL);
            return ds;
        }
        //获取最大的ID顺序号
        public static  int GetTop()
        {
            int top = 0;
            top = (int)claSqlConnDB.ExecuteScalar(claSqlConnDB.gStrConnDefault, CommandType.Text, "select Max(dIntPLCID) from tZPLCManager") + 1;
            return top;
        }
        //添加方法（SQL）
        public static int AddData(int vIntPLCID ,string vStrPLCName, string vStrIPAdress, int vIntPLCPinPaiID, int vIntGongYiXitongID, string vStrRemark, string vStrPlcCode)
        {
            int mIntReturn = -1;
            string mStrSQL = "insert into tZPLCManager(dIntPLCID,dVchPLCName,dVchIPAdress,dIntPLCPinPaiID,dIntGongYiXitongID,dVchRemark,dVchPLCbianma) values (" + vIntPLCID + ",'" + vStrPLCName + "','" + vStrIPAdress + "'," + vIntPLCPinPaiID + "," + vIntGongYiXitongID + ",'" + vStrRemark + "','" + vStrPlcCode + "')";
            mIntReturn = claSqlConnDB.ExecuteNonQuery(claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL);
            return mIntReturn;
        }

        //编辑方法（SQL）
        public static int EditData(int vIntPLCID, string vStrPLCName, string vStrIPAdress, int vIntPLCPinPaiID, int vIntGongYiXitongID, string vStrRemark, string vStrPlcCode)
        {
            int mIntReturn = -1;
            string mStrSQL = "update tZPLCManager set dVchPLCName = '" + vStrPLCName + "',dVchIPAdress = '" + vStrIPAdress + "',dIntPLCPinPaiID = '" + vIntPLCPinPaiID + "',dIntGongYiXitongID = " + vIntGongYiXitongID + ",dVchRemark = '" + vStrRemark + "', dVchPLCbianma = '" + vStrPlcCode + "' where dIntPLCID = " + vIntPLCID + "";
            mIntReturn = claSqlConnDB.ExecuteNonQuery(claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL);
            return mIntReturn;
        }

        //删除操作(SQL)
        public static int DelData(int vIntPLCID)
        {
            int mIntReturn = -1;
            string mStrSQL = "delete from tZPLCManager where dIntPLCID = " + vIntPLCID;
            mIntReturn = claSqlConnDB.ExecuteNonQuery(claSqlConnDB.gStrConnDefault,CommandType.Text,mStrSQL);
            return mIntReturn;
        }
        /// <summary>
        /// 根据PLCID获取PLC编码,PLC系统
        /// </summary>
        /// <param name="vIntPlcID">plcID</param>
        /// <param name="voStrPlcCode">plc编码（输出）</param>
        /// <param name="voIntPlcXiTong">plc所属系统（输出）</param>
        public static void GetPlcCode(int vIntPlcID,out string voStrPlcCode,out int voIntPlcXiTong)
        {
            string mStrSQL = @"select top(1) dVchPLCbianma,dIntGongYiXitongID from tZPLCManager Where dIntPLCID =  " + vIntPlcID;
            DataTable dt = null;
            dt = claSqlConnDB.ExecuteDataset(claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL, null).Tables[0];
            voStrPlcCode = dt.Rows[0][0].ToString();
            if (string.IsNullOrEmpty(dt.Rows[0][1].ToString()) == false)
            {
                voIntPlcXiTong = Int32.Parse(dt.Rows[0][1].ToString());
            }
            else
            {
                voIntPlcXiTong = 0;
            }
        }

        public static DataTable GetComboxPlc(string vStrWhere)
        {
            string mStrSQL = @"select dVchPLCbianma,dVchPLCName,dVchIPAdress,dVchState from tZPLCManager " + vStrWhere;
            DataTable dt = claSqlConnDB.ExecuteDataset(claSqlConnDB.gStrConnDefault,CommandType.Text,mStrSQL).Tables[0];
            return dt;
        }


        public static DataTable GetXitongData(string vStrWhere)
        {
            string mStrSQL = " SELECT  dIntPLCXitong, dVchPLCXitongName from tZGongyiXitong where dIntPLCXitong<>0 " + vStrWhere;
            DataTable dt = claSqlConnDB.ExecuteDataset(claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL).Tables[0];
            return dt;
        }



        
    }
}
