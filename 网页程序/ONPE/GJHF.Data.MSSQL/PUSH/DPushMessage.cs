using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using System.Data.SqlClient;
using GJHF.Data.Interface.PUSH;

namespace GJHF.Data.MSSQL.PUSH
{
    public class DPushMessage : IPushMessage
    {
        #region IPushMessage 成员

        public int GetNewSendNO()
        {
            return (new Random()).Next(1, 66666);
        }

        public string SavePushMessage(int v_push_type, string v_push_key, string v_message_content, string v_message_extras, HashSet<string> v_employee_codes)
        {
            string mStrEmployeeCodes = "";
            if (v_employee_codes != null && v_employee_codes.Count > 0)
            {
                foreach (string mStrEmployeeCode in v_employee_codes)
                {
                    if (mStrEmployeeCode != "")
                    {
                        mStrEmployeeCodes += mStrEmployeeCode + ",";
                    }
                }
                if (mStrEmployeeCodes.Substring(mStrEmployeeCodes.Length - 1) == ",")
                {
                    mStrEmployeeCodes = mStrEmployeeCodes.Substring(0, mStrEmployeeCodes.Length - 1);
                }
            }
            else
            {
                mStrEmployeeCodes = "";
            }
            string mStrPushID = COMMON.DGlobal.GetIdentityPushMessagePushID();
            string mStrSQL = @"INSERT INTO t_PushMessage(record_type,record_key,push_id,message_content,message_extras,employee_codes,is_push)
                            VALUES(@record_type,@record_key,@push_id,@message_content,@message_extras,@employee_codes,0)";
            SqlParameter[] parameters = new SqlParameter[]{
                new SqlParameter("@record_type",SqlDbType.Int){Value=v_push_type},
                new SqlParameter("@record_key",SqlDbType.VarChar,200){Value=v_push_key},
                new SqlParameter("@push_id",SqlDbType.VarChar,30){Value=mStrPushID},
                new SqlParameter("@message_content",SqlDbType.VarChar,200){Value=v_message_content},
                new SqlParameter("@message_extras",SqlDbType.VarChar,4000){Value=v_message_extras},
                new SqlParameter("@employee_codes",SqlDbType.VarChar,8000){Value=mStrEmployeeCodes},
            };
            int mIntReturn = claSqlConnDB.ExecuteNonQuery(claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL, parameters);
            if (mIntReturn == 1)
            {
                return mStrPushID;
            }
            else
            {
                return "";
            }
        }

        public string GetRegistrationIDsByPushID(string v_push_id)
        {
            string mStrEmployeeRegistration = "";
            string mStrSQL = @"SELECT employee_registration FROM t_PushMessage where push_id=@push_id";
            SqlParameter[] parameters = new SqlParameter[]{
                new SqlParameter("@push_id",SqlDbType.VarChar,30){Value=v_push_id}
            };
            DataTable dt = null;
            using (dt = claSqlConnDB.ExecuteDataset(claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL, parameters).Tables[0])
            {
                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    mStrEmployeeRegistration = dt.Rows[i][0].ToString();
                }
            }
            return mStrEmployeeRegistration;
        }

        public GJHF.Data.Model.PUSH.MPushMsg GetPushMessageDetailByPushID(string v_push_id)
        {
            string mStrSQL = @"SELECT * from t_PushMessage  where push_id=@push_id";
            SqlParameter[] parameters = new SqlParameter[]{
                new SqlParameter("@push_id",SqlDbType.VarChar,30){Value=v_push_id}
            };
            GJHF.Data.Model.PUSH.MPushMsg mMPushMsg = (GJHF.Data.Model.PUSH.MPushMsg)claSqlConnDB.GetDetail(claSqlConnDB.gStrConnDefault, mStrSQL, "GJHF.Data.Model.PUSH.MPushMsg", "GJHF.Data.Model", parameters);
            return mMPushMsg;
        }

        public int UpdateQueryTime(string v_push_id, DateTime v_query_time)
        {
            string mStrSQL = @"UPDATE t_PushMessage SET query_time=@query_time where push_id=@push_id";
            SqlParameter[] parameters = new SqlParameter[]{
                new SqlParameter("@push_id",SqlDbType.VarChar,30){Value=v_push_id},
                new SqlParameter("@query_time",SqlDbType.DateTime){Value=v_query_time}
            };
            return claSqlConnDB.ExecuteNonQuery(claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL, parameters);
        }

        #endregion


    }
}
