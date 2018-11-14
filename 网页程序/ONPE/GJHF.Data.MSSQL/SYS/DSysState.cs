using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using System.Data.SqlClient;

namespace GJHF.Data.MSSQL.SYS
{
    public class DSysState:Interface.SYS.ISysState
    {
        #region ISysState 成员

        public int AddSysState(string v_sys_state_name, string v_sys_state_code, string v_sys_state_remark)
        {
            string mStrSQL = @"INSERT INTO t_sys_state(sys_state_name,sys_state_code,sys_state_remark)VALUES(@sys_state_name,@sys_state_code,@sys_state_remark)";
            SqlParameter[] parameters = new SqlParameter[]{
                new SqlParameter("@sys_state_name",SqlDbType.VarChar,100){Value=v_sys_state_name.Substring(0,100)},
                new SqlParameter("@sys_state_code",SqlDbType.VarChar,20){Value=v_sys_state_code.Substring(0,20)},
                new SqlParameter("@sys_state_remark",SqlDbType.VarChar,200){Value=v_sys_state_remark.Substring(0,200)},
            };
            return claSqlConnDB.ExecuteNonQuery(claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL, parameters);

        }

        public int UpdateSysState(int v_sys_state_id, string v_sys_state_name, string v_sys_state_code, string v_sys_state_remark)
        {
            string mStrSQL = @"UPDATE  t_sys_state SET 
                                sys_state_name=@sys_state_name,
                                sys_state_code=@sys_state_code,
                                sys_state_remark=@sys_state_remark
                                WHERE sys_state_id=@sys_state_id";
            SqlParameter[] parameters = new SqlParameter[]{
                new SqlParameter("@sys_state_id",SqlDbType.Int){Value=v_sys_state_id},
                new SqlParameter("@sys_state_name",SqlDbType.VarChar,100){Value=v_sys_state_name.Substring(0,100)},
                new SqlParameter("@sys_state_code",SqlDbType.VarChar,20){Value=v_sys_state_code.Substring(0,20)},
                new SqlParameter("@sys_state_remark",SqlDbType.VarChar,200){Value=v_sys_state_remark.Substring(0,200)},
            };
            return claSqlConnDB.ExecuteNonQuery(claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL, parameters);
        }

        public int UpdateSysState(int v_sys_state_id, int v_sys_state_value)
        {
            string mStrSQL = @"UPDATE  t_sys_state SET 
                                sys_state_value=@sys_state_value
                                WHERE sys_state_id=@sys_state_id";
            SqlParameter[] parameters = new SqlParameter[]{
                new SqlParameter("@sys_state_id",SqlDbType.Int){Value=v_sys_state_id},
                new SqlParameter("@sys_state_value",SqlDbType.Int){Value=v_sys_state_value},
            };
            return claSqlConnDB.ExecuteNonQuery(claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL, parameters);
        }
        public int GetSysStateValue(int v_sys_state_id)
        {
            string mStrSQL = @"SELECT sys_state_value FROM   t_sys_state 
                                WHERE sys_state_id=@sys_state_id";
            SqlParameter[] parameters = new SqlParameter[]{
                new SqlParameter("@sys_state_id",SqlDbType.Int){Value=v_sys_state_id},
            };
            Model.SYS.MSysState mMSysState = new Model.SYS.MSysState();
            mMSysState = (Model.SYS.MSysState)claSqlConnDB.GetDetail(claSqlConnDB.gStrConnDefault, mStrSQL, "GJHF.Data.Model.SYS.MSysState", "GJHF.Data.Model", parameters);
            if (mMSysState != null && mMSysState.sys_state_vaue != null)
            {
                return mMSysState.sys_state_vaue;
            }
            else
            {
                return -100;
            }
        }
        public int DelSysState(int v_sys_state_id)
        {
            string mStrSQL = @"DELETE FROM   t_sys_state 
                                WHERE sys_state_id=@sys_state_id";
            SqlParameter[] parameters = new SqlParameter[]{
                new SqlParameter("@sys_state_id",SqlDbType.Int){Value=v_sys_state_id},
            };
            return claSqlConnDB.ExecuteNonQuery(claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL, parameters);
        }

        public int GetSysStateCount(string v_sys_state_name, string v_sys_state_code)
        {
            string mStrSQL = @"SELECT COUNT(0) FROM t_sys_state " + GetWhere(v_sys_state_name, v_sys_state_code);
            return claSqlConnDB.GetRecordCount(claSqlConnDB.gStrConnDefault, mStrSQL);
        }

        public DataTable GetSysState(string v_sys_state_name, string v_sys_state_code)
        {
            string mStrSQL = @"SELECT sys_state_id,sys_state_name,sys_state_code,sys_state_value,sys_state_remark FROM t_sys_state"
                    + GetWhere(v_sys_state_name, v_sys_state_code);
            return claSqlConnDB.ExecuteDataset(claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL).Tables[0];
        }

        public DataTable GetSysState(string v_sys_state_name, string v_sys_state_code, string v_sort, string v_order)
        {
            string mStrSQL = @"SELECT sys_state_id,sys_state_name,sys_state_code,sys_state_value,sys_state_remark FROM t_sys_state"
                    + GetWhere(v_sys_state_name, v_sys_state_code) + GetOrder(v_sort, v_order);
            return claSqlConnDB.ExecuteDataset(claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL).Tables[0];
        }

        public DataTable GetSysState(int v_page, int v_rows, string v_sys_state_name, string v_sys_state_code, string v_sort, string v_order)
        {
            string mStrSQL = @"SELECT sys_state_id,sys_state_name,sys_state_code,sys_state_value,sys_state_remark FROM t_sys_state"
                    + GetWhere(v_sys_state_name, v_sys_state_code) + GetOrder(v_sort, v_order);
            return claSqlConnDB.ExecuteDataset(v_rows, v_page,claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL).Tables[0];
        }

        #endregion

        private string GetWhere(string v_sys_state_name, string v_sys_state_code)
        {
            string mStrWhere = " WHERE 1=1 ";
            if (v_sys_state_name != "")
            {
                mStrWhere = " AND t_sys_state.sys_state_name like '%" + v_sys_state_name + "%'";
            }
            if (v_sys_state_code != "")
            {
                mStrWhere = " AND t_sys_state.sys_state_code like '%" + v_sys_state_code + "%'";
            }
            return mStrWhere;
        }
        private string GetOrder(string v_sort, string v_order)
        {
            string mStrOrder = "";
            if (v_sort != "")
            {
                mStrOrder = " ORDER BY t_sys_state." + v_sort;
                if (v_order != "")
                {
                    mStrOrder = mStrOrder + " " + v_order; 
                }
            }
            return mStrOrder;
        }
    }
}
