using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using System.Data.SqlClient;
using GJHF.Data.Model.FORM.WIDGET;
using GJHF.Data.Interface.FORM.WIDGET;

namespace GJHF.Data.MSSQL.FORM.WIDGET
{
    public class DFORMWidgetButton:IFORMWidgetButton
    {
        #region IFORMWidgetButton 成员

        public int AddWidgetButtonData(string v_id, string v_name, int v_style, int v_plain, string v_icon, int v_align, int v_eventtype, string v_eventcontext)
        {
            string mStrSQL = @"INSERT INTO t_FormButton(No,id,name,plain,style,icon,align,eventtype,eventcontext)VALUES(@No,@id,@name,@plain,@style,@icon,@align,@eventtype,@eventcontext)";
            SqlParameter[] parameters = new SqlParameter[]{
                new SqlParameter("@No",SqlDbType.VarChar,30){Value=COMMON.DGlobal.GetIdentityFormControlLinkButtonID()},
                new SqlParameter("@id",SqlDbType.VarChar,50){Value=v_id},
                new SqlParameter("@name",SqlDbType.VarChar,50){Value=v_name},
                new SqlParameter("@plain",SqlDbType.Int,4){Value=v_style},
                new SqlParameter("@style",SqlDbType.Int,4){Value=v_plain},
                new SqlParameter("@icon",SqlDbType.VarChar,50){Value=v_icon},
                new SqlParameter("@align",SqlDbType.Int,4){Value=v_align},
                new SqlParameter("@eventtype",SqlDbType.Int,4){Value=v_eventtype},
                new SqlParameter("@eventcontext",SqlDbType.VarChar,1000){Value=v_eventcontext},
            };
            return claSqlConnDB.ExecuteNonQuery(claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL, parameters);
        }

        public int EditWidgetButtonData(string v_No, string v_id, string v_name, int v_style, int v_plain, string v_icon, int v_align, int v_eventtype, string v_eventcontext)
        {
            string mStrSQL = @"UPDATE  t_FormButton SET 
                                    id=@id,
                                    name=@name,
                                    plain=@plain,
                                    style=@style,
                                    icon=@icon,
                                    align=@align,
                                    eventtype=@eventtype,
                                    eventcontext=@eventvontext
                                    WHERE No=@No";
            SqlParameter[] parameters = new SqlParameter[]{
                new SqlParameter("@No",SqlDbType.VarChar,30){Value=v_No},
                new SqlParameter("@id",SqlDbType.VarChar,50){Value=v_id},
                new SqlParameter("@name",SqlDbType.VarChar,50){Value=v_name},
                new SqlParameter("@plain",SqlDbType.Int,4){Value=v_style},
                new SqlParameter("@style",SqlDbType.Int,4){Value=v_plain},
                new SqlParameter("@icon",SqlDbType.VarChar,50){Value=v_icon},
                new SqlParameter("@align",SqlDbType.Int,4){Value=v_align},
                new SqlParameter("@eventtype",SqlDbType.Int,4){Value=v_eventtype},
                new SqlParameter("@eventcontext",SqlDbType.VarChar,1000){Value=v_eventcontext},
            };
            return claSqlConnDB.ExecuteNonQuery(claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL, parameters);
        }

        public int DelWidgetButtonData(string v_No)
        {
            string mStrSQL = @"DELETE FROM  t_FormButton 
                                    WHERE No=@No";
            SqlParameter[] parameters = new SqlParameter[]{
                new SqlParameter("@No",SqlDbType.VarChar,30){Value=v_No},
            };
            return claSqlConnDB.ExecuteNonQuery(claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL, parameters);
        }

        public int GetWidgetButtonCount(string v_id, string v_name)
        {
            string mStrSQL = @"SELECT COUNT(*) FROM t_FormButton" + GetWhere(v_id, v_name);
            return claSqlConnDB.GetRecordCount(claSqlConnDB.gStrConnDefault, mStrSQL);
        }

        public DataTable GetWidgetButtonData(string v_id, string v_name)
        {
            string mStrSQL = @"SELECT No,id,name,plain,style,icon,align,eventtype,eventcontext FROM t_FormButton " + GetWhere(v_id, v_name);
            return claSqlConnDB.ExecuteDataset(claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL).Tables[0];
        }

        public DataTable GetWidgetButtonData(string v_id, string v_name, string v_sort, string v_order)
        {
            string mStrSQL = @"SELECT No,id,name,plain,style,icon,align,eventtype,eventcontext FROM t_FormButton " + GetWhere(v_id, v_name) + GetOrder(v_sort, v_order);
            return claSqlConnDB.ExecuteDataset(claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL).Tables[0];
        }

        public DataTable GetWidgetButtonData(int v_page, int v_rows, string v_id, string v_name, string v_sort, string v_order)
        {
            string mStrSQL = @"SELECT No,id,name,plain,style,icon,align,eventtype,eventcontext FROM t_FormButton " + GetWhere(v_id, v_name) + GetOrder(v_sort, v_order);
            return claSqlConnDB.ExecuteDataset(v_rows, v_page,claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL).Tables[0];
        }

        public Dictionary<string, object> GetWidgetButtonDetail(string v_No)
        {
            string mStrSQL = @"SELECT No,id,name,plain,style,icon,align,eventtype,eventcontext FROM t_FormButton WHERE No=@No";
            SqlParameter[] parameters = new SqlParameter[]{
                new SqlParameter("@No",SqlDbType.VarChar,30){Value=v_No},
            };
            return GJHF.Utility.Convert.ConvertModelToDictionary(claSqlConnDB.GetDetail(claSqlConnDB.gStrConnDefault, mStrSQL, "GJHF.Data.Model.FORM.WIDGET.MFORMWidgetButton", "GJHF.Data.Model", parameters));
        }

        #endregion

        private string GetWhere(string v_id, string v_name)
        {
            string mStrWhere = " WHERE 1=1 ";
            if (v_id != "")
            {
                mStrWhere += " AND t_FormButton.id LIKE '%" + v_id + "%'";
            }
            if (v_name != "")
            {
                mStrWhere += " AND t_FormButton.name LIKE '%" + v_name + "%'";
            }
            return mStrWhere;
        }

        private string GetOrder(string v_sort, string v_order)
        {
            string mStrOrder = "";
            if (v_sort != "")
            {
                mStrOrder += " ORDER BY t_FormButton." + v_sort;
                if (v_order != "")
                {
                    mStrOrder += " " + v_order;
                }
            }
            return mStrOrder;
        }
    }
}
