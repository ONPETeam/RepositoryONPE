using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using System.Data.SqlClient;

namespace GJHF.Data.MSSQL.SYS
{
    public class DSysVoiceTemplate:GJHF.Data.Interface.SYS.ISysVoiceTemplate
    {

        public int GetJXTemplateCount(string v_template_no, int v_template_type, string v_template_name, string v_template_content, int v_template_state=-100)
        {
            string mStrSQL = @"SELECT COUNT(0) FROM t_sys_template " + GetWhere(v_template_no, v_template_type, v_template_name, v_template_content, v_template_state);
           
            return claSqlConnDB.GetRecordCount(claSqlConnDB.gStrConnDefault, mStrSQL);
        }

        public DataTable GetJXTemplateData(string v_template_no, int v_template_type, string v_template_name, string v_template_content, int v_template_state=-100)
        {
            string mStrSQL = @"SELECT template_id,template_no,template_type,template_content,template_name,template_state template_remark FROM t_sys_template " + GetWhere(v_template_no, v_template_type, v_template_name, v_template_content, v_template_state);
            return claSqlConnDB.ExecuteDataset(claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL).Tables[0];
        }
        
        public DataTable GetJXTemplateData(string v_template_no, int v_template_type, string v_template_name, string v_template_content, string v_sort, string v_order, int v_template_state = -100)
        {
            string mStrSQL = @"SELECT template_id,template_no,template_type,template_content,template_name,template_state template_remark FROM t_sys_template " +
                GetWhere(v_template_no, v_template_type, v_template_name, v_template_content, v_template_state)
                + GetOrder(v_sort, v_order);
            return claSqlConnDB.ExecuteDataset(claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL).Tables[0];
        }
        
        public DataTable GetJXTemplateData(int v_page, int v_rows, string v_template_no, int v_template_type, string v_template_name, string v_template_content, string v_sort, string v_order, int v_template_state = -100)
        {
            string mStrSQL = @"SELECT template_id,template_no,template_type,template_content,template_name,template_state template_remark FROM t_sys_template " +
                GetWhere(v_template_no, v_template_type, v_template_name, v_template_content, v_template_state)
                + GetOrder(v_sort, v_order);
            return claSqlConnDB.ExecuteDataset(v_rows, v_page, claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL).Tables[0];
        }
        
        public int OnlineJXTemplate(string v_template_id)
        {
            string mStrSQL = @"Update  t_sys_template set  template_state=-99 WHERE template_id=@template_id";
            SqlParameter[] parameters = new SqlParameter[]{
                new  SqlParameter("@template_id",SqlDbType.VarChar,30){Value=v_template_id}
            };
            return claSqlConnDB.ExecuteNonQuery(claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL, parameters);
        }

        public int AddJxTemplate(int v_template_type, string v_template_content, string v_template_name, string v_template_remark)
        {
            string mStrTemplateID = COMMON.DGlobal.GetIdentityPushTemplateID();
            string mStrSQL = @" INSERT INTO t_sys_template(template_id,template_type,template_content,template_name, template_remark)
                              VALUES(@template_id,@template_type,@template_content,@template_name, @template_remark)";
            SqlParameter[] parameters = new SqlParameter[]{
                new SqlParameter("@template_id",SqlDbType.VarChar,30){Value=mStrTemplateID},
                new SqlParameter("@template_type",SqlDbType.Int){Value=v_template_type},
                new SqlParameter("@template_content",SqlDbType.VarChar,200){Value=v_template_content},
                new SqlParameter("@template_name",SqlDbType.VarChar,100){Value=v_template_name},
                new SqlParameter("@template_remark",SqlDbType.VarChar,200){Value=v_template_remark},
            };
            return claSqlConnDB.ExecuteNonQuery(claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL, parameters);
        }

        public int OfflineJXTemplate(string v_template_id)
        {
            string mStrSQL = @"Update  t_sys_template set  template_state=-2 WHERE template_id=@template_id";
            SqlParameter[] parameters = new SqlParameter[]{
                new  SqlParameter("@template_id",SqlDbType.VarChar,30){Value=v_template_id}
            };
            return claSqlConnDB.ExecuteNonQuery(claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL, parameters);
        }

        public int UpdateJXTemplate(string v_template_id, string v_template_content, string v_template_name, string v_template_remark)
        {
            string mStrSQL = @" UPDATE t_sys_template Set 
                                template_content=@template_content,
                                template_name=@template_name, 
                                template_remark=@template_remark
                                where template_id=@template_id";
            SqlParameter[] parameters = new SqlParameter[]{
                new SqlParameter("@template_id",SqlDbType.VarChar,30){Value=v_template_id},
                new SqlParameter("@template_content",SqlDbType.VarChar,200){Value=v_template_content},
                new SqlParameter("@template_name",SqlDbType.VarChar,100){Value=v_template_name},
                new SqlParameter("@template_remark",SqlDbType.VarChar,200){Value=v_template_remark},
            };
            return claSqlConnDB.ExecuteNonQuery(claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL, parameters);
        }

        public int GetTemplateNoByID(string v_template_id)
        {
            int mIntTemplateNo = 0;
            string mStrSQL = " SELECT template_no FROM t_sys_template WHERE template_id=@template_id";
            SqlParameter[] parameters = new SqlParameter[]{
                new SqlParameter("@template_id",SqlDbType.VarChar,30){Value=v_template_id}
            };
            DataTable dt = null;
            using (dt = claSqlConnDB.ExecuteDataset(claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL, parameters).Tables[0])
            {
                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    mIntTemplateNo = int.Parse(dt.Rows[i][0] == null ? "0" : dt.Rows[i][0].ToString());
                }
            }
            return mIntTemplateNo;
        }

        private string GetWhere(string v_template_no, int v_template_type, string v_template_name, string v_template_content, int v_template_state=-100)
        {
            string mStrWhere = " WHERE 1=1 ";
            if (v_template_no != "")
            {
                mStrWhere = mStrWhere + " AND  template_no like '%" + v_template_no + "%' ";
            }
            if (v_template_type != -99)
            {
                mStrWhere = mStrWhere + " AND template_type=" + v_template_type + "  "; 
            }
            if (v_template_name != "")
            {
                mStrWhere = mStrWhere + " AND template_name like '%" + v_template_name + "%' ";
            }
            if (v_template_content != "")
            {
                mStrWhere = mStrWhere + " AND template_content like '%" + v_template_content + "%' ";
            }
            if (v_template_state != -100)
            {
                mStrWhere = mStrWhere + " AND template_state=" + v_template_state + " ";
            }
            return mStrWhere;
        }

        private string GetOrder(string v_sort, string v_order)
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
