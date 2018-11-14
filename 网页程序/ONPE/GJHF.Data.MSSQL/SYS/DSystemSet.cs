using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using System.Data.SqlClient;

namespace GJHF.Data.MSSQL.SYS
{
    public class DSystemSet:Interface.SYS.ISystemSet
    {
        #region INetworkAlarm 成员

        public string GetSystemSet(string v_set_key)
        {
            byte[] m_set_context = null;
            string mStrSQL = @"SELECT set_context FROM t_sys_set where set_key=@set_key";
            SqlParameter[] parameters = new SqlParameter[]{
                new SqlParameter("@set_key",SqlDbType.VarChar,100){Value=v_set_key}
            };
            DataTable dt=null;
            using (dt = claSqlConnDB.ExecuteDataset(claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL, parameters).Tables[0])
            {
                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    m_set_context = (byte[])dt.Rows[i][0];
                }
            }
            return GJHF.Utility.Convert.ConvertByteToString(m_set_context);
        }

        public int SaveSystemSet(string v_set_key, string v_set_context)
        {
            int mIntKeyCount = GetSystemSetCount(v_set_key);
            if (mIntKeyCount > 0)
            {
                return UpdateSystemSet(v_set_key, GJHF.Utility.Convert.ConvertStringToByte(v_set_context));
            }
            else
            {
                return AddSystemSet(v_set_key, GJHF.Utility.Convert.ConvertStringToByte(v_set_context));
            }
        }

        public Model.SYS.MNetworkWriteContext GetLastWriteContext()
        {
            string mStrSQL = @"SELECT  dIntBJ as alarm_id, dVchFwq as alarm_server_code, dDaeGengxinTime as alarm_last_write_time, dVchRemark as alarm_remark
                            FROM   tZplcXr";
            return (Model.SYS.MNetworkWriteContext)claSqlConnDB.GetDetail(claSqlConnDB.gStrConnDefault, mStrSQL, "GJHF.Data.Model.SYS.MNetworkWriteContext", "GJHF.Data.Model", null);
        }

        #endregion

        

        private int GetSystemSetCount(string v_set_key)
        {
            string mStrSQL = @"SELECT COUNT(0) FROM t_sys_set where set_key=@set_key";
            SqlParameter[] parameters = new SqlParameter[]{
                new SqlParameter("@set_key",SqlDbType.VarChar,100){Value=v_set_key}
            };
            return claSqlConnDB.GetRecordCount(claSqlConnDB.gStrConnDefault, mStrSQL, parameters);
        }
        private int AddSystemSet(string v_set_key, byte[] v_set_context)
        {
            string mStrSQL = @"INSERT INTO t_sys_set (set_key,set_context)VALUES(@set_key,@set_context)";
            SqlParameter[] parameters = new SqlParameter[]{
                new SqlParameter("@set_context",SqlDbType.Image){Value=v_set_context},
                new SqlParameter("@set_key",SqlDbType.VarChar,100){Value=v_set_key}
            };
            return claSqlConnDB.ExecuteNonQuery(claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL, parameters);
        }
        private int UpdateSystemSet(string v_set_key, byte[] v_set_context)
        {
            string mStrSQL = @"UPDATE t_sys_set set set_context=@set_context where set_key=@set_key";
            SqlParameter[] parameters = new SqlParameter[]{
                new SqlParameter("@set_context",SqlDbType.Image){Value=v_set_context},
                new SqlParameter("@set_key",SqlDbType.VarChar,100){Value=v_set_key}
            };
            return claSqlConnDB.ExecuteNonQuery(claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL, parameters);
        }

       
    }
}
