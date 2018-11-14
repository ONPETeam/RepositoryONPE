using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using System.Data.SqlClient;

namespace GJHF.Data.MSSQL.PUSH
{
    public class DPushVoiceNotifyResult:GJHF.Data.Interface.PUSH.IPushVoiceNotifyResult
    {
        public int AddVoiceNotifyResult(int v_record_type, string v_record_key, string v_notify_id, string v_user_id, string v_user_phone, int v_notify_state, string v_state_remark, string v_notify_key)
        {
            string mStrNotifyResultID=COMMON.DGlobal.GetIdentityPushVoiceNotifyResultID();
            DateTime mDtmCreateTime=System.DateTime.Now;
            DateTime mDtmInitTime=DateTime.Parse("1900-01-01 00:00:00");
            string mStrSQL = @"INSERT INTO t_Push_voice_notify_result(data_id,record_type,record_key,notify_id,user_id ,user_phone,notify_state,state_remark,create_time,answer_time,release_time,result_key)
                            VALUES(@data_id,@record_type,@record_key,@notify_id,@user_id ,@user_phone,@notify_state,@state_remark,@create_time,@answer_time,@release_time,@result_key)";
            SqlParameter[] parameters = new SqlParameter[]{
                new SqlParameter("@data_id",SqlDbType.VarChar,30){Value=mStrNotifyResultID},
                new SqlParameter("@record_type",SqlDbType.Int){Value=v_record_type},
                new SqlParameter("@record_key",SqlDbType.VarChar,200){Value=v_record_key},
                new SqlParameter("@notify_id",SqlDbType.VarChar,30){Value=v_notify_id},
                new SqlParameter("@user_id",SqlDbType.VarChar,100){Value=v_user_id},
                new SqlParameter("@user_phone",SqlDbType.VarChar,20){Value=v_user_phone},
                new SqlParameter("@notify_state",SqlDbType.Int){Value=v_notify_state},
                new SqlParameter("@state_remark",SqlDbType.VarChar,200){Value=v_state_remark},
                new SqlParameter("@create_time",SqlDbType.DateTime){Value=mDtmCreateTime},
                new SqlParameter("@answer_time",SqlDbType.DateTime){Value=mDtmInitTime},
                new SqlParameter("@release_time",SqlDbType.DateTime){Value=mDtmInitTime},
                new SqlParameter("@result_key",SqlDbType.VarChar,100){Value=v_notify_key},
            };
            return claSqlConnDB.ExecuteNonQuery(claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL, parameters);
        }

        public int GetVoiceNotifyResultCount(int v_record_type, string v_record_key)
        {
            string mStrSQL = @"SELECT COUNT(0) FROM t_Push_voice_notify_result " + GetWhere(v_record_type, v_record_key);
            return claSqlConnDB.GetRecordCount(claSqlConnDB.gStrConnDefault, mStrSQL);
        }

        public DataTable GetVoiceNotifyResultData(int v_record_type, string v_record_key)
        {
            string mStrSQL = @" SELECT data_id,record_type,record_key,notify_id,user_id ,user_phone,notify_state,state_remark,create_time,answer_time,release_time,result_key  FROM t_Push_voice_notify_result "
                + GetWhere(v_record_type, v_record_key);
            return claSqlConnDB.ExecuteDataset(claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL).Tables[0];
        }

        public string GetWhere(int v_record_type, string v_record_key)
        {
            string mStrWHERE = " WHERE 1=1 ";
            if (v_record_type != -99)
            {
                mStrWHERE = mStrWHERE + " AND record_type=" + v_record_type + " ";
            }
            if (v_record_key != "")
            {
                mStrWHERE = mStrWHERE + " AND record_key='" + v_record_key + "' ";
            }
            return mStrWHERE;
        }
    }
}
