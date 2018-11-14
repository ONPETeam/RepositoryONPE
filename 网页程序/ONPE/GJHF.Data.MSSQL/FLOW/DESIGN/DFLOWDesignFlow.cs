using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using System.Data.SqlClient;
using GJHF.Data.Model.FLOW.DESIGN;
using GJHF.Data.Interface.FLOW.DESIGN;

namespace GJHF.Data.MSSQL.FLOW.DESIGN
{
    public class DFLOWDesignFlow:IFlowDesignFlow
    {
        #region IFLOWDesignFlow 成员

        public int AddFlowDesignData(string v_flow_name, int v_flow_class, int v_flow_order, int v_flow_type, int v_version_control, string v_flow_creator, string v_flow_remark)
        {
            string m_flow_id = COMMON.DGlobal.GetIdentityFlowDesignID();
            SqlParameter[] parameters = new SqlParameter[]{
                new SqlParameter("@flow_id",SqlDbType.VarChar,50){Value=m_flow_id},
                new SqlParameter("@flow_name",SqlDbType.VarChar,200){Value=v_flow_name},
                new SqlParameter("@flow_class",SqlDbType.Int,4){Value=v_flow_class},
                new SqlParameter("@flow_order",SqlDbType.Int,4){Value=v_flow_order},
                new SqlParameter("@flow_type",SqlDbType.Int,4){Value=v_flow_type},
                new SqlParameter("@version_control",SqlDbType.Int,4){Value=v_version_control},
                new SqlParameter("@create_people",SqlDbType.VarChar,30){Value=v_flow_creator},
                new SqlParameter("@flow_remark",SqlDbType.VarChar,500){Value=v_flow_remark},
                new SqlParameter("@exec_return",SqlDbType.Int,4){Direction=System.Data.ParameterDirection.Output}
            };
            return claSqlConnDB.ExecuteNonQuery(claSqlConnDB.gStrConnDefault, CommandType.StoredProcedure, "p_add_flow_info", parameters);
        }

        public int EditFlowDesignData(string v_flow_id, string v_flow_name, int v_flow_class, int v_flow_order, int v_flow_type, string v_flow_remark)
        {
            SqlParameter[] parameters = new SqlParameter[]{
                new SqlParameter("@flow_id",SqlDbType.VarChar,50){Value=v_flow_id},
                new SqlParameter("@flow_name",SqlDbType.VarChar,200){Value=v_flow_name},
                new SqlParameter("@flow_class",SqlDbType.Int,4){Value=v_flow_class},
                new SqlParameter("@flow_order",SqlDbType.Int,4){Value=v_flow_order},
                new SqlParameter("@flow_type",SqlDbType.Int,4){Value=v_flow_type},
                new SqlParameter("@flow_remark",SqlDbType.VarChar,500){Value=v_flow_remark},
                new SqlParameter("@exec_return",SqlDbType.Int,4){Direction=System.Data.ParameterDirection.Output}
            };
            return claSqlConnDB.ExecuteNonQuery(claSqlConnDB.gStrConnDefault, CommandType.StoredProcedure, "p_edit_flow_info", parameters);
        }

        public int DeleteFlowDesignData(string v_flow_id)
        {
            SqlParameter[] parameters = new SqlParameter[]{
                new SqlParameter("@flow_id",SqlDbType.VarChar,50){Value=v_flow_id},
                new SqlParameter("@exec_return",SqlDbType.Int,4){Direction=System.Data.ParameterDirection.Output}
            };
            return claSqlConnDB.ExecuteNonQuery(claSqlConnDB.gStrConnDefault, CommandType.StoredProcedure, "p_del_flow_info", parameters);
        }

        

        public int GetFlowDesignCount(string v_flow_name, int v_flow_class, int v_flow_order, int v_flow_type)
        {
            string mStrSQL = @"SELECT COUNT(0) FROM t_flowdesign " + GetWhere(v_flow_name, v_flow_class, v_flow_order, v_flow_type);
            return claSqlConnDB.GetRecordCount(claSqlConnDB.gStrConnDefault, mStrSQL);
        }


        public DataTable GetListFlowDesignData(int v_page, int v_rows, string v_flow_name, int v_flow_class, int v_flow_order, int v_flow_type, string v_sort, string v_order)
        {
            string mStrSQL = @"SELECT     t_flowdesign.flow_id, t_flowdesign.flow_name, t_FlowClass.class_id, t_FlowClass.class_name, t_flowdesign.flow_order, t_FlowType.type_id, t_FlowType.type_name, t_flowdesign.version_control, 
                                                      t_flowdesign.create_time, t_flowdesign.flow_creator, t_flowdesign.current_version, t_flowdesign.last_update, t_flowdesign.last_writter, t_flowdesign.run_version, t_flowdesign.run_time, 
                                                      t_flowdesign.run_people,t_flowdesign.flow_remark
                                FROM         t_flowdesign LEFT OUTER JOIN
                                                      t_FlowType ON t_flowdesign.flow_type = t_FlowType.type_id LEFT OUTER JOIN
                                                      t_FlowClass ON t_flowdesign.flow_class = t_FlowClass.class_id "
                        + GetWhere(v_flow_name, v_flow_class, v_flow_order, v_flow_type) + GetOrder(v_sort, v_order);
            return claSqlConnDB.ExecuteDataset(v_rows, v_page, claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL, null).Tables[0];
        }

        public DataTable GetListFlowDesignData(string v_flow_name, int v_flow_class, int v_flow_order, int v_flow_type, string v_sort, string v_order)
        {
            string mStrSQL = @"SELECT     t_flowdesign.flow_id, t_flowdesign.flow_name, t_FlowClass.class_id, t_FlowClass.class_name, t_flowdesign.flow_order, t_FlowType.type_id, t_FlowType.type_name, t_flowdesign.version_control, 
                                                      t_flowdesign.create_time, t_flowdesign.flow_creator, t_flowdesign.current_version, t_flowdesign.last_update, t_flowdesign.last_writter, t_flowdesign.run_version, t_flowdesign.run_time, 
                                                      t_flowdesign.run_people,t_flowdesign.flow_remark
                                FROM         t_flowdesign LEFT OUTER JOIN
                                                      t_FlowType ON t_flowdesign.flow_type = t_FlowType.type_id LEFT OUTER JOIN
                                                      t_FlowClass ON t_flowdesign.flow_class = t_FlowClass.class_id "
                        + GetWhere(v_flow_name, v_flow_class, v_flow_order, v_flow_type) + GetOrder(v_sort, v_order);
            return claSqlConnDB.ExecuteDataset(claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL, null).Tables[0];
        }
        public DataTable GetListFlowDesignData(string v_flow_name, int v_flow_class, int v_flow_order, int v_flow_type)
        {
            string mStrSQL = @"SELECT     t_flowdesign.flow_id, t_flowdesign.flow_name, t_FlowClass.class_id, t_FlowClass.class_name, t_flowdesign.flow_order, t_FlowType.type_id, t_FlowType.type_name, t_flowdesign.version_control, 
                                                      t_flowdesign.create_time, t_flowdesign.flow_creator, t_flowdesign.current_version, t_flowdesign.last_update, t_flowdesign.last_writter, t_flowdesign.run_version, t_flowdesign.run_time, 
                                                      t_flowdesign.run_people,t_flowdesign.flow_remark
                                FROM         t_flowdesign LEFT OUTER JOIN
                                                      t_FlowType ON t_flowdesign.flow_type = t_FlowType.type_id LEFT OUTER JOIN
                                                      t_FlowClass ON t_flowdesign.flow_class = t_FlowClass.class_id "
                        + GetWhere(v_flow_name, v_flow_class, v_flow_order, v_flow_type);
            return claSqlConnDB.ExecuteDataset(claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL, null).Tables[0];
        }
        private string GetWhere( string v_flow_name, int v_flow_class, int v_flow_order, int v_flow_type)
        {
            string mStrWhere = " where 1=1";
            if (v_flow_name != "")
            {
                mStrWhere += " AND flow_name like '%" + v_flow_name + "%'";
            }
            if (v_flow_class != 0)
            {
                mStrWhere += " AND flow_class = " + v_flow_class; 
            }
            if (v_flow_order != 0)
            {
                mStrWhere += " AND flow_order = " + v_flow_order;
            }
            if (v_flow_type != 0)
            {
                mStrWhere += " AND flow_type = " + v_flow_type;
            }
            return mStrWhere;
        }

        private string GetOrder(string v_sort, string v_order)
        {
            string mStrOrder = " ";
            if (v_sort != "")
            {
                mStrOrder += " ORDER BY t_flowdesign." + v_sort;
                if (v_order != "")
                {
                    mStrOrder +=" "+ v_order;
                }
            }
            return mStrOrder;
        }

        public Dictionary<string, object> GetFlowDesignDetail(string v_flow_id)
        {
            MFLOWDesignFlow mMFLOWDesignFlow = new MFLOWDesignFlow();
            string mStrSQL = @"SELECT flow_id,flow_name,flow_class,flow_order,flow_type,version_control,create_time,flow_creator,current_version,last_update,last_writter,run_version ,run_time,run_people ,flow_remark
                            FROM t_flowdesign WHERE  flow_id=@flow_id";
            SqlParameter[] parameters = new SqlParameter[]{
                new SqlParameter("@flow_id",SqlDbType.VarChar,50){Value=v_flow_id}
            };
            mMFLOWDesignFlow = (MFLOWDesignFlow)claSqlConnDB.GetDetail(claSqlConnDB.gStrConnDefault, mStrSQL, "GJHF.Data.Model.FLOW.DESIGN.MFLOWDesignFlow", "GJHF.Data.Model", parameters);
            mMFLOWDesignFlow.wf_json = new DFlowWFJson().GetWFJson(v_flow_id, "");
            return GJHF.Utility.Convert.ConvertModelToDictionary(mMFLOWDesignFlow);
        }

        
        #endregion
    }
}
