<%@ WebHandler CodeBehind Language="C#" Class="equipHandler" %>

using System;
using System.Web;
using ModelClass;
using Newtonsoft.Json;
using NPE.UIDataClass;
using System.Data;
using System.Collections.Generic;
using System.Data.SqlClient;

public class equipHandler : IHttpHandler
{

    string sort = "";
    string order = "";

    int rows = 10;
    int page = 1;
    int type = 0;

    string equip_code = "";
    string equip_innum = "";
    string equip_name = "";
    string equip_mark = "";
    string equip_type = "";
    string equip_parent = "";
    string area_id = "";
    string equip_manageDep = "";
    string equip_checkDep = "";
    string equip_header = "";
    string equip_remark = "";

    int mIntParaNullable = 0;
    string mStrReturn = "";
    object mObjReturn = null;

    public void ProcessRequest(HttpContext context)
    {
        string action = "";
        context.Response.ContentType = "text/plain";
        if (context.Request.Params["equip_code"] != null)
        {
            equip_code = context.Request.Params["equip_code"];
        }
        if (context.Request.Params["equip_innum"] != null)
        {
            equip_innum = context.Request.Params["equip_innum"];
        }
        if (context.Request.Params["equip_name"] != null)
        {
            equip_name = context.Request.Params["equip_name"];
        }
        if (context.Request.Params["equip_mark"] != null)
        {
            equip_mark = context.Request.Params["equip_mark"];
        }
        if (context.Request.Params["equip_type"] != null)
        {
            equip_type = context.Request.Params["equip_type"];
        }
        if (context.Request.Params["equip_parent"] != null)
        {
            equip_parent = context.Request.Params["equip_parent"];
        }
        if (context.Request.Params["area_id"] != null)
        {
            area_id = context.Request.Params["area_id"];
        }
        if (context.Request.Params["equip_manageDep"] != null)
        {
            equip_manageDep = context.Request.Params["equip_manageDep"];
        }
        if (context.Request.Params["equip_checkDep"] != null)
        {
            equip_checkDep = context.Request.Params["equip_checkDep"];
        }
        if (context.Request.Params["equip_header"] != null)
        {
            equip_header = context.Request.Params["equip_header"];
        }
        if (context.Request.Params["equip_remark"] != null)
        {
            equip_remark = context.Request.Params["equip_remark"];
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
        if (context.Request.Params["type"] != null)
        {
            type = int.Parse(context.Request.Params["type"]);
        }
        if (context.Request.Params["action"] != null)
        {
            action = context.Request.Params["action"];
        }
        switch (action.ToLower())
        {
            case "add":
                string m_add_equip_name = "";
                if (context.Request.Params["equip_name"] != null)
                {
                    m_add_equip_name = context.Request.Params["equip_name"].ToString();
                }
                else
                {
                    mIntParaNullable = mIntParaNullable + 1;
                }
                string m_add_equip_innum = "";
                if (context.Request.Params["equip_innum"] != null)
                {
                    m_add_equip_innum = context.Request.Params["equip_innum"].ToString();
                }
                string m_add_equip_mark = "";
                if (context.Request.Params["equip_mark"] != null)
                {
                    m_add_equip_mark = context.Request.Params["equip_mark"].ToString();
                }
                string m_add_equip_type = "";
                if (context.Request.Params["equip_type"] != null)
                {
                    m_add_equip_type = context.Request.Params["equip_type"].ToString();
                }
                string m_add_equip_parent = "";
                if (context.Request.Params["equip_parent"] != null)
                {
                    m_add_equip_parent = context.Request.Params["equip_parent"].ToString();
                }
                int m_add_area_id = 0;
                if (context.Request.Params["area_id"] != null)
                {
                    if (int.TryParse(context.Request.Params["area_id"], out m_add_area_id) == false)
                    {
                        mIntParaNullable = mIntParaNullable + 1;
                    }
                }
                else
                {
                    mIntParaNullable = mIntParaNullable + 1;
                }
                int m_add_equip_manageDep = 0;
                if (context.Request.Params["equip_manageDep"] != null)
                {
                    if (int.TryParse(context.Request.Params["equip_manageDep"], out m_add_equip_manageDep) == false)
                    {
                        mIntParaNullable = mIntParaNullable + 1;
                    }
                }
                else
                {
                    mIntParaNullable = mIntParaNullable + 1;
                }
                int m_add_equip_checkDep = 0;
                if (context.Request.Params["equip_checkDep"] != null)
                {
                    if (int.TryParse(context.Request.Params["equip_checkDep"], out m_add_equip_checkDep) == false)
                    {
                        mIntParaNullable = mIntParaNullable + 1;
                    }
                }
                else
                {
                    mIntParaNullable = mIntParaNullable + 1;
                }
                string m_add_equip_header = "";
                if (context.Request.Params["equip_header"] != null)
                {
                    m_add_equip_header = context.Request.Params["equip_header"].ToString();
                }
                string m_add_equip_remark = "";
                if (context.Request.Params["equip_remark"] != null)
                {
                    m_add_equip_remark = context.Request.Params["equip_remark"].ToString();
                }
                if (mIntParaNullable == 0)
                {
                    mObjReturn = AddEquipData(m_add_equip_innum,m_add_equip_name,m_add_equip_mark,m_add_equip_type,m_add_equip_parent,m_add_area_id,m_add_equip_manageDep,m_add_equip_checkDep,m_add_equip_header,m_add_equip_remark);
                    if (mObjReturn.ToString() == "1")
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
                context.Response.Write(mStrReturn);
                break;
            case "edit":
                string m_edit_equip_code = "";
                if (context.Request.Params["equip_code"] != null)
                {
                    m_edit_equip_code = context.Request.Params["equip_code"].ToString();
                }
                else
                {
                    mIntParaNullable = mIntParaNullable + 1;
                }
                string m_edit_equip_name = "";
                if (context.Request.Params["equip_name"] != null)
                {
                    m_edit_equip_name = context.Request.Params["equip_name"].ToString();
                }
                else
                {
                    mIntParaNullable = mIntParaNullable + 1;
                }
                string m_edit_equip_innum = "";
                if (context.Request.Params["equip_innum"] != null)
                {
                    m_edit_equip_innum = context.Request.Params["equip_innum"].ToString();
                }
                string m_edit_equip_mark = "";
                if (context.Request.Params["equip_mark"] != null)
                {
                    m_edit_equip_mark = context.Request.Params["equip_mark"].ToString();
                }
                string m_edit_equip_type = "";
                if (context.Request.Params["equip_type"] != null)
                {
                    m_edit_equip_type = context.Request.Params["equip_type"].ToString();
                }
                string m_edit_equip_header = "";
                if (context.Request.Params["equip_header"] != null)
                {
                    m_edit_equip_header = context.Request.Params["equip_header"].ToString();
                }
                string m_edit_equip_remark = "";
                if (context.Request.Params["equip_remark"] != null)
                {
                    m_edit_equip_remark = context.Request.Params["equip_remark"].ToString();
                }
                if (mIntParaNullable == 0)
                {
                    mObjReturn = EditEquipData(m_edit_equip_code, m_edit_equip_name, m_edit_equip_innum, m_edit_equip_mark, m_edit_equip_type, m_edit_equip_header, m_edit_equip_remark);
                    if (mObjReturn.ToString() == "1")
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
                context.Response.Write(mStrReturn);
                break;
            case "del":
                string m_del_equip_code = "";
                if (context.Request.Params["equip_code"] != null)
                {
                    m_del_equip_code = context.Request.Params["equip_code"].ToString();
                }
                else
                {
                    mIntParaNullable = mIntParaNullable + 1;
                }
                if (mIntParaNullable == 0)
                {
                    mObjReturn = DelEquipData(m_del_equip_code);
                    if (mObjReturn.ToString() == "0")
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
                context.Response.Write(mStrReturn);
                break;
            case "grid":
                System.Text.StringBuilder sb = new System.Text.StringBuilder();
                sb.Append("{ ");
                sb.Append(string.Format("\"total\":{0},\"rows\":", GetEquipPageCount()));
                string s = ShowEquipGird();
                sb.Append(s);
                sb.Append("}");
                context.Response.Write(sb.ToString());
                break;
            case "tree":
                context.Response.Write(GetEquipTreeJson());
                break;
            case "combo":
                context.Response.Write(GetEquipComboJson());
                break;
            case "prop":
                string m_prop_equip_code = "";
                if (context.Request.Params["equip_code"] != null)
                {
                    m_prop_equip_code = context.Request.Params["equip_code"].ToString();
                }
                else
                {
                    mIntParaNullable = mIntParaNullable + 1; 
                }
                string m_prop_separa_char = ",";
                if (context.Request.Params["path_separa"] != null)
                {
                    m_prop_separa_char = context.Request.Params["path_separa"].ToString();
                }
                if (mIntParaNullable == 0)
                {
                    mStrReturn = GetProperty(m_prop_equip_code, m_prop_separa_char);
                }
                else
                {
                    mStrReturn = ""; 
                }
                context.Response.Write(mStrReturn);
                break;
            //case "detail":
            //    context.Response.Write(GetAreaDetail());
            //    break;
            default:

                break;
        }
    }
    private string GetProperty(string v_equip_code,string v_path_separa)
    {
        string mStrReturn = "";
        PropertyGrid property = new PropertyGrid();
        List<PropertyGridNode> propertyNode = new List<PropertyGridNode>();

        string lStrSql = @"SELECT     t_Equips.equip_code AS 设备编号, t_Equips.equip_innum AS 设备编码, t_Equips.equip_name AS 设备名称, t_Equips.equip_mark AS 设备符号, t_Equips.equip_type AS 设备型号, 
                                                  t_Equips_1.equip_name AS 上级设备名称, t_EquipArea.area_name AS 区域名称, tHRBranchInfo.dVchBranchName AS 管理部门, tHRBranchInfo_1.dVchBranchName AS 维护部门, 
                                                  t_Equips.equip_header AS 负责人,(SELECT path_name + @path_separa FROM f_get_equip_full_path(t_Equips.equip_code) order by path_type,path_level desc  FOR XML PATH('')) as 设备路径
                            FROM         t_EquipArea RIGHT OUTER JOIN
                                                  t_Equips LEFT OUTER JOIN
                                                  tHRBranchInfo AS tHRBranchInfo_1 ON t_Equips.equip_checkDep = tHRBranchInfo_1.dIntBranchID LEFT OUTER JOIN
                                                  tHRBranchInfo ON t_Equips.equip_manageDep = tHRBranchInfo.dIntBranchID ON t_EquipArea.area_id = t_Equips.area_id LEFT OUTER JOIN
                                                  t_Equips AS t_Equips_1 ON t_Equips.equip_parent = t_Equips_1.equip_code
                            WHERE     t_Equips.equip_code = @equip_code";
        SqlParameter[] parameters = new SqlParameter[]{
            new SqlParameter("@equip_code",SqlDbType.VarChar,30),
            new SqlParameter("@path_separa",SqlDbType.VarChar,10),
        };
        parameters[0].Value = v_equip_code;
        parameters[1].Value = v_path_separa;
        DataTable dt = null;
        using (dt = claSqlConnDB.ExecuteDataset(claSqlConnDB.gStrConnDefault, CommandType.Text, lStrSql,parameters).Tables[0])
        {
            property.total = dt.Columns.Count;
            for (int i = 0; i < dt.Columns.Count; i++)
            {
                PropertyGridNode propertytmp = new PropertyGridNode();
                propertytmp.name = dt.Columns[i].ColumnName;
                propertytmp.value = dt.Rows[0][i].ToString();
                propertytmp.group = "设备";
                propertytmp.editor = "text";
                propertyNode.Add(propertytmp);
            }
            property.rows = propertyNode;
        }
        return mStrReturn = JsonConvert.SerializeObject(property);

    }
    private string GetProperty()
    {
        string mStrReturn = "";
        PropertyGrid property = new PropertyGrid();
        List<PropertyGridNode> propertyNode = new List<PropertyGridNode>();

        string lStrSql = @"SELECT     t_Equips.equip_code AS 设备编号, t_Equips.equip_innum AS 设备编码, t_Equips.equip_name AS 设备名称, t_Equips.equip_mark AS 设备符号, t_Equips.equip_type AS 设备型号, 
                                                  t_Equips_1.equip_name AS 上级设备名称, t_EquipArea.area_name AS 区域名称, tHRBranchInfo.dVchBranchName AS 管理部门, tHRBranchInfo_1.dVchBranchName AS 维护部门, 
                                                  t_Equips.equip_header AS 负责人,(SELECT path_name+',' FROM f_get_equip_full_path(t_Equips.equip_code) order by path_type,path_level desc  FOR XML PATH('')) as 设备路径
                            FROM         t_EquipArea RIGHT OUTER JOIN
                                                  t_Equips LEFT OUTER JOIN
                                                  tHRBranchInfo AS tHRBranchInfo_1 ON t_Equips.equip_checkDep = tHRBranchInfo_1.dIntBranchID LEFT OUTER JOIN
                                                  tHRBranchInfo ON t_Equips.equip_manageDep = tHRBranchInfo.dIntBranchID ON t_EquipArea.area_id = t_Equips.area_id LEFT OUTER JOIN
                                                  t_Equips AS t_Equips_1 ON t_Equips.equip_parent = t_Equips_1.equip_code
                            WHERE     t_Equips.equip_code = '" + equip_code + "'";
        DataTable dt = null;
        using (dt = claSqlConnDB.ExecuteDataset(claSqlConnDB.gStrConnDefault, CommandType.Text, lStrSql).Tables[0])
        {
            property.total = dt.Columns.Count;
            for (int i = 0; i < dt.Columns.Count; i++)
            {
                PropertyGridNode propertytmp = new PropertyGridNode();
                propertytmp.name = dt.Columns[i].ColumnName;
                propertytmp.value = dt.Rows[0][i].ToString();
                propertytmp.group = "设备";
                propertytmp.editor = "text";
                propertyNode.Add(propertytmp);
            }
            property.rows = propertyNode;
        }
        return mStrReturn = JsonConvert.SerializeObject(property);

    }
    private string GetEquipTreeJson()
    {
        string mStrReturn = "";
        mStrReturn = JsonConvert.SerializeObject(GetEquipTree(equip_parent, area_id));
        return mStrReturn;
    }
    private List<TreeNode> GetEquipTree(string equipParent, string areaID)
    {
        List<TreeNode> listTree = new List<TreeNode>();
        DataTable dt = null;
        string mStrWhere = "";
        string mStrEquipFileLink = "";
        string mStrFileClassCode = "PCZLLX999999000001";
        if (equipParent == "")
        {
            mStrWhere = "where equip_parent='' and area_id=" + areaID;
        }
        else
        {
            mStrWhere = "where equip_parent='" + equipParent + "'";
        }
        string mStrSQL = " SELECT  equip_code, equip_name,connect_prop from t_Equips " + mStrWhere;// +" order by equip_name";

        using (dt = claSqlConnDB.ExecuteDataset(claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL).Tables[0])
        {
            if (dt.Rows.Count > 0)
            {
                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    TreeNode treeTemp = new TreeNode();
                    treeTemp.id = dt.Rows[i][0].ToString();
                    mStrEquipFileLink = "";

                    //int mIntEquipFileNum=GetEquipFileNum(mStrFileClassCode, dt.Rows[i][0].ToString());
                    //if (mIntEquipFileNum > 0)
                    //{
                    //    mStrEquipFileLink = @"<img src='../../img/16/add.png' style='width:12px;height:12px;vertical-align: middle;' /><sup style='color:red'>" + mIntEquipFileNum + "</sup>";
                    //}
                    mStrEquipFileLink = SplitConnectPropData(dt.Rows[i][2].ToString());
                    treeTemp.text = dt.Rows[i][1].ToString() + mStrEquipFileLink;
                    if (GetEquipTreeNum(dt.Rows[i][0].ToString()) > 0)
                    {
                        treeTemp.state = "closed";
                        treeTemp.attributes = "equip";
                    }
                    else
                    {
                        treeTemp.state = "open";
                        treeTemp.attributes = "lastEquip";
                    }
                    treeTemp.iconCls = "icon-equip";
                    //treeTemp.children = GetAreaTree(dt.Rows[i][0].ToString());
                    listTree.Add(treeTemp);
                }
            }
        }
        return listTree;
    }

    private string SplitConnectPropData(string vStrConnectPropData)
    {
        string mStrReturn = "";
        string[] mStrConnectProp = vStrConnectPropData.Split('|');
        for (int i = 0; i < mStrConnectProp.Length; i++)
        {
            if (mStrConnectProp[i].Length > 0)
            {
                int mIntNumStart = mStrConnectProp[i].IndexOf('-');
                if (mIntNumStart >= 0)
                {
                    string mStrConnectPropName = mStrConnectProp[i].Substring(0, mIntNumStart);
                    string mStrNum = mStrConnectProp[i].Substring(mIntNumStart + 1, mStrConnectProp[i].Length - mIntNumStart - 1);
                    if (mStrNum != "0")
                    {
                        mStrReturn = mStrReturn + "<img src='../../img/16/" + mStrConnectPropName + ".png' style='width:12px;height:12px;vertical-align: middle;' /><sup style='color:red'>" + mStrNum + "</sup>";
                    }
                }
            }
        }
        return mStrReturn;
    }

    private int GetEquipFileNum(string vStrFileClassCode, string vStrEquipCode)
    {
        string mStrSQL = @" SELECT COUNT(0)   
                        FROM         t_File RIGHT OUTER JOIN  t_EquipFile ON t_File.file_code = t_EquipFile.file_code
                        WHERE t_EquipFile.equip_code='" + vStrEquipCode
                                                        + "' and t_File.fileclass_code ='" + vStrFileClassCode + "'";
        int i = claSqlConnDB.GetRecordCount(claSqlConnDB.gStrConnDefault, mStrSQL);
        return i;
    }

    private string GetEquipPageCount()
    {
        string mStrSQL = @" select count(0) from t_Equips " + GetWhere();
        int i = claSqlConnDB.GetRecordCount(claSqlConnDB.gStrConnDefault, mStrSQL);
        return i.ToString();
    }
    private int AddEquipData(string v_equip_innum, string v_equip_name, string v_equip_mark, string v_equip_type, string v_equip_parent,
        int v_area_id, int v_equip_manageDep, int v_equip_checkDep, string v_equip_header, string v_equip_remark)
    {
        global mGlobal = new global();
        equip_code = mGlobal.GetIdentityID("PC", "SB", "SY", System.DateTime.Now, 6);
        string mStrSQL = @" insert into t_Equips  (equip_code,equip_innum,equip_name,equip_mark,equip_type,equip_parent,area_id,equip_manageDep,
                            equip_checkDep,equip_header,equip_remark) 
                            VALUES(@equip_code,@equip_innum,@equip_name,@equip_mark,@equip_type,@equip_parent,@area_id,@equip_manageDep,
                            @equip_checkDep,@equip_header,@equip_remark)";
        SqlParameter[] parameters = new SqlParameter[]{
            new SqlParameter("@equip_code",SqlDbType.VarChar,30),
            new SqlParameter("@equip_innum",SqlDbType.VarChar,30),
            new SqlParameter("@equip_name",SqlDbType.VarChar,50),
            new SqlParameter("@equip_mark",SqlDbType.VarChar,20),
            new SqlParameter("@equip_type",SqlDbType.VarChar,100),
            new SqlParameter("@equip_parent",SqlDbType.VarChar,30),
            new SqlParameter("@area_id",SqlDbType.Int,4),
            new SqlParameter("@equip_manageDep",SqlDbType.Int,4),
            new SqlParameter("@equip_checkDep",SqlDbType.Int,4),
            new SqlParameter("@equip_header",SqlDbType.VarChar,20),
            new SqlParameter("@equip_remark",SqlDbType.VarChar,100),
        };
        parameters[0].Value = equip_code;
        parameters[1].Value = v_equip_innum;
        parameters[2].Value = v_equip_name;
        parameters[3].Value = v_equip_mark;
        parameters[4].Value = v_equip_type;
        parameters[5].Value = v_equip_parent;
        parameters[6].Value = v_area_id;
        parameters[7].Value = v_equip_manageDep;
        parameters[8].Value = v_equip_checkDep;
        parameters[9].Value = v_equip_header;
        parameters[10].Value = v_equip_remark;
        int i = claSqlConnDB.ExecuteNonQuery(claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL, parameters);
        return i;
    }

    private int EditEquipData(string v_equip_code, string v_equip_name, string v_equip_innum, string v_equip_mark, string v_equip_type, string v_equip_header, string v_equip_remark)
    {
        string mStrSQL = @" UPDATE  t_Equips SET 
                            equip_innum=@equip_innum,
                            equip_name=@equip_name,
                            equip_mark=@equip_mark,
                            equip_type=@equip_type,
                            equip_header=@equip_header,
                            equip_remark=@equip_remark
                      where equip_code=@equip_code";
        SqlParameter[] parameters = new SqlParameter[]{
            new SqlParameter("@equip_code",SqlDbType.VarChar,30),
            new SqlParameter("@equip_innum",SqlDbType.VarChar,30),
            new SqlParameter("@equip_name",SqlDbType.VarChar,50),
            new SqlParameter("@equip_mark",SqlDbType.VarChar,20),
            new SqlParameter("@equip_type",SqlDbType.VarChar,100),
            new SqlParameter("@equip_header",SqlDbType.VarChar,20),
            new SqlParameter("@equip_remark",SqlDbType.VarChar,100),
        };
        parameters[0].Value = v_equip_code;
        parameters[1].Value = v_equip_innum;
        parameters[2].Value = v_equip_name;
        parameters[3].Value = v_equip_mark;
        parameters[4].Value = v_equip_type;
        parameters[5].Value = v_equip_header;
        parameters[6].Value = v_equip_remark;
        int i = claSqlConnDB.ExecuteNonQuery(claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL, parameters);
        return i;
    }
    private int DelEquipData(string v_equip_code)
    {
        //string mStrSQL = @"delete from t_Equips where equip_code=@equip_code"; 
        SqlParameter[] parameters = new SqlParameter[]{
            new SqlParameter("@viVchEquipCode",SqlDbType.VarChar,30),
            new SqlParameter("@voIntReturn",SqlDbType.Int,4),
        };
        parameters[0].Value = v_equip_code;
        parameters[1].Direction = System.Data.ParameterDirection.Output;
        claSqlConnDB.ExecuteNonQuery(claSqlConnDB.gStrConnDefault, CommandType.StoredProcedure, "p_del_equip", parameters);
        int i = (int)parameters[1].Value;
        return i;
    }
    private string ShowEquipGird()
    {
        string mStrReturn = "";
        List<equip> listEquip = new List<equip>();
        DataTable dt = null;
        string mStrSQL = @"SELECT     t_Equips.equip_code, t_Equips.equip_innum, t_Equips.equip_name, t_Equips.equip_mark, t_Equips.equip_type, t_Equips.equip_parent, t_Equips_1.equip_name AS equip_parent_name, 
                              t_Equips.area_id, t_EquipArea.area_name, t_Equips.equip_manageDep, tHRBranchInfo.dVchBranchName AS equip_manage_name, tHRBranchInfo.dIntCompanyID AS equip_manage_company, 
                              tHRCompany.dVchCompanyName AS equip_manage_company_name, t_Equips.equip_checkDep, tHRBranchInfo_1.dVchBranchName AS equip_checkDep_name, 
                              tHRBranchInfo_1.dIntCompanyID AS equip_check_company, tHRCompany_1.dVchCompanyName AS equip_check_company_name, t_Equips.equip_header, t_Equips.equip_remark
                            FROM         t_EquipArea RIGHT OUTER JOIN
                              t_Equips LEFT OUTER JOIN
                              t_Equips AS t_Equips_1 ON t_Equips.equip_parent = t_Equips_1.equip_code ON t_EquipArea.area_id = t_Equips.area_id LEFT OUTER JOIN
                              tHRCompany AS tHRCompany_1 RIGHT OUTER JOIN
                              tHRBranchInfo AS tHRBranchInfo_1 ON tHRCompany_1.dIntCompanyID = tHRBranchInfo_1.dIntCompanyID ON t_Equips.equip_checkDep = tHRBranchInfo_1.dIntBranchID LEFT OUTER JOIN
                              tHRCompany RIGHT OUTER JOIN
                              tHRBranchInfo ON tHRCompany.dIntCompanyID = tHRBranchInfo.dIntCompanyID ON t_Equips.equip_manageDep = tHRBranchInfo.dIntBranchID "
                    + GetWhere() + GetOrder();
        using (dt = claSqlConnDB.ExecuteDataset(rows, page, claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL).Tables[0])
        {
            if (dt.Rows.Count > 0)
            {
                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    equip equipTemp = new equip();
                    if (dt.Rows[i][0] != null)
                    {
                        equipTemp.equip_code = dt.Rows[i][0].ToString();
                    }
                    if (dt.Rows[i][1] != null)
                    {
                        equipTemp.equip_innum = dt.Rows[i][1].ToString();
                    }
                    if (dt.Rows[i][2] != null)
                    {
                        equipTemp.equip_name = dt.Rows[i][2].ToString();
                    }
                    if (dt.Rows[i][3] != null)
                    {
                        equipTemp.equip_mark = dt.Rows[i][3].ToString();
                    }
                    if (dt.Rows[i][4] != null)
                    {
                        equipTemp.equip_type = dt.Rows[i][4].ToString();
                    }
                    if (dt.Rows[i][5] != null)
                    {
                        equipTemp.equip_parent = dt.Rows[i][5].ToString();
                    }
                    if (dt.Rows[i][6] != null)
                    {
                        equipTemp.equip_parent_name = dt.Rows[i][6].ToString();
                    }
                    if (dt.Rows[i][7] != null)
                    {
                        equipTemp.area_id = dt.Rows[i][7].ToString();
                    }
                    if (dt.Rows[i][8] != null)
                    {
                        equipTemp.area_name = dt.Rows[i][8].ToString();
                    }
                    if (dt.Rows[i][9] != null)
                    {
                        equipTemp.equip_manageDep = dt.Rows[i][9].ToString();
                    }
                    if (dt.Rows[i][10] != null)
                    {
                        equipTemp.equip_manageDep_name = dt.Rows[i][10].ToString();
                    }
                    if (dt.Rows[i][11] != null)
                    {
                        equipTemp.equip_manage_company = dt.Rows[i][11].ToString();
                    }
                    if (dt.Rows[i][12] != null)
                    {
                        equipTemp.equip_manage_company_name = dt.Rows[i][12].ToString();
                    }
                    if (dt.Rows[i][13] != null)
                    {
                        equipTemp.equip_checkDep = dt.Rows[i][13].ToString();
                    }
                    if (dt.Rows[i][14] != null)
                    {
                        equipTemp.equip_checkDep_name = dt.Rows[i][14].ToString();
                    }
                    if (dt.Rows[i][15] != null)
                    {
                        equipTemp.equip_check_company = dt.Rows[i][15].ToString();
                    }
                    if (dt.Rows[i][16] != null)
                    {
                        equipTemp.equip_check_company_name = dt.Rows[i][16].ToString();
                    }
                    if (dt.Rows[i][17] != null)
                    {
                        equipTemp.equip_header = dt.Rows[i][17].ToString();
                    }
                    if (dt.Rows[i][18] != null)
                    {
                        equipTemp.equip_remark = dt.Rows[i][18].ToString();
                    }
                    listEquip.Add(equipTemp);
                }
            }
            mStrReturn = JsonConvert.SerializeObject(listEquip);
        }

        return mStrReturn;
    }
    private string GetEquipComboJson()
    {
        string mStrReturn = "";
        mStrReturn = JsonConvert.SerializeObject(GetEquipCombo(equip_parent, area_id, type));
        return mStrReturn;
    }
    private List<combotree> GetEquipCombo(string equipParent, string vStrAreaID, int v_type)
    {
        List<combotree> listCombo = new List<combotree>();
        DataTable dt = null;
        string lStrSQL = "select equip_code,equip_name from t_Equips where equip_parent ='" + equipParent + "' and area_id=" + vStrAreaID;
        using (dt = claSqlConnDB.ExecuteDataset(claSqlConnDB.gStrConnDefault, System.Data.CommandType.Text, lStrSQL).Tables[0])
        {
            if (dt.Rows.Count > 0)
            {
                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    combotree comboNodetmp = new combotree();
                    comboNodetmp.id = dt.Rows[i][0].ToString();
                    comboNodetmp.text = dt.Rows[i][1].ToString();
                    if (v_type != 1)
                    {
                        if (GetEquipTreeNum(dt.Rows[i][0].ToString()) > 0)
                        {
                            comboNodetmp.state = "closed";
                            comboNodetmp.attributes = "equip";
                        }
                        else
                        {
                            comboNodetmp.state = "open";
                            comboNodetmp.attributes = "lastequip";
                        }
                    }
                    else
                    {
                        comboNodetmp.state = "open";
                        comboNodetmp.attributes = "topequip";
                    }
                    //comboNodetmp.children = GetAreaCombo(dt.Rows[i][0].ToString());
                    listCombo.Add(comboNodetmp);
                }
            }
        }
        return listCombo;
    }
    private int GetEquipTreeNum(string equipParent)
    {
        string mStrSQL = " select count(0) from t_Equips where equip_parent ='" + equipParent + "'";
        int i = claSqlConnDB.GetRecordCount(claSqlConnDB.gStrConnDefault, mStrSQL);
        return i;
    }
    private string GetWhere()
    {
        string mStrWhere = "";
        if (equip_code != "")
        {
            if (mStrWhere != "")
            {
                mStrWhere = mStrWhere + " and t_Equips.equip_code ='" + equip_code + "'";
            }
            else
            {
                mStrWhere = " where t_Equips.equip_code ='" + equip_code + "'";
            }
        }
        if (equip_innum != "")
        {
            if (mStrWhere != "")
            {
                mStrWhere = mStrWhere + " and t_Equips.equip_innum like '%" + equip_innum + "%'";
            }
            else
            {
                mStrWhere = " where t_Equips.equip_innum like '%" + equip_innum + "%'";
            }
        }
        if (equip_name != "")
        {
            if (mStrWhere != "")
            {
                mStrWhere = mStrWhere + " and t_Equips.equip_name like '%" + equip_name + "%'";
            }
            else
            {
                mStrWhere = " where t_Equips.equip_name like '%" + equip_name + "%'";
            }
        }
        return mStrWhere;
    }
    private string GetOrder()
    {
        string mStrOrder = "";
        if (sort != "")
        {
            mStrOrder = " order by " + sort;
            if (order != "")
            {
                mStrOrder = mStrOrder + " " + order;
            }
        }
        return mStrOrder;
    }
    public bool IsReusable
    {
        get
        {
            return false;
        }
    }

}