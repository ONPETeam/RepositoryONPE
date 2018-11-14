using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using System.Data.SqlClient;
using GJHF.Data.Interface.FLOW.CLASS;
using GJHF.Data.Model.FLOW.CLASS;

namespace GJHF.Data.MSSQL.FLOW.CLASS
{
    public class  DFLOWFlowClass:IFLOWFlowClass
    {
        #region IFLOWFlowClass 成员

        public int AddFlowClassData(string v_class_name, string v_class_remark)
        {
            string mStrSQL = @"INSERT INTO t_flowclass(class_name,class_remark)VALUES(@class_name,@class_remark)";
            SqlParameter[] parameter = new SqlParameter[]{
                new SqlParameter("@class_name",SqlDbType.VarChar,50){Value=v_class_name},
                new SqlParameter("@class_remark",SqlDbType.VarChar,200){Value=v_class_remark},
            };
            return claSqlConnDB.ExecuteNonQuery(claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL, parameter);
        }

        public int EditFlowClassData(int v_class_id, string v_class_name, string v_class_remark)
        {
            string mStrSQL = @"UPDATE t_flowclass SET 
                            class_name,
                            class_remark
                            WHERE class_id=@class_id";
            SqlParameter[] parameter = new SqlParameter[]{
                new SqlParameter("@class_id",SqlDbType.Int,4){Value=v_class_id},
                new SqlParameter("@class_name",SqlDbType.VarChar,50){Value=v_class_name},
                new SqlParameter("@class_remark",SqlDbType.VarChar,200){Value=v_class_remark},
            };
            return claSqlConnDB.ExecuteNonQuery(claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL, parameter);
        }

        public int DelFlowClassData(int v_class_id)
        {
            string mStrSQL = @"DELETE FROM t_flowclass 
                            WHERE class_id=@class_id";
            SqlParameter[] parameter = new SqlParameter[]{
                new SqlParameter("@class_id",SqlDbType.Int,4){Value=v_class_id},
            };
            return claSqlConnDB.ExecuteNonQuery(claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL, parameter);
        }

        public Dictionary<string,object> GetFlowClassDetail(int v_class_id)
        {
            string mStrSQL = @"SELECT  class_id,class_name,class_remark FROM  t_FlowClass  WHERE class_id=@class_id";
            SqlParameter[] parameters = new SqlParameter[] { 
                new SqlParameter("@class_id",SqlDbType.Int,4){Value=v_class_id},
            };
            return GJHF.Utility.Convert.ConvertModelToDictionary(claSqlConnDB.GetDetail(claSqlConnDB.gStrConnDefault, mStrSQL, "GJHF.Data.Model.FLOW.CLASS.MFLOWFlowClass", "GJHF.Data.Model", parameters));
        }

        public int GetFlowClassCount(string v_class_name, string v_class_remark)
        {
            string mStrSQL = @"SELECT COUNT(0) FROM t_FlowClass" + GetWhere(v_class_name, v_class_remark);
            return claSqlConnDB.GetRecordCount(claSqlConnDB.gStrConnDefault, mStrSQL);
        }

        public DataTable GetFlowClassData(int v_rows, int v_page, string v_class_name, string v_class_remark, string v_sort, string v_order)
        {
            string mStrSQL = @"SELECT  class_id,class_name,class_remark FROM  t_FlowClass " + GetWhere(v_class_name, v_class_remark) + GetOrder(v_sort, v_order);
            return claSqlConnDB.ExecuteDataset(v_rows, v_page, claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL).Tables[0];
        }
        public DataTable GetFlowClassData(string v_class_name, string v_class_remark, string v_sort, string v_order)
        {
            string mStrSQL = @"SELECT  class_id,class_name,class_remark FROM  t_FlowClass " + GetWhere(v_class_name, v_class_remark) + GetOrder(v_sort, v_order);
            return claSqlConnDB.ExecuteDataset(claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL).Tables[0];
        }
        public DataTable GetFlowClassData(string v_class_name, string v_class_remark)
        {
            string mStrSQL = @"SELECT  class_id,class_name,class_remark FROM  t_FlowClass " + GetWhere(v_class_name, v_class_remark);
            return claSqlConnDB.ExecuteDataset(claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL).Tables[0];
        }
        #endregion

        private string GetWhere(string v_class_name, string v_class_remark)
        {
            string mStrWhere = " WHERE 1=1 ";
            if (v_class_name != "")
            {
                mStrWhere += " AND t_FlowClass.class_name LIKE '%" + v_class_name + "%'";
            }
            if (v_class_remark != "")
            {
                mStrWhere += " AND t_FlowClass.class_remark LIKE '%" + v_class_remark + "%'";
            }
            return mStrWhere;
        }

        private string GetOrder(string v_sort, string v_order)
        {
            string mStrOrder = "";
            if (v_sort != "")
            {
                mStrOrder += " ORDER BY t_FlowClass." + v_sort;
                if (v_order != "")
                {
                    mStrOrder += " " + v_order;
                }
            }
            return mStrOrder;
        }
    }
}
