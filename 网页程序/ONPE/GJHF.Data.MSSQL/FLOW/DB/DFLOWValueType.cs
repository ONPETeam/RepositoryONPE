using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using System.Data.SqlClient;
using GJHF.Data.Interface.FLOW.DB;
using GJHF.Data.Model.FLOW.DB;

namespace GJHF.Data.MSSQL.FLOW.DB
{
    public class DFLOWValueType:IFLOWValueType
    {
        #region IFLOWValueType 成员

        public int AddValueTypeData(string v_type_name, string v_type_remark)
        {
            string mStrSQL = @"INSERT INTO t_FlowValueType(type_name ,type_remark)VALUES(@type_name ,@type_remark)";
            SqlParameter[] parameters = new SqlParameter[] { 
                new SqlParameter("@type_name",SqlDbType.VarChar,50){Value=v_type_name},
                new SqlParameter("@type_remark",SqlDbType.VarChar,100){Value=v_type_remark},
            };
            return claSqlConnDB.ExecuteNonQuery(claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL, parameters);
        }

        public int EditValueTypeData(int v_type_id, string v_type_name, string v_type_remark)
        {
            string mStrSQL = @"UPDATE t_FlowValueType SET type_name=@type_name ,type_remark=@type_remark WHERE type_id=@type_id";
            SqlParameter[] parameters = new SqlParameter[] { 
                new SqlParameter("@type_id",SqlDbType.Int,4){Value=v_type_id},
                new SqlParameter("@type_name",SqlDbType.VarChar,50){Value=v_type_name},
                new SqlParameter("@type_remark",SqlDbType.VarChar,100){Value=v_type_remark},
            };
            return claSqlConnDB.ExecuteNonQuery(claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL, parameters);
        }

        public int DelValueTypeData(int v_type_id)
        {
            string mStrSQL = @"DELETE FROM  t_FlowValueType  WHERE type_id=@type_id";
            SqlParameter[] parameters = new SqlParameter[] { 
                new SqlParameter("@type_id",SqlDbType.Int,4){Value=v_type_id},
            };
            return claSqlConnDB.ExecuteNonQuery(claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL, parameters);
        }

        public MFLOWValueType GetValueTypeDetail(int v_type_id)
        {
            string mStrSQL = @"SELECT  type_id,type_name,type_remark FROM  t_FlowValueType  WHERE type_id=@type_id";
            SqlParameter[] parameters = new SqlParameter[] { 
                new SqlParameter("@type_id",SqlDbType.Int,4){Value=v_type_id},
            };
            return (MFLOWValueType)claSqlConnDB.GetDetail(claSqlConnDB.gStrConnDefault, mStrSQL, "GJHF.Data.Model.FLOW.DB.MFLOWValueType", "GJHF.Data.Model", parameters);
        }

        public DataTable GetValueTypeData(int v_rows, int v_page, string v_type_name, string v_type_remark, string v_sort, string v_order)
        {
            string mStrSQL = @"SELECT  type_id,type_name,type_remark FROM  t_FlowValueType " + GetWhere(v_type_name, v_type_remark) + GetOrder(v_sort, v_order);
            return claSqlConnDB.ExecuteDataset(v_rows, v_page, claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL).Tables[0];
        }
        public DataTable GetValueTypeData( string v_type_name, string v_type_remark, string v_sort, string v_order)
        {
            string mStrSQL = @"SELECT  type_id,type_name,type_remark FROM  t_FlowValueType " + GetWhere(v_type_name, v_type_remark) + GetOrder(v_sort, v_order);
            return claSqlConnDB.ExecuteDataset( claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL).Tables[0];
        }

        public int GetValueTypeCount(string v_type_name, string v_type_remark)
        {
            string mStrSQL = @"SELECT COUNT(0) FROM  t_FlowValueType " + GetWhere(v_type_name, v_type_remark);
            return claSqlConnDB.GetRecordCount(claSqlConnDB.gStrConnDefault, mStrSQL);
        }

        #endregion

        private string GetWhere(string v_type_name, string v_type_remark)
        {
            string mStrWhere = " WHERE 1=1 ";
            if (v_type_name != "")
            {
                mStrWhere += " AND t_FlowValueType.type_name LIKE '%" + v_type_name + "%'";
            }
            if (v_type_remark != "")
            {
                mStrWhere += " AND t_FlowValueType.type_remark LIKE '%" + v_type_remark + "%'";
            }
            return mStrWhere;
        }

        private string GetOrder(string v_sort, string v_order)
        {
            string mStrOrder = "";
            if (v_sort != "")
            {
                mStrOrder += " ORDER BY t_FlowValueType." + v_sort;
                if (v_order != "")
                {
                    mStrOrder += " " + v_order;
                }
            }
            return mStrOrder;
        }
    }
}
