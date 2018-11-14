using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using System.Data.SqlClient;

namespace GJHF.Data.MSSQL.SYS
{
    public class DSysCarousel:Interface.SYS.ISysCarousel
    {
        #region ISysCarousel 成员

        public int AddSysCarousel(string v_image_name, string v_image_address, int v_image_state)
        {
            string mStrSQL = @"INSERT INTO t_sys_carousel(image_name,image_address,image_state)VALUES(@image_name,@image_address,@image_state)";
            SqlParameter[] parameters = new SqlParameter[]{
                new SqlParameter("@image_name",SqlDbType.VarChar,100){Value=v_image_name},
                new SqlParameter("@image_address",SqlDbType.VarChar,200){Value=v_image_address},
                new SqlParameter("@image_state",SqlDbType.Int){Value=v_image_state}
            };
            return claSqlConnDB.ExecuteNonQuery(claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL, parameters);
        }

        public int EditSysCarousel(int v_data_id, string v_image_name, string v_image_address, int v_image_state)
        {
            string mStrSQL = @"UPDATE  t_sys_carousel SET
                                image_name=@image_name,
                                image_address=@image_address,
                                image_state=@image_state
                                WHERE data_id=@data_id";
            SqlParameter[] parameters = new SqlParameter[]{
                new SqlParameter("@data_id",SqlDbType.Int){Value=v_data_id},
                new SqlParameter("@image_name",SqlDbType.VarChar,100){Value=v_image_name},
                new SqlParameter("@image_address",SqlDbType.VarChar,200){Value=v_image_address},
                new SqlParameter("@image_state",SqlDbType.Int){Value=v_image_state}
            };
            return claSqlConnDB.ExecuteNonQuery(claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL, parameters);
        }

        public int DelSysCarousel(int v_data_id)
        {
            string mStrSQL = @"DELETE FROM   t_sys_carousel 
                                WHERE data_id=@data_id";
            SqlParameter[] parameters = new SqlParameter[]{
                new SqlParameter("@data_id",SqlDbType.Int){Value=v_data_id},
            };
            return claSqlConnDB.ExecuteNonQuery(claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL, parameters);
        }
        public int UpdateSysCarouselState(int v_data_id, int v_image_state)
        {
            string mStrSQL = @"UPDATE  t_sys_carousel SET
                                image_state=@image_state
                                WHERE data_id=@data_id";
            SqlParameter[] parameters = new SqlParameter[]{
                new SqlParameter("@data_id",SqlDbType.Int){Value=v_data_id},
                new SqlParameter("@image_state",SqlDbType.Int){Value=v_image_state}
            };
            return claSqlConnDB.ExecuteNonQuery(claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL, parameters);
        }
        public int GetSysCarouselCount(int v_image_state)
        {
            string mStrSQL = @"SELECT COUNT(0) FROM t_sys_carousel" + GetWhere(v_image_state);
            return claSqlConnDB.GetRecordCount(claSqlConnDB.gStrConnDefault, mStrSQL);
        }

        public DataTable GetSysCarousel(int v_image_state)
        {
            string mStrSQL = @"SELECT data_id,image_name,image_address,image_state FROM t_sys_carousel" + GetWhere(v_image_state);
            return claSqlConnDB.ExecuteDataset(claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL).Tables[0];
        }

        #endregion

        private string GetWhere(int v_image_state)
        {
            string mStrWhere = " WHERE 1 = 1 ";
            if (v_image_state != -100)
            {
                mStrWhere = mStrWhere + " AND t_sys_carousel.image_state=" + v_image_state;
            }
            return mStrWhere;
        }
    }
}
