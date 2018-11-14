using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using System.Data.SqlClient;

namespace GJHF.Data.MSSQL.TSD
{
    public class DRequestUnit:Interface.TSD.IRequestUnit
    {
        #region IRequestUnit 成员

        public string AddPowerOffRequest(int v_request_company, int v_request_branch, string v_request_people, DateTime v_request_time, string v_stop_equip, DateTime v_stop_time, float v_stop_duration, string v_request_remark)
        {
            int mIntReturn = -1;
            string mStrPowerOffID="";
            SqlParameter[] parameters = new SqlParameter[]{
                new SqlParameter("@request_company",SqlDbType.Int){Value=v_request_company},
                new SqlParameter("@request_branch",SqlDbType.Int){Value=v_request_branch},
                new SqlParameter("@request_people",SqlDbType.VarChar,30){Value=v_request_people},
                new SqlParameter("@request_time",SqlDbType.DateTime){Value=v_request_time},
                new SqlParameter("@stop_equip",SqlDbType.VarChar,30){Value=v_stop_equip},
                new SqlParameter("@stop_time",SqlDbType.DateTime){Value=v_stop_time},
                new SqlParameter("@stop_duration",SqlDbType.Float){Value=v_stop_duration},
                new SqlParameter("@request_remark",SqlDbType.VarChar,200){Value=v_request_remark},
                new SqlParameter("@voRequestID",SqlDbType.VarChar,30){Direction=ParameterDirection.Output},
                new SqlParameter("@voIntReturn",SqlDbType.Int){Direction=ParameterDirection.Output},
            };
            claSqlConnDB.ExecuteNonQuery(claSqlConnDB.gStrConnDefault, CommandType.StoredProcedure, "p_tsd_add_power_off_request", parameters);
            mIntReturn = (int)parameters[9].Value;
            if (mIntReturn == 0)
            {
                mStrPowerOffID = parameters[8].Value.ToString();
            }
            return mStrPowerOffID;
        }

        public int CancelPowerOffRequest(string v_poweroff_id)
        {
            int mIntReturn = -1;
            int mIntIsCancel = -2;
            SqlParameter[] parameters = new SqlParameter[]{
                new SqlParameter("@poweroff_id",SqlDbType.VarChar,30){Value=v_poweroff_id},
                new SqlParameter("@voIntIsCancel",SqlDbType.Int){Direction=ParameterDirection.Output},
                new SqlParameter("@voIntReturn",SqlDbType.Int){Direction=ParameterDirection.Output} 
            };
            claSqlConnDB.ExecuteNonQuery(claSqlConnDB.gStrConnDefault, CommandType.StoredProcedure, "p_cancel_power_off_request", parameters);
            mIntReturn = (int)parameters[2].Value;
            if (mIntReturn == 0)
            {
                mIntIsCancel = (int)parameters[1].Value;
            }
            return mIntIsCancel;
        }

        public int GetPowerOffRequestCount(int v_request_status, int v_request_company, int v_request_branch, string v_request_people, DateTime v_request_start, DateTime v_request_end, string v_stop_equip, DateTime v_stop_start, DateTime v_stop_end, float v_stop_duration)
        {
            int mIntPowerOffRequestCount = 0;
            string mStrSQL = @"SELECT COUNT(0) FROM t_TSDPowerOffRequest" + GetPowerOffWhere(v_request_status, v_request_company, v_request_branch, v_request_people, v_request_start, v_request_end, v_stop_equip, v_stop_start, v_stop_end, v_stop_duration);
            mIntPowerOffRequestCount = claSqlConnDB.GetRecordCount(claSqlConnDB.gStrConnDefault, mStrSQL);
            return mIntPowerOffRequestCount;
        }

        public DataTable GetPowerOffRequest(int v_page, int v_rows, int v_request_status, int v_request_company, int v_request_branch, string v_request_people, DateTime v_request_start, DateTime v_request_end, string v_stop_equip, DateTime v_stop_start, DateTime v_stop_end, float v_stop_duration, string v_sort, string v_order)
        {
            string mStrSQL = @"SELECT     t_TSDPowerOffRequest.poweroff_id, t_TSDPowerOffRequest.request_status, t_TSDPowerOffRequest.request_company, t_TSDPowerOffRequest.request_branch, 
                                          t_TSDPowerOffRequest.request_people, t_TSDPowerOffRequest.request_time, t_TSDPowerOffRequest.stop_equip, t_TSDPowerOffRequest.stop_time, t_TSDPowerOffRequest.stop_duration, 
                                          t_TSDPowerOffRequest.request_remark, tHRCompany.dVchCompanyName AS company_name, tHRBranchInfo.dVchBranchName AS branch_name, t_Employee.employee_name, 
                                          t_Equips.equip_name
                             FROM         t_TSDPowerOffRequest LEFT OUTER JOIN
                                          t_Equips ON t_TSDPowerOffRequest.stop_equip = t_Equips.equip_code LEFT OUTER JOIN
                                          tHRBranchInfo ON t_TSDPowerOffRequest.request_branch = tHRBranchInfo.dIntBranchID LEFT OUTER JOIN
                                          t_Employee ON t_TSDPowerOffRequest.request_people = t_Employee.employee_code LEFT OUTER JOIN
                                          tHRCompany ON t_TSDPowerOffRequest.request_company = tHRCompany.dIntCompanyID " + GetPowerOffWhere(v_request_status, v_request_company, v_request_branch, v_request_people, v_request_start, v_request_end, v_stop_equip, v_stop_start, v_stop_end, v_stop_duration) + GetPowerOffOrder(v_sort, v_order);
            return claSqlConnDB.ExecuteDataset(v_rows, v_page,claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL).Tables[0];
        }

        public DataTable GetPowerOffRequest(int v_page, int v_rows, int v_request_status, int v_request_company, int v_request_branch, string v_request_people, DateTime v_request_start, DateTime v_request_end, string v_stop_equip, DateTime v_stop_start, DateTime v_stop_end, float v_stop_duration)
        {
            string mStrSQL = @"SELECT     t_TSDPowerOffRequest.poweroff_id, t_TSDPowerOffRequest.request_status, t_TSDPowerOffRequest.request_company, t_TSDPowerOffRequest.request_branch, 
                                          t_TSDPowerOffRequest.request_people, t_TSDPowerOffRequest.request_time, t_TSDPowerOffRequest.stop_equip, t_TSDPowerOffRequest.stop_time, t_TSDPowerOffRequest.stop_duration, 
                                          t_TSDPowerOffRequest.request_remark, tHRCompany.dVchCompanyName AS company_name, tHRBranchInfo.dVchBranchName AS branch_name, t_Employee.employee_name, 
                                          t_Equips.equip_name
                             FROM         t_TSDPowerOffRequest LEFT OUTER JOIN
                                          t_Equips ON t_TSDPowerOffRequest.stop_equip = t_Equips.equip_code LEFT OUTER JOIN
                                          tHRBranchInfo ON t_TSDPowerOffRequest.request_branch = tHRBranchInfo.dIntBranchID LEFT OUTER JOIN
                                          t_Employee ON t_TSDPowerOffRequest.request_people = t_Employee.employee_code LEFT OUTER JOIN
                                          tHRCompany ON t_TSDPowerOffRequest.request_company = tHRCompany.dIntCompanyID " + GetPowerOffWhere(v_request_status, v_request_company, v_request_branch, v_request_people, v_request_start, v_request_end, v_stop_equip, v_stop_start, v_stop_end, v_stop_duration);
            return claSqlConnDB.ExecuteDataset(v_rows, v_page, claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL).Tables[0];
        }

        public DataTable GetPowerOffRequest(int v_request_status, int v_request_company, int v_request_branch, string v_request_people, DateTime v_request_start, DateTime v_request_end, string v_stop_equip, DateTime v_stop_start, DateTime v_stop_end, float v_stop_duration)
        {
            string mStrSQL = @"SELECT     t_TSDPowerOffRequest.poweroff_id, t_TSDPowerOffRequest.request_status, t_TSDPowerOffRequest.request_company, t_TSDPowerOffRequest.request_branch, 
                                          t_TSDPowerOffRequest.request_people, t_TSDPowerOffRequest.request_time, t_TSDPowerOffRequest.stop_equip, t_TSDPowerOffRequest.stop_time, t_TSDPowerOffRequest.stop_duration, 
                                          t_TSDPowerOffRequest.request_remark, tHRCompany.dVchCompanyName AS company_name, tHRBranchInfo.dVchBranchName AS branch_name, t_Employee.employee_name, 
                                          t_Equips.equip_name
                             FROM         t_TSDPowerOffRequest LEFT OUTER JOIN
                                          t_Equips ON t_TSDPowerOffRequest.stop_equip = t_Equips.equip_code LEFT OUTER JOIN
                                          tHRBranchInfo ON t_TSDPowerOffRequest.request_branch = tHRBranchInfo.dIntBranchID LEFT OUTER JOIN
                                          t_Employee ON t_TSDPowerOffRequest.request_people = t_Employee.employee_code LEFT OUTER JOIN
                                          tHRCompany ON t_TSDPowerOffRequest.request_company = tHRCompany.dIntCompanyID " + GetPowerOffWhere(v_request_status, v_request_company, v_request_branch, v_request_people, v_request_start, v_request_end, v_stop_equip, v_stop_start, v_stop_end, v_stop_duration);
            return claSqlConnDB.ExecuteDataset(claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL).Tables[0];
        }
        public Dictionary<string, object> GetPowerOffDetailByID(string v_poweroff_id)
        {
            Dictionary<string, object> mDicPowerOffDetail = new Dictionary<string, object>();
            string mStrSQL = @"SELECT     t_TSDPowerOffRequest.poweroff_id, t_TSDPowerOffRequest.request_status, t_TSDPowerOffRequest.request_company, t_TSDPowerOffRequest.request_branch, 
                                          t_TSDPowerOffRequest.request_people, t_TSDPowerOffRequest.request_time, t_TSDPowerOffRequest.stop_equip, t_TSDPowerOffRequest.stop_time, t_TSDPowerOffRequest.stop_duration, 
                                          t_TSDPowerOffRequest.request_remark, tHRCompany.dVchCompanyName AS company_name, tHRBranchInfo.dVchBranchName AS branch_name, t_Employee.employee_name, 
                                          t_Equips.equip_name
                             FROM         t_TSDPowerOffRequest LEFT OUTER JOIN
                                          t_Equips ON t_TSDPowerOffRequest.stop_equip = t_Equips.equip_code LEFT OUTER JOIN
                                          tHRBranchInfo ON t_TSDPowerOffRequest.request_branch = tHRBranchInfo.dIntBranchID LEFT OUTER JOIN
                                          t_Employee ON t_TSDPowerOffRequest.request_people = t_Employee.employee_code LEFT OUTER JOIN
                                          tHRCompany ON t_TSDPowerOffRequest.request_company = tHRCompany.dIntCompanyID  
                            WHERE        t_TSDPowerOffRequest.poweroff_id=@poweroff_id";
            SqlParameter[] parameters = new SqlParameter[]{
                new SqlParameter("@poweroff_id",SqlDbType.VarChar,30){Value=v_poweroff_id}
            };
            mDicPowerOffDetail = GJHF.Utility.Convert.ConvertModelToDictionary(claSqlConnDB.GetDetail(claSqlConnDB.gStrConnDefault, mStrSQL, "GJHF.Data.Model.TSD.MPowerOffRequest", "GJHF.Data.Model", parameters));
            return mDicPowerOffDetail;
        }

        public string AddPowerOnRequest(string v_poweroff_id, int v_request_company, int v_request_branch, string v_request_people, DateTime v_request_time, DateTime v_star_time, string v_request_remark)
        {
            int mIntReturn = -1;
            string mStrPowerOnID = "";
            SqlParameter[] parameters = new SqlParameter[]{
                new SqlParameter("@poweroff_id",SqlDbType.VarChar,30){Value=v_poweroff_id},
                new SqlParameter("@request_company",SqlDbType.Int){Value=v_request_company},
                new SqlParameter("@request_branch",SqlDbType.Int){Value=v_request_branch},
                new SqlParameter("@request_employee",SqlDbType.VarChar,30){Value=v_request_people},
                new SqlParameter("@request_time",SqlDbType.DateTime){Value=v_request_time},
                new SqlParameter("@start_time",SqlDbType.DateTime){Value=v_star_time},
                new SqlParameter("@request_remark",SqlDbType.VarChar,200){Value=v_request_remark},
                new SqlParameter("@voPowerOnRequest",SqlDbType.VarChar,30){Direction=ParameterDirection.Output},
                new SqlParameter("@voIntReturn",SqlDbType.Int){Direction=ParameterDirection.Output},
            };
            claSqlConnDB.ExecuteNonQuery(claSqlConnDB.gStrConnDefault, CommandType.StoredProcedure, "p_tsd_add_power_on_request", parameters);
            mIntReturn = (int)parameters[8].Value;
            if (mIntReturn == 0)
            {
                mStrPowerOnID = parameters[7].Value.ToString();
            }
            return mStrPowerOnID;
        }

        public int CancelPowerOnRequest(string v_poweron_id)
        {
            int mIntReturn = -1;
            int mIntIsCancel = -2;
            SqlParameter[] parameters = new SqlParameter[]{
                new SqlParameter("@poweron_id",SqlDbType.VarChar,30){Value=v_poweron_id},
                new SqlParameter("@voIntIsCancel",SqlDbType.Int){Direction=ParameterDirection.Output},
                new SqlParameter("@voIntReturn",SqlDbType.Int){Direction=ParameterDirection.Output} 
            };
            claSqlConnDB.ExecuteNonQuery(claSqlConnDB.gStrConnDefault, CommandType.StoredProcedure, "p_cancle_power_on_request", parameters);
            mIntReturn = (int)parameters[2].Value;
            if (mIntReturn == 0)
            {
                mIntIsCancel = (int)parameters[1].Value;
            }
            return mIntIsCancel;
        }

        public int GetPowerOnRequestCount(int v_request_status, int v_request_company, int v_request_branch, string v_request_people, DateTime v_request_start, DateTime v_request_end, string v_stop_equip, DateTime v_poweron_start, DateTime v_poweron_end)
        {
            int mIntPowerOnRequestCount = 0;
            string mStrSQL = @"SELECT     count(0)
                             FROM         t_TSDPowerOnRequest LEFT OUTER JOIN
                                          tHRBranchInfo ON t_TSDPowerOnRequest.request_branch = tHRBranchInfo.dIntBranchID LEFT OUTER JOIN
                                          t_Employee ON t_TSDPowerOnRequest.request_people = t_Employee.employee_code LEFT OUTER JOIN
                                          tHRCompany ON t_TSDPowerOnRequest.request_company = tHRCompany.dIntCompanyID " + GetPowerOnWhere(v_request_status, v_request_company, v_request_branch, v_request_people, v_request_start, v_request_end, v_stop_equip, v_poweron_start, v_poweron_end);
            mIntPowerOnRequestCount = claSqlConnDB.GetRecordCount(claSqlConnDB.gStrConnDefault, mStrSQL);
            return mIntPowerOnRequestCount;
        }

        public DataTable GetPowerOnRequest(int v_page, int v_rows, int v_request_status, int v_request_company, int v_request_branch, string v_request_people, DateTime v_request_start, DateTime v_request_end, string v_stop_equip, DateTime v_poweron_start, DateTime v_poweron_end, string v_sort, string v_order)
        {
            string mStrSQL = @"SELECT     t_TSDPowerOnRequest.poweron_id, t_TSDPowerOnRequest.request_status, t_TSDPowerOnRequest.request_company, t_TSDPowerOnRequest.request_branch, 
                                          t_TSDPowerOnRequest.request_people, t_TSDPowerOnRequest.request_time, t_TSDPowerOnRequest.stop_time, t_TSDPowerOnRequest.request_remark, 
                                          tHRCompany.dVchCompanyName AS request_company_name, tHRBranchInfo.dVchBranchName AS request_branch_name, t_Employee.employee_name, 
                                          t_TSDPowerOffRequest.poweroff_id, t_Equips.equip_code, t_Equips.equip_name
                             FROM         t_Equips RIGHT OUTER JOIN
                                          t_TSDPowerOffRequest ON t_Equips.equip_code = t_TSDPowerOffRequest.stop_equip RIGHT OUTER JOIN
                                          t_TSDPowerOnRequest LEFT OUTER JOIN
                                          t_verification_request ON t_TSDPowerOnRequest.poweron_id = t_verification_request.poweron_request LEFT OUTER JOIN
                                          tHRBranchInfo ON t_TSDPowerOnRequest.request_branch = tHRBranchInfo.dIntBranchID LEFT OUTER JOIN
                                          t_Employee ON t_TSDPowerOnRequest.request_people = t_Employee.employee_code LEFT OUTER JOIN
                                          tHRCompany ON t_TSDPowerOnRequest.request_company = tHRCompany.dIntCompanyID ON 
                                          t_TSDPowerOffRequest.poweroff_id = t_verification_request.poweroff_request " + GetPowerOnWhere(v_request_status, v_request_company, v_request_branch, v_request_people, v_request_start, v_request_end, v_stop_equip, v_poweron_start, v_poweron_end) + GetPowerOnOrder(v_sort, v_order);
            return claSqlConnDB.ExecuteDataset(v_rows,v_page,claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL).Tables[0];
        }

        public DataTable GetPowerOnRequest(int v_page, int v_rows, int v_request_status, int v_request_company, int v_request_branch, string v_request_people, DateTime v_request_start, DateTime v_request_end, string v_stop_equip, DateTime v_poweron_start, DateTime v_poweron_end)
        {
            string mStrSQL = @"SELECT     t_TSDPowerOnRequest.poweron_id, t_TSDPowerOnRequest.request_status, t_TSDPowerOnRequest.request_company, t_TSDPowerOnRequest.request_branch, 
                                          t_TSDPowerOnRequest.request_people, t_TSDPowerOnRequest.request_time, t_TSDPowerOnRequest.stop_time, t_TSDPowerOnRequest.request_remark, 
                                          tHRCompany.dVchCompanyName AS request_company_name, tHRBranchInfo.dVchBranchName AS request_branch_name, t_Employee.employee_name, 
                                          t_TSDPowerOffRequest.poweroff_id, t_Equips.equip_code, t_Equips.equip_name
                             FROM         t_Equips RIGHT OUTER JOIN
                                          t_TSDPowerOffRequest ON t_Equips.equip_code = t_TSDPowerOffRequest.stop_equip RIGHT OUTER JOIN
                                          t_TSDPowerOnRequest LEFT OUTER JOIN
                                          t_verification_request ON t_TSDPowerOnRequest.poweron_id = t_verification_request.poweron_request LEFT OUTER JOIN
                                          tHRBranchInfo ON t_TSDPowerOnRequest.request_branch = tHRBranchInfo.dIntBranchID LEFT OUTER JOIN
                                          t_Employee ON t_TSDPowerOnRequest.request_people = t_Employee.employee_code LEFT OUTER JOIN
                                          tHRCompany ON t_TSDPowerOnRequest.request_company = tHRCompany.dIntCompanyID ON 
                                          t_TSDPowerOffRequest.poweroff_id = t_verification_request.poweroff_request " + GetPowerOnWhere(v_request_status, v_request_company, v_request_branch, v_request_people, v_request_start, v_request_end, v_stop_equip, v_poweron_start, v_poweron_end);
            return claSqlConnDB.ExecuteDataset(v_rows, v_page, claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL).Tables[0];
        }

        public DataTable GetPowerOnRequest(int v_request_status, int v_request_company, int v_request_branch, string v_request_people, DateTime v_request_start, DateTime v_request_end, string v_stop_equip, DateTime v_poweron_start, DateTime v_poweron_end)
        {
            string mStrSQL = @"SELECT     t_TSDPowerOnRequest.poweron_id, t_TSDPowerOnRequest.request_status, t_TSDPowerOnRequest.request_company, t_TSDPowerOnRequest.request_branch, 
                                          t_TSDPowerOnRequest.request_people, t_TSDPowerOnRequest.request_time, t_TSDPowerOnRequest.stop_time, t_TSDPowerOnRequest.request_remark, 
                                          tHRCompany.dVchCompanyName AS request_company_name, tHRBranchInfo.dVchBranchName AS request_branch_name, t_Employee.employee_name, 
                                          t_TSDPowerOffRequest.poweroff_id, t_Equips.equip_code, t_Equips.equip_name
                             FROM         t_Equips RIGHT OUTER JOIN
                                          t_TSDPowerOffRequest ON t_Equips.equip_code = t_TSDPowerOffRequest.stop_equip RIGHT OUTER JOIN
                                          t_TSDPowerOnRequest LEFT OUTER JOIN
                                          t_verification_request ON t_TSDPowerOnRequest.poweron_id = t_verification_request.poweron_request LEFT OUTER JOIN
                                          tHRBranchInfo ON t_TSDPowerOnRequest.request_branch = tHRBranchInfo.dIntBranchID LEFT OUTER JOIN
                                          t_Employee ON t_TSDPowerOnRequest.request_people = t_Employee.employee_code LEFT OUTER JOIN
                                          tHRCompany ON t_TSDPowerOnRequest.request_company = tHRCompany.dIntCompanyID ON 
                                          t_TSDPowerOffRequest.poweroff_id = t_verification_request.poweroff_request " + GetPowerOnWhere(v_request_status, v_request_company, v_request_branch, v_request_people, v_request_start, v_request_end, v_stop_equip, v_poweron_start, v_poweron_end);
            return claSqlConnDB.ExecuteDataset(claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL).Tables[0];
        }

        #endregion

        private string GetPowerOffWhere(int v_request_status, int v_request_company, int v_request_branch, string v_request_people, DateTime v_request_start, DateTime v_request_end, string v_stop_equip, DateTime v_stop_start, DateTime v_stop_end, float v_stop_duration)
        {
            string mStrWhere = " WHERE 1=1";
            if (v_request_status != -1)
            {
                mStrWhere = mStrWhere + " AND t_TSDPowerOffRequest.request_status=" + v_request_status.ToString() + " ";
            }
            if (v_request_company != 0)
            {
                mStrWhere = mStrWhere + " AND t_TSDPowerOffRequest.request_company=" + v_request_company.ToString() + " ";
            }
            if (v_request_branch != 0)
            {
                mStrWhere = mStrWhere + " AND t_TSDPowerOffRequest.request_branch=" + v_request_branch.ToString() + " ";
            }
            if (v_request_people != "")
            {
                mStrWhere = mStrWhere + " AND t_TSDPowerOffRequest.request_people='" + v_request_people.ToString() + "' ";
            }
            if (v_request_start != DateTime.Parse("1900-01-01 00:00"))
            {
                mStrWhere = mStrWhere + " AND t_TSDPowerOffRequest.request_time>CONVERT(DATETIME, '" + v_request_start .ToString()+ "', 102) ";
            }
            if (v_request_end != DateTime.Parse("1900-01-01 00:00"))
            {
                mStrWhere = mStrWhere + " AND t_TSDPowerOffRequest.request_time<CONVERT(DATETIME, '" + v_request_end.ToString() + "', 102) ";
            }
            if (v_stop_equip != "")
            {
                mStrWhere = mStrWhere + " AND t_TSDPowerOffRequest.stop_equip='" + v_stop_equip.ToString() + "' ";
            }
            if (v_stop_start != DateTime.Parse("1900-01-01 00:00"))
            {
                mStrWhere = mStrWhere + " AND t_TSDPowerOffRequest.stop_time>CONVERT(DATETIME, '" + v_stop_start.ToString() + "', 102) ";
            }
            if (v_stop_end != DateTime.Parse("1900-01-01 00:00"))
            {
                mStrWhere = mStrWhere + " AND t_TSDPowerOffRequest.stop_time<CONVERT(DATETIME, '" + v_stop_end.ToString() + "', 102) ";
            }
            if (v_stop_duration > 0)
            {
                mStrWhere = mStrWhere + " AND t_TSDPowerOffRequest.stop_duration>" + v_stop_duration.ToString() + " ";
            }
            return mStrWhere;
        }

        private string GetPowerOffOrder(string v_sort, string v_order)
        {
            string mStrOrder = "";
            if (v_sort != "")
            {
                mStrOrder = " ORDER BY t_TSDPowerOffRequest." + v_sort;
                if (v_order != "")
                {
                    mStrOrder = mStrOrder + " " + v_order;
                }
            }
            return mStrOrder;
        }

        private string GetPowerOnWhere(int v_request_status, int v_request_company, int v_request_branch, string v_request_people, DateTime v_request_start, DateTime v_request_end, string v_stop_equip, DateTime v_poweron_start, DateTime v_poweron_end)
        {
            string mStrWhere = " WHERE 1=1 ";
            if (v_request_status != -1)
            {
                mStrWhere = mStrWhere + " AND t_TSDPowerOnRequest.request_status=" + v_request_status.ToString() + " ";
            }
            if (v_request_company != 0)
            {
                mStrWhere = mStrWhere + " AND t_TSDPowerOnRequest.request_company=" + v_request_company.ToString() + " ";
            }
            if (v_request_branch != 0)
            {
                mStrWhere = mStrWhere + " AND t_TSDPowerOnRequest.request_branch=" + v_request_branch.ToString() + " ";
            }
            if (v_request_people != "")
            {
                mStrWhere = mStrWhere + " AND t_TSDPowerOnRequest.request_people ='" + v_request_people.ToString() + "'";
            }
            if (v_request_start != DateTime.Parse("1900-01-01 00:00"))
            {
                mStrWhere = mStrWhere + " AND t_TSDPowerOnRequest.request_time>CONVERT(DATETIME, '" + v_request_start.ToString() + "', 102) ";
            }
            if (v_request_end != DateTime.Parse("1900-01-01 00:00"))
            {
                mStrWhere = mStrWhere + " AND t_TSDPowerOnRequest.request_time<CONVERT(DATETIME, '" + v_request_end.ToString() + "', 102) ";
            }
            if (v_poweron_start != DateTime.Parse("1900-01-01 00:00"))
            {
                mStrWhere = mStrWhere + " AND t_TSDPowerOnRequest.start_time>CONVERT(DATETIME, '" + v_poweron_start.ToString() + "', 102) ";
            }
            if (v_poweron_end != DateTime.Parse("1900-01-01 00:00"))
            {
                mStrWhere = mStrWhere + " AND t_TSDPowerOnRequest.start_time<CONVERT(DATETIME, '" + v_poweron_end.ToString() + "', 102) ";
            }
            return mStrWhere;
        }

        private string GetPowerOnOrder(string v_sort, string v_order)
        {
            string mStrOrder = "";
            if (v_sort != "")
            {
                mStrOrder = " ORDER BY t_TSDPowerOnRequest." + v_sort;
                if (v_order != "")
                {
                    mStrOrder = mStrOrder + " " + v_order;
                }
            }
            return mStrOrder;
        }

        
    }
}
