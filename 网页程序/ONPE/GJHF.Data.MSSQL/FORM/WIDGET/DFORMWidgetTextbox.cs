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
    public class DFORMWidgetTextbox:IFORMWidgetTextbox
    {
        #region IFORMWidgetTextbox 成员

        public int AddWidgetTextboxData( string v_id, string v_name, int v_hide, float v_width, float v_height, float v_fontsize, int v_align, int v_input_type, string v_dataform, string v_dataview, string v_datafiled, string v_defaultvalue, int v_editable, int v_required, string v_placehold)
        {
            string mStrSQL = @"INSERT INTO t_FormTextbox(No,id,name,hide,width,height,fontsize,align,input_type,dataform,dataview,
                                                             datafiled,defaultvalue,editable,required,placehold)
                                                 VALUES(@No,@id,@name,@hide,@width,@height,@fontsize,@align,@input_type,@dataform,@dataview,
                                                             @datafiled,@defaultvalue,@editable,@required,@placehold)";
            SqlParameter[] parameters = new SqlParameter[]{
                new SqlParameter("@No",SqlDbType.VarChar,30){Value=COMMON.DGlobal.GetIdentityFormControlTextBoxID()},
                new SqlParameter("@id",SqlDbType.VarChar,50){Value=v_id},
                new SqlParameter("@name",SqlDbType.VarChar,50){Value=v_name},
                new SqlParameter("@hide",SqlDbType.Int,4){Value=v_hide},
                new SqlParameter("@width",SqlDbType.Float,20){Value=v_width},
                new SqlParameter("@height",SqlDbType.Float,20){Value=v_height},
                new SqlParameter("@fontsize",SqlDbType.Float,20){Value=v_fontsize},
                new SqlParameter("@align",SqlDbType.Int,4){Value=v_align},
                new SqlParameter("@input_type",SqlDbType.Int,4){Value=v_input_type},
                new SqlParameter("@dataform",SqlDbType.VarChar,500){Value=v_dataform},
                new SqlParameter("@dataview",SqlDbType.VarChar,200){Value=v_dataview},
                new SqlParameter("@datafiled",SqlDbType.VarChar,200){Value=v_datafiled},
                new SqlParameter("@defaultvalue",SqlDbType.VarChar,200){Value=v_defaultvalue},
                new SqlParameter("@editable",SqlDbType.Int,4){Value=v_editable},
                new SqlParameter("@required",SqlDbType.Int,4){Value=v_required},
                new SqlParameter("@placehold",SqlDbType.VarChar,200){Value=v_placehold},

            };
            return claSqlConnDB.ExecuteNonQuery(claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL, parameters);
        }

        public int EditWidgetTextboxData(string v_No, string v_id, string v_name, int v_hide, float v_width, float v_height, float v_fontsize, int v_align, int v_input_type, string v_dataform, string v_dataview, string v_datafiled, string v_defaultvalue, int v_editable, int v_required, string v_placehold)
        {
            string mStrSQL = @"UPDATE  t_FormTextbox SET 
                                    id=@id,
                                    name=@name,
                                    hide=@hide,
                                    width=@width,
                                    height=@height,
                                    fontsize=@fontsize,
                                    align=@align,
                                    input_type=@input_type,
                                    dataform=@dataform,
                                    dataview=@dataview,
                                    datafiled=@datafiled,
                                    defaultvalue=@defaultvalue,
                                    editable=@editable,
                                    required=@required,
                                    placehold=@placehold
                               WHERE No=@No";
            SqlParameter[] parameters = new SqlParameter[]{
                new SqlParameter("@No",SqlDbType.VarChar,30){Value=v_No},
                new SqlParameter("@id",SqlDbType.VarChar,50){Value=v_id},
                new SqlParameter("@name",SqlDbType.VarChar,50){Value=v_name},
                new SqlParameter("@hide",SqlDbType.Int,4){Value=v_hide},
                new SqlParameter("@width",SqlDbType.Float,20){Value=v_width},
                new SqlParameter("@height",SqlDbType.Float,20){Value=v_height},
                new SqlParameter("@fontsize",SqlDbType.Float,20){Value=v_fontsize},
                new SqlParameter("@align",SqlDbType.Int,4){Value=v_align},
                new SqlParameter("@input_type",SqlDbType.Int,4){Value=v_input_type},
                new SqlParameter("@dataform",SqlDbType.VarChar,500){Value=v_dataform},
                new SqlParameter("@dataview",SqlDbType.VarChar,200){Value=v_dataview},
                new SqlParameter("@datafiled",SqlDbType.VarChar,200){Value=v_datafiled},
                new SqlParameter("@defaultvalue",SqlDbType.VarChar,200){Value=v_defaultvalue},
                new SqlParameter("@editable",SqlDbType.Int,4){Value=v_editable},
                new SqlParameter("@required",SqlDbType.Int,4){Value=v_required},
                new SqlParameter("@placehold",SqlDbType.VarChar,200){Value=v_placehold},

            };
            return claSqlConnDB.ExecuteNonQuery(claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL, parameters);
        }

        public int DelWidgetTextboxData(string v_No)
        {
            string mStrSQL = @"DELETE FROM  t_FormTextbox 
                               WHERE No=@No";
            SqlParameter[] parameters = new SqlParameter[]{
                new SqlParameter("@No",SqlDbType.VarChar,30){Value=v_No},
            };
            return claSqlConnDB.ExecuteNonQuery(claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL, parameters);
        }

        public int GetWidgetTextboxCount(string v_id, string v_name)
        {
            string mStrSQL = @"SELECT COUNT(0) FROM t_FormTextbox" + GetWhere(v_id, v_name);
            return claSqlConnDB.GetRecordCount(claSqlConnDB.gStrConnDefault, mStrSQL);
        }

        public DataTable GetWidgetTextboxData(string v_id, string v_name)
        {
            string mStrSQL = @"SELECT No,id,name,hide,width,height,fontsize,align,input_type,dataform,dataview,
                                                             datafiled,defaultvalue,editable,required,placehold FROM t_FormTextbox " + GetWhere(v_id, v_name);
            return claSqlConnDB.ExecuteDataset(claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL).Tables[0];
        }

        public DataTable GetWidgetTextboxData(string v_id, string v_name, string v_sort, string v_order)
        {
            string mStrSQL = @"SELECT No,id,name,hide,width,height,fontsize,align,input_type,dataform,dataview,
                                                             datafiled,defaultvalue,editable,required,placehold FROM t_FormTextbox " + GetWhere(v_id, v_name) + GetOrder(v_sort, v_order);
            return claSqlConnDB.ExecuteDataset(claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL).Tables[0];
        }

        public DataTable GetWidgetTextboxData(int v_page, int v_rows, string v_id, string v_name, string v_sort, string v_order)
        {
            string mStrSQL = @"SELECT No,id,name,hide,width,height,fontsize,align,input_type,dataform,dataview,
                                                             datafiled,defaultvalue,editable,required,placehold FROM t_FormTextbox " + GetWhere(v_id, v_name) + GetOrder(v_sort, v_order);
            return claSqlConnDB.ExecuteDataset(v_rows,v_page,claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL).Tables[0];
        }

        public Dictionary<string, object> GetWidgetTextboxDetail(string v_No)
        {
            string mStrSQL = @"SELECT No,id,name,hide,width,height,fontsize,align,input_type,dataform,dataview,
                                                             datafiled,defaultvalue,editable,required,placehold FROM t_FormTextbox 
                                WHERE No=@No";
            SqlParameter[] parameters = new SqlParameter[]{
                new SqlParameter("@No",SqlDbType.VarChar,30){Value=v_No},
            };
            return GJHF.Utility.Convert.ConvertModelToDictionary(claSqlConnDB.GetDetail(claSqlConnDB.gStrConnDefault, mStrSQL, "GJHF.Data.Model.FORM.WIDGET.MFORMWidgetTextbox", "GJHF.Data.Model", parameters));
        }

        #endregion

        private string GetWhere(string v_id, string v_name)
        {
            string mStrWhere = " WHERE 1=1 ";
            if (v_id != "")
            {
                mStrWhere += " AND t_FormTextbox.id LIKE '%" + v_id + "%'";
            }
            if (v_name != "")
            {
                mStrWhere += " AND t_FormTextbox.name LIKE '%" + v_name + "%'";
            }
            return mStrWhere;
        }

        private string GetOrder(string v_sort, string v_order)
        {
            string mStrOrder = "";
            if (v_sort != "")
            {
                mStrOrder += " ORDER BY t_FormTextbox." + v_sort;
                if (v_order != "")
                {
                    mStrOrder += " " + v_order;
                }
            }
            return mStrOrder;
        }
    }
}
