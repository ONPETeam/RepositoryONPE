using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using System.Data.SqlClient;
using GJHF.Data.Interface.FLOW.VERSION;
using System.Collections;
//using GJHF.Data.Model.FLOW.VERSION;

namespace GJHF.Data.MSSQL.FLOW.VERSION
{
    public class DFlowVersion:IFlowVersion
    {
        #region IFlowVersion 成员

        public int AddFlowVersion(string v_flow_id, DateTime v_update_time, string v_update_people, string v_update_remark)
        {
            string mStrSQL = @"INSERT INTO t_flowversion(version_id,flow_id,update_time,update_people,version_remark )
                                VALUES(@version_id,@flow_id,@update_time,@update_people,@version_remark )";
            SqlParameter[] parameters = new SqlParameter[]{
                new SqlParameter("@version_id",SqlDbType.VarChar,30){Value=COMMON.DGlobal.GetIdentityFlowVersionID()},
                new SqlParameter("@flow_id",SqlDbType.VarChar,30){Value=v_flow_id},
                new SqlParameter("@update_time",SqlDbType.DateTime,20){Value=v_update_time},
                new SqlParameter("@update_people",SqlDbType.DateTime,30){Value=v_update_people},
                new SqlParameter("@version_remark",SqlDbType.DateTime,2000){Value=v_update_remark},
            };
            return claSqlConnDB.ExecuteNonQuery(claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL, parameters);
        }

        public int EditFlowVersion(string v_version_id, string v_flow_id, DateTime v_update_time, string v_update_people, string v_update_remark)
        {
            string mStrSQL = @"UPDATE t_flowversion SET
                                flow_id=@flow_id,
                                update_time=@update_time,
                                update_people=@update_people,
                                version_remark=@version_remark
                                WHERE version_id=@version_id";
            SqlParameter[] parameters = new SqlParameter[]{
                new SqlParameter("@version_id",SqlDbType.VarChar,30){Value=v_version_id},
                new SqlParameter("@flow_id",SqlDbType.VarChar,30){Value=v_flow_id},
                new SqlParameter("@update_time",SqlDbType.DateTime,20){Value=v_update_time},
                new SqlParameter("@update_people",SqlDbType.DateTime,30){Value=v_update_people},
                new SqlParameter("@version_remark",SqlDbType.DateTime,2000){Value=v_update_remark},
            };
            return claSqlConnDB.ExecuteNonQuery(claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL, parameters);
        }

        public int DelFlowVersion(string v_version_id)
        {
            string mStrSQL = @"DELETE FROM t_flowversion SET
                                WHERE version_id=@version_id";
            SqlParameter[] parameters = new SqlParameter[]{
                new SqlParameter("@version_id",SqlDbType.VarChar,30){Value=v_version_id},
            };
            return claSqlConnDB.ExecuteNonQuery(claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL, parameters);
        }

        public int GetFlowVersionCount(string v_flow_id)
        {
            string mStrSQL = @"SELECT COUNT(0) FROM t_flowversion" + GetWhere(v_flow_id);
            return claSqlConnDB.GetRecordCount(claSqlConnDB.gStrConnDefault, mStrSQL);
        }

        public DataTable GetFlowVersion(string v_flow_id)
        {
            string mStrSQL = @"SELECT version_id,flow_id,update_time,update_people,version_remark,is_run FROM t_flowversion" + GetWhere(v_flow_id);
            return claSqlConnDB.ExecuteDataset(claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL).Tables[0];
        }

        public DataTable GetFlowVersion(string v_flow_id, string v_sort, string v_order)
        {
            string mStrSQL = @"SELECT version_id,flow_id,update_time,update_people,version_remark,is_run FROM t_flowversion" + GetWhere(v_flow_id) + GetOrder(v_sort, v_order);
            return claSqlConnDB.ExecuteDataset(claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL).Tables[0];
        }

        public DataTable GetFlowVersion(int v_page, int v_rows, string v_flow_id, string v_sort, string v_order)
        {
            string mStrSQL = @"SELECT version_id,flow_id,update_time,update_people,version_remark,is_run FROM t_flowversion" + GetWhere(v_flow_id) + GetOrder(v_sort, v_order);
            return claSqlConnDB.ExecuteDataset(v_rows, v_page,claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL).Tables[0];
        }

        public Dictionary<string, object> GetFlowVersionDetail(string v_version_id)
        {
            GJHF.Data.Model.FLOW.VERSION.MFlowVersion mMFlowVersion = new Model.FLOW.VERSION.MFlowVersion();
            string mStrSQL = @"SELECT     t_flowversion.version_id, t_flowversion.flow_id, t_flowdesign.flow_name, t_flowdesign.flow_type, t_FlowType.type_name AS flow_type_name, t_flowversion.version_remark AS flow_descript
                        FROM         t_flowdesign INNER JOIN
                      t_flowversion ON t_flowdesign.flow_id = t_flowversion.flow_id INNER JOIN
                      t_FlowType ON t_flowdesign.flow_type = t_FlowType.type_id WHERE t_flowversion.version_id=@version_id";
            SqlParameter[] parameters = new SqlParameter[]{
                new SqlParameter("@version_id",SqlDbType.VarChar,30){Value=v_version_id},
            };
            mMFlowVersion = (GJHF.Data.Model.FLOW.VERSION.MFlowVersion)claSqlConnDB.GetDetail(claSqlConnDB.gStrConnDefault, mStrSQL, "GJHF.Data.Model.FLOW.VERSION.MFlowVersion", "GJHF.Data.Model", parameters);
            mMFlowVersion.wf_json = new DESIGN.DFlowWFJson().GetWFJson(mMFlowVersion.flow_id, v_version_id);
            return GJHF.Utility.Convert.ConvertModelToDictionary(mMFlowVersion);
        }

        #endregion

        private string GetWhere(string v_flow_id)
        {
            string mStrWhere = " WHERE 1=1 ";
            if (v_flow_id != "")
            {
                mStrWhere += " AND t_flowversion.flow_id = '" + v_flow_id + "'";
            }
            return mStrWhere;
        }

        private string GetOrder(string v_sort, string v_order)
        {
            string mStrOrder = "";
            if (v_sort != "")
            {
                mStrOrder += " ORDER BY t_flowversion." + v_sort;
                if (v_order != "")
                {
                    mStrOrder += " " + v_order;
                }
            }
            return mStrOrder;
        }
    }
}
