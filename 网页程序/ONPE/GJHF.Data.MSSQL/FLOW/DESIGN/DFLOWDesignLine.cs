using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using System.Data.SqlClient;
using GJHF.Data.Interface.FLOW.DESIGN;
using GJHF.Data.Model.FLOW.DESIGN;

namespace GJHF.Data.MSSQL.FLOW.DESIGN
{
    public class DFLOWDesignLine:IFlowDesignLine
    {
        #region IFLOWDesignLine 成员

        public int SaveNewLine(string v_line_id, string v_flow_id, string v_version_id, string v_step_start, string v_step_stop, int v_line_style, int v_start_type,
            string v_event_code, DateTime v_start_time, string v_database_connect, string v_table_name, string v_field_name, string v_set_value)
        {
            int mIntReturn = -1;
            string mStrSQL = @"INSERT INTO  t_FlowLine(line_id,flow_id,version_id,step_start,step_stop,line_style,start_type,event_code,start_time,database_connect,table_name,field_name,set_value)
                            VALUES(@line_id,@flow_id,@version_id,@step_start,@step_stop,@line_style,@start_type,@event_code,@start_time,@database_connect,@table_name,@field_name,@set_value)";
            SqlParameter[] parameters = new SqlParameter[]{
                new SqlParameter("@line_id",SqlDbType.VarChar,80){Value=v_line_id},
                new SqlParameter("@flow_id",SqlDbType.VarChar,30){Value=v_flow_id},
                new SqlParameter("@version_id",SqlDbType.VarChar,30){Value=v_version_id},
                new SqlParameter("@step_start",SqlDbType.VarChar,80){Value=v_step_start},
                new SqlParameter("@step_stop",SqlDbType.VarChar,80) {Value=v_step_stop},
                new SqlParameter("@line_style",SqlDbType.Int,4)  {Value=v_line_style},
                new SqlParameter("@start_type",SqlDbType.Int,4)    {Value=v_start_type},
                new SqlParameter("@event_code",SqlDbType.VarChar,1000)   {Value=v_event_code},
                new SqlParameter("@start_time",SqlDbType.DateTime,20)    {Value=v_start_time},
                new SqlParameter("@database_connect",SqlDbType.VarChar,300)     {Value=v_database_connect},
                new SqlParameter("@table_name",SqlDbType.VarChar,100)      {Value=v_table_name},
                new SqlParameter("@field_name",SqlDbType.VarChar,100)      {Value=v_field_name},
                new SqlParameter("@set_value",SqlDbType.VarChar,200)       {Value=v_set_value},
            };
            mIntReturn = claSqlConnDB.ExecuteNonQuery(claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL, parameters);
            return mIntReturn;
        }
        public int AddLineLayout(string v_line_id, string v_flow_id, string v_version_id, string v_step_start, string v_step_stop)
        {
            int mIntReturn = -1;
            string mStrSQL = @"INSERT INTO  t_FlowLine(line_id,flow_id,version_id,step_start,step_stop)
                            VALUES(@line_id,@flow_id,@version_id,@step_start,@step_stop)";
            SqlParameter[] parameters = new SqlParameter[]{
                new SqlParameter("@line_id",SqlDbType.VarChar,80){Value=v_line_id},
                new SqlParameter("@flow_id",SqlDbType.VarChar,30){Value=v_flow_id},
                new SqlParameter("@version_id",SqlDbType.VarChar,30){Value=v_version_id},
                new SqlParameter("@step_start",SqlDbType.VarChar,80){Value=v_step_start},
                new SqlParameter("@step_stop",SqlDbType.VarChar,80) {Value=v_step_stop},

                
            };
            mIntReturn = claSqlConnDB.ExecuteNonQuery(claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL, parameters);
            return mIntReturn;
        }
        public int UpdateLine(string v_line_id, string v_flow_id, string v_version_id, string v_step_start, string v_step_stop, int v_line_style, int v_start_type,
            string v_event_code, DateTime v_start_time, string v_database_connect, string v_table_name, string v_field_name, string v_set_value)
        {
            int mIntReturn = -1;
            string mStrSQL = @"UPDATE   t_FlowLine SET 
                                flow_id=@flow_id,
                                version_id=@version_id,
                                step_start=@step_start,
                                step_stop=@step_stop,
                                line_style=@line_style,
                                start_type=@start_type,
                                event_code=@event_code,
                                start_time=@start_time,
                                database_connect=@database_connect,
                                table_name=@table_name,
                                field_name=@field_name,
                                set_value=@set_value
                            WHERE  line_id=@line_id";
            SqlParameter[] parameters = new SqlParameter[]{
                new SqlParameter("@line_id",SqlDbType.VarChar,80){Value=v_line_id},
                new SqlParameter("@flow_id",SqlDbType.VarChar,30){Value=v_flow_id},
                new SqlParameter("@version_id",SqlDbType.VarChar,30){Value=v_version_id},
                new SqlParameter("@step_start",SqlDbType.VarChar,80){Value=v_step_start},
                new SqlParameter("@step_stop",SqlDbType.VarChar,80) {Value=v_step_stop},
                new SqlParameter("@line_style",SqlDbType.Int,4)  {Value=v_line_style},
                new SqlParameter("@start_type",SqlDbType.Int,4)    {Value=v_start_type},
                new SqlParameter("@event_code",SqlDbType.VarChar,1000)   {Value=v_event_code},
                new SqlParameter("@start_time",SqlDbType.DateTime,20)    {Value=v_start_time},
                new SqlParameter("@database_connect",SqlDbType.VarChar,300)     {Value=v_database_connect},
                new SqlParameter("@table_name",SqlDbType.VarChar,100)      {Value=v_table_name},
                new SqlParameter("@field_name",SqlDbType.VarChar,100)      {Value=v_field_name},
                new SqlParameter("@set_value",SqlDbType.VarChar,200)       {Value=v_set_value},
            };
            mIntReturn = claSqlConnDB.ExecuteNonQuery(claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL, parameters);
            return mIntReturn;
        }
        public int UpdateLineLayout(string v_line_id, string v_flow_id, string v_version_id, string v_step_start,  string v_step_stop)
        {
            int mIntReturn = -1;
            string mStrSQL = @"UPDATE   t_FlowLine SET 
                                flow_id=@flow_id,
                                version_id=@version_id,
                                step_start=@step_start,
                                step_stop=@step_stop
                               WHERE  line_id=@line_id";
            SqlParameter[] parameters = new SqlParameter[]{
                new SqlParameter("@line_id",SqlDbType.VarChar,80){Value=v_line_id},
                new SqlParameter("@flow_id",SqlDbType.VarChar,30){Value=v_flow_id},
                new SqlParameter("@version_id",SqlDbType.VarChar,30){Value=v_version_id},
                new SqlParameter("@step_start",SqlDbType.VarChar,80){Value=v_step_start},
                new SqlParameter("@step_stop",SqlDbType.VarChar,80){Value=v_step_stop},
            };
            mIntReturn = claSqlConnDB.ExecuteNonQuery(claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL, parameters);
            return mIntReturn;
        }

        public int DeleteLine(string v_line_id)
        {
            int mIntReturn = -1;
            string mStrSQL = @"DELETE FROM  t_FlowLine 
                            WHERE line_id=@line_id";
            SqlParameter[] parameters = new SqlParameter[]{
                new SqlParameter("@line_id",SqlDbType.VarChar,50){Value=v_line_id},
            };
            mIntReturn = claSqlConnDB.ExecuteNonQuery(claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL, parameters);
            return mIntReturn;
        }
        public Dictionary<string, object> GetLine(string v_line_id)
        {
            string mStrClassPath=GJHF.Utility.Config.DAOClassPath;
            MFlowDesignLine mMFLOWDesignLine = new MFlowDesignLine();
            string mStrSQL = @"SELECT line_id,flow_id,version_id,step_start,step_stop,line_style,start_type,event_code,start_time,database_connect,table_name,field_name,set_value FROM  t_FlowLine 
                            WHERE line_id=@line_id";
            SqlParameter[] parameters = new SqlParameter[]{
                new SqlParameter("@line_id",SqlDbType.VarChar,50){Value=v_line_id},
            };
            mMFLOWDesignLine = (MFlowDesignLine)claSqlConnDB.GetDetail(claSqlConnDB.gStrConnDefault, mStrSQL, "GJHF.Data.Model.FLOW.DESIGN.MFlowDesignLine", "GJHF.Data.Model", parameters);
            return  GJHF.Utility.Convert.ConvertModelToDictionary(mMFLOWDesignLine);
        }

        public DataTable GetDesignLinesData(int v_page, int v_rows, string v_flow_id, string v_version_id, string v_sort, string v_order)
        {
            string mStrSQL = @"SELECT line_id,flow_id,version_id,step_start,step_stop,line_style,start_type,event_code,start_time,database_connect,table_name,field_name,set_value FROM  t_FlowLine " + GetWhere(v_flow_id, v_version_id) + GetOrder(v_sort, v_order);
            return claSqlConnDB.ExecuteDataset(v_rows,v_page,claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL).Tables[0];
        }
        public DataTable GetDesignLinesData(string v_flow_id, string v_version_id, string v_sort, string v_order)
        {
            string mStrSQL = @"SELECT line_id,flow_id,version_id,step_start,step_stop,line_style,start_type,event_code,start_time,database_connect,table_name,field_name,set_value FROM  t_FlowLine " + GetWhere(v_flow_id, v_version_id) + GetOrder(v_sort, v_order);
            return claSqlConnDB.ExecuteDataset(claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL).Tables[0];
        }
        public DataTable GetDesignLinesData(string v_flow_id, string v_version_id)
        {
            string mStrSQL = @"SELECT line_id,flow_id,version_id,step_start,step_stop,line_style,start_type,event_code,start_time,database_connect,table_name,field_name,set_value FROM  t_FlowLine " + GetWhere(v_flow_id, v_version_id);
            return claSqlConnDB.ExecuteDataset(claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL).Tables[0];
        }
        public int GetLinesCount(string v_flow_id, string v_version_id)
        {
            string mStrSQL = @"SELECT COUNT(0) FROM  t_FlowLine " + GetWhere(v_flow_id, v_version_id);
            return claSqlConnDB.GetRecordCount(claSqlConnDB.gStrConnDefault, mStrSQL);
        }


        private string GetWhere(string v_flow_id, string v_version_id)
        {
            string mStrWhere = " WHERE 1=1 ";
            if (v_flow_id != "")
            {
                mStrWhere += " AND t_FlowLine.flow_id = '" + v_flow_id + "'";
            }
            if (v_version_id != "")
            {
                mStrWhere += " AND t_FlowLine.version_id = '" + v_version_id + "'";
            }
           
            return mStrWhere;
        }

        private string GetOrder(string v_sort, string v_order)
        {
            string mStrOrder = "";
            if (v_sort != "")
            {
                mStrOrder += " ORDER BY t_FlowLine." + v_sort;
                if (v_order != "")
                {
                    mStrOrder += " " + v_order;
                }
            }
            return mStrOrder;
        }

        #endregion
    }
}
