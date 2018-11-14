using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using System.Data.SqlClient;

namespace GJHF.Data.MSSQL.PUSH
{
    public class DPushVoiceNotify : GJHF.Data.Interface.PUSH.IPushVoiceNotify
    {
        public int GetPushVoiceNotifyCount(int v_record_type = -100, string v_record_key = "", int v_template_no = -1, DateTime? v_query_starttime = null, DateTime? v_query_endtime = null)
        {
            string mStrSQL = @" SELECT COUNT(0) FROM t_PushVoiceNotify " + GetWhere(v_record_type, v_record_key, v_template_no, v_query_starttime, v_query_endtime);
            return claSqlConnDB.GetRecordCount(claSqlConnDB.gStrConnDefault, mStrSQL);
        }

        public DataTable GetPushVoiceNotifyData(int v_record_type = -100, string v_record_key = "", int v_template_no = -1, DateTime? v_query_starttime = null, DateTime? v_query_endtime = null)
        {
            string mStrSQL = @"SELECT notify_id,notify_time,record_type,record_key,template_no,notify_params,notify_employees,employee_phone,employee_nophone,notify_state,notify_result 
                                FROM t_PushVoiceNotify "
                               + GetWhere(v_record_type, v_record_key, v_template_no, v_query_starttime, v_query_endtime);
            return claSqlConnDB.ExecuteDataset(claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL).Tables[0];
        }

        public DataTable GetPushVoiceNotifyData(int v_record_type = -100, string v_record_key = "", int v_template_no = -1, DateTime? v_query_starttime = null, DateTime? v_query_endtime = null, string v_sort = "", string v_order = "")
        {
            string mStrSQL = @"SELECT notify_id,notify_time,record_type,record_key,template_no,notify_params,notify_employees,employee_phone,employee_nophone,notify_state,notify_result 
                                FROM t_PushVoiceNotify "
                               + GetWhere(v_record_type, v_record_key, v_template_no, v_query_starttime, v_query_endtime)
                               + GetOrder(v_sort, v_order);
            return claSqlConnDB.ExecuteDataset(claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL).Tables[0];
        }

        public DataTable GetPushVoiceNotifyData(int v_page = 1, int v_rows = 10, int v_record_type = -100, string v_record_key = "", int v_template_no = -1, DateTime? v_query_starttime = null, DateTime? v_query_endtime = null, string v_sort = "", string v_order = "")
        {
            string mStrSQL = @"SELECT notify_id,notify_time,record_type,record_key,template_no,notify_params,notify_employees,employee_phone,employee_nophone,notify_state,notify_result 
                                FROM t_PushVoiceNotify "
                               + GetWhere(v_record_type, v_record_key, v_template_no, v_query_starttime, v_query_endtime)
                               + GetOrder(v_sort, v_order);
            return claSqlConnDB.ExecuteDataset(v_rows, v_page, claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL).Tables[0];
        }

        public string AddPushVoiceNotify(DateTime v_record_time, int v_record_type, string v_record_key, int v_template_no, string v_notify_params, string v_notify_employees, string v_employee_phone, string v_employee_nophone)
        {
            string mStrPushNotifyID = COMMON.DGlobal.GetIdentityPushVoiceNotifyID();

            string mStrSQL = @"INSERT INTO t_PushVoiceNotify(notify_id,notify_time,record_type,record_key,template_no,notify_params,notify_employees,employee_phone,employee_nophone)
                             VALUES(@notify_id,@notify_time,@record_type,@record_key,@template_no,@notify_params,@notify_employees,@employee_phone,@employee_nophone)";
            SqlParameter[] parameters = new SqlParameter[]{
                new SqlParameter("@notify_id",SqlDbType.VarChar,30){Value=mStrPushNotifyID},
                new SqlParameter("@notify_time",SqlDbType.DateTime){Value=v_record_time},
                new SqlParameter("@record_type",SqlDbType.Int){Value=v_record_type},
                new SqlParameter("@record_key",SqlDbType.VarChar,200){Value=v_record_key},
                new SqlParameter("@template_no",SqlDbType.Int){Value=v_template_no},
                new SqlParameter("@notify_params",SqlDbType.VarChar,500){Value=v_notify_params},
                new SqlParameter("@notify_employees",SqlDbType.VarChar,2000){Value=v_notify_employees},
                new SqlParameter("@employee_phone",SqlDbType.VarChar,2000){Value=v_employee_phone},
                new SqlParameter("@employee_nophone",SqlDbType.VarChar,2000){Value=v_employee_nophone},
            };
            int mIntReturn = claSqlConnDB.ExecuteNonQuery(claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL, parameters);
            if (mIntReturn >= 0)
            {
                return mStrPushNotifyID;
            }
            else
            {
                return "";
            }
        }

        private string GetWhere(int v_record_type = -100, string v_record_key = "", int v_template_no = -1, DateTime? v_query_starttime = null, DateTime? v_query_endtime = null)
        {
            string mStrWHERE=" WHERE 1=1 ";
            if (v_record_type != -100)
            {
                mStrWHERE = mStrWHERE + " AND record_type=" + v_record_type.ToString() +" ";
            }
            if (v_record_key != "")
            {
                mStrWHERE = mStrWHERE + " AND record_key like '%" + v_record_key + "%' ";
            }
            if (v_template_no != -1)
            {
                mStrWHERE = mStrWHERE + " AND template_no=" + v_template_no.ToString() + " ";
            }
            if (v_query_starttime != null)
            {
                mStrWHERE = mStrWHERE + " AND record_time >= CONVERT(DATETIME, '" + v_query_starttime + "', 102) ";
            }
            if (v_query_endtime != null)
            {
                mStrWHERE = mStrWHERE + " AND record_time <= CONVERT(DATETIME, '" + v_query_endtime + "', 102) ";
            }
            return mStrWHERE;
        }
        private string GetOrder(string v_sort = "", string v_order = "")
        {
            string mStrOrder = "";
            if (v_sort != "")
            {
                mStrOrder = " ORDER BY " + v_sort;
                if (v_order != "")
                {
                    mStrOrder = mStrOrder + " " + v_order;
                }
            }
            return mStrOrder;
        }
    }
}
