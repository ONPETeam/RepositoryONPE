using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using System.Data.SqlClient;

namespace GJHF.Data.MSSQL.TSD
{
    public class DTSDFlow:Interface.TSD.ITSDFlow
    {
        #region ITSDFlow 成员

        public int GetNoRequestPowerOn(string v_flow_id)
        {
            int mIntRequestPowerOn = 0;
            SqlParameter[] parameters = new SqlParameter[]{
                new SqlParameter("@flow_id",SqlDbType.VarChar,30){Value=v_flow_id},
                new SqlParameter("@voIntNoRequestCount",SqlDbType.Int){Direction=ParameterDirection.Output},
                new SqlParameter("@voIntReturn",SqlDbType.Int){Direction=ParameterDirection.Output}
            };
            claSqlConnDB.ExecuteNonQuery(claSqlConnDB.gStrConnDefault, CommandType.StoredProcedure, "p_tsd_get_norequest_poweron", parameters);
            int mIntReturn = (int)parameters[2].Value;
            if (mIntReturn == 0)
            {
                mIntRequestPowerOn = (int)parameters[1].Value;
            }
            return mIntRequestPowerOn;
        }

        public int ArchiveTsdFlow(string v_flow_id)
        {
            SqlParameter[] parameters = new SqlParameter[]{
                new SqlParameter("@flow_id",SqlDbType.VarChar,30){Value=v_flow_id},
                new SqlParameter("@voIntReturn",SqlDbType.Int){Direction=ParameterDirection.Output}
            };
            return claSqlConnDB.ExecuteNonQuery(claSqlConnDB.gStrConnDefault, CommandType.StoredProcedure, "p_tsd_archive", parameters);
        }
        
        public int GetTSDFlowCount(string v_equip_code, int v_flow_status, int v_poweroff_branch, string v_poweroff_employee, DateTime v_poweroff_start, DateTime v_poweroff_end, int v_poweron_branch, string v_poweron_employee, DateTime v_poweron_start, DateTime v_poweron_end, float v_timespan_min, float v_timespan_max)
        {
            int mIntTSDFlowCount = 0;
            string mStrSQL = @"SELECT count(0) FROM t_TSDFlowData " + GetWhere(v_equip_code, v_flow_status, v_poweroff_branch, v_poweroff_employee, v_poweroff_start, v_poweroff_end, v_poweron_branch, v_poweron_employee, v_poweron_start, v_poweron_end, v_timespan_min, v_timespan_max);
            mIntTSDFlowCount = claSqlConnDB.GetRecordCount(claSqlConnDB.gStrConnDefault, mStrSQL);
            return mIntTSDFlowCount;
        }

        public DataTable GetTSDFlowData(int v_page, int v_rows, string v_equip_code, int v_flow_status, int v_poweroff_branch, string v_poweroff_employee, DateTime v_poweroff_start, DateTime v_poweroff_end, int v_poweron_branch, string v_poweron_employee, DateTime v_poweron_start, DateTime v_poweron_end, float v_timespan_min, float v_timespan_max, string v_sort, string v_order)
        {
            string mStrSQL = @"SELECT     t_TSDFlowData.flow_id, t_TSDFlowData.equip_code, t_TSDFlowData.flow_status, t_TSDFlowData.confirmoff_id, t_TSDConfirm_1.confirm_people AS confirmoff_people, 
                                          t_TSDConfirm_1.confirm_time AS confirmoff_time, t_TSDConfirm_1.location_info AS confirmoff_location, t_TSDConfirm_1.equip_code AS confirmoff_equip_code, 
                                          t_TSDConfirm_1.equip_state AS confirmoff_equip_state, t_TSDConfirm_1.confirm_remark AS confirmoff_remark, t_TSDFlowData.off_time, t_TSDFlowData.offrun_branch, 
                                          t_TSDFlowData.offrun_employee, t_TSDFlowData.confirmon_id, t_TSDConfirm.confirm_people AS confirmon_people, t_TSDConfirm.confirm_time AS confirmon_time, 
                                          t_TSDConfirm.location_info AS confirmon_location, t_TSDConfirm.equip_code AS confirmon_equip_code, t_TSDConfirm.equip_state AS confirmon_equip_state, 
                                          t_TSDConfirm.confirm_remark AS confirmon_remark, t_TSDFlowData.on_time, t_TSDFlowData.onrun_branch, t_TSDFlowData.onrun_employee, t_TSDFlowData.off_timespan, 
                                          t_Employee_1.employee_name AS offrun_employee_name, t_Employee_2.employee_name AS onrun_employee_name, t_Equips.equip_name, 
                                          tHRBranchInfo_1.dVchBranchName AS offrun_branch_name, tHRBranchInfo.dVchBranchName AS onrun_branch_name, t_Employee_3.employee_name AS confirmoff_employee_name, 
                                          t_Employee.employee_name AS confirmon_employee_name
                             FROM         t_Employee AS t_Employee_3 INNER JOIN
                                          t_TSDConfirm AS t_TSDConfirm_1 ON t_Employee_3.employee_code = t_TSDConfirm_1.confirm_people RIGHT OUTER JOIN
                                          t_TSDFlowData LEFT OUTER JOIN
                                          tHRBranchInfo ON t_TSDFlowData.onrun_branch = tHRBranchInfo.dIntBranchID LEFT OUTER JOIN
                                          tHRBranchInfo AS tHRBranchInfo_1 ON t_TSDFlowData.offrun_branch = tHRBranchInfo_1.dIntBranchID LEFT OUTER JOIN
                                          t_Equips ON t_TSDFlowData.equip_code = t_Equips.equip_code LEFT OUTER JOIN
                                          t_Employee AS t_Employee_2 ON t_TSDFlowData.onrun_employee = t_Employee_2.employee_code LEFT OUTER JOIN
                                          t_Employee AS t_Employee_1 ON t_TSDFlowData.offrun_employee = t_Employee_1.employee_code LEFT OUTER JOIN
                                          t_TSDConfirm INNER JOIN
                                          t_Employee ON t_TSDConfirm.confirm_people = t_Employee.employee_code ON t_TSDFlowData.confirmon_id = t_TSDConfirm.confirm_id ON 
                                          t_TSDConfirm_1.confirm_id = t_TSDFlowData.confirmoff_id"
                + GetWhere(v_equip_code, v_flow_status, v_poweroff_branch, v_poweroff_employee, v_poweroff_start, v_poweroff_end, v_poweron_branch, v_poweron_employee, v_poweron_start, v_poweron_end, v_timespan_min, v_timespan_max)
                + GetOrder(v_sort, v_order);
            return claSqlConnDB.ExecuteDataset(v_rows, v_page, claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL).Tables[0];
        }

        public DataTable GetTSDFlowData(int v_page, int v_rows, string v_equip_code, int v_flow_status, int v_poweroff_branch, string v_poweroff_employee, DateTime v_poweroff_start, DateTime v_poweroff_end, int v_poweron_branch, string v_poweron_employee, DateTime v_poweron_start, DateTime v_poweron_end, float v_timespan_min, float v_timespan_max)
        {
            string mStrSQL = @"SELECT     t_TSDFlowData.flow_id, t_TSDFlowData.equip_code, t_TSDFlowData.flow_status, t_TSDFlowData.confirmoff_id, t_TSDConfirm_1.confirm_people AS confirmoff_people, 
                                          t_TSDConfirm_1.confirm_time AS confirmoff_time, t_TSDConfirm_1.location_info AS confirmoff_location, t_TSDConfirm_1.equip_code AS confirmoff_equip_code, 
                                          t_TSDConfirm_1.equip_state AS confirmoff_equip_state, t_TSDConfirm_1.confirm_remark AS confirmoff_remark, t_TSDFlowData.off_time, t_TSDFlowData.offrun_branch, 
                                          t_TSDFlowData.offrun_employee, t_TSDFlowData.confirmon_id, t_TSDConfirm.confirm_people AS confirmon_people, t_TSDConfirm.confirm_time AS confirmon_time, 
                                          t_TSDConfirm.location_info AS confirmon_location, t_TSDConfirm.equip_code AS confirmon_equip_code, t_TSDConfirm.equip_state AS confirmon_equip_state, 
                                          t_TSDConfirm.confirm_remark AS confirmon_remark, t_TSDFlowData.on_time, t_TSDFlowData.onrun_branch, t_TSDFlowData.onrun_employee, t_TSDFlowData.off_timespan, 
                                          t_Employee_1.employee_name AS offrun_employee_name, t_Employee_2.employee_name AS onrun_employee_name, t_Equips.equip_name, 
                                          tHRBranchInfo_1.dVchBranchName AS offrun_branch_name, tHRBranchInfo.dVchBranchName AS onrun_branch_name, t_Employee_3.employee_name AS confirmoff_employee_name, 
                                          t_Employee.employee_name AS confirmon_employee_name
                             FROM         t_Employee AS t_Employee_3 INNER JOIN
                                          t_TSDConfirm AS t_TSDConfirm_1 ON t_Employee_3.employee_code = t_TSDConfirm_1.confirm_people RIGHT OUTER JOIN
                                          t_TSDFlowData LEFT OUTER JOIN
                                          tHRBranchInfo ON t_TSDFlowData.onrun_branch = tHRBranchInfo.dIntBranchID LEFT OUTER JOIN
                                          tHRBranchInfo AS tHRBranchInfo_1 ON t_TSDFlowData.offrun_branch = tHRBranchInfo_1.dIntBranchID LEFT OUTER JOIN
                                          t_Equips ON t_TSDFlowData.equip_code = t_Equips.equip_code LEFT OUTER JOIN
                                          t_Employee AS t_Employee_2 ON t_TSDFlowData.onrun_employee = t_Employee_2.employee_code LEFT OUTER JOIN
                                          t_Employee AS t_Employee_1 ON t_TSDFlowData.offrun_employee = t_Employee_1.employee_code LEFT OUTER JOIN
                                          t_TSDConfirm INNER JOIN
                                          t_Employee ON t_TSDConfirm.confirm_people = t_Employee.employee_code ON t_TSDFlowData.confirmon_id = t_TSDConfirm.confirm_id ON 
                                          t_TSDConfirm_1.confirm_id = t_TSDFlowData.confirmoff_id"
                + GetWhere(v_equip_code, v_flow_status, v_poweroff_branch, v_poweroff_employee, v_poweroff_start, v_poweroff_end, v_poweron_branch, v_poweron_employee, v_poweron_start, v_poweron_end, v_timespan_min, v_timespan_max);
            return claSqlConnDB.ExecuteDataset(v_rows,v_page,claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL).Tables[0];
        }

        public DataTable GetTSDFlowData(string v_equip_code, int v_flow_status, int v_poweroff_branch, string v_poweroff_employee, DateTime v_poweroff_start, DateTime v_poweroff_end, int v_poweron_branch, string v_poweron_employee, DateTime v_poweron_start, DateTime v_poweron_end, float v_timespan_min, float v_timespan_max)
        {
            string mStrSQL = @"SELECT     t_TSDFlowData.flow_id, t_TSDFlowData.equip_code, t_TSDFlowData.flow_status, t_TSDFlowData.confirmoff_id, t_TSDConfirm_1.confirm_people AS confirmoff_people, 
                                          t_TSDConfirm_1.confirm_time AS confirmoff_time, t_TSDConfirm_1.location_info AS confirmoff_location, t_TSDConfirm_1.equip_code AS confirmoff_equip_code, 
                                          t_TSDConfirm_1.equip_state AS confirmoff_equip_state, t_TSDConfirm_1.confirm_remark AS confirmoff_remark, t_TSDFlowData.off_time, t_TSDFlowData.offrun_branch, 
                                          t_TSDFlowData.offrun_employee, t_TSDFlowData.confirmon_id, t_TSDConfirm.confirm_people AS confirmon_people, t_TSDConfirm.confirm_time AS confirmon_time, 
                                          t_TSDConfirm.location_info AS confirmon_location, t_TSDConfirm.equip_code AS confirmon_equip_code, t_TSDConfirm.equip_state AS confirmon_equip_state, 
                                          t_TSDConfirm.confirm_remark AS confirmon_remark, t_TSDFlowData.on_time, t_TSDFlowData.onrun_branch, t_TSDFlowData.onrun_employee, t_TSDFlowData.off_timespan, 
                                          t_Employee_1.employee_name AS offrun_employee_name, t_Employee_2.employee_name AS onrun_employee_name, t_Equips.equip_name, 
                                          tHRBranchInfo_1.dVchBranchName AS offrun_branch_name, tHRBranchInfo.dVchBranchName AS onrun_branch_name, t_Employee_3.employee_name AS confirmoff_employee_name, 
                                          t_Employee.employee_name AS confirmon_employee_name
                             FROM         t_Employee AS t_Employee_3 INNER JOIN
                                          t_TSDConfirm AS t_TSDConfirm_1 ON t_Employee_3.employee_code = t_TSDConfirm_1.confirm_people RIGHT OUTER JOIN
                                          t_TSDFlowData LEFT OUTER JOIN
                                          tHRBranchInfo ON t_TSDFlowData.onrun_branch = tHRBranchInfo.dIntBranchID LEFT OUTER JOIN
                                          tHRBranchInfo AS tHRBranchInfo_1 ON t_TSDFlowData.offrun_branch = tHRBranchInfo_1.dIntBranchID LEFT OUTER JOIN
                                          t_Equips ON t_TSDFlowData.equip_code = t_Equips.equip_code LEFT OUTER JOIN
                                          t_Employee AS t_Employee_2 ON t_TSDFlowData.onrun_employee = t_Employee_2.employee_code LEFT OUTER JOIN
                                          t_Employee AS t_Employee_1 ON t_TSDFlowData.offrun_employee = t_Employee_1.employee_code LEFT OUTER JOIN
                                          t_TSDConfirm INNER JOIN
                                          t_Employee ON t_TSDConfirm.confirm_people = t_Employee.employee_code ON t_TSDFlowData.confirmon_id = t_TSDConfirm.confirm_id ON 
                                          t_TSDConfirm_1.confirm_id = t_TSDFlowData.confirmoff_id"
                + GetWhere(v_equip_code, v_flow_status, v_poweroff_branch, v_poweroff_employee, v_poweroff_start, v_poweroff_end, v_poweron_branch, v_poweron_employee, v_poweron_start, v_poweron_end, v_timespan_min, v_timespan_max);
            return claSqlConnDB.ExecuteDataset(claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL).Tables[0];
        }

        public int GetTSDFlowDetailCount(string v_flow_id)
        {
            string mStrSQL = @"SELECT count(0) FROM t_TSDFlowRequestDetail " + GetDetailWhere(v_flow_id);
            return claSqlConnDB.GetRecordCount(claSqlConnDB.gStrConnDefault, mStrSQL);
            
        }

        public DataTable GetTSDFlowDetail(int v_page, int v_rows, string v_flow_id, string v_sort, string v_order)
        {
            string mStrSQL = @"SELECT     t_TSDFlowRequestDetail.flow_id, t_TSDFlowRequestDetail.detail_status, t_TSDPowerOffRequest.poweroff_id, t_TSDPowerOffRequest.request_status AS poweroff_request_status, 
                                          t_TSDPowerOffRequest.request_company AS poweroff_request_company, t_TSDPowerOffRequest.request_branch AS poweroff_request_branch, 
                                          t_TSDPowerOffRequest.request_people AS poweroff_request_employee, t_TSDPowerOffRequest.request_time AS poweroff_request_time, t_TSDPowerOffRequest.stop_equip, 
                                          t_TSDPowerOffRequest.stop_time, t_TSDPowerOffRequest.stop_duration, t_TSDPowerOffRequest.request_remark AS poweroff_request_remark, 
                                          t_examine_poweroff.examine_id AS poweroff_examine_id, t_TSDExamine.examine_status AS poweroff_examine_status, t_TSDExamine.examine_time AS poweroff_examine_time, 
                                          t_TSDExamine.examine_people AS poweroff_examine_people, t_TSDProof.proof_id AS poweroff_examine_proof_id, t_TSDProof.equip_code AS poweroff_examine_equip_code, 
                                          t_TSDProof.equip_value AS poweroff_examine_equip_value, t_TSDProof.value_time AS poweroff_examine_value_time, t_TSDExamine.examine_result AS poweroff_examine_result, 
                                          t_TSDExamine.examine_remark AS poweroff_examine_remark, t_TSDPowerOnRequest.poweron_id, t_TSDPowerOnRequest.request_company AS poweron_request_company, 
                                          t_TSDPowerOnRequest.request_branch AS poweron_request_branch, t_TSDPowerOnRequest.request_people AS poweron_request_employee, 
                                          t_TSDPowerOnRequest.request_time AS poweron_request_time, t_TSDPowerOnRequest.stop_time AS start_time, t_TSDPowerOnRequest.request_remark AS poweron_request_remark, 
                                          t_TSDExamine_1.examine_id AS poweron_examine_id, t_TSDExamine_1.examine_status AS poweron_examine_status, t_TSDExamine_1.examine_time AS poweron_examine_time, 
                                          t_TSDExamine_1.examine_people AS poweron_examine_employee, t_TSDProof_1.proof_id AS poweron_examine_proof_id, t_TSDProof_1.equip_code AS poweron_examine_equip_code, 
                                          t_TSDProof_1.equip_value AS poweron_examine_equip_value, t_TSDProof_1.value_time AS poweron_examine_value_time, t_TSDExamine_1.examine_result AS poweron_examine_result, 
                                          t_TSDExamine_1.examine_remark AS poweron_examine_remark, t_Employee_1.employee_name AS poweroff_examine_employee_name, 
                                          t_Employee.employee_name AS poweroff_request_employee_name, t_Employee_2.employee_name AS poweron_request_employee_name, 
                                          t_Employee_3.employee_name AS poweron_examine_employee_name, tHRCompany_1.dVchCompanyName AS poweron_request_company_name, 
                                          tHRBranchInfo_1.dVchBranchName AS poweron_request_branch_name, tHRCompany.dVchCompanyName AS poweroff_request_company_name, 
                                          tHRBranchInfo.dVchBranchName AS poweroff_request_branch_name
                             FROM         t_TSDProof AS t_TSDProof_1 RIGHT OUTER JOIN
                                          t_TSDFlowRequestDetail LEFT OUTER JOIN
                                          t_TSDPowerOffRequest LEFT OUTER JOIN
                                          tHRBranchInfo ON t_TSDPowerOffRequest.request_branch = tHRBranchInfo.dIntBranchID LEFT OUTER JOIN
                                          tHRCompany ON t_TSDPowerOffRequest.request_company = tHRCompany.dIntCompanyID LEFT OUTER JOIN
                                          t_Employee ON t_TSDPowerOffRequest.request_people = t_Employee.employee_code LEFT OUTER JOIN
                                          t_Employee AS t_Employee_2 RIGHT OUTER JOIN
                                          tHRCompany AS tHRCompany_1 RIGHT OUTER JOIN
                                          tHRBranchInfo AS tHRBranchInfo_1 RIGHT OUTER JOIN
                                          t_TSDPowerOnRequest ON tHRBranchInfo_1.dIntBranchID = t_TSDPowerOnRequest.request_branch ON tHRCompany_1.dIntCompanyID = t_TSDPowerOnRequest.request_company ON 
                                          t_Employee_2.employee_code = t_TSDPowerOnRequest.request_people LEFT OUTER JOIN
                                          t_Employee AS t_Employee_3 RIGHT OUTER JOIN
                                          t_TSDExamine AS t_TSDExamine_1 ON t_Employee_3.employee_code = t_TSDExamine_1.examine_people RIGHT OUTER JOIN
                                          t_examine_poweron ON t_TSDExamine_1.examine_id = t_examine_poweron.examine_id ON t_TSDPowerOnRequest.poweron_id = t_examine_poweron.poweron_id RIGHT OUTER JOIN
                                          t_verification_request ON t_TSDPowerOnRequest.poweron_id = t_verification_request.poweron_request ON 
                                          t_TSDPowerOffRequest.poweroff_id = t_verification_request.poweroff_request LEFT OUTER JOIN
                                          t_examine_poweroff LEFT OUTER JOIN
                                          t_TSDProof RIGHT OUTER JOIN
                                          t_TSDExamine LEFT OUTER JOIN
                                          t_Employee AS t_Employee_1 ON t_TSDExamine.examine_people = t_Employee_1.employee_code ON t_TSDProof.proof_id = t_TSDExamine.examine_proof ON 
                                          t_examine_poweroff.examine_id = t_TSDExamine.examine_id ON t_TSDPowerOffRequest.poweroff_id = t_examine_poweroff.poweroff_id ON 
                                          t_TSDFlowRequestDetail.request_id = t_TSDPowerOffRequest.poweroff_id ON t_TSDProof_1.proof_id = t_TSDExamine_1.examine_proof"
                            + GetDetailWhere(v_flow_id) + GetDetailOrder(v_sort, v_order);

            return claSqlConnDB.ExecuteDataset(v_rows,v_page,claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL).Tables[0];
        }
        #endregion

        private string GetWhere(string v_equip_code, int v_flow_status, int v_poweroff_branch, string v_poweroff_employee, DateTime v_poweroff_start, DateTime v_poweroff_end, int v_poweron_branch, string v_poweron_employee, DateTime v_poweron_start, DateTime v_poweron_end, float v_timespan_min, float v_timespan_max)
        {
            string mStrWhere=" WHERE 1=1 ";
            if (v_equip_code != "")
            {
                mStrWhere = mStrWhere + " AND t_TSDFlowData.equip_code='" + v_equip_code.ToString() + "' ";
            }
            if (v_flow_status != -1)
            {
                mStrWhere = mStrWhere + " AND t_TSDFlowData.flow_status=" + v_flow_status.ToString() + " ";
            }
            if (v_poweroff_branch != 0)
            {
                mStrWhere = mStrWhere + " AND t_TSDFlowData.offrun_branch=" + v_poweroff_branch.ToString() + " ";
            }
            if (v_poweroff_employee != "")
            {
                mStrWhere = mStrWhere + " AND t_TSDFlowData.offrun_employee='" + v_poweroff_employee.ToString() + "' ";
            }
            if (v_poweroff_start != DateTime.Parse("1900-01-01 00:00:00"))
            {
                mStrWhere = mStrWhere + " AND t_TSDFlowData.off_time>CONVERT(DATETIME,'" + v_poweroff_start.ToString() + "',102) ";
            }
            if (v_poweroff_end != DateTime.Parse("1900-01-01 00:00:00"))
            {
                mStrWhere = mStrWhere + " AND t_TSDFlowData.off_time<CONVERT(DATETIME,'" + v_poweroff_end.ToString() + "',102) ";
            }
            if (v_poweron_branch != 0)
            {
                mStrWhere = mStrWhere + " AND t_TSDFlowData.onrun_branch=" + v_poweron_branch.ToString() + " ";
            }
            if (v_poweron_employee != "")
            {
                mStrWhere = mStrWhere + " AND t_TSDFlowData.onrun_employee='" + v_poweron_employee.ToString() + "' ";
            }
            if (v_poweron_start != DateTime.Parse("1900-01-01 00:00:00"))
            {
                mStrWhere = mStrWhere + " AND t_TSDFlowData.on_time>CONVERT(DATETIME,'" + v_poweron_start.ToString() + "',102) ";
            }
            if (v_poweron_end != DateTime.Parse("1900-01-01 00:00:00"))
            {
                mStrWhere = mStrWhere + " AND t_TSDFlowData.on_time<CONVERT(DATETIME,'" + v_poweron_end.ToString() + "',102) ";
            }
            if (v_timespan_min != -1)
            {
                mStrWhere = mStrWhere + " AND t_TSDFlowData.off_timespan>" + v_timespan_min.ToString() + " ";
            }
            if (v_timespan_max != -1)
            {
                mStrWhere = mStrWhere + " AND t_TSDFlowData.off_timespan<" + v_timespan_max.ToString() + " ";
            }
            return mStrWhere;
        }

        private string GetOrder(string v_sort, string v_order)
        {
            string mStrOrder = "";
            if (v_sort != "")
            {
                mStrOrder = " ORDER BY t_TSDFlowData." + v_sort + " ";
                if (v_order != "")
                {
                    mStrOrder = mStrOrder + v_order;
                }
            }
            return mStrOrder;
        }

        private string GetDetailWhere(string v_flow_id)
        {
            string mStrWhere = " WHERE t_TSDFlowRequestDetail.flow_id='" + v_flow_id + "' ";
            return mStrWhere;
        }
        private string GetDetailOrder(string v_sort, string v_order)
        {
            string mStrOrder = " Order By t_TSDPowerOffRequest.request_time desc";
            return mStrOrder;
        }
    }
}
