<%@ WebHandler Language="C#" Class="fileEquipHandler" %>

using System;
using System.Web;
using ModelClass;
using Newtonsoft.Json;
using NPE.UIDataClass;
using System.Data;
using System.Collections.Generic;
using System.Data.SqlClient;

public class fileEquipHandler : IHttpHandler {

    string fileclass_code = "";
    string equipfile_code = "";
    string equip_code = "";
    string equip_name = "";
    string file_code = "";
 //   string equipfile_status = "";
    string sort = "";
    string order = "";

    int rows = 10;
    int page = 1;
    
    public void ProcessRequest (HttpContext context) {
        context.Response.ContentType = "text/plain";
        string action = "";
        if (context.Request.Params["fileclass_code"] != null)
        {
            fileclass_code = context.Request.Params["fileclass_code"];
        }
        if (context.Request.Params["equipfile_code"] != null)
        {
            equipfile_code = context.Request.Params["equipfile_code"];
        }
        if (context.Request.Params["equip_code"] != null)
        {
            equip_code = context.Request.Params["equip_code"];
        }
        if (context.Request.Params["equip_name"] != null)
        {
            equip_name = context.Request.Params["equip_name"];
        }
        if (context.Request.Params["file_code"] != null)
        {
            file_code = context.Request.Params["file_code"];
        }
        if (context.Request.Params["sort"] != null)
        {
            sort = context.Request.Params["sort"];
        }
        if (context.Request.Params["order"] != null)
        {
            order = context.Request.Params["order"];
        }
        if (context.Request.Params["rows"] != null)
        {
            rows = int.Parse(context.Request.Params["rows"]);
        }
        if (context.Request.Params["page"] != null)
        {
            page = int.Parse(context.Request.Params["page"]);
        }
        if (context.Request.Params["action"] != null)
        {
            action = context.Request.Params["action"];
        }
        switch (action)
        {
            case "add":
                context.Response.Write(addFileEquip());
                break;
            case "edit":

                break;
            case "del":
                context.Response.Write(delFileEquip());
                break;
            case "grid":
                System.Text.StringBuilder sb = new System.Text.StringBuilder();
                sb.Append("{ ");
                sb.Append(string.Format("\"total\":{0},\"rows\":", GetFileEquipPageCount()));
                string s = ShowFileEquipGird();
                sb.Append(s);
                sb.Append("}");
                context.Response.Write(sb.ToString());
                break;

            case "combo":
                context.Response.Write(GetFileEquipComboJson());
                break;
            //case "prop":
            //    context.Response.Write(GetProperty());
            //    break;
            //case "detail":
            //    context.Response.Write(GetAreaDetail());
            //    break;
            default:

                break;
        } 
       
    }
    private string addFileEquip()
    {
        global mGlobal = new global();
        equipfile_code = mGlobal.GetIdentityID("PC", "SB", "ZL", System.DateTime.Now, 6);
        string mStrSQL = @"insert into t_EquipFile(equipfile_code,equip_code,file_code)
                        values(@equipfile_code ,@equip_code ,@file_code)";
        SqlParameter[] l0lSqlParameter = new SqlParameter[3]{
            new SqlParameter("@equipfile_code",SqlDbType.VarChar,30),
            new SqlParameter("@equip_code",SqlDbType.VarChar,30),
            new SqlParameter("@file_code",SqlDbType.VarChar,30)
        };
        l0lSqlParameter[0].Value = equipfile_code;
        l0lSqlParameter[1].Value = equip_code;
        l0lSqlParameter[2].Value = file_code;
        int i = claSqlConnDB.ExecuteNonQuery(claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL, l0lSqlParameter);
        if (i >= 0)
        {
            i=global.SetEquipConnectProp(equip_code, "FILE", 1);
        }
        return i.ToString();
    }
    private string delFileEquip()
    {
        string mStrSQL = @"SELECT equip_code  from t_EquipFile where equipfile_code=@equipfile_code ";
        SqlParameter[] parameter = new SqlParameter[1]{
            new SqlParameter("@equipfile_code",SqlDbType.VarChar,30)
        };
        parameter[0].Value = equipfile_code;
        fileequip mFileEquip = (fileequip)claSqlConnDB.GetDetail(claSqlConnDB.gStrConnDefault, mStrSQL, "ModelClass.fileequip", parameter);
        string mStrEquipCode = mFileEquip.equip_code;
        int i = global.SetEquipConnectProp(mStrEquipCode, "FILE", -1);
        if (i >= 0)
        {
            mStrSQL = @"delete from  t_EquipFile where equipfile_code=@equipfile_code ";
            SqlParameter[] l0lSqlParameter = new SqlParameter[1]{
                                new SqlParameter("@equipfile_code",SqlDbType.VarChar,30)
                            };
            l0lSqlParameter[0].Value = equipfile_code;
            i = claSqlConnDB.ExecuteNonQuery(claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL, l0lSqlParameter);
        }
        return i.ToString();
    }
    private string GetFileEquipPageCount()
    {
        string mStrSQL = @" SELECT count(0) 
                            FROM         t_EquipArea RIGHT OUTER JOIN
                            t_Equips ON t_EquipArea.area_id = t_Equips.area_id LEFT OUTER JOIN
                            t_Equips AS t_Equips_1 ON t_Equips.equip_parent = t_Equips_1.equip_code RIGHT OUTER JOIN
                            t_File LEFT OUTER JOIN
                            t_Diretory LEFT OUTER JOIN
                            t_FileClass ON t_Diretory.fileclass_code = t_FileClass.fileclass_code RIGHT OUTER JOIN
                            t_FileDiretory ON t_Diretory.diretory_code = t_FileDiretory.diretory_code ON t_File.file_code = t_FileDiretory.file_code RIGHT OUTER JOIN
                            t_EquipFile ON t_File.file_code = t_EquipFile.file_code ON t_Equips.equip_code = t_EquipFile.equip_code " + GetWhere();
        int i = claSqlConnDB.GetRecordCount(claSqlConnDB.gStrConnDefault, mStrSQL);
        return i.ToString(); 
    }
    public string ShowFileEquipGird()
    {
        string mStrReturn = "";
        List<fileequip> listTemp = new List<fileequip>();
        string mStrSQL = @"SELECT     t_EquipFile.equipfile_code, t_Equips.equip_code, t_Equips.equip_name, t_Equips_1.equip_code AS equip_parent_code, t_Equips_1.equip_name AS equip_parent_name, t_EquipArea.area_id, 
                                              t_EquipArea.area_name, t_File.file_code, t_File.file_name, t_Diretory.diretory_code, t_Diretory.diretory_name, t_FileClass.fileclass_code, t_FileClass.fileclass_name
                        FROM         t_EquipArea RIGHT OUTER JOIN
                                              t_Equips ON t_EquipArea.area_id = t_Equips.area_id LEFT OUTER JOIN
                                              t_Equips AS t_Equips_1 ON t_Equips.equip_parent = t_Equips_1.equip_code RIGHT OUTER JOIN
                                              t_File LEFT OUTER JOIN
                                              t_Diretory LEFT OUTER JOIN
                                              t_FileClass ON t_Diretory.fileclass_code = t_FileClass.fileclass_code RIGHT OUTER JOIN
                                              t_FileDiretory ON t_Diretory.diretory_code = t_FileDiretory.diretory_code ON t_File.file_code = t_FileDiretory.file_code RIGHT OUTER JOIN
                                              t_EquipFile ON t_File.file_code = t_EquipFile.file_code ON t_Equips.equip_code = t_EquipFile.equip_code" + GetWhere() + GetOrder();
        DataTable dt = null;
        using (dt = claSqlConnDB.ExecuteDataset(rows, page, claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL).Tables[0])
        {
            if (dt.Rows.Count > 0)
            {
                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    fileequip fileEquipTemp = new fileequip();
                    fileEquipTemp.equipfile_code = dt.Rows[i][0].ToString();
                    fileEquipTemp.equip_code = dt.Rows[i][1].ToString();
                    fileEquipTemp.equip_name = dt.Rows[i][2].ToString();
                    fileEquipTemp.equip_parent_code = dt.Rows[i][3].ToString();
                    fileEquipTemp.equip_parent_name = dt.Rows[i][4].ToString();
                    fileEquipTemp.area_id = dt.Rows[i][5].ToString();
                    fileEquipTemp.area_name = dt.Rows[i][6].ToString();
                    fileEquipTemp.file_code = dt.Rows[i][7].ToString();
                    fileEquipTemp.file_name = dt.Rows[i][8].ToString();
                    fileEquipTemp.diretory_code = dt.Rows[i][9].ToString();
                    fileEquipTemp.diretory_name = dt.Rows[i][10].ToString();
                    fileEquipTemp.fileclass_code = dt.Rows[i][11].ToString();
                    fileEquipTemp.fileclass_name = dt.Rows[i][12].ToString();
                    listTemp.Add(fileEquipTemp); 
                } 
            }
        }
        mStrReturn = JsonConvert.SerializeObject(listTemp);
        return mStrReturn; ; 
    }
    public string GetWhere()
    {
        string mStrWhere = "";
        if (file_code != "")
        {
            mStrWhere = " where t_EquipFile.file_code ='" + file_code + "' ";
        }
        if (equip_name!="")
        {
            if (mStrWhere != "")
            {
                mStrWhere = mStrWhere + " and t_Equips.equip_name like '%" + equip_name + "%' ";
            }
            else
            {
                mStrWhere = " where t_Equips.equip_name like '%" + equip_name + "%' ";
            }
        }
        if (equip_code != "")
        {
            if (mStrWhere != "")
            {
                mStrWhere = mStrWhere + " and t_EquipFile.equip_code ='" + equip_code + "' ";
            }
            else
            {
                mStrWhere = " where t_EquipFile.equip_code ='" + equip_code + "' ";
            }
        }
        if (fileclass_code != "")
        {
            if (mStrWhere != "")
            {
                mStrWhere = mStrWhere + " and t_FileClass.fileclass_code ='" + fileclass_code + "' ";
            }
            else
            {
                mStrWhere = " where t_FileClass.fileclass_code ='" + fileclass_code + "' ";
            }
        }
        return mStrWhere;
    }
    private string GetOrder()
    {
        string mStrOrder = "";
        if (sort != "")
        {
            mStrOrder = " ORDER BY " + sort + " ";
            if (order != "")
            {
                mStrOrder = mStrOrder + order + " ";
            }
        }
        return mStrOrder;
    }
    public string GetFileEquipComboJson()
    {
        return JsonConvert.SerializeObject(GetFileEquipCombo(file_code, equip_code));
    }
    public List<combotree> GetFileEquipCombo(string fileCode,string equipCode)
    {
        List<combotree> listCombo = new List<combotree>();
        string mStrSQL = "";
        if (fileCode != "" && equipCode == "")
        {
            mStrSQL = @"SELECT     t_Equips.equip_code, t_Equips.equip_name
                        FROM         t_EquipFile LEFT OUTER JOIN
                                              t_File ON t_EquipFile.file_code = t_File.file_code LEFT OUTER JOIN
                                              t_Equips ON t_EquipFile.equip_code = t_Equips.equip_code
                        WHERE     (t_File.file_code LIKE '%" + fileCode + "%')  ";
        }
        if (fileCode == "" && equipCode != "")
        {
            mStrSQL = @"SELECT     t_File.file_code, t_File.file_name
                        FROM         t_Equips RIGHT OUTER JOIN
                                              t_EquipFile ON t_Equips.equip_code = t_EquipFile.equip_code LEFT OUTER JOIN
                                              t_File ON t_EquipFile.file_code = t_File.file_code
                        WHERE     (t_Equips.equip_code LIKE '%" + equipCode + "%')";
        }
        DataTable dt = null;
        using (dt = claSqlConnDB.ExecuteDataset(claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL).Tables[0])
        {
            if (dt.Rows.Count > 0)
            {
                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    combotree combotreeTemp = new combotree();
                    combotreeTemp.id = dt.Rows[i][0].ToString();
                    combotreeTemp.text = dt.Rows[i][1].ToString();
                    combotreeTemp.state = "open";
                    listCombo.Add(combotreeTemp);
                } 
            } 
        }
        return listCombo;
    }
    public bool IsReusable {
        get {
            return false;
        }
    }

}