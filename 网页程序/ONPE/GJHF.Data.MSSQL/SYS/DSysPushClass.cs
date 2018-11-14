using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using System.Data.SqlClient;
namespace GJHF.Data.MSSQL.SYS
{
    public class DSysPushClass:GJHF.Data.Interface.SYS.ISysPushClass
    {
        #region ISysPushClass 成员

        public int AddPushClass(string v_class_name, string v_class_remark, int v_android_buildid=0, int v_ios_sound=0)
        {
            string m_push_class_name = v_class_name;
            string m_push_class_id;
            if (m_push_class_name == "") return -1;
            m_push_class_id=COMMON.DGlobal.GetIdentityPushClassClassID();
            string mStrSQL = @"INSERT INTO t_sys_push_class(class_id,class_name,class_remark,android_buildid,ios_sound)
                            VALUES(@class_id,@class_name,@class_remark,@android_buildid,@ios_sound)";
            SqlParameter[] parameters = new SqlParameter[]{
                new SqlParameter("@class_id",SqlDbType.VarChar,30){Value=m_push_class_id},
                new SqlParameter("@class_name",SqlDbType.VarChar,100){Value=v_class_name},
                new SqlParameter("@class_remark",SqlDbType.VarChar,200){Value=v_class_remark},
                new SqlParameter("@android_buildid",SqlDbType.Int){Value=v_android_buildid},
                new SqlParameter("@ios_sound",SqlDbType.Int){Value=v_ios_sound}
            };
            return claSqlConnDB.ExecuteNonQuery(claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL, parameters);
        }

        public int EditPushClass(string v_class_id, string v_class_name, string v_class_remark, int v_android_buildid = 0, int v_ios_sound = 0)
        {
            string m_push_class_name = v_class_name;
            string m_push_class_id = v_class_id;
            if (m_push_class_id == "" || m_push_class_name == "") return -1;
            string mStrSQL = @"UPDATE t_sys_push_class SET
                            class_name=@class_name,
                            class_remark=@class_remark,
                            android_buildid=@android_buildid,
                            ios_sound=@ios_sound
                            WHERE class_id=@class_id";
            SqlParameter[] parameters = new SqlParameter[]{
                new SqlParameter("@class_id",SqlDbType.VarChar,30){Value=v_class_id},
                new SqlParameter("@class_name",SqlDbType.VarChar,100){Value=v_class_name},
                new SqlParameter("@class_remark",SqlDbType.VarChar,200){Value=v_class_remark},
                new SqlParameter("@android_buildid",SqlDbType.Int){Value=v_android_buildid},
                new SqlParameter("@ios_sound",SqlDbType.Int){Value=v_ios_sound}
            };
            return claSqlConnDB.ExecuteNonQuery(claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL, parameters);
        }

        public int DelPushClass(string v_class_id)
        {
            string mStrSQL = @"DELETE FROM t_sys_push_class WHERE class_id=@class_id";
            SqlParameter[] parameters = new SqlParameter[]{
                new SqlParameter("@class_id",SqlDbType.VarChar,30){Value=v_class_id},
            };
            return claSqlConnDB.ExecuteNonQuery(claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL, parameters);
        }

        public int GetPushClassCount(string v_class_name, string v_class_remark, int v_android_buildid = -1, int v_ios_sound = -1)
        {
            string mStrSQL = @" SELECT COUNT(0) 
                                FROM      t_sys_ios_sound RIGHT OUTER JOIN
                                          t_sys_push_class ON t_sys_ios_sound.sound_id = t_sys_push_class.ios_sound LEFT OUTER JOIN
                                          t_sys_android_buildid ON t_sys_push_class.android_buildid = t_sys_android_buildid.data_id " 
                    + GetWhere(v_class_name, v_class_remark, v_ios_sound, v_android_buildid);
            return claSqlConnDB.GetRecordCount(claSqlConnDB.gStrConnDefault, mStrSQL);
        }

        public DataTable GetPushClassData(string v_class_name, string v_class_remark, int v_android_buildid = -1, int v_ios_sound = -1)
        {
            string mStrSQL = @"SELECT     t_sys_push_class.class_id, t_sys_push_class.class_name, t_sys_push_class.class_remark, t_sys_android_buildid.data_id AS android_buildid_id, 
                                          t_sys_android_buildid.build_name AS android_buildid_name, t_sys_ios_sound.sound_id AS ios_sound_id, t_sys_ios_sound.sound_name AS ios_sound_name
                                FROM      t_sys_ios_sound RIGHT OUTER JOIN
                                          t_sys_push_class ON t_sys_ios_sound.sound_id = t_sys_push_class.ios_sound LEFT OUTER JOIN
                                          t_sys_android_buildid ON t_sys_push_class.android_buildid = t_sys_android_buildid.data_id"
                    + GetWhere(v_class_name, v_class_remark, v_ios_sound, v_android_buildid);
            return claSqlConnDB.ExecuteDataset(claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL).Tables[0];
        }

        public DataTable GetPushClassData(string v_class_name, string v_class_remark, string v_sort, string v_order, int v_android_buildid = -1, int v_ios_sound = -1)
        {
            string mStrSQL = @"SELECT     t_sys_push_class.class_id, t_sys_push_class.class_name, t_sys_push_class.class_remark, t_sys_android_buildid.data_id AS android_buildid_id, 
                                          t_sys_android_buildid.build_name AS android_buildid_name, t_sys_ios_sound.sound_id AS ios_sound_id, t_sys_ios_sound.sound_name AS ios_sound_name
                                FROM      t_sys_ios_sound RIGHT OUTER JOIN
                                          t_sys_push_class ON t_sys_ios_sound.sound_id = t_sys_push_class.ios_sound LEFT OUTER JOIN
                                          t_sys_android_buildid ON t_sys_push_class.android_buildid = t_sys_android_buildid.data_id"
                    + GetWhere(v_class_name, v_class_remark, v_ios_sound, v_android_buildid)
                    + GetOrder(v_sort, v_order);
            return claSqlConnDB.ExecuteDataset(claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL).Tables[0];
        }

        public DataTable GetPushClassData(int v_page, int v_rows, string v_class_name, string v_class_remark, string v_sort, string v_order, int v_android_buildid = -1, int v_ios_sound = -1)
        {
            string mStrSQL = @"SELECT     t_sys_push_class.class_id, t_sys_push_class.class_name, t_sys_push_class.class_remark, t_sys_android_buildid.data_id AS android_buildid_id, 
                                          t_sys_android_buildid.build_name AS android_buildid_name, t_sys_ios_sound.sound_id AS ios_sound_id, t_sys_ios_sound.sound_name AS ios_sound_name
                                FROM      t_sys_ios_sound RIGHT OUTER JOIN
                                          t_sys_push_class ON t_sys_ios_sound.sound_id = t_sys_push_class.ios_sound LEFT OUTER JOIN
                                          t_sys_android_buildid ON t_sys_push_class.android_buildid = t_sys_android_buildid.data_id"
                    + GetWhere(v_class_name, v_class_remark, v_ios_sound, v_android_buildid)
                    + GetOrder(v_sort, v_order);
            return claSqlConnDB.ExecuteDataset(v_rows, v_page, claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL).Tables[0];
        }

        public int GetAndroidBuildIDByClassID(string v_class_id)
        {
            string mStrSQL = @"SELECT     t_sys_android_buildid.build_id as android_build_id
                                FROM         t_sys_push_class LEFT OUTER JOIN
                                           t_sys_android_buildid ON t_sys_push_class.android_buildid = t_sys_android_buildid.data_id 
                                WHERE t_sys_push_class.class_id=@class_id";
            SqlParameter[] parameters = new SqlParameter[]{
                new SqlParameter("@class_id",SqlDbType.VarChar,30){Value=v_class_id},
            };
            GJHF.Data.Model.SYS.MSysPushClass mMSysPushClass = (GJHF.Data.Model.SYS.MSysPushClass)claSqlConnDB.GetDetail(claSqlConnDB.gStrConnDefault, mStrSQL, "GJHF.Data.Model.SYS.MSysPushClass", "GJHF.Data.Model", parameters);
            return mMSysPushClass.android_build_id;
        }

        public string GetIosSoundByClassID(string v_class_id)
        {
            string mStrSQL = @"SELECT     t_sys_ios_sound.sound_code as ios_sound_code
                            FROM         t_sys_push_class LEFT OUTER JOIN
                      t_sys_ios_sound ON t_sys_push_class.android_buildid = t_sys_ios_sound.sound_id WHERE t_sys_push_class.class_id=@class_id";
            SqlParameter[] parameters = new SqlParameter[]{
                new SqlParameter("@class_id",SqlDbType.VarChar,30){Value=v_class_id},
            };
            GJHF.Data.Model.SYS.MSysPushClass mMSysPushClass = (GJHF.Data.Model.SYS.MSysPushClass)claSqlConnDB.GetDetail(claSqlConnDB.gStrConnDefault, mStrSQL, "GJHF.Data.Model.SYS.MSysPushClass", "GJHF.Data.Model", parameters);
            return mMSysPushClass.ios_sound_code;
        }

        #endregion

        private string GetWhere(string v_class_name, string v_class_remark, int v_ios_sound = -1, int v_android_buildid = -1)
        {
            string mStrWhere = " WHERE 1=1 ";
            if (v_class_name != "")
            {
                mStrWhere = mStrWhere + " AND t_sys_push_class.class_name like '%" + v_class_name + "%' ";
            }
            if (v_class_remark != "")
            {
                mStrWhere = mStrWhere + " AND t_sys_push_class.class_remark like '%" + v_class_remark + "%' ";
            }
            if (v_android_buildid != -1)
            {
                mStrWhere = mStrWhere + " AND t_sys_push_class.android_buildid =" + v_android_buildid + " ";
            }
            if (v_ios_sound != -1)
            {
                mStrWhere = mStrWhere + " AND t_sys_push_class.ios_sound = " + v_ios_sound + " ";
            }
            return mStrWhere;
        }

        private string GetOrder(string v_sort,string v_order)
        {
            string mStrOrder = "";
            if (v_sort != "")
            {
                mStrOrder = " ORDER BY t_sys_push_class." + v_sort;
                if (v_order != "")
                {
                    mStrOrder = mStrOrder + " " + v_order;
                }
            }
            return mStrOrder;
        }
    }
}
