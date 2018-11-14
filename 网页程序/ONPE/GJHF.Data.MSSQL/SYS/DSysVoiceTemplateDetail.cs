using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using System.Data.SqlClient;

namespace GJHF.Data.MSSQL.SYS
{
    public class DSysVoiceTemplateDetail:GJHF.Data.Interface.SYS.ISysVoiceTemplateDetail
    {
        public int GetJXTemplateParamCount(string v_template_id)
        {
            string mStrSQL = @"SELECT COUNT(0) FROM t_sys_template_param WHERE template_id=@template_id";
            SqlParameter[] parameters = new SqlParameter[]{
                new SqlParameter("@template_id",SqlDbType.VarChar,30){Value=v_template_id}
            };
            return claSqlConnDB.GetRecordCount(claSqlConnDB.gStrConnDefault, mStrSQL, parameters);
        }

        public DataTable GetJXTemplateParamData(string v_template_id)
        {
            string mStrSQL = @"SELECT param_id,param_name,param_code,param_type,param_length,template_id,param_remark FROM t_sys_template_param WHERE template_id=@template_id";
            SqlParameter[] parameters = new SqlParameter[]{
                new SqlParameter("@template_id",SqlDbType.VarChar,30){Value=v_template_id}
            };
            return claSqlConnDB.ExecuteDataset(claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL, parameters).Tables[0];
        }

        public int AddTemplateParam(string v_param_name, string v_param_code, int v_param_type, int v_param_length, string v_template_id, string v_param_remark)
        {
            string mStrParamID = COMMON.DGlobal.GetIdentityPushTemplateParamID();
            string mStrSQL = @"INSERT INTO t_sys_template_param
                            (param_id,param_name,param_code,param_type,param_length,template_id,param_remark)
                            VALUES(@param_id,@param_name,@param_code,@param_type,@param_length,@template_id,@param_remark)";
            SqlParameter[] parameters = new SqlParameter[]{
                new SqlParameter("@param_id",SqlDbType.VarChar,30){Value=mStrParamID},
                new SqlParameter("@param_name",SqlDbType.VarChar,50){Value=v_param_name},
                new SqlParameter("@param_code",SqlDbType.VarChar,50){Value=v_param_code},
                new SqlParameter("@param_type",SqlDbType.Int){Value=v_param_type},
                new SqlParameter("@param_length",SqlDbType.Int){Value=v_param_length},
                new SqlParameter("@template_id",SqlDbType.VarChar,30){Value=v_template_id},
                new SqlParameter("@param_remark",SqlDbType.VarChar,200){Value=v_param_remark},
            };
            return claSqlConnDB.ExecuteNonQuery(claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL, parameters);
        }

        public int DelTemplateParam(string v_param_id)
        {
            string mStrSQL = @"DELETE FROM  t_sys_template_param
                             where param_id=@param_id ";
            SqlParameter[] parameters = new SqlParameter[]{
                new SqlParameter("@param_id",SqlDbType.VarChar,30){Value=v_param_id}
            };
            return claSqlConnDB.ExecuteNonQuery(claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL, parameters);
        }
    }
}
