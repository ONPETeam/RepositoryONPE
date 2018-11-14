using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using System.Data.SqlClient;

namespace GJHF.Data.MSSQL.SYS
{
    public class DSysAndroidBuildID:GJHF.Data.Interface.SYS.ISysAndroidBuildID
    {
        #region ISysAndroidBuildID 成员

        public int AddAndroidBuildID(string v_build_name, int v_build_id, string v_build_remark)
        {
            string mStrSQL = @" INSERT INTO t_sys_android_buildid(build_name,build_id,build_remark)VALUES(@build_name,@build_id,@build_remark)";
            SqlParameter[] parameters = new SqlParameter[]{
                new SqlParameter("@build_name",SqlDbType.VarChar,100){Value=v_build_name},
                new SqlParameter("@build_id",SqlDbType.Int){Value=v_build_id},
                new SqlParameter("@build_remark",SqlDbType.VarChar,500){Value=v_build_remark},
            };
            return claSqlConnDB.ExecuteNonQuery(claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL, parameters);
        }

        public int EditAndroidBuildID(int v_data_id, string v_build_name, int v_build_id, string v_build_remark)
        {
            string mStrSQL = @" UPDATE  t_sys_android_buildid SET 
                                build_name=@build_name,
                                build_id=@build_id,
                                build_remark=@build_remark
                                WHERE data_id=@data_id";
            SqlParameter[] parameters = new SqlParameter[]{
                new SqlParameter("@data_id",SqlDbType.Int){Value=v_data_id},
                new SqlParameter("@build_name",SqlDbType.VarChar,100){Value=v_build_name},
                new SqlParameter("@build_id",SqlDbType.Int){Value=v_build_id},
                new SqlParameter("@build_remark",SqlDbType.VarChar,500){Value=v_build_remark},
            };
            return claSqlConnDB.ExecuteNonQuery(claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL, parameters);
        }

        public int DelAndroidBuildID(int v_data_id)
        {
            string mStrSQL = @" DELETE FROM  t_sys_android_buildid 
                                WHERE data_id=@data_id";
            SqlParameter[] parameters = new SqlParameter[]{
                new SqlParameter("@data_id",SqlDbType.Int){Value=v_data_id},
            };
            return claSqlConnDB.ExecuteNonQuery(claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL, parameters);
        }

        public int GetAndroidBuildIDCount(string v_build_name, string v_build_remark, int v_build_id = -1)
        {
            string mStrSQL = @"SELECT count(0) FROM t_sys_android_buildid" + GetWhere(v_build_name, v_build_remark, v_build_id);
            return claSqlConnDB.GetRecordCount(claSqlConnDB.gStrConnDefault, mStrSQL);
        }

        public DataTable GetAndroidBuildIDData(string v_build_name, string v_build_remark, int v_build_id = -1)
        {
            string mStrSQL = @"SELECT data_id,build_name,build_id,build_remark FROM t_sys_android_buildid" + GetWhere(v_build_name, v_build_remark, v_build_id);
            return claSqlConnDB.ExecuteDataset(claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL).Tables[0];
        }

        public DataTable GetAndroidBuildIDData(string v_build_name, string v_build_remark, string v_sort, string v_order, int v_build_id = -1)
        {
            string mStrSQL = @"SELECT data_id,build_name,build_id,build_remark FROM t_sys_android_buildid"
                + GetWhere(v_build_name, v_build_remark, v_build_id)
                + GetOrder(v_sort, v_order);
            return claSqlConnDB.ExecuteDataset(claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL).Tables[0];
        }

        public DataTable GetAndroidBuildIDData(int v_page, int v_rows, string v_build_name, string v_build_remark, string v_sort, string v_order, int v_build_id = -1)
        {
            string mStrSQL = @"SELECT data_id,build_name,build_id,build_remark FROM t_sys_android_buildid"
               + GetWhere(v_build_name, v_build_remark, v_build_id)
               + GetOrder(v_sort, v_order);
            return claSqlConnDB.ExecuteDataset(v_rows, v_page, claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL).Tables[0];
        }

        #endregion

        private string GetWhere(string v_build_name, string v_build_remark, int v_build_id = -1)
        {
            string mStrWhere = " WHERE 1=1 ";
            if (v_build_name != "")
            {
                mStrWhere = mStrWhere + " AND t_sys_android_buildid.build_name like '%" + v_build_name + "%' ";
            }
            if (v_build_remark != "")
            {
                mStrWhere = mStrWhere + " AND t_sys_android_buildid.build_remark like '%" + v_build_remark + "%' ";
            }
            if (v_build_id != -1)
            {
                mStrWhere = mStrWhere + " AND t_sys_android_buildid.build_id=" + v_build_id + " ";
            }
            return mStrWhere;
        }
        private string GetOrder(string v_sort, string v_order)
        {
            string mStrOrder = "";
            if (v_sort != "")
            {
                mStrOrder = " ORDER BY t_sys_android_buildid." + v_sort;
                if (v_order != "")
                {
                    mStrOrder = mStrOrder + " " + v_order;
                }
            }
            return mStrOrder;
        }
    }
}
