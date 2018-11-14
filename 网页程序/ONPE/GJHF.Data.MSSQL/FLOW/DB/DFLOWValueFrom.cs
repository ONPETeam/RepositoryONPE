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
    public class DFLOWValueFrom:IFLOWValueFrom
    {
        #region IFLOWValueFrom 成员

        public int AddValueFromData(string v_value_from_name, int v_type_id, string v_analyze_function, string v_return_type, string v_value_from_remark)
        {
            string mStrSQL = @"INSERT INTO t_FlowValueFrom(value_from_name,type_id,analyze_function,return_type,value_from_remark)
                                VALUES(@value_from_name,@type_id,@analyze_function,@return_type,@value_from_remark)";
            SqlParameter[] parameters = new SqlParameter[]{
                new SqlParameter("@value_from_name",SqlDbType.VarChar,200){Value=v_value_from_name},
                new SqlParameter("@type_id",SqlDbType.Int,4){Value=v_type_id},
                new SqlParameter("@analyze_function",SqlDbType.VarChar,200){Value=v_analyze_function},
                new SqlParameter("@return_type",SqlDbType.VarChar,50){Value=v_return_type},
                new SqlParameter("@value_from_remark",SqlDbType.VarChar,200){Value=v_value_from_remark},
            };
            return claSqlConnDB.ExecuteNonQuery(claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL, parameters);
        }

        public int EditValueFromData(int v_value_from_id, string v_value_from_name, int v_type_id, string v_analyze_function, string v_return_type, string v_value_from_remark)
        {
            string mStrSQL = @"UPDATE t_FlowValueFrom SET 
                                value_from_name=@value_from_name,
                                type_id=@type_id,
                                analyze_function=@analyze_function,
                                return_type=@return_type,
                                value_from_remark=@value_from_remark
                                WHERE value_from_id=@value_from_id";
            SqlParameter[] parameters = new SqlParameter[]{
                new SqlParameter("@value_from_id",SqlDbType.Int,4){Value=v_value_from_id},
                new SqlParameter("@value_from_name",SqlDbType.VarChar,200){Value=v_value_from_name},
                new SqlParameter("@type_id",SqlDbType.Int,4){Value=v_type_id},
                new SqlParameter("@analyze_function",SqlDbType.VarChar,200){Value=v_analyze_function},
                new SqlParameter("@return_type",SqlDbType.VarChar,50){Value=v_return_type},
                new SqlParameter("@value_from_remark",SqlDbType.VarChar,200){Value=v_value_from_remark},
            };
            return claSqlConnDB.ExecuteNonQuery(claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL, parameters);
        }

        public int DelValueFromData(int v_value_from_id)
        {
            string mStrSQL = @"DELETE FROM t_FlowValueFrom 
                                WHERE value_from_id=@value_from_id";
            SqlParameter[] parameters = new SqlParameter[]{
                new SqlParameter("@value_from_id",SqlDbType.Int,4){Value=v_value_from_id},
            };
            return claSqlConnDB.ExecuteNonQuery(claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL, parameters);
        }

        public MFLOWValueFrom GetValueFromDetail(int v_value_from_id)
        {
            string mStrSQL = @"SELECT  value_from_id,value_from_name,type_id,analyze_function,return_type,value_from_remark FROM  t_FlowValueFrom  WHERE value_from_id=@value_from_id";
            SqlParameter[] parameters = new SqlParameter[] { 
                new SqlParameter("@value_from_id",SqlDbType.Int,4){Value=v_value_from_id},
            };
            return (MFLOWValueFrom)claSqlConnDB.GetDetail(claSqlConnDB.gStrConnDefault, mStrSQL, "GJHF.Data.Model.FLOW.DB.MFLOWValueFrom", "GJHF.Data.Model", parameters);
        }

        public int GetValueFromCount(string v_value_from_name, int v_type_id, string v_analyze_function, string v_return_type)
        {
            string mStrSQL = @"SELECT COUNT(0) FROM  t_FlowValueFrom " + GetWhere(v_value_from_name, v_type_id, v_analyze_function, v_return_type);
            return claSqlConnDB.GetRecordCount(claSqlConnDB.gStrConnDefault, mStrSQL);
        }

        public DataTable GetValueFromData(int v_rows, int v_page, string v_value_from_name, int v_type_id, string v_analyze_function, string v_return_type, string v_sort, string v_order)
        {
            string mStrSQL = @"SELECT  value_from_id,value_from_name,type_id,analyze_function,return_type,value_from_remark FROM  t_FlowValueFrom " + GetWhere(v_value_from_name, v_type_id, v_analyze_function, v_return_type) + GetOrder(v_sort, v_order);
            return claSqlConnDB.ExecuteDataset(v_rows, v_page, claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL).Tables[0];
        }
        public DataTable GetValueFromData(string v_value_from_name, int v_type_id, string v_analyze_function, string v_return_type, string v_sort, string v_order)
        {
            string mStrSQL = @"SELECT  value_from_id,value_from_name,type_id,analyze_function,return_type,value_from_remark FROM  t_FlowValueFrom " + GetWhere(v_value_from_name, v_type_id, v_analyze_function, v_return_type) + GetOrder(v_sort, v_order);
            return claSqlConnDB.ExecuteDataset( claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL).Tables[0];
        }
        #endregion
        private string GetWhere(string v_value_from_name, int v_type_id, string v_analyze_function, string v_return_type)
        {
            string mStrWhere = " WHERE 1=1 ";
            if (v_value_from_name != "")
            {
                mStrWhere += " AND t_FlowValueFrom.value_from_name LIKE '%" + v_value_from_name + "%'";
            }
            if (v_type_id != 0)
            {
                mStrWhere += " AND t_FlowValueFrom.type_id = " + v_type_id + "%'";
            }
            if (v_analyze_function != "")
            {
                mStrWhere += " AND t_FlowValueFrom.analyze_function LIKE '%" + v_analyze_function + "%'";
            }
            if (v_return_type != "")
            {
                mStrWhere += " AND t_FlowValueFrom.return_type LIKE '%" + v_return_type + "%'";
            }
            return mStrWhere;
        }

        private string GetOrder(string v_sort, string v_order)
        {
            string mStrOrder = "";
            if (v_sort != "")
            {
                mStrOrder += " ORDER BY t_FlowValueFrom." + v_sort;
                if (v_order != "")
                {
                    mStrOrder += " " + v_order;
                }
            }
            return mStrOrder;
        }
    }
}
