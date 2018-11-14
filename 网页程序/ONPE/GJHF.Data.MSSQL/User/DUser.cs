using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data.SqlClient;
using System.Data;

namespace GJHF.Data.MSSQL.User
{
    public class DUser:Interface.User.IUser
    {
        #region IUser 成员

        public string GetOldUserRight(string v_user_code, int v_right_class, int v_right_type, string v_spara_code)
        {
            string mStrUserRight = "";
            SqlParameter[] parameters ={
                       new SqlParameter("@viVchUserCode",SqlDbType.VarChar,100),
                       new SqlParameter("@viIntRightClass", SqlDbType.Int,4), 
                       new SqlParameter("@viIntRightType", SqlDbType.Int,4),
                       new SqlParameter("@viVchSparaCode", SqlDbType.VarChar,200),
                       new SqlParameter("@voVchUserRight", SqlDbType.VarChar,8000)
                                  };
            parameters[0].Value = v_user_code;
            parameters[1].Value = v_right_class;
            parameters[2].Value = v_right_type;
            parameters[3].Value = v_spara_code;
            parameters[4].Direction = System.Data.ParameterDirection.Output;
            claSqlConnDB.ExecuteNonQuery(claSqlConnDB.gStrConnDefault, CommandType.StoredProcedure, "p_get_user_right", parameters);
            mStrUserRight = parameters[4].Value.ToString();
            return mStrUserRight;
        }

        public string GetAllUserRight(int v_right_class, int v_right_type, string v_spara_code)
        {
            string mStrUserRight = "";
            SqlParameter[] parameters ={
                       new SqlParameter("@viIntRightClass", SqlDbType.Int,4){Value = v_right_class}, 
                       new SqlParameter("@viVchSparaCode", SqlDbType.VarChar,200){Value = v_spara_code},
                       new SqlParameter("@voVchUserRight", SqlDbType.VarChar,8000){Direction = System.Data.ParameterDirection.Output}
            };
            claSqlConnDB.ExecuteNonQuery(claSqlConnDB.gStrConnDefault, CommandType.StoredProcedure, "p_get_all_right", parameters);
            mStrUserRight = parameters[2].Value.ToString();
            return mStrUserRight;
        }

        public string GetUserRight(string v_user_code, int v_right_class, int v_right_type, string v_spara_code)
        {
            string mStrUserRight = "";
            SqlParameter[] parameters ={
                       new SqlParameter("@viVchUserCode",SqlDbType.VarChar,100),
                       new SqlParameter("@viIntRightClass", SqlDbType.Int,4), 
                       new SqlParameter("@viIntRightType", SqlDbType.Int,4),
                       new SqlParameter("@viVchSparaCode", SqlDbType.VarChar,200),
                       new SqlParameter("@voVchUserRight", SqlDbType.VarChar,8000)
                                  };
            parameters[0].Value = v_user_code;
            parameters[1].Value = v_right_class;
            parameters[2].Value = v_right_type;
            parameters[3].Value = v_spara_code;
            parameters[4].Direction = System.Data.ParameterDirection.Output;
            claSqlConnDB.ExecuteNonQuery(claSqlConnDB.gStrConnDefault, CommandType.StoredProcedure, "p_get_user_right", parameters);
            mStrUserRight = parameters[4].Value.ToString();
            return mStrUserRight;
        }

        public string ConvertIdToRemark(string vStrIDString, string v_spara_code)
        {
            string mStrReturn = "";
            string mStrSQL = @" SELECT right_remark from t_rights where right_code in ('" + vStrIDString.Replace(v_spara_code, "','") + "')";
            DataTable dt = null;
            using (dt = claSqlConnDB.ExecuteDataset(claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL).Tables[0])
            {
                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    mStrReturn = mStrReturn + dt.Rows[i][0].ToString() + v_spara_code;
                }
            }
            return mStrReturn;
        }


        public int SetDefaultRightGroup(string v_user_id)
        {
            string mStrSQL = @"insert into t_user_group (user_code,group_code)values(@user_code,'PCQXRG9999990001')";
            SqlParameter[] parameters = new SqlParameter[]{
                new SqlParameter("@user_code",SqlDbType.VarChar,100){Value=v_user_id}
            };
            return claSqlConnDB.ExecuteNonQuery(claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL, parameters);
        }

        public bool IsExistUser(string v_user_id)
        {
            string mStrSQL = @"SELECT count(0) FROM t_employee Where user_id=@user_id";
            SqlParameter [] parameters=new SqlParameter[]{
                new SqlParameter("@user_id",SqlDbType.VarChar,100){Value=v_user_id},            
            };
            if (claSqlConnDB.GetRecordCount(claSqlConnDB.gStrConnDefault, mStrSQL, parameters) > 0)
            {
                return true;
            }
            else
            {
                return false;
            }
        }

        #endregion
    }
}
