using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;

namespace GJHF.Business.PLC
{
    
    public class BPLCPointPhoneType
    {
        private GJHF.Data.Interface.PLC.IPLCPointPhoneType bPLCPointPhoneType;
        public BPLCPointPhoneType()
        {
            this.bPLCPointPhoneType = GJHF.Data.Factory.PLC.FPLCPointPhoneType.Create();
        }
        /// <summary>
        /// 保存PLC点地址与手机显示系统的绑定关系
        /// </summary>
        /// <param name="plc_point_address_id">PLC点地址编号</param>
        /// <param name="phone_type_ids">由分隔符分隔的手机显示系统编号字符串</param>
        /// <param name="id_separator">分隔符</param>
        /// <returns>执行结果，1 成功 其他值 失败</returns>
        public int SavePLCPointPhoneType(int plc_point_address_id, string phone_type_ids, char id_separator)
        {
            try
            {
                int mIntPhoneTypeID = 0;
                int mIntErrorNum = 0;
                //1.删除PLC点地址绑定的所有手机显示系统
                int mIntDelReturn = bPLCPointPhoneType.DelPLCPointPhoneType(plc_point_address_id);
                //删除新表
                mIntDelReturn = bPLCPointPhoneType.DelPLCPointPJ(plc_point_address_id); 
                if (mIntDelReturn >= 0)
                {
                    //如果删除成功，则开始添加新的绑定
                    HashSet<string> mStrPhoneTypeIDs = GJHF.Utility.Convert.ConvertStringToHashSet(phone_type_ids, id_separator);
                    
                    foreach (string mStrPhoneTypeID in mStrPhoneTypeIDs)
                    {
                        if (!string.IsNullOrEmpty(mStrPhoneTypeID))
                        {
                            mIntPhoneTypeID = 0;
                            if (int.TryParse(mStrPhoneTypeID, out mIntPhoneTypeID))
                            {
                                if (mIntPhoneTypeID != 0)
                                {
                                    int mIntReturn = bPLCPointPhoneType.AddPLCPointPhoneType(plc_point_address_id, mIntPhoneTypeID);
                                    if (mIntReturn < 0)
                                    {
                                        mIntErrorNum = mIntErrorNum + 1;
                                    }
                                }
                            }
                        }
                    }
                    //添加新表
                    bPLCPointPhoneType.AddPLCPointPJ(plc_point_address_id, "," + phone_type_ids + ",");
                    if (mIntErrorNum == 0)
                    {
                        return 1;
                    }
                    else
                    {
                        return 0;
                    }
                }
                else
                {
                    return 0;
                }
            }
            catch (Exception e)
            {
                return -1;
            }
        }

        public bool DelPLCPointPhoneType(int plc_point_address_id,out string msg)
        {
            msg = "";
            bool isSuccess = false; 
            try
            {
                if (bPLCPointPhoneType.DelPLCPointPhoneType(plc_point_address_id) >= 0 && bPLCPointPhoneType.DelPLCPointPJ(plc_point_address_id) >=0)
                {
                    isSuccess = true;
                    msg = "执行成功！";
                }
                return isSuccess;
            }
            catch(Exception eee)
            {
                isSuccess = false;
                msg = eee.ToString();
                return isSuccess;
            }
        }

        //根据点地址id搜素相关的系统
        public  DataTable GetDataByid(int vIntDataID)
        {
            return bPLCPointPhoneType.GetDataByid(vIntDataID);
        }

        //把系统名称变为字符串进行拼接 i-id,n-name
        public  string DataTableToString(int vIntDataID,string vStrIdOrName)
        {
            string mStrConvert = "";
            DataTable dt = GetDataByid(vIntDataID);
            if (dt.Rows.Count > 0)
            {
                if (vStrIdOrName == "n")
                {
                    foreach (DataRow dr in dt.Rows)
                    {
                        mStrConvert = dr["dVchPointType"].ToString() + "|" + dr["dVchRemark"].ToString() + "," + mStrConvert;
                    }
                }
                if (vStrIdOrName == "i")
                {
                    foreach (DataRow dr in dt.Rows)
                    {
                        mStrConvert = dr["dIntNoteID"].ToString() + "," + mStrConvert;
                    }
                }
                //去掉最后一个逗号
                mStrConvert = mStrConvert.Substring(0, mStrConvert.Length - 1);
            }

            return mStrConvert;
        }
        
    }
}
