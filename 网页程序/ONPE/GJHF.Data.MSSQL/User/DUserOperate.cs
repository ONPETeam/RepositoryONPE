using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using System.Data.SqlClient;

namespace GJHF.Data.MSSQL.User
{
    public class DUserOperate:Interface.User.IUserOperate
    {
        #region IUserOperate 成员

        public int AddUserOperateRecord(string v_user_id,string v_employee_name, DateTime v_operate_time, int v_equip_type, string v_equip_sign, int v_way_type, 
            string v_way_sign, string v_menu_link, string v_menu_title, string v_menu_extra, string v_operate_remark)
        {
            int mIntReturn = 0;
            string mStrSQL = @"INSERT INTO t_UserOperateRecord
                            (user_id,employee_name,operate_time,equip_type,equip_sign,way_type,way_sign,menu_link,menu_title,menu_extra,operate_remark)
                            VALUES
                            (@user_id,@employee_name,@operate_time,@equip_type,@equip_sign,@way_type,@way_sign,@menu_link,@menu_title,@menu_extra,@operate_remark)";
            SqlParameter[] parameters = new SqlParameter[]{
                new SqlParameter("@user_id",SqlDbType.VarChar,100){Value=v_user_id},
                new SqlParameter("@employee_name",SqlDbType.VarChar,50){Value=v_employee_name},
                new SqlParameter("@operate_time",SqlDbType.DateTime){Value=v_operate_time},
                new SqlParameter("@equip_type",SqlDbType.Int){Value=v_equip_type},
                new SqlParameter("@equip_sign",SqlDbType.VarChar,50){Value=v_equip_sign},
                new SqlParameter("@way_type",SqlDbType.Int){Value=v_way_type},
                new SqlParameter("@way_sign",SqlDbType.VarChar,50){Value=v_way_sign},
                new SqlParameter("@menu_link",SqlDbType.VarChar,200){Value=v_menu_link},
                new SqlParameter("@menu_title",SqlDbType.VarChar,50){Value=v_menu_title},
                new SqlParameter("@menu_extra",SqlDbType.VarChar,500){Value=v_menu_extra},
                new SqlParameter("@operate_remark",SqlDbType.VarChar,200){Value=v_operate_remark},
            };
            mIntReturn = claSqlConnDB.ExecuteNonQuery(claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL, parameters);
            return mIntReturn;
        }

        #endregion
    }
}
