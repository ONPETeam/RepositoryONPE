using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using System.Data.SqlClient;

namespace GJHF.Data.MSSQL.PLC
{
    public class DPLCPointPhoneType:GJHF.Data.Interface.PLC.IPLCPointPhoneType
    {

        #region IPLCPointPhoneType 成员

        public int AddPLCPointPhoneType(int plc_point_address_id, int phone_type_id)
        {
            string mStrSQL = @"INSERT INTO tZPlcPointType(dIntNoteID,dIntDataID)VALUES(@phone_type_id,@plc_point_address_id)";
            SqlParameter[] parameters = new SqlParameter[]{
                new SqlParameter("@plc_point_address_id",SqlDbType.Int){Value=plc_point_address_id},
                new SqlParameter("@phone_type_id",SqlDbType.Int){Value=phone_type_id}
            };
            return claSqlConnDB.ExecuteNonQuery(claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL, parameters);
        }

        public int DelPLCPointPhoneType(int plc_point_address_id)
        {
            string mStrSQL = @"DELETE FROM tZPlcPointType WHERE dIntDataID=@plc_point_address_id";
            SqlParameter[] parameters = new SqlParameter[]{
                new SqlParameter("@plc_point_address_id",SqlDbType.Int){Value=plc_point_address_id}
            };
            return claSqlConnDB.ExecuteNonQuery(claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL, parameters);
        }


        public int AddPLCPointPJ(int plc_point_address_id, string plc_point_pj)
        {
            string mStrSQL = @"INSERT INTO tZPlcPointTypeOne(dIntDataID,dVchPointTypePj)VALUES(@plc_point_address_id,@plc_point_pj)";
            SqlParameter[] parameters = new SqlParameter[]{
                new SqlParameter("@plc_point_address_id",SqlDbType.Int){Value=plc_point_address_id},
                new SqlParameter("@plc_point_pj",SqlDbType.VarChar){Value=plc_point_pj}
            };
            return claSqlConnDB.ExecuteNonQuery(claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL, parameters);

        }

        public int DelPLCPointPJ(int plc_point_address_id)
        {
            string mStrSQL = @"DELETE FROM tZPlcPointTypeOne WHERE dIntDataID=@plc_point_address_id";
            SqlParameter[] parameters = new SqlParameter[]{
                new SqlParameter("@plc_point_address_id",SqlDbType.Int){Value=plc_point_address_id}
            };
            return claSqlConnDB.ExecuteNonQuery(claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL, parameters);

        }
        //根据点地址id搜素相关的系统
        public DataTable GetDataByid(int vIntDataID)
        {
            string mStrSQL = "select * from tZPlcPointType left outer join t_XJPointType on tZPlcPointType.dIntNoteID = t_XJPointType.dIntNoteID where dIntDataID = " + vIntDataID;
            return claSqlConnDB.ExecuteDataset(claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL).Tables[0];
        }
        #endregion
    }
}
