using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using System.Data.SqlClient;
using GJHF.Data.Interface.FLOW.TYPE;
using GJHF.Data.Model.FLOW.TYPE;

namespace GJHF.Data.MSSQL.FLOW.TYPE
{
    public class DFLOWFlowType:IFLOWFlowType
    {
        #region IFLOWFlowType 成员

        public int AddFlowTypeData(string v_type_name, int v_type_order, int v_type_parent)
        {
            string mStrSQL = @"INSERT INTO t_FlowType(type_name ,type_order,type_parent)VALUES(@type_name ,@type_order,@type_parent)";
            SqlParameter[] parameters = new SqlParameter[] { 
                new SqlParameter("@type_name",SqlDbType.VarChar,50){Value=v_type_name},
                new SqlParameter("@type_order",SqlDbType.Int,4){Value=v_type_order},
                new SqlParameter("@type_parent",SqlDbType.Int,4){Value=v_type_parent},
            };
            return claSqlConnDB.ExecuteNonQuery(claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL, parameters);
        }

        public int EditFlowTypeData(int v_type_id, string v_type_name, int v_type_order, int v_type_parent)
        {
            string mStrSQL = @"UPDATE t_FlowValueType SET type_name=@type_name ,type_order=@type_order,type_parent=@type_parent WHERE type_id=@type_id";
            SqlParameter[] parameters = new SqlParameter[] { 
                new SqlParameter("@type_id",SqlDbType.Int,4){Value=v_type_id},
                new SqlParameter("@type_name",SqlDbType.VarChar,50){Value=v_type_name},
                new SqlParameter("@type_order",SqlDbType.Int,4){Value=v_type_order},
                new SqlParameter("@type_parent",SqlDbType.Int,4){Value=v_type_parent},
            };
            return claSqlConnDB.ExecuteNonQuery(claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL, parameters);
        }

        public int DelFlowTypeData(int v_type_id)
        {
            string mStrSQL = @"DELETE FROM t_FlowValueType  WHERE type_id=@type_id";
            SqlParameter[] parameters = new SqlParameter[] { 
                new SqlParameter("@type_id",SqlDbType.Int,4){Value=v_type_id},
            };
            return claSqlConnDB.ExecuteNonQuery(claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL, parameters);
        }

        public Dictionary<string,object> GetFlowTypeDetail(int v_type_id)
        {
            string mStrSQL = @"SELECT  type_id,type_name ,type_order,type_parent FROM  t_FlowType  WHERE type_id=@type_id";
            SqlParameter[] parameters = new SqlParameter[] { 
                new SqlParameter("@type_id",SqlDbType.Int,4){Value=v_type_id},
            };
            return (GJHF.Utility.Convert.ConvertModelToDictionary(claSqlConnDB.GetDetail(claSqlConnDB.gStrConnDefault, mStrSQL, "GJHF.Data.Model.FLOW.DB.MFLOWFlowType","GJHF.Data.Model", parameters)));
        }

        public DataTable GetFlowTypeData(int v_page, int v_rows, string v_type_name, int v_type_parent, string v_sort, string v_order)
        {
            string mStrSQL = @"SELECT  type_id,type_name ,type_order,type_parent FROM  t_FlowType " + GetWhere(v_type_name, v_type_parent) + GetOrder(v_sort, v_order);
            DataTable dt = null;
            dt= claSqlConnDB.ExecuteDataset(v_rows, v_page, claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL).Tables[0];
            return dt;
        }

        public DataTable GetFlowTypeData(string v_type_name, int v_type_parent, string v_sort, string v_order)
        {
            string mStrSQL = @"SELECT  type_id,type_name ,type_order,type_parent FROM  t_FlowType " + GetWhere(v_type_name, v_type_parent) + GetOrder(v_sort, v_order);
            return claSqlConnDB.ExecuteDataset(claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL).Tables[0];
        }

        public DataTable GetFlowTypeData(string v_type_name, int v_type_parent)
        {
            string mStrSQL = @"SELECT  type_id,type_name ,type_order,type_parent FROM  t_FlowType " + GetWhere(v_type_name, v_type_parent);
            return claSqlConnDB.ExecuteDataset(claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL).Tables[0];
        }

        public int GetFlowTypeCount(string v_type_name, int v_type_parent)
        {
            string mStrSQL = @"SELECT COUNT(0) FROM  t_FlowType " + GetWhere(v_type_name, v_type_parent);
            return claSqlConnDB.GetRecordCount(claSqlConnDB.gStrConnDefault, mStrSQL);
        }

        #endregion

        private string GetWhere(string v_type_name, int v_type_parent)
        {
            string mStrWhere = " WHERE 1=1 ";
            if (v_type_name != "")
            {
                mStrWhere += " AND t_FlowType.type_name LIKE '%" + v_type_name + "%'";
            }
            if (v_type_parent >=0)
            {
                mStrWhere += " AND t_FlowType.type_parent = " + v_type_parent;
            }
            return mStrWhere;
        }

        private string GetOrder(string v_sort, string v_order)
        {
            string mStrOrder = "";
            if (v_sort != "")
            {
                mStrOrder += " ORDER BY t_FlowType." + v_sort;
                if (v_order != "")
                {
                    mStrOrder += " " + v_order;
                }
            }
            return mStrOrder;
        }
    }
}
