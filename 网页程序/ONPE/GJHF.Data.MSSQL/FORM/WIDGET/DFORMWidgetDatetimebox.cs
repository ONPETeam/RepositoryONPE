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
    public class DFORMWidgetDatetimebox:IFORMWidgetDatetimebox
    {
        #region IFORMWidgetDatetimebox 成员

        public int AddWidgetDatetimeboxData(string v_id, string v_name, float v_width, float v_height, float v_fontsize, int v_align, int v_datetype, int v_secondshow, string v_timeseparator, string v_format, string v_datafrom, string v_dataview, string v_datafiled, string v_defaultvalue, int v_editable, int v_required, string v_placehold)
        {
            string mStrSQL = @"INSERT INTO t_FormDatetimebox(  No,id,name,width,height,fontsize,align ,datetype,secondshow,timeseparator,format,
                                                          dataform,dataview,datafiled,defaultvalue,editable,required,placehold)
                                                    VALUES(
                                                        @No,@id,@name,@width,@height,@fontsize,@align ,@datetype,@secondshow ,@timeseparator,@format,
                                                        @dataform,@dataview,@datafiled,@defaultvalue,@editable,@required,@placehold)";
            SqlParameter[] parameters = new SqlParameter[]{
                new SqlParameter("@No",SqlDbType.VarChar,30){Value=COMMON.DGlobal.GetIdentityFormControlDatetimeBoxID()},
                new SqlParameter("@id",SqlDbType.VarChar,50){Value=v_id},
                new SqlParameter("@name",SqlDbType.VarChar,50){Value=v_name},
                new SqlParameter("@width",SqlDbType.Float,20){Value=v_width},
                new SqlParameter("@height",SqlDbType.Float,20){Value=v_height},
                new SqlParameter("@fontsize",SqlDbType.Float,20){Value=v_fontsize},
                new SqlParameter("@align",SqlDbType.Int,4){Value=v_align},
                new SqlParameter("@datetype",SqlDbType.Int,4){Value=v_datetype},
                new SqlParameter("@secondshow",SqlDbType.Int,4){Value=v_secondshow},
                new SqlParameter("@timeseparator",SqlDbType.VarChar,20){Value=v_timeseparator},
                new SqlParameter("@format",SqlDbType.Float,20){Value=v_format},
                new SqlParameter("@dataform",SqlDbType.VarChar,200){Value=v_datafrom},
                new SqlParameter("@dataview",SqlDbType.VarChar,200){Value=v_dataview},
                new SqlParameter("@datafiled",SqlDbType.VarChar,200){Value=v_datafiled},
                new SqlParameter("@defaultvalue",SqlDbType.VarChar,200){Value=v_defaultvalue},
                new SqlParameter("@editable",SqlDbType.Int,4){Value=v_editable},
                new SqlParameter("@required",SqlDbType.Int,4){Value=v_required},
                new SqlParameter("@placehold",SqlDbType.VarChar,200){Value=v_placehold},
            };
            return claSqlConnDB.ExecuteNonQuery(claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL, parameters);
        }

        public int EditWidgetDatetimeboxData(string v_No, string v_id, string v_name, float v_width, float v_height, float v_fontsize, int v_align, int v_datetype, int v_secondshow, string v_timeseparator, string v_format, string v_datafrom, string v_dataview, string v_datafiled, string v_defaultvalue, int v_editable, int v_required, string v_placehold)
        {
            string mStrSQL = @"UPDATE t_FormDatetimebox SET
                                        id=@id,
                                        name=@name,
                                        width=@width,
                                        height=@height,
                                        fontsize=@fontsize,
                                        align =@align,
                                        datetype=@datetype,
                                        secondshow=@secondshow,
                                        timeseparator=@timeseparator,
                                        format=@format,
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
                new SqlParameter("@width",SqlDbType.Float,20){Value=v_width},
                new SqlParameter("@height",SqlDbType.Float,20){Value=v_height},
                new SqlParameter("@fontsize",SqlDbType.Float,20){Value=v_fontsize},
                new SqlParameter("@align",SqlDbType.Int,4){Value=v_align},
                new SqlParameter("@datetype",SqlDbType.Int,4){Value=v_datetype},
                new SqlParameter("@secondshow",SqlDbType.Int,4){Value=v_secondshow},
                new SqlParameter("@timeseparator",SqlDbType.VarChar,20){Value=v_timeseparator},
                new SqlParameter("@format",SqlDbType.Float,20){Value=v_format},
                new SqlParameter("@dataform",SqlDbType.VarChar,200){Value=v_datafrom},
                new SqlParameter("@dataview",SqlDbType.VarChar,200){Value=v_dataview},
                new SqlParameter("@datafiled",SqlDbType.VarChar,200){Value=v_datafiled},
                new SqlParameter("@defaultvalue",SqlDbType.VarChar,200){Value=v_defaultvalue},
                new SqlParameter("@editable",SqlDbType.Int,4){Value=v_editable},
                new SqlParameter("@required",SqlDbType.Int,4){Value=v_required},
                new SqlParameter("@placehold",SqlDbType.VarChar,200){Value=v_placehold},
            };
            return claSqlConnDB.ExecuteNonQuery(claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL, parameters);
        }

        public int DelWidgetDatetimeboxData(string v_No)
        {
            string mStrSQL = @"DELETE FROM  t_FormDatetimebox
                                        WHERE No=@No";
            SqlParameter[] parameters = new SqlParameter[]{
                new SqlParameter("@No",SqlDbType.VarChar,30){Value=v_No},
            };
            return claSqlConnDB.ExecuteNonQuery(claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL, parameters);
        }

        public int GetWidgetDatetimeboxCount(string v_id, string v_name)
        {
            string mStrSQL = @"SELECT COUNT(0) FROM  t_FormDatetimebox " + GetWhere(v_id, v_name);
            return claSqlConnDB.GetRecordCount(claSqlConnDB.gStrConnDefault, mStrSQL);
        }

        public DataTable GetWidgetDatetimeboxData(string v_id, string v_name)
        {
            string mStrSQL = @"SELECT No,id,name,width,height,fontsize,align ,datetype,secondshow,timeseparator,format,
                                                          dataform,dataview,datafiled,defaultvalue,editable,required,placehold FROM  t_FormDatetimebox " + GetWhere(v_id, v_name);
            return claSqlConnDB.ExecuteDataset(claSqlConnDB.gStrConnDefault,CommandType.Text, mStrSQL).Tables[0];
        }

        public DataTable GetWidgetDatetimeboxData(string v_id, string v_name, string v_sort, string v_order)
        {
            string mStrSQL = @"SELECT No,id,name,width,height,fontsize,align ,datetype,secondshow,timeseparator,format,
                                                          dataform,dataview,datafiled,defaultvalue,editable,required,placehold FROM  t_FormDatetimebox "
                                + GetWhere(v_id, v_name) + GetOrder(v_sort, v_order);
            return claSqlConnDB.ExecuteDataset(claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL).Tables[0];
        }

        public DataTable GetWidgetDatetimeboxData(int v_page, int v_rows, string v_id, string v_name, string v_sort, string v_order)
        {
            string mStrSQL = @"SELECT No,id,name,width,height,fontsize,align ,datetype,secondshow,timeseparator,format,
                                                          dataform,dataview,datafiled,defaultvalue,editable,required,placehold FROM  t_FormDatetimebox "
                                 + GetWhere(v_id, v_name) + GetOrder(v_sort, v_order);
            return claSqlConnDB.ExecuteDataset(v_rows, v_page,claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL).Tables[0];
        }

        public Dictionary<string, object> GetWidgetDatetimeboxDetail(string v_No)
        {
            string mStrSQL = @"SELECT No,id,name,width,height,fontsize,align ,datetype,secondshow,timeseparator,format,
                                      dataform,dataview,datafiled,defaultvalue,editable,required,placehold FROM  t_FormDatetimebox 
                                WHERE No=@No";
            SqlParameter[] parameters = new SqlParameter[]{
                new SqlParameter("@No",SqlDbType.VarChar,30){Value=v_No},
            };
            return GJHF.Utility.Convert.ConvertModelToDictionary(claSqlConnDB.GetDetail(claSqlConnDB.gStrConnDefault, mStrSQL, "GJHF.Data.Model.FORM.WIDGET.MFORMWidgetDatetimebox", "GJHF.Data.Model", parameters));
        }

        #endregion

        private string GetWhere(string v_id, string v_name)
        {
            string mStrWhere = " WHERE 1=1 ";
            if (v_id != "")
            {
                mStrWhere += " AND t_FormDatetimebox.id LIKE '%" + v_id + "%'";
            }
            if (v_name != "")
            {
                mStrWhere += " AND t_FormDatetimebox.name LIKE '%" + v_name + "%'";
            }
            return mStrWhere;
        }

        private string GetOrder(string v_sort, string v_order)
        {
            string mStrOrder = "";
            if (v_sort != "")
            {
                mStrOrder += " ORDER BY t_FormDatetimebox." + v_sort;
                if (v_order != "")
                {
                    mStrOrder += " " + v_order;
                }
            }
            return mStrOrder;
        }
    }
}
