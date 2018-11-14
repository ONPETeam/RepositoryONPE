using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using System.Data.SqlClient;

namespace GJHF.Data.MSSQL.TSD
{
    public class DExamineUnit:Interface.TSD.IExamineUnit
    {
        #region IExamineUnit 成员

        public int ExamineRequest(int v_request_type, string v_request_id, DateTime v_examine_time, string v_examine_people, string v_equip_code, string v_equip_value, DateTime v_value_time, int v_examine_result, string v_examine_remark)
        {
            if (v_request_type == 0)
            {
                SqlParameter[] parameters = new SqlParameter[]{
                    new SqlParameter("@poweroff_id",SqlDbType.VarChar,30){Value=v_request_id},
                    new SqlParameter("@examine_time",SqlDbType.DateTime){Value=v_examine_time},
                    new SqlParameter("@examine_people",SqlDbType.VarChar,30){Value=v_examine_people},
                    new SqlParameter("@equip_code",SqlDbType.VarChar,30){Value=v_equip_code},
                    new SqlParameter("@equip_value",SqlDbType.VarChar,100){Value=v_equip_value},
                    new SqlParameter("@value_time",SqlDbType.DateTime){Value=v_value_time},
                    new SqlParameter("@examine_result",SqlDbType.Int){Value=v_examine_result},
                    new SqlParameter("@examine_remark",SqlDbType.VarChar,200){Value=v_examine_remark},
                    new SqlParameter("@voIntReturn",SqlDbType.Int){Direction=ParameterDirection.Output},
                };
                return claSqlConnDB.ExecuteNonQuery(claSqlConnDB.gStrConnDefault, CommandType.StoredProcedure, "p_tsd_examine_power_off_request", parameters);
            }
            if(v_request_type==1)
            {
                SqlParameter[] parameters = new SqlParameter[]{
                    new SqlParameter("@poweron_id",SqlDbType.VarChar,30){Value=v_request_id},
                    new SqlParameter("@examine_time",SqlDbType.DateTime){Value=v_examine_time},
                    new SqlParameter("@examine_people",SqlDbType.VarChar,30){Value=v_examine_people},
                    new SqlParameter("@equip_code",SqlDbType.VarChar,30){Value=v_equip_code},
                    new SqlParameter("@equip_value",SqlDbType.VarChar,100){Value=v_equip_value},
                    new SqlParameter("@value_time",SqlDbType.DateTime){Value=v_value_time},
                    new SqlParameter("@examine_result",SqlDbType.Int){Value=v_examine_result},
                    new SqlParameter("@examine_remark",SqlDbType.VarChar,200){Value=v_examine_remark},
                    new SqlParameter("@voIntReturn",SqlDbType.Int){Direction=ParameterDirection.Output},
                };
                return claSqlConnDB.ExecuteNonQuery(claSqlConnDB.gStrConnDefault, CommandType.StoredProcedure, "p_tsd_examine_power_on_request", parameters);
            }
            return -1;
        }

        public int GetExamineCount(int v_request_type, DateTime v_examine_start, DateTime v_examine_end, string v_examine_people, string v_equip_code, int v_examine_result, string v_examine_remark)
        {
            int mIntExamineCount = 0;
            string mStrSQL = @"SELECT COUNT(0) FROM t_TSDExamine LEFT OUTER JOIN t_TSDProof ON t_TSDProof.proof_id=t_TSDExamine.examine_proof " + GetWhere(v_request_type, v_examine_start, v_examine_end, v_examine_people, v_equip_code, v_examine_result, v_examine_remark);
            mIntExamineCount = claSqlConnDB.GetRecordCount(claSqlConnDB.gStrConnDefault, mStrSQL);
            return mIntExamineCount;
        }

        public DataTable GetExamineData(int v_page, int v_rows, int v_request_type, DateTime v_examine_start, DateTime v_examine_end, string v_examine_people, string v_equip_code, int v_examine_result, string v_examine_remark, string v_sort, string v_order)
        {
            string mStrSQL = @"SELECT     t_TSDExamine.examine_id, t_TSDExamine.examine_status, t_TSDExamine.examine_time, t_TSDExamine.examine_people, t_TSDExamine.examine_result, t_TSDExamine.examine_remark, 
                      t_TSDProof.equip_code, t_TSDProof.equip_value, t_TSDProof.value_time, t_Equips.equip_name, t_Employee.employee_name
FROM         t_Employee RIGHT OUTER JOIN
                      t_TSDExamine ON t_Employee.employee_code = t_TSDExamine.examine_people LEFT OUTER JOIN
                      t_Equips INNER JOIN
                      t_TSDProof ON t_Equips.equip_code = t_TSDProof.equip_code ON t_TSDExamine.examine_proof = t_TSDProof.proof_id "
                            + GetWhere(v_request_type, v_examine_start, v_examine_end, v_examine_people, v_equip_code, v_examine_result, v_examine_remark)
                            + GetOrder(v_sort, v_order);
            return claSqlConnDB.ExecuteDataset(v_rows, v_page, claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL).Tables[0];
        }

        public DataTable GetExamineData(int v_page, int v_rows, int v_request_type, DateTime v_examine_start, DateTime v_examine_end, string v_examine_people, string v_equip_code, int v_examine_result, string v_examine_remark)
        {
            string mStrSQL = @"SELECT     t_TSDExamine.examine_id, t_TSDExamine.examine_status, t_TSDExamine.examine_time, t_TSDExamine.examine_people, t_TSDExamine.examine_result, t_TSDExamine.examine_remark, 
                      t_TSDProof.equip_code, t_TSDProof.equip_value, t_TSDProof.value_time, t_Equips.equip_name, t_Employee.employee_name
FROM         t_Employee RIGHT OUTER JOIN
                      t_TSDExamine ON t_Employee.employee_code = t_TSDExamine.examine_people LEFT OUTER JOIN
                      t_Equips INNER JOIN
                      t_TSDProof ON t_Equips.equip_code = t_TSDProof.equip_code ON t_TSDExamine.examine_proof = t_TSDProof.proof_id "
                            + GetWhere(v_request_type, v_examine_start, v_examine_end, v_examine_people, v_equip_code, v_examine_result, v_examine_remark);
            return claSqlConnDB.ExecuteDataset(v_rows, v_page, claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL).Tables[0];
        }

        public DataTable GetExamineData(int v_request_type, DateTime v_examine_start, DateTime v_examine_end, string v_examine_people, string v_equip_code, int v_examine_result, string v_examine_remark)
        {
            string mStrSQL = @"SELECT     t_TSDExamine.examine_id, t_TSDExamine.examine_status, t_TSDExamine.examine_time, t_TSDExamine.examine_people, t_TSDExamine.examine_result, t_TSDExamine.examine_remark, 
                      t_TSDProof.equip_code, t_TSDProof.equip_value, t_TSDProof.value_time, t_Equips.equip_name, t_Employee.employee_name
FROM         t_Employee RIGHT OUTER JOIN
                      t_TSDExamine ON t_Employee.employee_code = t_TSDExamine.examine_people LEFT OUTER JOIN
                      t_Equips INNER JOIN
                      t_TSDProof ON t_Equips.equip_code = t_TSDProof.equip_code ON t_TSDExamine.examine_proof = t_TSDProof.proof_id "
                             + GetWhere(v_request_type, v_examine_start, v_examine_end, v_examine_people, v_equip_code, v_examine_result, v_examine_remark);
            return claSqlConnDB.ExecuteDataset(claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL).Tables[0];
        }

        #endregion

        private string GetWhere(int v_request_type, DateTime v_examine_start, DateTime v_examine_end, string v_examine_people, string v_equip_code, int v_examine_result, string v_examine_remark)
        {
            string mStrWhere = " WHERE 1=1 ";
            if (v_request_type == 0)
            {
                mStrWhere = " RIGHT OUTER JOIN t_examine_poweroff on t_examine_poweroff.examine_id = t_TSDExamine.examine_id " + mStrWhere;
            }
            if (v_request_type == 1)
            {
                mStrWhere = " RIGHT OUTER JOIN t_examine_poweron on t_examine_poweron.examine_id=t_TSDExamine.examine_id" + mStrWhere;
            }
            if (v_examine_start != DateTime.Parse("1900-01-01 00:00"))
            {
                mStrWhere = mStrWhere +" AND t_TSDExamine.examine_time>CONVERT(DATETIME, '" + v_examine_start .ToString()+ "', 102) ";
            }
            if (v_examine_end != DateTime.Parse("1900-01-01 00:00"))
            {
                mStrWhere = mStrWhere + " AND t_TSDExamine.examine_time<CONVERT(DATETIME, '" + v_examine_end.ToString() + "', 102) ";
            }
            if (v_examine_people != "")
            {
                mStrWhere = mStrWhere + " AND t_TSDExamine.examine_people='" + v_examine_people.ToString() + "' ";
            }
            if (v_equip_code != "")
            {
                mStrWhere = mStrWhere + " AND t_TSDProof.equip_code='" + v_equip_code.ToString() + "' ";
            }
            if (v_examine_result != -1)
            {
                mStrWhere = mStrWhere + " AND t_TSDExamine.examine_result=" + v_examine_result.ToString() + " ";
            }
            if (v_examine_remark != "")
            {
                mStrWhere = mStrWhere + " AND t_TSDExamine.examine_remark like '%" + v_examine_remark.ToString() + "%' ";
            }
            return mStrWhere;
        }

        private string GetOrder(string v_sort, string v_order)
        {
            string mStrOrder = "";
            if (v_sort != "")
            {
                mStrOrder = " ORDER BY t_TSDExamine." + v_sort;
                if (v_order != "")
                {
                    mStrOrder = mStrOrder + " " + v_order;
                }
            }
            return mStrOrder;
        }
    }
}
