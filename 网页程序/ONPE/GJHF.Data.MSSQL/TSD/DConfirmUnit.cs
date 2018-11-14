using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using System.Data.SqlClient;

namespace GJHF.Data.MSSQL.TSD
{
    public class DConfirmUnit:Interface.TSD.IConfirmUnit
    {
        #region IConfirmUnit 成员

        public string ConfirmPowerOff(string v_flow_id, string v_confirm_people, DateTime v_confirm_time, string v_location_info, string v_equip_code, int v_equip_status, string v_confirm_remark)
        {
            int mIntReturn = -1;
            string mStrConfirmID = "";
            SqlParameter[] parameters = new SqlParameter[]{
                new SqlParameter("@flow_id",SqlDbType.VarChar,30){Value=v_flow_id},
                new SqlParameter("@confirm_people",SqlDbType.VarChar,30){Value=v_confirm_people},
                new SqlParameter("@confirm_time",SqlDbType.DateTime){Value=v_confirm_time},
                new SqlParameter("@location_info",SqlDbType.VarChar,200){Value=v_location_info},
                new SqlParameter("@equip_code",SqlDbType.VarChar,30){Value=v_equip_code},
                new SqlParameter("@equip_state",SqlDbType.Int){Value=v_equip_status},
                new SqlParameter("@confirm_remark",SqlDbType.VarChar,500){Value=v_confirm_remark},
                new SqlParameter("@voConfirmID",SqlDbType.VarChar,30){Direction=ParameterDirection.Output},
                new SqlParameter("@voIntReturn",SqlDbType.Int){Direction=ParameterDirection.Output},
            };
            claSqlConnDB.ExecuteNonQuery(claSqlConnDB.gStrConnDefault, CommandType.StoredProcedure, "p_tsd_comfirm_power_off", parameters);
            mIntReturn = (int)parameters[8].Value;
            if (mIntReturn == 0)
            {
                mStrConfirmID = parameters[7].Value.ToString();
            }
            return mStrConfirmID;
        }

        public int PowerOff(string v_flow_id, DateTime v_poweroff_time, int v_poweroff_branch, string v_poweroff_employee)
        {
            SqlParameter[] parameters = new SqlParameter[]{
                new SqlParameter("@flow_id",SqlDbType.VarChar,30){Value=v_flow_id},
                new SqlParameter("@poweroff_time",SqlDbType.DateTime){Value=v_poweroff_time},
                new SqlParameter("@poweroff_branch",SqlDbType.Int){Value=v_poweroff_branch},
                new SqlParameter("@poweroff_employee",SqlDbType.VarChar,200){Value=v_poweroff_employee},
                new SqlParameter("@voIntReturn",SqlDbType.Int){Direction=ParameterDirection.Output}
            };
            return claSqlConnDB.ExecuteNonQuery(claSqlConnDB.gStrConnDefault, CommandType.StoredProcedure, "p_tsd_power_off", parameters);
        }

        public string ConfirmPowerOn(string v_flow_id, string v_confirm_people, DateTime v_confirm_time, string v_location_info, string v_equip_code, int v_equip_status, string v_confirm_remark)
        {
            int mIntReturn = -1;
            string mStrConfirmID = "";
            SqlParameter[] parameters = new SqlParameter[]{
                new SqlParameter("@flow_id",SqlDbType.VarChar,30){Value=v_flow_id},
                new SqlParameter("@confirm_people",SqlDbType.VarChar,30){Value=v_confirm_people},
                new SqlParameter("@confirm_time",SqlDbType.DateTime){Value=v_confirm_time},
                new SqlParameter("@location_info",SqlDbType.VarChar,200){Value=v_location_info},
                new SqlParameter("@equip_code",SqlDbType.VarChar,30){Value=v_equip_code},
                new SqlParameter("@equip_state",SqlDbType.Int){Value=v_equip_status},
                new SqlParameter("@confirm_remark",SqlDbType.VarChar,500){Value=v_confirm_remark},
                new SqlParameter("@voConfirmID",SqlDbType.VarChar,30){Direction=ParameterDirection.Output},
                new SqlParameter("@voIntReturn",SqlDbType.Int){Direction=ParameterDirection.Output},
            };
            claSqlConnDB.ExecuteNonQuery(claSqlConnDB.gStrConnDefault, CommandType.StoredProcedure, "p_tsd_comfirm_power_on", parameters);
            mIntReturn = (int)parameters[8].Value;
            if (mIntReturn == 0)
            {
                mStrConfirmID = parameters[7].Value.ToString();
            }
            return mStrConfirmID;
        }

        public int PowerOn(string v_flow_id, DateTime v_poweron_time, int v_poweron_branch, string v_poweron_employee)
        {
            SqlParameter[] parameters = new SqlParameter[]{
                new SqlParameter("@flow_id",SqlDbType.VarChar,30){Value=v_flow_id},
                new SqlParameter("@poweron_time",SqlDbType.DateTime){Value=v_poweron_time},
                new SqlParameter("@poweron_branch",SqlDbType.Int){Value=v_poweron_branch},
                new SqlParameter("@poweron_employee",SqlDbType.VarChar,200){Value=v_poweron_employee},
                new SqlParameter("@voIntReturn",SqlDbType.Int){Direction=ParameterDirection.Output}
            };
            return claSqlConnDB.ExecuteNonQuery(claSqlConnDB.gStrConnDefault, CommandType.StoredProcedure, "p_tsd_power_on", parameters);
        }

        #endregion
    }
}
