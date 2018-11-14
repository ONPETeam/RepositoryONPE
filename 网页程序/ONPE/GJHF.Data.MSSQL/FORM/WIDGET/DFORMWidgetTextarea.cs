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
    public class DFORMWidgetTextarea:IFORMWidgetTextarea
    {
        #region IFORMWidgetTextarea 成员

        public int AddWidgetTextareaData(string v_id, string v_name, float v_width, float v_height, int v_rows, float v_fontsize, int v_align, string v_datafrom, string v_dataview, 
            string v_datafiled, string v_defaultvalue, int v_editable, int v_required, string v_placehold)
        {
            string mStrSQL = @"INSERT INTO t_FormTextarea(No,id,name,width,height,rows,fontsize,align ,datafrom,dataview,
                                                        datafiled,defaultvalue,editable,required,placehold)VALUES(
                                                        @No,@id,@name,@width,@height,@rows,@fontsize,@align ,@datafrom,@dataview,
                                                        @datafiled,@defaultvalue,@editable,@required,@placehold)";
            SqlParameter[] parameters = new SqlParameter[]{
                new SqlParameter("@No",SqlDbType.VarChar,30){Value=COMMON.DGlobal.GetIdentityFormControlTextAreaID()},
                new SqlParameter("@id",SqlDbType.VarChar,50){Value=v_id},
                new SqlParameter("@name",SqlDbType.VarChar,50){Value=v_name},
                new SqlParameter("@width",SqlDbType.Float,20){Value=v_width},
                new SqlParameter("@height",SqlDbType.Float,20){Value=v_height},
                new SqlParameter("@rows",SqlDbType.Int,4){Value=v_rows},
                new SqlParameter("@fontsize",SqlDbType.Float,20){Value=v_fontsize},
                new SqlParameter("@align",SqlDbType.Int,4){Value=v_align},
                new SqlParameter("@datafrom",SqlDbType.VarChar,200){Value=v_datafrom},
                new SqlParameter("@dataview",SqlDbType.VarChar,200){Value=v_dataview},
                new SqlParameter("@datafiled",SqlDbType.VarChar,200){Value=v_datafiled},
                new SqlParameter("@defaultvalue",SqlDbType.VarChar,200){Value=v_defaultvalue},
                new SqlParameter("@editable",SqlDbType.Int,4){Value=v_editable},
                new SqlParameter("@required",SqlDbType.Int,4){Value=v_required},
                new SqlParameter("@placehold",SqlDbType.VarChar,200){Value=v_placehold},
            };
            return claSqlConnDB.ExecuteNonQuery(claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL, parameters);
        }

        public int EditWidgetTextareaData(string v_No, string v_id, string v_name, float v_width, float v_height, int v_rows, float v_fontsize, int v_align, string v_datafrom, string v_dataview, string v_datafiled, string v_defaultvalue, int v_editable, int v_required, string v_placehold)
        {
            string mStrSQL = @"UPDATE t_FormTextarea SET
                                        id=@id,
                                        name=@name,
                                        width=@width,
                                        height=@height,
                                        rows=@rows,
                                        fontsize=@fontsize,
                                        align =@align,
                                        datafrom=@datafrom,
                                        dataview=@dataview,
                                        datafiled=@datafiled,
                                        defaultvalue=@defaultvalue,
                                        editable=@editable,
                                        required=@required,
                                        placehold=@placehold
                                        WHERE No= @No";
            SqlParameter[] parameters = new SqlParameter[]{
                new SqlParameter("@No",SqlDbType.VarChar,30){Value=v_No},
                new SqlParameter("@id",SqlDbType.VarChar,50){Value=v_id},
                new SqlParameter("@name",SqlDbType.VarChar,50){Value=v_name},
                new SqlParameter("@width",SqlDbType.Float,20){Value=v_width},
                new SqlParameter("@height",SqlDbType.Float,20){Value=v_height},
                new SqlParameter("@rows",SqlDbType.Int,4){Value=v_rows},
                new SqlParameter("@fontsize",SqlDbType.Float,20){Value=v_fontsize},
                new SqlParameter("@align",SqlDbType.Int,4){Value=v_align},
                new SqlParameter("@datafrom",SqlDbType.VarChar,200){Value=v_datafrom},
                new SqlParameter("@dataview",SqlDbType.VarChar,200){Value=v_dataview},
                new SqlParameter("@datafiled",SqlDbType.VarChar,200){Value=v_datafiled},
                new SqlParameter("@defaultvalue",SqlDbType.VarChar,200){Value=v_defaultvalue},
                new SqlParameter("@editable",SqlDbType.Int,4){Value=v_editable},
                new SqlParameter("@required",SqlDbType.Int,4){Value=v_required},
                new SqlParameter("@placehold",SqlDbType.VarChar,200){Value=v_placehold},
            };
            return claSqlConnDB.ExecuteNonQuery(claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL, parameters);
        }

        public int DelWidgetTextareaData(string v_No)
        {
            string mStrSQL = @"DELETE FROM  t_FormTextarea 
                                        WHERE No= @No";
            SqlParameter[] parameters = new SqlParameter[]{
                new SqlParameter("@No",SqlDbType.VarChar,30){Value=v_No},
            };
            return claSqlConnDB.ExecuteNonQuery(claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL, parameters);
        }

        public int GetWidgetTextareaCount(string v_id, string v_name)
        {
            string mStrSQL = "SELECT COUNT(0) FROM t_FormTextarea" + GetWhere(v_id, v_name);
            return claSqlConnDB.GetRecordCount(claSqlConnDB.gStrConnDefault, mStrSQL);
        }

        public DataTable GetWidgetTextareaData(string v_id, string v_name)
        {
            string mStrSQL = @"SELECT No,id,name,width,height,rows,fontsize,align ,datafrom,dataview,
                                                        datafiled,defaultvalue,editable,required,placehold FROM t_FormTextarea" + GetWhere(v_id, v_name);
            return claSqlConnDB.ExecuteDataset(claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL).Tables[0];
        }

        public DataTable GetWidgetTextareaData(string v_id, string v_name, string v_sort, string v_order)
        {
            string mStrSQL = @"SELECT No,id,name,width,height,rows,fontsize,align ,datafrom,dataview,
                                                        datafiled,defaultvalue,editable,required,placehold FROM t_FormTextarea" + GetWhere(v_id, v_name)+GetOrder(v_sort,v_order);
            return claSqlConnDB.ExecuteDataset(claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL).Tables[0];
        }

        public DataTable GetWidgetTextareaData(int v_page, int v_rows, string v_id, string v_name, string v_sort, string v_order)
        {
            string mStrSQL = @"SELECT No,id,name,width,height,rows,fontsize,align ,datafrom,dataview,
                                                        datafiled,defaultvalue,editable,required,placehold FROM t_FormTextarea" + GetWhere(v_id, v_name) + GetOrder(v_sort, v_order);
            return claSqlConnDB.ExecuteDataset(v_rows, v_page,claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL).Tables[0];
        }

        public Dictionary<string, object> GetWidgetTextareaDetail(string v_No)
        {
            string mStrSQL = @"SELECT No,id,name,width,height,rows,fontsize,align ,datafrom,dataview,
                                                        datafiled,defaultvalue,editable,required,placehold FROM t_FormTextarea 
                                WHERE No=@No";
            SqlParameter[] parameters = new SqlParameter[]{
                new SqlParameter("@No",SqlDbType.VarChar,30){Value=v_No},
            };
            return GJHF.Utility.Convert.ConvertModelToDictionary(claSqlConnDB.GetDetail(claSqlConnDB.gStrConnDefault, mStrSQL, "GJHF.Data.Model.FORM.WIDGET.MFORMWidgetTextarea", "GJHF.Data.Model", parameters));
        }

        #endregion

        private string GetWhere(string v_id, string v_name)
        {
            string mStrWhere = " WHERE 1=1 ";
            if (v_id != "")
            {
                mStrWhere += " AND t_FormTextarea.id LIKE '%" + v_id + "%'";
            }
            if (v_name != "")
            {
                mStrWhere += " AND t_FormTextarea.name LIKE '%" + v_name + "%'";
            }
            return mStrWhere;
        }

        private string GetOrder(string v_sort, string v_order)
        {
            string mStrOrder = "";
            if (v_sort != "")
            {
                mStrOrder += " ORDER BY t_FormTextarea." + v_sort;
                if (v_order != "")
                {
                    mStrOrder += " " + v_order;
                }
            }
            return mStrOrder;
        }
    }
}
