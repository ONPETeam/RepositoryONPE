using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data.SqlClient;
using System.Data;

namespace GJHF.Business.User
{
    public class User
    {
        /// <summary>
        /// 判断是否是管理员
        /// </summary>
        /// <param name="v_user_data">cookie中的用户数据，即ticket.UserData</param>
        /// <returns></returns>
        public static bool IsSystemAdmin(string v_user_data)
        {
            try
            {
                Dictionary<string, object> mDicUserData = (Dictionary<string, object>)Newtonsoft.Json.JsonConvert.DeserializeObject<Dictionary<string, object>>(v_user_data);
                if (mDicUserData != null)
                {
                    string mStrRightType = mDicUserData["right_type"].ToString();
                    int mIntRightType = 0;
                    if (int.TryParse(mStrRightType, out mIntRightType) == false)
                    {
                        return false;
                    }
                    if (mIntRightType != 1) return false;
                }
                else
                {
                    return false;
                }
                return true;
            }
            catch (Exception e)
            {
                return false;
            }
        }

        /// <summary>
        /// 获取用户编号
        /// </summary>
        /// <param name="v_user_data">cookie中的用户数据，即ticket.UserData</param>
        /// <returns></returns>
        public static string GetUserID(string v_user_data)
        {
            try
            {
                Dictionary<string, object> mDicUserData = (Dictionary<string, object>)Newtonsoft.Json.JsonConvert.DeserializeObject<Dictionary<string, object>>(v_user_data);
                if (mDicUserData != null)
                {
                    string mStrUserID = "";
                    if (mDicUserData["user_id"] != null)
                    {
                        mStrUserID = mDicUserData["user_id"].ToString();
                    }
                    return mStrUserID;
                }
                else
                {
                    return "";
                }
            }
            catch (Exception e)
            {
                return "";
            }
        }

        /// <summary>
        /// 获取用户权限
        /// </summary>
        /// <param name="v_user_data">cookie中的用户数据，即ticket.UserData</param>
        /// <param name="v_right_class">权限类别</param>
        /// <param name="v_right_type">权限类型</param>
        /// <param name="v_spara_code">分隔符</param>
        /// <returns>以分隔符连接的权限项</returns>
        public static string GetUserRight(string v_user_data, int v_right_class, int v_right_type, string v_spara_code)
        {
            string mStrRights = "";

            bool isAdmin = GJHF.Business.User.User.IsSystemAdmin(v_user_data);
            if (isAdmin)
            {
                mStrRights = GetAllUserRight(v_right_class, v_right_type, v_spara_code);
            }
            else
            {
                string mStrUserID = GJHF.Business.User.User.GetUserID(v_user_data);
                mStrRights = GetUserRightNoUse(mStrUserID, v_right_class, v_right_type, v_spara_code);
            }
            if (mStrRights.Length > 1)
            {
                mStrRights = mStrRights.Substring(0, mStrRights.Length - 1);
            }
            return mStrRights;
        }

        /// <summary>
        /// 获取用户权限
        /// </summary>
        /// <param name="v_user_code">用户编号</param>
        /// <param name="v_right_class">权限类别 1、PC端BS权限 2、</param>
        /// <param name="v_right_type">权限类型 取值[1,3] 1 拥有，3 可授权</param>
        /// <param name="v_spara_code">分隔符</param>
        /// <returns>以v_spara_code为分隔符的权限编号集</returns>
        private static string GetUserRightNoUse(string v_user_code, int v_right_class, int v_right_type, string v_spara_code)
        {
            string mStrReturn = "";
            GJHF.Data.Interface.User.IUser mIUser = GJHF.Data.Factory.User.FUser.Create();
            string mStrUserRight = mIUser.GetUserRight(v_user_code, v_right_class, v_right_type, v_spara_code);
            switch (v_right_class)
            {
                case 1:
                    mStrReturn = mStrUserRight;
                    break;
                case 3:
                    mStrReturn = mStrUserRight;
                    break;
                default:
                    mStrReturn = mStrUserRight;
                    break;
            }
            return mStrReturn;
        }

        /// <summary>
        /// 获取所有用户权限
        /// </summary>
        /// <param name="v_right_class">权限类别</param>
        /// <param name="v_right_type">权限类型</param>
        /// <param name="v_spara_code">分隔符</param>
        /// <returns></returns>
        private static string GetAllUserRight(int v_right_class, int v_right_type, string v_spara_code)
        {
            string mStrReturn = "";
            GJHF.Data.Interface.User.IUser mIUser = GJHF.Data.Factory.User.FUser.Create();
            string mStrUserRight = mIUser.GetAllUserRight(v_right_class, v_right_type, v_spara_code);
            switch (v_right_class)
            {
                case 1:
                    mStrReturn = mStrUserRight;
                    break;
                case 3:
                    mStrReturn = mStrUserRight;
                    break;
                default:
                    mStrReturn = mStrUserRight;
                    break;
            }
            return mStrReturn;
        }

        [Obsolete("已作废，请使用GetUserRightNoUse方法")]
        private static string GetOldUserRight(string v_user_code, int v_right_class, int v_right_type, string v_spara_code)
        {
            string mStrReturn = "";
            GJHF.Data.Interface.User.IUser mIUser = GJHF.Data.Factory.User.FUser.Create();
            string mStrUserRight = mIUser.GetOldUserRight(v_user_code, v_right_class, v_right_type, v_spara_code);
            switch (v_right_class)
            {
                case 1:
                    mStrReturn = mStrUserRight;
                    break;
                case 3:
                    if (v_right_type != 3)
                    {
                        if (mStrUserRight.Length > 0)
                        {
                            mStrUserRight = mStrUserRight.Substring(0, mStrUserRight.Length - 1);
                            mStrReturn = ConvertIdToRemark(mStrUserRight, v_spara_code);
                        }
                        else
                        {
                            mStrReturn = "";
                        }
                    }
                    else
                    {
                        mStrReturn = mStrUserRight;
                    }
                    break;
                default:
                    mStrReturn = mStrUserRight;
                    break;
            }
            return mStrReturn;
        }
        [Obsolete("已作废")]
        private static string ConvertIdToRemark(string vStrIDString, string v_spara_code)
        {
            GJHF.Data.Interface.User.IUser mIUser = GJHF.Data.Factory.User.FUser.Create();
            return mIUser.ConvertIdToRemark(vStrIDString, v_spara_code);
        }

        /// <summary>
        /// 添加用户操作记录（菜单级别）
        /// </summary>
        /// <param name="v_user_id">用户编号</param>
        /// <param name="v_employee_name">员工姓名</param>
        /// <param name="v_equip_type">设备类型 1 电脑 2 手机 3 其他</param>
        /// <param name="v_equip_sign">设备标识</param>
        /// <param name="v_way_type">访问方式 1 浏览器 2 应用程序 3 其他</param>
        /// <param name="v_way_sign">访问标识</param>
        /// <param name="v_menu_link">菜单链接</param>
        /// <param name="v_menu_title">菜单名称</param>
        /// <param name="v_menu_extra">菜单扩展</param>
        /// <param name="v_operate_remark">操作备注</param>
        /// <returns>记录保存结果 1 成功 0 失败</returns>
        public static int AddUserOperateRecord(string v_user_id, string v_employee_name, int v_equip_type, string v_equip_sign, int v_way_type,
            string v_way_sign, string v_menu_link, string v_menu_title, string v_menu_extra, string v_operate_remark)
        {
            DateTime mDtmOperateTime = System.DateTime.Now;
            return GJHF.Data.Factory.User.FUserOperate.Create().AddUserOperateRecord(v_user_id, v_employee_name, mDtmOperateTime, v_equip_type, v_equip_sign, v_way_type,
             v_way_sign, v_menu_link, v_menu_title, v_menu_extra, v_operate_remark);
        }
    }
}
