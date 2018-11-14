using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using System.Data.SqlClient;
using GJHF.Data.Interface.PUSH;

namespace GJHF.Data.MSSQL.PUSH
{
    public class DPushResult : IPushResult
    {

        #region IPushResult 成员

        public int SavePushInfo(int v_record_type, string v_record_key, string v_push_id, int v_send_no, string v_msg_id, Dictionary<string, string> v_employee_registration, HashSet<string> v_noregistration_userid)
        {
            int j = 1;
            string mStrSQL = @"UPDATE t_PushMessage SET 
                               send_no=@send_no,
                               msg_id =@msg_id,
                               employee_registration=@employee_registration,
                               no_registration=@no_registration,
                               is_push=1
                               WHERE push_id=@push_id";
            SqlParameter[] parameters = new SqlParameter[] { 
                new SqlParameter("@push_id",SqlDbType.VarChar,30){Value=v_push_id},
                new SqlParameter("@send_no",SqlDbType.Int,4){Value=v_send_no},
                new SqlParameter("@msg_id",SqlDbType.VarChar,50){Value=v_msg_id},
                new SqlParameter("@employee_registration",SqlDbType.VarChar,int.MaxValue){Value=Newtonsoft.Json.JsonConvert.SerializeObject(v_employee_registration)},
                new SqlParameter("@no_registration",SqlDbType.VarChar,int.MaxValue){Value=Newtonsoft.Json.JsonConvert.SerializeObject(v_noregistration_userid)},
            };
            int i = claSqlConnDB.ExecuteNonQuery(claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL, parameters);
            if (i == 1)
            {
                foreach (KeyValuePair<string, string> kv in v_employee_registration)
                {
                    string mStrDetailID = COMMON.DGlobal.GetIdentityPushMessageResultDetailID();
                    if (string.IsNullOrEmpty(kv.Value))
                    {
                        mStrSQL = @"INSERT INTO t_ResultDetail(record_type,record_key,detail_id,push_id,employee_code,is_push,push_remark)
                                VALUES(@record_type,@record_key,@detail_id,@push_id,@employee_code,0,'未获取用户设备注册号')";
                        SqlParameter[] parametersDetail = new SqlParameter[] { 
                            new SqlParameter("@record_type",SqlDbType.Int){Value=v_record_type},
                            new SqlParameter("@record_key",SqlDbType.VarChar,200){Value=v_record_key},
                            new SqlParameter("@detail_id",SqlDbType.VarChar,30){Value=mStrDetailID},
                            new SqlParameter("@push_id",SqlDbType.VarChar,30){Value=v_push_id},
                            new SqlParameter("@employee_code",SqlDbType.VarChar,100){Value=kv.Key},
                        };
                        if (claSqlConnDB.ExecuteNonQuery(claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL, parametersDetail) != 1)
                        {
                            j = j - 1;
                        }
                    }
                    else
                    {
                        mStrSQL = @"INSERT INTO t_ResultDetail(record_type,record_key,detail_id,push_id,employee_code,registration_id,is_push,push_remark)
                                VALUES(@record_type,@record_key,@detail_id,@push_id,@employee_code,@registration_id,1,'')";
                        SqlParameter[] parametersDetail = new SqlParameter[] { 
                            new SqlParameter("@record_type",SqlDbType.Int){Value=v_record_type},
                            new SqlParameter("@record_key",SqlDbType.VarChar,200){Value=v_record_key},
                            new SqlParameter("@detail_id",SqlDbType.VarChar,30){Value=mStrDetailID},
                            new SqlParameter("@push_id",SqlDbType.VarChar,30){Value=v_push_id},
                            new SqlParameter("@employee_code",SqlDbType.VarChar,100){Value=kv.Key},
                            new SqlParameter("@registration_id",SqlDbType.VarChar,50){Value=kv.Value},
                        };
                        if (claSqlConnDB.ExecuteNonQuery(claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL, parametersDetail) != 1)
                        {
                            j = j - 1;
                        }
                    }
                }
            }
            else
            {
                j = 0;
            }
            return j;
        }

        public int SavePushRecived(string v_push_id, int v_android_received, int v_ios_apns_sent, int v_ios_apns_received, int v_ios_msg_received, int v_wp_mpns_sent)
        {
            int mIntReturn = 0;
            string mStrResultID = COMMON.DGlobal.GetIdentityPushMessagePushResultID();
            string mStrSQL = "";
            mStrSQL = @"INSERT INTO t_PushResult(result_id,android_received,ios_apns_sent,ios_apns_received,ios_msg_received,wp_mpns_sent)
                     VALUES(@result_id,@android_received,@ios_apns_sent,@ios_apns_received,@ios_msg_received,@wp_mpns_sent)";
            SqlParameter[] parameters = new SqlParameter[] { 
                new SqlParameter("@result_id",SqlDbType.VarChar,30){Value=mStrResultID},
                new SqlParameter("@android_received",SqlDbType.Int,4){Value=v_android_received},
                new SqlParameter("@ios_apns_sent",SqlDbType.Int,4){Value=v_ios_apns_sent},
                new SqlParameter("@ios_apns_received",SqlDbType.Int,4){Value=v_ios_apns_received},
                new SqlParameter("@ios_msg_received",SqlDbType.Int,4){Value=v_ios_msg_received},
                new SqlParameter("@wp_mpns_sent",SqlDbType.Int,4){Value=v_wp_mpns_sent},
            };
            int mIntSaveRecived = claSqlConnDB.ExecuteNonQuery(claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL, parameters);
            if (mIntSaveRecived == 1)
            {
                mStrSQL = "UPDATE t_PushMessage SET result_id=@result_id WHERE push_id=@push_id";
                SqlParameter[] parameters_unio = new SqlParameter[]{
                     new SqlParameter("@push_id",SqlDbType.VarChar,30){Value=v_push_id},
                     new SqlParameter("@result_id",SqlDbType.VarChar,30){Value=mStrResultID},
                };
                mIntReturn = claSqlConnDB.ExecuteNonQuery(claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL, parameters_unio);

            }
            else
            {
                mIntReturn = -1;
            }
            return mIntReturn;
        }

        public int SavePushResultDetail(string v_push_id, string v_registration_id, int v_detail_status)
        {
            int mIntIsPush = 0;
            int mIntIsReceive = 0;
            if (v_detail_status == 1)
            {
                mIntIsPush = 1;
            }
            mIntIsReceive = v_detail_status;
            string mStrDetailID = COMMON.DGlobal.GetIdentityPushMessageResultDetailID();
            string mStrSQL = "";
            if (mIntIsPush == 1)
            {
                mStrSQL = @"UPDATE t_ResultDetail set is_push=@is_push ,is_received=@is_receive 
                               WHERE push_id=@push_id and registration_id=@registration_id";
                SqlParameter[] parameters = new SqlParameter[]{
                     new SqlParameter("@is_push",SqlDbType.Int){Value=mIntIsPush},
                     new SqlParameter("@is_receive",SqlDbType.Int){Value=mIntIsReceive},
                     new SqlParameter("@push_id",SqlDbType.VarChar,30){Value=v_push_id},
                     new SqlParameter("@registration_id",SqlDbType.VarChar,100){Value=v_registration_id},
                };
                return claSqlConnDB.ExecuteNonQuery(claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL, parameters);
            }
            else
            {
                mStrSQL = @"UPDATE t_ResultDetail set is_received=@is_receive 
                               WHERE push_id=@push_id and registration_id=@registration_id";
                SqlParameter[] parameters = new SqlParameter[]{
                     new SqlParameter("@is_receive",SqlDbType.Int){Value=mIntIsReceive},
                     new SqlParameter("@push_id",SqlDbType.VarChar,30){Value=v_push_id},
                     new SqlParameter("@registration_id",SqlDbType.VarChar,100){Value=v_registration_id},
                };
                return claSqlConnDB.ExecuteNonQuery(claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL, parameters);
            }
        }

        public DataTable GetPushResultDetails(string v_push_id)
        {

            string mStrSQL = @"SELECT     t_ResultDetail.detail_id, t_ResultDetail.push_id, t_ResultDetail.employee_code, t_Employee.employee_name, t_ResultDetail.registration_id, t_ResultDetail.is_push, t_ResultDetail.push_remark, 
                                          t_ResultDetail.is_received, t_ResultDetail.is_confirm, t_ResultDetail.confirm_time, t_ResultDetail.push_time, t_ResultDetail.record_type, t_ResultDetail.record_key
                             FROM         t_Employee RIGHT OUTER JOIN
                                          t_ResultDetail ON t_Employee.user_id = t_ResultDetail.employee_code  WHERE t_ResultDetail.push_id=@push_id";
            SqlParameter[] parameters = new SqlParameter[]{
                new SqlParameter("@push_id",SqlDbType.VarChar,30){Value=v_push_id},
            };
            return claSqlConnDB.ExecuteDataset(claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL, parameters).Tables[0];
        }

        /// <summary>
        /// 确认推送信息
        /// </summary>
        /// <param name="v_push_id">推送编号</param>
        /// <param name="v_user_id">用户编号</param>
        /// <param name="v_confirm_time">确认时间</param>
        /// <returns></returns>
        public int ConfirmPush(string v_push_id, string v_user_id, DateTime v_confirm_time)
        {
            string mStrSQL = @"UPDATE t_ResultDetail SET is_push=1,is_received=1, is_confirm=1 , confirm_time=@confirm_time WHERE push_id=@push_id and employee_code=@employee_code";
            SqlParameter[] parameters = new SqlParameter[]{
                new SqlParameter("@push_id",SqlDbType.VarChar,30){Value=v_push_id},
                new SqlParameter("@employee_code",SqlDbType.VarChar,100){Value=v_user_id},
                new SqlParameter("@confirm_time",SqlDbType.DateTime){Value=v_confirm_time}
            };
            return claSqlConnDB.ExecuteNonQuery(claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL, parameters);
        }
        #endregion
    }
}
