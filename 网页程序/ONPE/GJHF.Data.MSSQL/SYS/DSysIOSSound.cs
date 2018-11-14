using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using System.Data.SqlClient;

namespace GJHF.Data.MSSQL.SYS
{
    public class DSysIOSSound:GJHF.Data.Interface.SYS.ISysIOSSound
    {
        #region ISysIOSSound 成员

        public int AddIOSSound(string v_sound_name, string v_sound_code, string v_sound_remark)
        {
            string mStrSQL = @" INSERT INTO t_sys_ios_sound(sound_name,sound_code,sound_remark)VALUES(@sound_name,@sound_code,@sound_remark)";
            SqlParameter[] parameters = new SqlParameter[]{
                new SqlParameter("@sound_name",SqlDbType.VarChar,100){Value=v_sound_name},
                new SqlParameter("@sound_code",SqlDbType.VarChar,200){Value=v_sound_code},
                new SqlParameter("@sound_remark",SqlDbType.VarChar,500){Value=v_sound_remark},
            };
            return claSqlConnDB.ExecuteNonQuery(claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL, parameters);
        }

        public int EditIOSSound(int v_sound_id, string v_sound_name, string v_sound_code, string v_sound_remark)
        {
            string mStrSQL = @" UPDATE  t_sys_ios_sound SET 
                                sound_name=@sound_name,
                                sound_code=@sound_code,
                                sound_remark=@sound_remark
                                WHERE sound_id=@sound_id";
            SqlParameter[] parameters = new SqlParameter[]{
                new SqlParameter("@sound_id",SqlDbType.Int){Value=v_sound_id},
                new SqlParameter("@sound_name",SqlDbType.VarChar,100){Value=v_sound_name},
                new SqlParameter("@sound_code",SqlDbType.VarChar,200){Value=v_sound_code},
                new SqlParameter("@sound_remark",SqlDbType.VarChar,500){Value=v_sound_remark},
            };
            return claSqlConnDB.ExecuteNonQuery(claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL, parameters);
        }

        public int DelIOSSound(int v_sound_id)
        {
            string mStrSQL = @" DELETE FROM   t_sys_ios_sound 
                                WHERE sound_id=@sound_id";
            SqlParameter[] parameters = new SqlParameter[]{
                new SqlParameter("@sound_id",SqlDbType.Int){Value=v_sound_id},
            };
            return claSqlConnDB.ExecuteNonQuery(claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL, parameters);
        }

        public int GetIOSSoundCount(string v_sound_name, string v_sound_code, string v_sound_remark)
        {
            string mStrSQL = @"SELECT count(0) FROM t_sys_ios_sound" + GetWhere(v_sound_name, v_sound_code, v_sound_remark);
            return claSqlConnDB.GetRecordCount(claSqlConnDB.gStrConnDefault, mStrSQL);
        }

        public System.Data.DataTable GetIOSSoundData(string v_sound_name, string v_sound_code, string v_sound_remark)
        {
            string mStrSQL = @"SELECT sound_id,sound_name,sound_code,sound_remark FROM t_sys_ios_sound" + GetWhere(v_sound_name, v_sound_code, v_sound_remark);
            return claSqlConnDB.ExecuteDataset(claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL).Tables[0];
        }

        public System.Data.DataTable GetIOSSoundData(string v_sound_name, string v_sound_code, string v_sound_remark, string v_sort, string v_order)
        {
            string mStrSQL = @"SELECT sound_id,sound_name,sound_code,sound_remark FROM t_sys_ios_sound"
                + GetWhere(v_sound_name, v_sound_code, v_sound_remark)
                + GetOrder(v_sort, v_order);
            return claSqlConnDB.ExecuteDataset(claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL).Tables[0];
        }

        public System.Data.DataTable GetIOSSoundData(int v_page, int v_rows, string v_sound_name, string v_sound_code, string v_sound_remark, string v_sort, string v_order)
        {
            string mStrSQL = @"SELECT sound_id,sound_name,sound_code,sound_remark FROM t_sys_ios_sound"
                + GetWhere(v_sound_name, v_sound_code, v_sound_remark)
                + GetOrder(v_sort, v_order);
            return claSqlConnDB.ExecuteDataset(v_rows, v_page, claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL).Tables[0];
        }

        #endregion

        private string GetWhere(string v_sound_name, string v_sound_code, string v_sound_remark)
        {
            string mStrWhere = " WHERE 1=1 ";
            if (v_sound_name != "")
            {
                mStrWhere = mStrWhere + " AND t_sys_ios_sound.sound_name like '%" + v_sound_name + "%' ";
            }
            if (v_sound_code != "")
            {
                mStrWhere = mStrWhere + " AND t_sys_ios_sound.sound_code like '%" + v_sound_code + "%' ";
            }
            if (v_sound_remark != "")
            {
                mStrWhere = mStrWhere + " AND t_sys_ios_sound.sound_remark like '%" + v_sound_remark + "%' ";
            }
            return mStrWhere;
        }
        private string GetOrder(string v_sort, string v_order)
        {
            string mStrOrder = "";
            if (v_sort != "")
            {
                mStrOrder = " ORDER BY t_sys_ios_sound." + v_sort;
                if (v_order != "")
                {
                    mStrOrder = mStrOrder + " " + v_order;
                }
            }
            return mStrOrder;
        }
    }
}
