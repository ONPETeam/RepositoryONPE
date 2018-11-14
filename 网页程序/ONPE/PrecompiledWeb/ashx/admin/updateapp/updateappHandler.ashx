<%@ WebHandler Language="C#" Class="updateappHandler" %>

using System;
using System.Web;
using Newtonsoft.Json;
using NPE.UIDataClass;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Generic;
using ModelClass;
using System.IO;


public class updateappHandler : IHttpHandler
{

    int page = 1;
    int rows = 10;
    string order = "";
    string sort = "";
    public void ProcessRequest(HttpContext context)
    {
        string action = "";
        string mStrReturn = "";
        object mObjDetial = null;
        string mStrMsg = "";
        int mIntParamNullable = 0;
        context.Response.ContentType = "text/plain";
        action = context.Request.Params["action"];
        switch (action)
        {
            case "add":
                
                int m_add_platform_type = 0;
                if (context.Request.Params["platform_type"] != null)
                {
                    if (int.TryParse(context.Request.Params["platform_type"].ToString(), out m_add_platform_type) == false)
                    {
                        mIntParamNullable = mIntParamNullable + 1;
                    }
                }
                else
                {
                    mIntParamNullable = mIntParamNullable + 1;
                }
                string m_add_platform_guid = "";
                if (context.Request.Params["platform_guid"] != null)
                {
                    m_add_platform_guid = context.Request.Params["platform_guid"];
                }
                else
                {
                    mIntParamNullable = mIntParamNullable + 1;
                }
                string m_add_app_name = "";
                if (context.Request.Params["app_name"] != null)
                {
                    m_add_app_name = context.Request.Params["app_name"];
                }
                else
                {
                    mIntParamNullable = mIntParamNullable + 1;
                }
                string m_add_region_name = "";
                if (context.Request.Params["region_name"] != null)
                {
                    m_add_region_name = context.Request.Params["region_name"];
                }
                else
                {
                    mIntParamNullable = mIntParamNullable + 1;
                }
                int m_add_region_code = 0;
                if (context.Request.Params["region_code"] != null)
                {
                    if (int.TryParse(context.Request.Params["region_code"].ToString(), out m_add_region_code) == false)
                    {
                        mIntParamNullable = mIntParamNullable + 1;
                    }
                }
                else
                {
                    mIntParamNullable = mIntParamNullable + 1;
                }
                int m_add_low_region_code = 0;
                if (context.Request.Params["low_region_code"] != null)
                {
                    if (int.TryParse(context.Request.Params["low_region_code"].ToString(), out m_add_low_region_code) == false)
                    {
                        mIntParamNullable = mIntParamNullable + 1;
                    }
                }
                else
                {
                    mIntParamNullable = mIntParamNullable + 1;
                }
                int m_add_force_update = 0;
                if (context.Request.Params["force_update"] != null)
                {
                    if (int.TryParse(context.Request.Params["force_update"].ToString(), out m_add_force_update) == true)
                    {
                        if (m_add_force_update != 0 && m_add_force_update != 1)
                        {
                            mIntParamNullable = mIntParamNullable + 1;
                        }
                    }
                    else
                    {
                        mIntParamNullable = mIntParamNullable + 1;
                    }
                }
                else
                {
                    mIntParamNullable = mIntParamNullable + 1;
                }
                DateTime m_add_update_time;
                if (context.Request.Params["update_time"] != null)
                {
                    if (DateTime.TryParse(context.Request.Params["update_time"], out m_add_update_time) == false)
                    {
                        m_add_update_time = DateTime.Parse("1900-01-01");
                    }
                }
                else
                {
                    m_add_update_time = DateTime.Parse("1900-01-01");
                }
                
                
                string m_add_update_context = "";
                if (context.Request.Params["update_context"] != null)
                {
                    m_add_update_context = context.Request.Params["update_context"];
                }
                else
                {
                    m_add_update_context = "";
                }
                HttpPostedFile file = null;
                HttpFileCollection httpFileCollection = context.Request.Files;
                string m_add_update_address = "";
                if (httpFileCollection.Count > 0)
                {
                    file = httpFileCollection[0];
                }
                if (file != null)
                {
                    string file_name = System.DateTime.Now.ToFileTimeUtc().ToString() +file.FileName.Substring(file.FileName.LastIndexOf("\\") + 1);
                    string file_path ="../../../UF/APP";
                    common.SaveFile(file_path, file_name, file);
                    m_add_update_address = "http://121.40.203.230/ONPE/UF/APP/" +  file_name;
                }
                if (mIntParamNullable == 0)
                {
                    mObjDetial = AddUadateAppData(m_add_platform_type, m_add_platform_guid, m_add_app_name, m_add_region_name, m_add_region_code, m_add_low_region_code, m_add_force_update, m_add_update_time, m_add_update_address, m_add_update_context);
                    if (mObjDetial.ToString() == "1")
                    {
                        mStrReturn = "{'success':true,'msg':'添加数据成功！'}";
                    }
                    else
                    {
                        mStrReturn = "{'success':false,'msg':'添加数据失败！'}";
                    }
                }
                else
                {
                    mStrReturn = "{'success':false,'msg':'缺少必要参数！'}";
                }
                break;
            case "edit":
                int m_edit_record_id = 0;
                if (context.Request.Params["record_id"] != null)
                {
                    if (int.TryParse(context.Request.Params["record_id"], out m_edit_record_id) == false)
                    {
                        mIntParamNullable = mIntParamNullable + 1;
                    }
                }
                else
                {
                    mIntParamNullable = mIntParamNullable + 1;
                }
                int m_edit_platform_type = 0;
                if (context.Request.Params["platform_type"] != null)
                {
                    if (int.TryParse(context.Request.Params["platform_type"], out m_edit_platform_type) == false)
                    {
                        mIntParamNullable = mIntParamNullable + 1;
                    }
                }
                else
                {
                    mIntParamNullable = mIntParamNullable + 1;
                }
                string m_edit_platform_guid = "";
                if (context.Request.Params["platform_guid"] != null)
                {
                    m_edit_platform_guid = context.Request.Params["platform_guid"];
                }
                else
                {
                    mIntParamNullable = mIntParamNullable + 1;
                }
                string m_edit_app_name = "";
                if (context.Request.Params["app_name"] != null)
                {
                    m_edit_app_name = context.Request.Params["app_name"];
                }
                else
                {
                    mIntParamNullable = mIntParamNullable + 1;
                }
                string m_edit_region_name = "";
                if (context.Request.Params["region_name"] != null)
                {
                    m_edit_region_name = context.Request.Params["region_name"];
                }
                else
                {
                    mIntParamNullable = mIntParamNullable + 1;
                }
                int m_edit_region_code = 0;
                if (context.Request.Params["region_code"] != null)
                {
                    if (int.TryParse(context.Request.Params["region_code"], out m_edit_region_code) == false)
                    {
                        mIntParamNullable = mIntParamNullable + 1;
                    }
                }
                else
                {
                    mIntParamNullable = mIntParamNullable + 1;
                }
                int m_edit_low_region_code = 0;
                if (context.Request.Params["low_region_code"] != null)
                {
                    if (int.TryParse(context.Request.Params["low_region_code"], out m_edit_low_region_code) == false)
                    {
                        mIntParamNullable = mIntParamNullable + 1;
                    }
                }
                else
                {
                    mIntParamNullable = mIntParamNullable + 1;
                }
                int m_edit_force_update = 0;
                if (context.Request.Params["force_update"] != null)
                {
                    if (int.TryParse(context.Request.Params["force_update"], out m_edit_force_update) == true)
                    {
                        if (m_edit_force_update != 0 && m_edit_force_update != 1)
                        {
                            mIntParamNullable = mIntParamNullable + 1;
                        }
                    }
                    else
                    {
                        mIntParamNullable = mIntParamNullable + 1;
                    }
                }
                else
                {
                    mIntParamNullable = mIntParamNullable + 1;
                }
                DateTime m_edit_update_time;
                if (context.Request.Params["update_time"] != null)
                {
                    if (DateTime.TryParse(context.Request.Params["update_time"], out m_edit_update_time) == false)
                    {
                        m_edit_update_time = DateTime.Parse("1900-01-01");
                    }
                }
                else
                {
                    m_edit_update_time = DateTime.Parse("1900-01-01");
                }

                string m_edit_update_context = "";
                if (context.Request.Params["update_context"] != null)
                {
                    m_edit_update_context = context.Request.Params["update_context"];
                }
                else
                {
                    m_edit_update_context = "";
                }
                if (mIntParamNullable == 0)
                {
                    mObjDetial = EditUpdateAppData(m_edit_record_id, m_edit_platform_type, m_edit_platform_guid, m_edit_app_name, m_edit_region_name, m_edit_region_code, m_edit_low_region_code, m_edit_force_update, m_edit_update_time, m_edit_update_context);
                    if (mObjDetial.ToString() == "1")
                    {
                        mStrReturn = "{'success':true,'msg':'编辑数据成功！'}";
                    }
                    else
                    {
                        mStrReturn = "{'success':false,'msg':'编辑数据失败！'}";
                    }
                }
                else
                {
                    mStrReturn = "{'success':false,'msg':'缺少必要参数！'}";
                }
                break;
            case "del":
                int m_del_record_id = 0;
                if (context.Request.Params["record_id"] != null)
                {
                    if (int.TryParse(context.Request.Params["record_id"], out m_del_record_id) == false)
                    {
                        mIntParamNullable = mIntParamNullable + 1;
                    }
                }
                else
                {
                    mIntParamNullable = mIntParamNullable + 1;
                }
                if (mIntParamNullable == 0)
                {
                    mObjDetial = DelUpdateAppData(m_del_record_id);
                    if (mObjDetial.ToString() == "1")
                    {
                        mStrReturn = "{'success':true,'msg':'删除数据成功！'}";
                    }
                    else
                    {
                        mStrReturn = "{'success':false,'msg':'删除数据失败！'}";
                    }
                }
                else
                {
                    mStrReturn = "{'success':false,'msg':'缺少必要参数！'}";
                }
                break;
            case "new":
                 int m_new_platform_type = 0;
                if (context.Request.Params["platform_type"] != null)
                {
                    if (int.TryParse(context.Request.Params["platform_type"], out m_new_platform_type) == false)
                    {
                        mIntParamNullable = mIntParamNullable + 1;
                    }
                }
                else
                {
                    mIntParamNullable = mIntParamNullable + 1;
                }
                string m_new_platform_guid = "";
                if (context.Request.Params["platform_guid"] != null)
                {
                    m_new_platform_guid = context.Request.Params["platform_guid"];
                }
                else
                {
                    mIntParamNullable = mIntParamNullable + 1;
                }
                if (mIntParamNullable == 0)
                {
                    mObjDetial = GetNewVersionApp(m_new_platform_type, m_new_platform_guid);
                    mStrReturn = "{\"success\":true,\"msg\":" + JsonConvert.SerializeObject(mObjDetial) + "}";
                }
                else
                {
                    mStrReturn = "{\"success\":false,\"msg\":\"缺少必要参数！\"}"; 
                }
                break;
            case "grid":
                order = context.Request.Params["order"];
                sort = context.Request.Params["sort"];
                if (int.TryParse(context.Request.Params["page"], out page) == false)
                {
                    page = 1;
                }
                if (int.TryParse(context.Request.Params["rows"], out rows) == false)
                {
                    rows = 10;
                }
                string m_grid_platform_guid = "";
                if (context.Request.Params["platform_guid"] != null)
                {
                    m_grid_platform_guid = context.Request.Params["platform_guid"];
                }
                string m_grid_app_name = "";
                if (context.Request.Params["app_name"] != null)
                {
                    m_grid_app_name = context.Request.Params["app_name"];
                }
                int m_grid_platform_type = -1;
                if (context.Request.Params["platform_type"] != null)
                {
                    if (int.TryParse(context.Request.Params["platform_type"], out m_grid_platform_type) == false)
                    {
                        m_grid_platform_type = -1;
                    }
                }
                string m_grid_region_name = "";
                if (context.Request.Params["region_name"] != null)
                {
                    m_grid_region_name = context.Request.Params["region_name"];
                }
                int m_grid_region_code = 0;
                if (context.Request.Params["region_code"] != null)
                {
                    if (int.TryParse(context.Request.Params["region_code"], out m_grid_region_code) == false)
                    {
                        m_grid_region_code = 0;
                    }
                }
                int m_grid_force_update = -1;
                if (context.Request.Params["force_update"] != null)
                {
                    if (int.TryParse(context.Request.Params["region_code"], out m_grid_force_update) == false)
                    {
                        m_grid_force_update = -1;
                    }
                }
                string m_grid_update_context = "";
                if (context.Request.Params["update_context"] != null)
                {
                    m_grid_update_context = context.Request.Params["update_context"];
                }
                mObjDetial = GetUpdateAppData(page, rows,m_grid_platform_guid, m_grid_app_name, m_grid_platform_type, m_grid_region_name, m_grid_region_code, m_grid_force_update, m_grid_update_context, sort, order);
                mStrMsg = string.Format("\"total\":{0},\"rows\":", GetUpdateAppCount(m_grid_platform_guid,m_grid_app_name, m_grid_platform_type, m_grid_region_name, m_grid_region_code, m_grid_force_update, m_grid_update_context));
                mStrReturn = "{" + mStrMsg + JsonConvert.SerializeObject(mObjDetial) + "}";
                break;
            default:
                mStrReturn = "{\"success\":false,\"msg\":\"缺少必要参数！\"}";
                break;
        }
        context.Response.Write(mStrReturn);
    }

    private updateapp GetNewVersionApp(int v_platform_type, string v_platform_guid)
    {
        updateapp mUpdateApp = new updateapp();
        string mStrSQL = @"SELECT TOP 1 
                                record_id,
                                record_time,
                                platform_type,
                                platform_guid,
                                app_name,
                                region_name,
                                region_code,
                                low_region_code,
                                force_update,
                                update_time,
                                update_address,
                                update_context from t_UpdateApp 
                        WHERE platform_type=@platform_type 
                        AND platform_guid=@platform_guid 
                        AND (update_time<=convert(datetime,@update_time,102) or update_time=convert(datetime,'1900-01-01',102))
                        ORDER BY region_code DESC ";
        SqlParameter []parameters=new SqlParameter[]{
            new SqlParameter("@platform_type",SqlDbType.Int,4),
            new SqlParameter("@platform_guid",SqlDbType.VarChar,50),
            new SqlParameter("@update_time",SqlDbType.VarChar,20)
        };
        parameters[0].Value=v_platform_type;
        parameters[1].Value=v_platform_guid;
        parameters[2].Value=System.DateTime.Now.ToString();
        mUpdateApp = (updateapp)claSqlConnDB.GetDetail(claSqlConnDB.gStrConnDefault, mStrSQL, "ModelClass.updateapp", parameters);
        return mUpdateApp; 
    }
    
    private int AddUadateAppData(int v_platform_type, string v_platform_guid, string v_app_name, string v_region_name, int v_region_code, int v_low_region_code, int v_force_update, DateTime v_update_time, string v_update_address, string v_update_context)
    {
        int mIntReturn = 0;
        string mStrSQL = @"INSERT INTO t_UpdateApp (
                                record_time,
                                platform_type,
                                platform_guid,
                                app_name,
                                region_name,
                                region_code,
                                low_region_code,
                                force_update,
                                update_time,
                                update_address,
                                update_context)
                        VALUES(@record_time,
                               @platform_type,
                               @platform_guid,
                               @app_name,
                               @region_name,
                               @region_code,
                               @low_region_code,
                               @force_update,
                               @update_time,
                               @update_address,
                               @update_context)";
        SqlParameter[] parameters = new SqlParameter[] { 
            new SqlParameter("@record_time",SqlDbType.DateTime),
            new SqlParameter("@platform_type",SqlDbType.Int,4),
            new SqlParameter("@platform_guid",SqlDbType.VarChar,50),
            new SqlParameter("@app_name",SqlDbType.VarChar,50),
            new SqlParameter("@region_name",SqlDbType.VarChar,50),
            new SqlParameter("@region_code",SqlDbType.Int,4),
            new SqlParameter("@low_region_code",SqlDbType.Int,4),
            new SqlParameter("@force_update",SqlDbType.Int,4),
            new SqlParameter("@update_time",SqlDbType.DateTime),
            new SqlParameter("@update_address",SqlDbType.VarChar,500),
            new SqlParameter("@update_context",SqlDbType.VarChar,2000),
        };
        parameters[0].Value = System.DateTime.Now;
        parameters[1].Value = v_platform_type;
        parameters[2].Value = v_platform_guid;
        parameters[3].Value = v_app_name;
        parameters[4].Value = v_region_name;
        parameters[5].Value = v_region_code;
        parameters[6].Value = v_low_region_code;
        parameters[7].Value = v_force_update;
        parameters[8].Value = v_update_time;
        parameters[9].Value = v_update_address;
        parameters[10].Value = v_update_context;
        mIntReturn = claSqlConnDB.ExecuteNonQuery(claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL, parameters);
        return mIntReturn;
    }

    private int EditUpdateAppData(int v_record_id, int v_platform_type, string v_platform_guid, string v_app_name, string v_region_name, int v_region_code, int v_low_region_code, int v_force_update, DateTime v_update_time, string v_update_context)
    {
        int mIntReturn = 0;
        string mStrSQL = @"UPDATE t_UpdateApp SET 
                            platform_type=@platform_type, 
                            platform_guid=@platform_guid,
                            app_name=@app_name,
                            region_name=@region_name,
                            region_code=@region_code,
                            low_region_code=@low_region_code,
                            force_update=@force_update,
                            update_time=@update_time,
                            update_context=@update_context
                        where record_id=@record_id";
        SqlParameter[] parameters = new SqlParameter[] { 
            new SqlParameter("@record_id",SqlDbType.Int,4),
            new SqlParameter("@platform_type",SqlDbType.Int,4),
            new SqlParameter("@platform_guid",SqlDbType.VarChar,50),
            new SqlParameter("@app_name",SqlDbType.VarChar,50),
            new SqlParameter("@region_name",SqlDbType.VarChar,50),
            new SqlParameter("@region_code",SqlDbType.Int,4),
            new SqlParameter("@low_region_code",SqlDbType.Int,4),
            new SqlParameter("@force_update",SqlDbType.Int,4),
            new SqlParameter("@update_time",SqlDbType.DateTime),
            new SqlParameter("@update_context",SqlDbType.VarChar,2000),
        };
        parameters[0].Value = v_record_id;
        parameters[1].Value = v_platform_type;
        parameters[2].Value = v_platform_guid;
        parameters[3].Value = v_app_name;
        parameters[4].Value = v_region_name;
        parameters[5].Value = v_region_code;
        parameters[6].Value = v_low_region_code;
        parameters[7].Value = v_force_update;
        parameters[8].Value = v_update_time;
        parameters[9].Value = v_update_context;
        mIntReturn = claSqlConnDB.ExecuteNonQuery(claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL, parameters);
        return mIntReturn;
    }

    private int DelUpdateAppData(int v_record_id)
    {
        int mIntReturn = 0;
        string mStrSQL = @"DELETE FROM t_UpdateApp WHERE record_id=@record_id";
        SqlParameter[] parameters = new SqlParameter[] { 
            new SqlParameter("@record_id",SqlDbType.Int,4)
        };
        parameters[0].Value = v_record_id;
        mIntReturn = claSqlConnDB.ExecuteNonQuery(claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL, parameters);
        return mIntReturn;
    }

    private int GetUpdateAppCount(string v_platform_guid, string v_app_name, int v_platform_type, string v_region_name, int v_region_code, int v_force_update, string v_update_context)
    {

        string mStrSQL = @" select count(0) from t_UpdateApp " + GetWhere(v_platform_guid,v_app_name, v_platform_type, v_region_name, v_region_code, v_force_update, v_update_context);
        int i = claSqlConnDB.GetRecordCount(claSqlConnDB.gStrConnDefault, mStrSQL);
        return i;
    }

    private List<updateapp> GetUpdateAppData(int page, int rows,string v_platform_guid, string v_app_name, int v_platform_type, string v_region_name, int v_region_code, int v_force_update, string v_update_context, string v_sort, string v_order)
    {
        List<updateapp> mLstUpdateApp = new List<updateapp>();
        string mStrSQL = @"SELECT record_id,record_time,platform_type,platform_guid,app_name,region_name,region_code,low_region_code,force_update,update_time,update_address,update_context 
                            FROM t_UpdateApp "
                        + GetWhere(v_platform_guid,v_app_name, v_platform_type, v_region_name, v_region_code, v_force_update, v_update_context)
                        + GetSort(v_sort, v_order);
        DataTable dt = null;
        using (dt = claSqlConnDB.ExecuteDataset(claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL).Tables[0])
        {
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                updateapp mUpdateAppTmp = new updateapp();
                mUpdateAppTmp.record_id = dt.Rows[i][0].ToString();
                mUpdateAppTmp.record_time = dt.Rows[i][1].ToString();
                mUpdateAppTmp.platform_type = dt.Rows[i][2].ToString();
                mUpdateAppTmp.platform_guid = dt.Rows[i][3].ToString();
                mUpdateAppTmp.app_name = dt.Rows[i][4].ToString();
                mUpdateAppTmp.region_name = dt.Rows[i][5].ToString();
                mUpdateAppTmp.region_code = dt.Rows[i][6].ToString();
                mUpdateAppTmp.low_region_code = dt.Rows[i][7].ToString();
                mUpdateAppTmp.force_update = dt.Rows[i][8].ToString();
                mUpdateAppTmp.update_time = dt.Rows[i][9].ToString();
                mUpdateAppTmp.update_address = dt.Rows[i][10].ToString();
                mUpdateAppTmp.update_context = dt.Rows[i][11].ToString();
                mLstUpdateApp.Add(mUpdateAppTmp);
            }
        }
        return mLstUpdateApp;
    }

    private string GetWhere(string v_platform_guid,string v_app_name, int v_platform_type, string v_region_name, int v_region_code, int v_force_update, string v_update_context)
    {
        string mStrWhere = "";
        if (v_platform_guid != "")
        {
            if (mStrWhere != "")
            {
                mStrWhere = " WHERE t_UpdateApp.platform_guid ='" + v_platform_guid + "'";
            }
            else
            {
                mStrWhere = " and t_UpdateApp.platform_guid =" + v_platform_guid + "'";
            }
        }
        if (v_app_name != "")
        {
            if (mStrWhere != "")
            {
                mStrWhere = " WHERE t_UpdateApp.app_name like '%" + v_app_name + "%'";
            }
            else
            {
                mStrWhere = " and t_UpdateApp.app_name like '%" + v_app_name + "%'";
            }
        }
        if (v_platform_type != -1)
        {
            if (mStrWhere != "")
            {
                mStrWhere = " WHERE t_UpdateApp.platform_type =" + v_platform_type;
            }
            else
            {
                mStrWhere = " and t_UpdateApp.platform_type =" + v_platform_type;
            }
        }
        if (v_region_name != "")
        {
            if (mStrWhere != "")
            {
                mStrWhere = " WHERE t_UpdateApp.region_name like '%" + v_region_name + "%'";
            }
            else
            {
                mStrWhere = " and t_UpdateApp.region_name like '%" + v_region_name + "%'";
            }
        }
        if (v_region_code != 0)
        {
            if (mStrWhere != "")
            {
                mStrWhere = " WHERE t_UpdateApp.region_code =" + v_region_code;
            }
            else
            {
                mStrWhere = " and t_UpdateApp.region_code =" + v_region_code;
            }
        }
        if (v_force_update != -1)
        {
            if (mStrWhere != "")
            {
                mStrWhere = " WHERE t_UpdateApp.force_update =" + v_force_update;
            }
            else
            {
                mStrWhere = " and t_UpdateApp.force_update =" + v_force_update;
            }
        }
        if (v_update_context != "")
        {
            if (mStrWhere != "")
            {
                mStrWhere = " WHERE t_UpdateApp.update_context like '%" + v_update_context + "%'";
            }
            else
            {
                mStrWhere = " and t_UpdateApp.update_context like '%" + v_update_context + "%'";
            }
        }
        return mStrWhere;
    }

    private string GetSort(string v_grid_sort, string v_grid_order)
    {
        string mStrSort = "";
        if (v_grid_sort != "" && v_grid_sort != null)
        {
            mStrSort = " order by t_UpdateApp." + v_grid_sort;
            if (v_grid_order != "" && v_grid_order != null)
            {
                mStrSort = mStrSort + " " + v_grid_order;
            }
        }
        return mStrSort;
    }

    public bool IsReusable
    {
        get
        {
            return false;
        }
    }

}