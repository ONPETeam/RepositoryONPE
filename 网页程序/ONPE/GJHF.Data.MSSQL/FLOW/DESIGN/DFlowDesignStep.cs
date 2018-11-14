using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using System.Data.SqlClient;
using GJHF.Data.Interface.FLOW.DESIGN;

namespace GJHF.Data.MSSQL.FLOW.DESIGN
{
    public class DFlowDesignStep:IFlowDesignStep
    {

        #region IFlowDesignStep 成员

        public int AddStep(string v_step_id, string v_step_name, string v_flow_id, string v_version_id, string v_step_type, float v_step_x, float v_step_y, int v_base_OpinionDisplay, int v_base_ExpiredPrompt, int v_base_SignatureType, float v_base_WorkTime, int v_base_Archives, string v_send_message, string v_back_message, string v_form_forms, string v_base_SubFlow, string v_base_Note, int v_behavior_FlowType, int v_behavior_RunSelect, int v_behavior_HandlerType, string v_behavior_SelectRange, string v_behavior_HandlerStep, string v_behavior_ValueField, string v_behavior_DefaultHandler, int v_behavior_BackModel, int v_behavior_HanlderModel, int v_behavior_BackType, float v_behavior_Percentage, string v_behavior_BackStep, int v_behavior_Countersignature, float v_behavior_CountersignaturePercentage, string v_behavior_CopyFor, int v_behavior_SubFlowStrategy, string v_event_SubFlowActivationBefore, string v_event_SubFlowCompletedBefore, string v_event_SubmitBefore, string v_event_SubmitAfter, string v_event_BackBefore, string v_event_BackAfter)
        {
            string mStrSQL = @"INSERT INTO t_flowStep(step_id, step_name, flow_id, version_id, step_type, step_x, step_y, base_OpinionDisplay, base_ExpiredPrompt, base_SignatureType, base_WorkTime, base_Archives, send_message, 
                      back_message, form_forms, base_SubFlow, base_Note, behavior_FlowType, behavior_RunSelect, behavior_HandlerType, behavior_SelectRange, behavior_HandlerStep, behavior_ValueField, 
                      behavior_DefaultHandler, behavior_BackModel, behavior_HanlderModel, behavior_BackType, behavior_Percentage, behavior_BackStep, behavior_Countersignature, 
                      behavior_CountersignaturePercentage, behavior_CopyFor, behavior_SubFlowStrategy, event_SubFlowActivationBefore, event_SubFlowCompletedBefore, event_SubmitBefore, event_SubmitAfter, 
                      event_BackBefore, event_BackAfter)
                      VALUES(@step_id, @step_name, @flow_id, @version_id, @step_type, @step_x,@step_y, @base_OpinionDisplay, @base_ExpiredPrompt, @base_SignatureType, @base_WorkTime, @base_Archives, @send_message, 
                      @back_message, @form_forms, @base_SubFlow, @base_Note, @behavior_FlowType, @behavior_RunSelect, @behavior_HandlerType, @behavior_SelectRange, @behavior_HandlerStep, @behavior_ValueField, 
                      @behavior_DefaultHandler, @behavior_BackModel, @behavior_HanlderModel, @behavior_BackType, @behavior_Percentage, @behavior_BackStep, @behavior_Countersignature, 
                      @behavior_CountersignaturePercentage, @behavior_CopyFor, @behavior_SubFlowStrategy, @event_SubFlowActivationBefore, @event_SubFlowCompletedBefore, @event_SubmitBefore, @event_SubmitAfter, 
                      @event_BackBefore, @event_BackAfter)";
            SqlParameter[] parameters = new SqlParameter[]{
                new SqlParameter("@step_id",SqlDbType.VarChar,80){Value=v_step_id},
                new SqlParameter("@step_name",SqlDbType.VarChar,200){Value=v_step_name},
                new SqlParameter("@flow_id",SqlDbType.VarChar,30){Value=v_flow_id},
                new SqlParameter("@version_id",SqlDbType.VarChar,30){Value=v_version_id},
                new SqlParameter("@step_type",SqlDbType.VarChar,20){Value=v_step_type},
                new SqlParameter("@step_x",SqlDbType.Float,20){Value=v_step_x},
                new SqlParameter("@step_y",SqlDbType.Float,20){Value=v_step_y},
                new SqlParameter("@base_OpinionDisplay",SqlDbType.Int,4){Value=v_base_OpinionDisplay},
                new SqlParameter("@base_ExpiredPrompt",SqlDbType.Int,4){Value=v_base_ExpiredPrompt},
                new SqlParameter("@base_SignatureType",SqlDbType.Int,4){Value=v_base_SignatureType},
                new SqlParameter("@base_WorkTime",SqlDbType.Float,20){Value=v_base_WorkTime},
                new SqlParameter("@base_Archives",SqlDbType.Int,4){Value=v_base_Archives},
                new SqlParameter("@send_message",SqlDbType.VarChar,200){Value=v_base_Archives},
                new SqlParameter("@back_message",SqlDbType.VarChar,200){Value=v_back_message},
                new SqlParameter("@form_forms",SqlDbType.VarChar,30){Value=v_form_forms},
                new SqlParameter("@base_SubFlow",SqlDbType.VarChar,80){Value=v_base_SubFlow},
                new SqlParameter("@base_Note",SqlDbType.VarChar,500){Value=v_base_Note},
                new SqlParameter("@behavior_FlowType",SqlDbType.Int,4){Value=v_behavior_FlowType},
                new SqlParameter("@behavior_RunSelect",SqlDbType.Int,4){Value=v_behavior_RunSelect},
                new SqlParameter("@behavior_HandlerType",SqlDbType.Int,4){Value=v_behavior_HandlerType},
                new SqlParameter("@behavior_SelectRange",SqlDbType.VarChar,2000){Value=v_behavior_SelectRange},
                new SqlParameter("@behavior_HandlerStep",SqlDbType.VarChar,50){Value=v_behavior_HandlerStep},
                new SqlParameter("@behavior_ValueField",SqlDbType.VarChar,200){Value=v_behavior_ValueField},
                new SqlParameter("@behavior_DefaultHandler",SqlDbType.VarChar,2000){Value=v_behavior_DefaultHandler},
                new SqlParameter("@behavior_BackModel",SqlDbType.Int,4){Value=v_behavior_BackModel},
                new SqlParameter("@behavior_HanlderModel",SqlDbType.Int,4){Value=v_behavior_HanlderModel},
                new SqlParameter("@behavior_BackType",SqlDbType.Int,4){Value=v_behavior_BackType},
                new SqlParameter("@behavior_Percentage",SqlDbType.Float,20){Value=v_behavior_Percentage},
                new SqlParameter("@behavior_BackStep",SqlDbType.VarChar,80){Value=v_behavior_BackStep},
                new SqlParameter("@behavior_Countersignature",SqlDbType.Int,4){Value=v_behavior_Countersignature},
                new SqlParameter("@behavior_CountersignaturePercentage",SqlDbType.Float,20){Value=v_behavior_CountersignaturePercentage},
                new SqlParameter("@behavior_CopyFor",SqlDbType.VarChar,5000){Value=v_behavior_CopyFor},
                new SqlParameter("@behavior_SubFlowStrategy",SqlDbType.Int,4){Value=v_behavior_SubFlowStrategy},
                new SqlParameter("@event_SubFlowActivationBefore",SqlDbType.VarChar,2000){Value=v_event_SubFlowActivationBefore},
                new SqlParameter("@event_SubFlowCompletedBefore",SqlDbType.VarChar,2000){Value=v_event_SubFlowCompletedBefore},
                new SqlParameter("@event_SubmitBefore",SqlDbType.VarChar,2000){Value=v_event_SubmitBefore},
                new SqlParameter("@event_SubmitAfter",SqlDbType.VarChar,2000){Value=v_event_SubmitAfter},
                new SqlParameter("@event_BackBefore",SqlDbType.VarChar,2000){Value=v_event_BackBefore},
                new SqlParameter("@event_BackAfter",SqlDbType.VarChar,2000){Value=v_event_BackAfter},
            };
            return claSqlConnDB.ExecuteNonQuery(claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL, parameters);
        }
        public int AddStepLayout(string v_step_id,  string v_flow_id, string v_version_id, string v_step_type, float v_step_x, float v_step_y)
        {
            string mStrSQL = @"INSERT INTO t_flowStep(step_id, flow_id, version_id, step_type, step_x, step_y)
                      VALUES(@step_id, @flow_id, @version_id, @step_type, @step_x,@step_y)";
            SqlParameter[] parameters = new SqlParameter[]{
                new SqlParameter("@step_id",SqlDbType.VarChar,80){Value=v_step_id},
                new SqlParameter("@flow_id",SqlDbType.VarChar,30){Value=v_flow_id},
                new SqlParameter("@version_id",SqlDbType.VarChar,30){Value=v_version_id},
                new SqlParameter("@step_type",SqlDbType.VarChar,20){Value=v_step_type},
                new SqlParameter("@step_x",SqlDbType.Float,20){Value=v_step_x},
                new SqlParameter("@step_y",SqlDbType.Float,20){Value=v_step_y},
            };
            return claSqlConnDB.ExecuteNonQuery(claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL, parameters);
        }
        public int UpdateStep(string v_step_id, string v_step_name, string v_flow_id, string v_version_id, string v_step_type, float v_step_x, float v_step_y, int v_base_OpinionDisplay, int v_base_ExpiredPrompt, int v_base_SignatureType, float v_base_WorkTime, int v_base_Archives, string v_send_message, string v_back_message, string v_form_forms, string v_base_SubFlow, string v_base_Note, int v_behavior_FlowType, int v_behavior_RunSelect, int v_behavior_HandlerType, string v_behavior_SelectRange, string v_behavior_HandlerStep, string v_behavior_ValueField, string v_behavior_DefaultHandler, int v_behavior_BackModel, int v_behavior_HanlderModel, int v_behavior_BackType, float v_behavior_Percentage, string v_behavior_BackStep, int v_behavior_Countersignature, float v_behavior_CountersignaturePercentage, string v_behavior_CopyFor, int v_behavior_SubFlowStrategy, string v_event_SubFlowActivationBefore, string v_event_SubFlowCompletedBefore, string v_event_SubmitBefore, string v_event_SubmitAfter, string v_event_BackBefore, string v_event_BackAfter)
        {
            string mStrSQL = @"UPDATE t_flowStep  SET 
                                step_name=@step_name, 
                                flow_id=@flow_id,  
                                version_id=@version_id,  
                                step_type=@step_type,  
                                step_x=@step_x,  
                                step_y=@step_y,  
                                base_OpinionDisplay=@base_OpinionDisplay,  
                                base_ExpiredPrompt=@base_ExpiredPrompt,  
                                base_SignatureType=@base_SignatureType,  
                                base_WorkTime=@base_WorkTime,  
                                base_Archives=@base_Archives,  
                                send_message=@send_message, 
                                back_message=@back_message,  
                                form_forms=@form_forms,  
                                base_SubFlow=@base_SubFlow,  
                                base_Note=@base_Note,  
                                behavior_FlowType=@behavior_FlowType,  
                                behavior_RunSelect=@behavior_RunSelect,  
                                behavior_HandlerType=@behavior_HandlerType,  
                                behavior_SelectRange=@behavior_SelectRange,  
                                behavior_HandlerStep=@behavior_HandlerStep,  
                                behavior_ValueField=@behavior_ValueField, 
                                behavior_DefaultHandler=@behavior_DefaultHandler,  
                                behavior_BackModel=@behavior_BackModel,  
                                behavior_HanlderModel=@behavior_HanlderModel,  
                                behavior_BackType=@behavior_BackType,  
                                behavior_Percentage=@behavior_Percentage,  
                                behavior_BackStep=@behavior_BackStep,  
                                behavior_Countersignature=@behavior_Countersignature, 
                                behavior_CountersignaturePercentage=@behavior_CountersignaturePercentage,  
                                behavior_CopyFor=@behavior_CopyFor,  
                                behavior_SubFlowStrategy=@behavior_SubFlowStrategy,  
                                event_SubFlowActivationBefore=@event_SubFlowActivationBefore,  
                                event_SubFlowCompletedBefore=@event_SubFlowCompletedBefore,  
                                event_SubmitBefore=@event_SubmitBefore,  
                                event_SubmitAfter=@event_SubmitAfter, 
                                event_BackBefore=@event_BackBefore,  
                                event_BackAfter=@event_BackAfter
                      WHERE step_id=@step_id";
            SqlParameter[] parameters = new SqlParameter[]{
                new SqlParameter("@step_id",SqlDbType.VarChar,80){Value=v_step_id},
                new SqlParameter("@step_name",SqlDbType.VarChar,200){Value=v_step_name},
                new SqlParameter("@flow_id",SqlDbType.VarChar,30){Value=v_flow_id},
                new SqlParameter("@version_id",SqlDbType.VarChar,30){Value=v_version_id},
                new SqlParameter("@step_type",SqlDbType.VarChar,20){Value=v_step_type},
                new SqlParameter("@step_x",SqlDbType.Float,20){Value=v_step_x},
                new SqlParameter("@step_y",SqlDbType.Float,20){Value=v_step_y},
                new SqlParameter("@base_OpinionDisplay",SqlDbType.Int,4){Value=v_base_OpinionDisplay},
                new SqlParameter("@base_ExpiredPrompt",SqlDbType.Int,4){Value=v_base_ExpiredPrompt},
                new SqlParameter("@base_SignatureType",SqlDbType.Int,4){Value=v_base_SignatureType},
                new SqlParameter("@base_WorkTime",SqlDbType.Float,20){Value=v_base_WorkTime},
                new SqlParameter("@base_Archives",SqlDbType.Int,4){Value=v_base_Archives},
                new SqlParameter("@send_message",SqlDbType.VarChar,200){Value=v_base_Archives},
                new SqlParameter("@back_message",SqlDbType.VarChar,200){Value=v_back_message},
                new SqlParameter("@form_forms",SqlDbType.VarChar,30){Value=v_form_forms},
                new SqlParameter("@base_SubFlow",SqlDbType.VarChar,80){Value=v_base_SubFlow},
                new SqlParameter("@base_Note",SqlDbType.VarChar,500){Value=v_base_Note},
                new SqlParameter("@behavior_FlowType",SqlDbType.Int,4){Value=v_behavior_FlowType},
                new SqlParameter("@behavior_RunSelect",SqlDbType.Int,4){Value=v_behavior_RunSelect},
                new SqlParameter("@behavior_HandlerType",SqlDbType.Int,4){Value=v_behavior_HandlerType},
                new SqlParameter("@behavior_SelectRange",SqlDbType.VarChar,2000){Value=v_behavior_SelectRange},
                new SqlParameter("@behavior_HandlerStep",SqlDbType.VarChar,50){Value=v_behavior_HandlerStep},
                new SqlParameter("@behavior_ValueField",SqlDbType.VarChar,200){Value=v_behavior_ValueField},
                new SqlParameter("@behavior_DefaultHandler",SqlDbType.VarChar,2000){Value=v_behavior_DefaultHandler},
                new SqlParameter("@behavior_BackModel",SqlDbType.Int,4){Value=v_behavior_BackModel},
                new SqlParameter("@behavior_HanlderModel",SqlDbType.Int,4){Value=v_behavior_HanlderModel},
                new SqlParameter("@behavior_BackType",SqlDbType.Int,4){Value=v_behavior_BackType},
                new SqlParameter("@behavior_Percentage",SqlDbType.Float,20){Value=v_behavior_Percentage},
                new SqlParameter("@behavior_BackStep",SqlDbType.VarChar,80){Value=v_behavior_BackStep},
                new SqlParameter("@behavior_Countersignature",SqlDbType.Int,4){Value=v_behavior_Countersignature},
                new SqlParameter("@behavior_CountersignaturePercentage",SqlDbType.Float,20){Value=v_behavior_CountersignaturePercentage},
                new SqlParameter("@behavior_CopyFor",SqlDbType.VarChar,5000){Value=v_behavior_CopyFor},
                new SqlParameter("@behavior_SubFlowStrategy",SqlDbType.Int,4){Value=v_behavior_SubFlowStrategy},
                new SqlParameter("@event_SubFlowActivationBefore",SqlDbType.VarChar,2000){Value=v_event_SubFlowActivationBefore},
                new SqlParameter("@event_SubFlowCompletedBefore",SqlDbType.VarChar,2000){Value=v_event_SubFlowCompletedBefore},
                new SqlParameter("@event_SubmitBefore",SqlDbType.VarChar,2000){Value=v_event_SubmitBefore},
                new SqlParameter("@event_SubmitAfter",SqlDbType.VarChar,2000){Value=v_event_SubmitAfter},
                new SqlParameter("@event_BackBefore",SqlDbType.VarChar,2000){Value=v_event_BackBefore},
                new SqlParameter("@event_BackAfter",SqlDbType.VarChar,2000){Value=v_event_BackAfter},
            };
            return claSqlConnDB.ExecuteNonQuery(claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL, parameters);
        }
        
        public int UpdateStepLayout(string v_step_id, string v_flow_id, string v_version_id, string v_step_type, float v_step_x, float v_step_y)
        {
            string mStrSQL = @"UPDATE t_flowStep  SET 
                                flow_id=@flow_id,  
                                version_id=@version_id,  
                                step_type=@step_type,  
                                step_x=@step_x,  
                                step_y=@step_y
                      WHERE step_id=@step_id";
            SqlParameter[] parameters = new SqlParameter[]{
                new SqlParameter("@step_id",SqlDbType.VarChar,80){Value=v_step_id},
                new SqlParameter("@flow_id",SqlDbType.VarChar,30){Value=v_flow_id},
                new SqlParameter("@version_id",SqlDbType.VarChar,30){Value=v_version_id},
                new SqlParameter("@step_type",SqlDbType.VarChar,20){Value=v_step_type},
                new SqlParameter("@step_x",SqlDbType.Float,20){Value=v_step_x},
                new SqlParameter("@step_y",SqlDbType.Float,20){Value=v_step_y}
            };
            return claSqlConnDB.ExecuteNonQuery(claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL, parameters);
        }

        public int DelStep(string v_step_id)
        {
            string mStrSQL = @"DELETE FROM t_flowStep
                      WHERE step_id=@step_id";
            SqlParameter[] parameters = new SqlParameter[]{
                new SqlParameter("@step_id",SqlDbType.VarChar,80){Value=v_step_id},
            };
            return claSqlConnDB.ExecuteNonQuery(claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL, parameters);
        }

        public Dictionary<string, object> GetStepDetail(string v_step_id)
        {
            GJHF.Data.Model.FLOW.DESIGN.MFlowDesignStep mMFlowDesignStep = new GJHF.Data.Model.FLOW.DESIGN.MFlowDesignStep();
            string mStrSQL = @"SELECT step_id, step_name, flow_id, version_id, step_type, step_x, step_y, base_OpinionDisplay, base_ExpiredPrompt, base_SignatureType, base_WorkTime, base_Archives, send_message, 
                      back_message, form_forms, base_SubFlow, base_Note, behavior_FlowType, behavior_RunSelect, behavior_HandlerType, behavior_SelectRange, behavior_HandlerStep, behavior_ValueField, 
                      behavior_DefaultHandler, behavior_BackModel, behavior_HanlderModel, behavior_BackType, behavior_Percentage, behavior_BackStep, behavior_Countersignature, 
                      behavior_CountersignaturePercentage, behavior_CopyFor, behavior_SubFlowStrategy, event_SubFlowActivationBefore, event_SubFlowCompletedBefore, event_SubmitBefore, event_SubmitAfter, 
                      event_BackBefore, event_BackAfter FROM  t_flowStep WHERE step_id=@step_id";
            SqlParameter[] parameters = new SqlParameter[]{
                new SqlParameter("@step_id",SqlDbType.VarChar,80){Value=v_step_id},
            };
            mMFlowDesignStep = (GJHF.Data.Model.FLOW.DESIGN.MFlowDesignStep)claSqlConnDB.GetDetail(claSqlConnDB.gStrConnDefault, mStrSQL, "GJHF.Data.Model.FLOW.DESIGN.MFlowDesignStep", "GJHF.Data.Model", parameters);
            return GJHF.Utility.Convert.ConvertModelToDictionary(mMFlowDesignStep);
        }

        public int GetStepCount(string v_flow_id, string v_version_id)
        {
            string mStrSQL = @"SELECT count(0) FROM  t_flowStep " + GetWhere(v_flow_id, v_version_id);
            return claSqlConnDB.GetRecordCount(claSqlConnDB.gStrConnDefault, mStrSQL);
        }

        public DataTable GetStep(int v_page, int v_rows, string v_flow_id, string v_version_id, string v_sort, string v_order)
        {
            string mStrSQL = @"SELECT step_id, step_name, flow_id, version_id, step_type, step_x, step_y, base_OpinionDisplay, base_ExpiredPrompt, base_SignatureType, base_WorkTime, base_Archives, send_message, 
                      back_message, form_forms, base_SubFlow, base_Note, behavior_FlowType, behavior_RunSelect, behavior_HandlerType, behavior_SelectRange, behavior_HandlerStep, behavior_ValueField, 
                      behavior_DefaultHandler, behavior_BackModel, behavior_HanlderModel, behavior_BackType, behavior_Percentage, behavior_BackStep, behavior_Countersignature, 
                      behavior_CountersignaturePercentage, behavior_CopyFor, behavior_SubFlowStrategy, event_SubFlowActivationBefore, event_SubFlowCompletedBefore, event_SubmitBefore, event_SubmitAfter, 
                      event_BackBefore, event_BackAfter FROM  t_flowStep " + GetWhere(v_flow_id, v_version_id) + GetOrder(v_sort, v_order);
            return claSqlConnDB.ExecuteDataset(v_rows, v_page, claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL).Tables[0];
        }

        public DataTable GetStep(string v_flow_id, string v_version_id, string v_sort, string v_order)
        {
            string mStrSQL = @"SELECT step_id, step_name, flow_id, version_id, step_type, step_x, step_y, base_OpinionDisplay, base_ExpiredPrompt, base_SignatureType, base_WorkTime, base_Archives, send_message, 
                      back_message, form_forms, base_SubFlow, base_Note, behavior_FlowType, behavior_RunSelect, behavior_HandlerType, behavior_SelectRange, behavior_HandlerStep, behavior_ValueField, 
                      behavior_DefaultHandler, behavior_BackModel, behavior_HanlderModel, behavior_BackType, behavior_Percentage, behavior_BackStep, behavior_Countersignature, 
                      behavior_CountersignaturePercentage, behavior_CopyFor, behavior_SubFlowStrategy, event_SubFlowActivationBefore, event_SubFlowCompletedBefore, event_SubmitBefore, event_SubmitAfter, 
                      event_BackBefore, event_BackAfter FROM  t_flowStep " + GetWhere(v_flow_id, v_version_id) + GetOrder(v_sort, v_order);
            return claSqlConnDB.ExecuteDataset( claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL).Tables[0];
        }

        public DataTable GetStep(string v_flow_id, string v_version_id)
        {
            string mStrSQL = @"SELECT step_id, step_name, flow_id, version_id, step_type, step_x, step_y, base_OpinionDisplay, base_ExpiredPrompt, base_SignatureType, base_WorkTime, base_Archives, send_message, 
                      back_message, form_forms, base_SubFlow, base_Note, behavior_FlowType, behavior_RunSelect, behavior_HandlerType, behavior_SelectRange, behavior_HandlerStep, behavior_ValueField, 
                      behavior_DefaultHandler, behavior_BackModel, behavior_HanlderModel, behavior_BackType, behavior_Percentage, behavior_BackStep, behavior_Countersignature, 
                      behavior_CountersignaturePercentage, behavior_CopyFor, behavior_SubFlowStrategy, event_SubFlowActivationBefore, event_SubFlowCompletedBefore, event_SubmitBefore, event_SubmitAfter, 
                      event_BackBefore, event_BackAfter FROM  t_flowStep " + GetWhere(v_flow_id, v_version_id);
            return claSqlConnDB.ExecuteDataset( claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL).Tables[0];
        }
        private string GetWhere(string v_flow_id, string v_version_id)
        {
            string mStrWhere = " WHERE 1=1 ";
            if (v_flow_id != "")
            {
                mStrWhere += " AND t_flowStep.flow_id = '" + v_flow_id + "'";
            }
            if (v_version_id != "")
            {
                mStrWhere += " AND t_flowStep.version_id = '" + v_version_id + "'";
            }

            return mStrWhere;
        }

        private string GetOrder(string v_sort, string v_order)
        {
            string mStrOrder = "";
            if (v_sort != "")
            {
                mStrOrder += " ORDER BY t_flowStep." + v_sort;
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
