<%@ WebHandler Language="C#" Class="fileHandler" %>

using System;
using System.Web;
using ModelClass;
using Newtonsoft.Json;
using NPE.UIDataClass;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Generic;

public class fileHandler : IHttpHandler {

    string sort = "";
    string order = "";

    int rows = 10;
    int page = 1;


    string file_code = "";
    string file_name = "";
    string file_innum = "";
    string file_type = "";
    string fileclass_code = "";
    string file_size = "";
    string file_data_flag = "1";
    string file_address = "";
    byte[] file_context = null;
    string file_time = "";
    string file_people = "";
    string file_remark = "";
    string file_sort = "";
    string diretory_code = "";

    public void ProcessRequest(HttpContext context)
    {
        string action = "";
        context.Response.ContentType = "text/plain";
        HttpPostedFile file = null;
        if (context.Request.Params["diretory_code"] != null)
        {
            diretory_code = context.Request.Params["diretory_code"];
        }
        if (context.Request.Params["file_code"] != null)
        {
            file_code = context.Request.Params["file_code"];
        }
        if (context.Request.Params["file_name"] != null)
        {
            file_name = context.Request.Params["file_name"];
        }
        if (context.Request.Params["file_innum"] != null)
        {
            file_innum = context.Request.Params["file_innum"];
        }
        if (context.Request.Params["file_type"] != null)
        {
            file_type = context.Request.Params["file_type"];
        }
        if (context.Request.Params["fileclass_code"] != null)
        {
            fileclass_code = context.Request.Params["fileclass_code"];
        }
        if (context.Request.Params["file_data_flag"] != null)
        {
            file_data_flag = context.Request.Params["file_data_flag"];
        }
        if (context.Request.Params["file_address"] != null)
        {
            file_address = context.Request.Params["file_address"];
        }
        if (context.Request.Params["file_time"] != null)
        {
            file_time = context.Request.Params["file_time"];
        }
        if (context.Request.Params["file_people"] != null)
        {
            file_people = context.Request.Params["file_people"];
        }
        if (context.Request.Params["file_remark"] != null)
        {
            file_remark = context.Request.Params["file_remark"];
        }
        if (context.Request.Params["file_sort"] != null)
        {
            file_sort = context.Request.Params["file_sort"];
        }
        HttpFileCollection httpFileCollection = context.Request.Files;
        if (httpFileCollection.Count > 0)
        {
            file = httpFileCollection[0]; 
        }
        if (file != null)
        {
            //file_name = file.FileName;
            file_name=file.FileName.Substring(file.FileName.LastIndexOf("\\") + 1);
            file_size = file.ContentLength.ToString();
            file_type = file.ContentType.ToString();
            file_context=new byte[file.ContentLength];
            file_time = System.DateTime.Now.ToString(); 
            file.InputStream.Read(file_context, 0, file.ContentLength);
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
                context.Response.Write(addFile());
                break;
            case "edit":

                break;
            case "del":
                context.Response.Write(delFile());
                break;
            case "grid":
                System.Text.StringBuilder sb = new System.Text.StringBuilder();
                sb.Append("{ ");
                sb.Append(string.Format("\"total\":{0},\"rows\":", GetFilePageCount()));
                string s = ShowFileGird();
                sb.Append(s);
                sb.Append("}");
                context.Response.Write(sb.ToString());
                break;
            case "tree":
                context.Response.Write(GetFileTreeJson());
                break;
            case "combo":
                context.Response.Write(GetFileComboJson());
                break;
            case "prop":
                context.Response.Write(GetProperty());
                break;
            //case "detail":
            //    context.Response.Write(GetAreaDetail());
            //    break;
            case "out":
                byte[] datas = getFileContext(file_code);
                context.Response.OutputStream.Write(datas, 0, datas.Length);
                break;
            case "info":
                if (file_code != "")
                {
                    context.Response.Write(getFileDatas(file_code));
                }
                else
                {
                    context.Response.Write(errorOut("文件编码不能为空"));
                }
                break;
            case "download":
                file mFile = getFile(file_code);
                context.Response.ClearContent();
                context.Response.ContentType = "application/octet-stream";
                context.Response.AddHeader("Content-Disposition", "attachment;filename=" + mFile.file_name.ToString());
                context.Response.OutputStream.Write(mFile.file_context, 0, mFile.file_context.Length);
                context.Response.OutputStream.Flush();
                context.Response.OutputStream.Close();
                context.Response.Flush();
                context.Response.End();  
                break;
            case "replace":
                context.Response.Write(ReplaceFile());
                break;
            case "sort":
                context.Response.Write(SortFile(file_code, file_sort).ToString());
                break;
            default:

                break;
        }
    }
    private int SortFile(string fileCode, string fileSort)
    {
        int mIntReturn = 0;
        int mIntSortNum = 0;
        if ((int.TryParse(fileSort, out mIntSortNum) == false) || fileCode == "")
        {
            mIntReturn = -1;
        }
        else
        {
            string mStrSQL = @"update t_File  set file_sort=" + fileSort +
                                " WHERE file_code='" + fileCode + "'";
            mIntReturn = claSqlConnDB.ExecuteNonQuery(claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL);
        }
        return mIntReturn;
    }
    private string ReplaceFile() 
    {
        string mStrSQL = @"UPDATE t_File  set  file_context=@fileContext where file_code='" + file_code + "'";
        SqlParameter[] lOlcParameter = new SqlParameter[1] 
                {
                    new SqlParameter("@fileContext", SqlDbType.Image),
                };
        lOlcParameter[0].Value = file_context;
        int i = claSqlConnDB.ExecuteNonQuery(claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL,lOlcParameter);
        return i.ToString();
    }
    
    private file getFile(string fileCode)
    {
        file mFile = new file();
        string mStrSQL = @"SELECT   file_context,file_name FROM t_File
                                WHERE     (t_File.file_code='" + fileCode + "')";
        DataTable dt = null;
        using (dt = claSqlConnDB.ExecuteDataset(claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL).Tables[0])
        {
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                mFile.file_context = (byte[])dt.Rows[i][0];
                mFile.file_name = dt.Rows[i][1].ToString();
            }
        }
        return mFile;
    }
    private string getFileDatas(string fileCode)
    {
        file mFile = new file();
        string mStrSQL = @"SELECT   file_code,file_name,file_innum,file_type,fileclass_code,file_size,file_data_flag,file_address,
                            file_time,file_people,file_remark FROM t_File
                                WHERE     (t_File.file_code='" + fileCode + "')";
        DataTable dt = null;
        using (dt = claSqlConnDB.ExecuteDataset(claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL).Tables[0])
        {
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                mFile.file_code = dt.Rows[i][0].ToString();
                mFile.file_name = dt.Rows[i][1].ToString();
                mFile.file_innum = dt.Rows[i][2].ToString();
                mFile.file_type = dt.Rows[i][3].ToString();
                mFile.fileclass_code = dt.Rows[i][4].ToString();
                mFile.file_size = dt.Rows[i][5].ToString();
                mFile.file_data_flag = dt.Rows[i][6].ToString();
                mFile.file_address = dt.Rows[i][7].ToString();
                mFile.file_time = dt.Rows[i][8].ToString();
                mFile.file_people = dt.Rows[i][9].ToString();
                mFile.file_remark = dt.Rows[i][10].ToString();
            }
        }
        return JsonConvert.SerializeObject(mFile);
    }
    
    private byte[] getFileContext(string fileCode)
    {
         byte[] mData=null;
         
         string mStrSQL = @"SELECT  file_context FROM t_File
                                WHERE     (t_File.file_code='" + fileCode + "')";
         DataTable dt = null;
         using (dt = claSqlConnDB.ExecuteDataset(claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL).Tables[0])
         {
             for (int i = 0; i < dt.Rows.Count; i++)
             {
                 //byte d = byte.Parse(dt.Rows[i][11].ToString());
                 mData = (byte[])dt.Rows[i][0];
             }
         }
         return mData;
    }
    
    private string GetProperty()
    {
        string mStrReturn = "";
        PropertyGrid property = new PropertyGrid();
        List<PropertyGridNode> propertyNode = new List<PropertyGridNode>();

        string lStrSql = @"SELECT     t_File.file_code AS 资料编号, t_File.file_name AS 资料名称, t_File.file_innum AS 资料编码, t_File.file_type AS 文件类型, t_File.file_size AS 文件大小, t_File.file_time AS 创建时间, 
                                t_File.file_people AS 上传人, t_File.file_remark AS 备注, t_FileClass_1.fileclass_name AS 资料类型名称,t_File.file_sort as  显示排序
                            FROM         t_File LEFT OUTER JOIN
                                t_FileClass AS t_FileClass_1 ON t_File.fileclass_code = t_FileClass_1.fileclass_code 
                            WHERE t_File.file_code ='" + file_code + "'";
        DataTable dt = null;
        using (dt = claSqlConnDB.ExecuteDataset(claSqlConnDB.gStrConnDefault, CommandType.Text, lStrSql).Tables[0])
        {
            property.total = dt.Columns.Count;
            for (int i = 0; i < dt.Columns.Count; i++)
            {
                PropertyGridNode propertytmp = new PropertyGridNode();
                propertytmp.name = dt.Columns[i].ColumnName;
                propertytmp.value = dt.Rows[0][i].ToString();
                propertytmp.group = "资料";
                if (i == dt.Columns.Count - 1)
                {
                    propertytmp.editor = "text";
                }
                propertyNode.Add(propertytmp);
            }
            property.rows = propertyNode;
        }
        return mStrReturn = JsonConvert.SerializeObject(property);

    }
    private string GetFileTreeJson()
    {
        string mStrReturn = "";
        mStrReturn = JsonConvert.SerializeObject(GetFileTree(fileclass_code, diretory_code));
        return mStrReturn;
    }
    private List<TreeNode> GetFileTree(string fileclassCode, string diretoryCode)
    {
        List<TreeNode> listTree = new List<TreeNode>();
        DataTable dt = null;
        string mStrSQL = @"select t_File.file_code,t_File.file_name from t_File right outer join t_FileDiretory 
                            on t_FileDiretory.file_code=t_File.file_code where t_FileDiretory.diretory_code ='" + diretoryCode
                            + "' and t_File.fileclass_code='" + fileclassCode + "' order by t_File.file_sort ";
        using (dt = claSqlConnDB.ExecuteDataset(claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL).Tables[0])
        {
            if (dt.Rows.Count > 0)
            {
                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    TreeNode treeTemp = new TreeNode();
                    treeTemp.id = dt.Rows[i][0].ToString();
                    treeTemp.text = dt.Rows[i][1].ToString();
                    treeTemp.attributes = "file";
                    listTree.Add(treeTemp);
                }
            }
        }
        return listTree;
    }
    private string GetFilePageCount()
    {
        string mStrSQL = @" select count(0) from t_File " + GetWhere();
        int i = claSqlConnDB.GetRecordCount(claSqlConnDB.gStrConnDefault, mStrSQL);
        return i.ToString();
    }
    private string addFile()
    {
        global mGlobal = new global();
        file_code = mGlobal.GetIdentityID("PC", "ZL", "WJ", System.DateTime.Now, 6);
        string mStrSQL = @"insert into t_File(file_code,file_name,file_innum,file_type,fileclass_code,file_size,file_data_flag,file_address,
                            file_context,file_time,file_people,file_remark) values(
                        '" + file_code + "','" + file_name + "','" + file_innum + "','" + file_type + "','" + fileclass_code + "','" + file_size + "'," + file_data_flag + ",'" + file_address
                           + "',@fileContext,'" + file_time + "','" + file_people + "','" + file_remark + "')";
        SqlParameter[] lOlcParameter = new SqlParameter[1] 
                {
                    new SqlParameter("@fileContext", SqlDbType.Image),
                };
        lOlcParameter[0].Value = file_context;
        int i = claSqlConnDB.ExecuteNonQuery(claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL,lOlcParameter);
        if (i >= 0)
        {
            string filediretory_code = mGlobal.GetIdentityID("PC", "ZL", "FD", System.DateTime.Now, 6);
            mStrSQL = @"insert into t_FileDiretory(filediretory_code,file_code,diretory_code,filediretory_show_number) values 
                      ('" + filediretory_code + "','" + file_code + "','" + diretory_code + "',0)";
            i = claSqlConnDB.ExecuteNonQuery(claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL, null);
        }

        return file_code;
    }
    private string delFile()
    {
        string mStrSQL = @"delete from t_File where file_code='" + file_code + "'";
        int i = claSqlConnDB.ExecuteNonQuery(claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL);

        return i.ToString();
    }
    private string ShowFileGird()
    {
        string mStrReturn = "";
        List<file> listFile = new List<file>();
        DataTable dt = null;
        string mStrSQL = @"SELECT     t_File.file_code, t_File.file_name, t_File.file_innum, t_File.file_type, t_File.fileclass_code, t_FileClass.fileclass_name, t_Diretory.diretory_code,
                                      t_Diretory.diretory_name, t_File.file_size, t_File.file_data_flag, 
                                      t_File.file_address, t_File.file_time, t_File.file_people, t_File.file_remark
                         FROM         t_Diretory RIGHT OUTER JOIN
                                      t_FileDiretory ON t_Diretory.diretory_code = t_FileDiretory.diretory_code RIGHT OUTER JOIN
                                      t_File LEFT OUTER JOIN
                                      t_FileClass ON t_File.fileclass_code = t_FileClass.fileclass_code ON t_FileDiretory.file_code = t_File.file_code " + GetWhere() + GetOrder();
        using (dt = claSqlConnDB.ExecuteDataset(rows, page, claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL).Tables[0])
        {
            if (dt.Rows.Count > 0)
            {
                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    file fileTemp = new file();
                    fileTemp.file_code = dt.Rows[i][0].ToString();
                    fileTemp.file_name = dt.Rows[i][1].ToString();
                    fileTemp.file_innum = dt.Rows[i][2].ToString();
                    fileTemp.file_type = dt.Rows[i][3].ToString();
                    fileTemp.fileclass_code = dt.Rows[i][4].ToString();
                    fileTemp.fileclass_name = dt.Rows[i][5].ToString();
                    fileTemp.diretory_code = dt.Rows[i][6].ToString();
                    fileTemp.diretory_name = dt.Rows[i][7].ToString();
                    fileTemp.file_size = dt.Rows[i][8].ToString();
                    fileTemp.file_data_flag = dt.Rows[i][9].ToString();
                    fileTemp.file_address = dt.Rows[i][10].ToString();
                    fileTemp.file_time = dt.Rows[i][11].ToString();
                    fileTemp.file_people = dt.Rows[i][12].ToString();
                    fileTemp.file_remark = dt.Rows[i][13].ToString();
                    listFile.Add(fileTemp);
                }
            }
            mStrReturn = JsonConvert.SerializeObject(listFile);
        }

        return mStrReturn;
    }
    private string GetFileComboJson()
    {
        string mStrReturn = "";
        mStrReturn = JsonConvert.SerializeObject(GetFileCombo( diretory_code));
        return mStrReturn;
    }
    private List<combotree> GetFileCombo(string diretoryCode)
    {
        List<combotree> listCombo = new List<combotree>();
        DataTable dt = null;
        string lStrSQL = @"select t_File.file_code,t_File.file_name from t_File right outer join t_FileDiretory 
                            on t_FileDiretory.file_code=t_File.file_code where t_FileDiretory.diretory_code ='" + diretoryCode
                            + "' ";
        using (dt = claSqlConnDB.ExecuteDataset(claSqlConnDB.gStrConnDefault, System.Data.CommandType.Text, lStrSQL).Tables[0])
        {
            if (dt.Rows.Count > 0)
            {
                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    combotree comboNodetmp = new combotree();
                    comboNodetmp.id = dt.Rows[i][0].ToString();
                    comboNodetmp.text = dt.Rows[i][1].ToString();
                    comboNodetmp.state = "open";
                    
                    listCombo.Add(comboNodetmp);
                }
            }
        }
        return listCombo;
    }
    
    
    private string GetWhere()
    {
        string mStrWhere = " where 1=1 ";
        if (file_code != "")
        {
            mStrWhere += " and t_File.file_code = '" + file_code + "'";
        }
        if (file_name != "")
        {
            mStrWhere += " and t_File.file_name like '%" + file_name + "%'"; 
        }
	if (file_type != "")
        {
            mStrWhere += " and t_File.file_type like '%" + file_type + "%'";
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
    private string errorOut(string vStrErrMessage)
    {
        System.Text.StringBuilder sb = new System.Text.StringBuilder();
        sb.Append("{ ");
        sb.Append(string.Format("\"msg\":\"error\",\"info\":{0}", vStrErrMessage));
        sb.Append("}");
        return sb.ToString();
    }
    public bool IsReusable
    {
        get
        {
            return false;
        }
    }

}