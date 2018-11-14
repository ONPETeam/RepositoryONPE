using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using System.Data.SqlClient;

namespace GJHF.Data.MSSQL.COMMON
{
    public class DGlobal
    {
        private static string GetIdentityID(string vStrDataBaseCode, string vStrSystemCode, string vStrFunctionCode, DateTime vDtmDatatime, int vIntCodeLength)
        {
            string lRwgdNum = "";
            int intreturn = -1;
            SqlParameter[] _Parameter = new SqlParameter[7]
            {
                new SqlParameter("@viVchDatabaseCode",SqlDbType.VarChar,2),
                new SqlParameter("@viVchSubsystem",SqlDbType.VarChar,2),
                new SqlParameter("@viVchFunction",SqlDbType.VarChar,2),
                new SqlParameter("@viDmeTime",SqlDbType.DateTime,30),
                new SqlParameter("@viIntSerialNo",SqlDbType.Int,4),
                new SqlParameter("@voVchNumberValue",SqlDbType.VarChar,30),
                new SqlParameter("@voIntReturn",SqlDbType.Int),
            };
            _Parameter[0].Value = vStrDataBaseCode;
            _Parameter[1].Value = vStrSystemCode;
            _Parameter[2].Value = vStrFunctionCode;
            _Parameter[3].Value = vDtmDatatime;
            _Parameter[4].Value = vIntCodeLength;
            _Parameter[5].Direction = System.Data.ParameterDirection.Output;
            _Parameter[6].Direction = System.Data.ParameterDirection.Output;
            claSqlConnDB.ExecuteNonQuery(claSqlConnDB.gStrConnDefault, CommandType.StoredProcedure, "pPBGetNumberValue", _Parameter);
            intreturn = (int)_Parameter[6].Value;
            lRwgdNum = _Parameter[5].Value.ToString();
            return lRwgdNum;
        }

        #region 推送相关
        /// <summary>
        ///  获取推送主键编号
        /// </summary>
        /// <returns></returns>
        public static string GetIdentityPushMessagePushID()
        {
            return GetIdentityID("PC", "PM", "ID", DateTime.Now, 6);
        }
        /// <summary>
        /// 获取推送结果主键编号
        /// </summary>
        /// <returns></returns>
        public static string GetIdentityPushMessagePushResultID()
        {
            return GetIdentityID("PC", "PM", "PR", DateTime.Now, 6);
        }
        /// <summary>
        /// 获取推送结果详情主键编号
        /// </summary>
        /// <returns></returns>
        public static string GetIdentityPushMessageResultDetailID()
        {
            return GetIdentityID("PC", "PM", "RD", DateTime.Now, 6);
        }
        #endregion

        #region 表单控件相关
        /// <summary>
        /// 获取表单控件事件类型主键编号
        /// </summary>
        /// <returns></returns>
        public static string GetIdentityFormControlEventTypeID()
        {
            return GetIdentityID("PC", "FC", "ET", DateTime.Now, 6);
        }
        /// <summary>
        /// 获取表单控件事件主键编号
        /// </summary>
        /// <returns></returns>
        public static string GetIdentityFormControlEventDetailID()
        {
            return GetIdentityID("PC", "FC", "ED", DateTime.Now, 6);
        }

        /// <summary>
        /// 获取表单控件文本框主键编号
        /// </summary>
        /// <returns></returns>
        public static string GetIdentityFormControlTextBoxID()
        {
            return GetIdentityID("PC", "FC", "TB", DateTime.Now, 6);
        }

        /// <summary>
        /// 获取表单控件文本域主键编号
        /// </summary>
        /// <returns></returns>
        public static string GetIdentityFormControlTextAreaID()
        {
            return GetIdentityID("PC", "FC", "TA", DateTime.Now, 6);
        }
        /// <summary>
        /// 获取表单控件验证框主键编号
        /// </summary>
        /// <returns></returns>
        public static string GetIdentityFormControlValidateBoxID()
        {
            return GetIdentityID("PC", "FC", "VB", DateTime.Now, 6);
        }
        /// <summary>
        /// 获取表单控件时间日期框主键编号
        /// </summary>
        /// <returns></returns>
        public static string GetIdentityFormControlDatetimeBoxID()
        {
            return GetIdentityID("PC", "FC", "DB", DateTime.Now, 6);
        }
        /// <summary>
        /// 获取表单控件单选多选框主键编号
        /// </summary>
        /// <returns></returns>
        public static string GetIdentityFormControlRadioCheckID()
        {
            return GetIdentityID("PC", "FC", "RC", DateTime.Now, 6);
        }
        /// <summary>
        /// 获取表单控件下拉框主键编号
        /// </summary>
        /// <returns></returns>
        public static string GetIdentityFormControlComboBoxID()
        {
            return GetIdentityID("PC", "FC", "CB", DateTime.Now, 6);
        }
        /// <summary>
        /// 获取表单控件按钮主键编号
        /// </summary>
        /// <returns></returns>
        public static string GetIdentityFormControlLinkButtonID()
        {
            return GetIdentityID("PC", "FC", "LB", DateTime.Now, 6);
        }
        /// <summary>
        /// 获取流程设计流程信息主键编号
        /// </summary>
        /// <returns></returns>
        public static string GetIdentityFlowDesignID()
        {
            return GetIdentityID("PC", "FD", "FI", DateTime.Now, 4);
        }
        /// <summary>
        /// 获取流程设计流程版本主键编号
        /// </summary>
        /// <returns></returns>
        public static string GetIdentityFlowVersionID()
        {
            return GetIdentityID("PC", "FD", "FV", DateTime.Now, 4);
        }
        #endregion

        #region 员工相关
        /// <summary>
        /// 获取员工编号
        /// </summary>
        /// <returns></returns>
        public static string GetIdentityEmployeeCode()
        {
            return GetIdentityID("PC", "HR", "EP", DateTime.Now, 4);
        }
        #endregion

        #region 停送电相关
        /// <summary>
        /// 获取停送电申请单编号
        /// </summary>
        /// <returns></returns>
        public static string GetIdentityTSDRequestFormID()
        {
            return GetIdentityID("PC", "SO", "RF", DateTime.Now, 4);
        }

        /// <summary>
        /// 获取停送电流程编号
        /// </summary>
        /// <returns></returns>
        public static string GetIdentityTSDFlowID()
        {
            return GetIdentityID("PC", "SO", "FI", DateTime.Now, 4);
        }

        /// <summary>
        /// 获取审核凭据编号
        /// </summary>
        /// <returns></returns>
        public static string GetIdentityTSDExamineProofID()
        {
            return GetIdentityID("PC", "SO", "EP", DateTime.Now, 4);
        }

        /// <summary>
        /// 获取审核记录编号
        /// </summary>
        /// <returns></returns>
        public static string GetIdentityTSDExamineRequestID()
        {
            return GetIdentityID("PC", "SO", "ER", DateTime.Now, 4);
        }

        /// <summary>
        /// 获取人工记录编号
        /// </summary>
        /// <returns></returns>
        public static string GetIdentityTSDRequestConfirmID()
        {
            return GetIdentityID("PC", "SO", "RC", DateTime.Now, 4);
        }
        #endregion

        #region 文件资料相关
        /// <summary>
        /// 获取资料类型自增长编号
        /// </summary>
        /// <returns></returns>
        public static string GetIdentityFileClassCode()
        {
            return GetIdentityID("PC", "ZL", "LX", DateTime.Now, 6);
        }
        #endregion

        #region 系统配置相关
        /// <summary>
        ///  获取推送等级设定编号
        /// </summary>
        /// <returns></returns>
        public static string GetIdentityPushClassClassID()
        {
            return GetIdentityID("PC", "AP", "CI", DateTime.Now, 4);
        }
        /// <summary>
        ///  获取语音通知编号
        /// </summary>
        /// <returns></returns>
        public static string GetIdentityPushVoiceNotifyID()
        {
            return GetIdentityID("PC", "AP", "VN", DateTime.Now, 4);
        }
        /// <summary>
        ///  获取语音通知详情编号
        /// </summary>
        /// <returns></returns>
        public static string GetIdentityPushVoiceNotifyResultID()
        {
            return GetIdentityID("PC", "AP", "NR", DateTime.Now, 4);
        }
        /// <summary>
        ///  获取推送模板编号
        /// </summary>
        /// <returns></returns>
        public static string GetIdentityPushTemplateID()
        {
            return GetIdentityID("PC", "AP", "TI", DateTime.Now, 4);
        }

        /// <summary>
        ///  获取推送模板参数编号
        /// </summary>
        /// <returns></returns>
        public static string GetIdentityPushTemplateParamID()
        {
            return GetIdentityID("PC", "AP", "TP", DateTime.Now, 4);
        }
        #endregion

    }
}
