<%@ WebHandler Language="C#" Class="rwdHandle" %>

using System;
using System.Web;
using System.Data.SqlClient;
using System.Data;
using ModelClass;
using Newtonsoft.Json;
using System.Collections.Generic;

public class rwdHandle : IHttpHandler {

    int rows = 10;
    int page = 1;
    
    string type = "";
    string RwCreatUnit = "";
    string RwCreatPeo = "";
    string RwStart = "";
    string RecBranch = "";
    string RecEmployee = "";
    string RecTime = "";
    string Area = "";
    string RwContent = "";
    string OthersEquip = "";
    string SetEnd = "";
    string rwdNote = "";
    string qzName = "";
    
    public void ProcessRequest(HttpContext context)
    {
        context.Response.ContentType = "text/plain";
        type = context.Request.Params["type"];
        RwCreatUnit = context.Request.Params["RwCreatUnit"];
        RwCreatPeo = context.Request.Params["RwCreatPeo"];
        RwStart = context.Request.Params["RwStart"];
        RecBranch = context.Request.Params["RecBranch"];
        RecEmployee = context.Request.Params["RecEmployee"];
        RecTime = context.Request.Params["RecTime"];
        Area = context.Request.Params["Area"];
        RwContent = context.Request.Params["RwContent"];
        OthersEquip = context.Request.Params["OthersEquip"];
        SetEnd = context.Request.Params["SetEnd"];
        rwdNote = context.Request.Params["rwdNote"];
        qzName = context.Request.Params["qzName"];
        
        string rwdid = context.Request.Params["rwdid"];

        if (context.Request.Params["rows"] != null)
        {
            rows = int.Parse(context.Request.Params["rows"]);
        }
        if (context.Request.Params["page"] != null)
        {
            page = int.Parse(context.Request.Params["page"]);
        }
        switch (type)
        {
            case "add":
                context.Response.Write(addrwd());
                break;
            case "del":
                context.Response.Write(delrwd(rwdid));
                break;
            case "edit":

                break;
            case "grid":
                System.Text.StringBuilder sb = new System.Text.StringBuilder();
                sb.Append("{ ");
                sb.Append(string.Format("\"total\":{0},\"rows\":", GetCount()));
                string s = showData();
                sb.Append(s);
                sb.Append("}");
                context.Response.Write(sb.ToString());
                break;
            case "qz1":
                context.Response.Write(updateQZ1());
                break;
            case "qz2":
                context.Response.Write(updateQZ2());
                break;
            case "qz3":
                context.Response.Write(updateQZ3());
                break;                   
                
            default:
                break;
        }      
    }

    private string GetCount()
    {
        string mStrSQL = @" select count(0) from t_RWD " + GetWhere();
        int i = claSqlConnDB.GetRecordCount(claSqlConnDB.gStrConnDefault, mStrSQL);
        return i.ToString();
    }
    private string GetWhere()
    {
        string mStrWhere = "";
        return mStrWhere;
    }
    
    public string showData()
    {
        string returnStr = "";
        List<rwd> rwdGrid = new List<rwd>();
        string lStrSQL = "select dVchRwNote,dVchRwCreatUnit,dVchRwCreatPeo,dDaeRwStart,dDaeSetEnd,dVchRecBranch,dVchRecEmployee,dDaeRecTime,dVchRwContent,dVchImportentLevel,dVchArea,dVchOthersEquip,dVchCheckQZ,dVchOwnerQZ,dVchEquipDepQZ from t_RWD order by dDaeRwStart desc";
        DataTable dt = null;
        using (dt = claSqlConnDB.ExecuteDataset(rows, page, claSqlConnDB.gStrConnDefault, CommandType.Text, lStrSQL).Tables[0])
        {
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                rwd rwdtmp = new rwd();
                rwdtmp.dVchRwNote = dt.Rows[i][0].ToString();
                rwdtmp.dVchRwCreatUnit = dt.Rows[i][1].ToString();
                rwdtmp.dVchRwCreatPeo = dt.Rows[i][2].ToString();
                rwdtmp.dDaeRwStart= dt.Rows[i][3].ToString();
                rwdtmp.dDaeSetEnd = dt.Rows[i][4].ToString();
                rwdtmp.dVchRecBranch = dt.Rows[i][5].ToString();
                rwdtmp.dVchRecEmployee = dt.Rows[i][6].ToString();
                rwdtmp.dDaeRecTime = dt.Rows[i][7].ToString();
                rwdtmp.dVchRwContent = dt.Rows[i][8].ToString();
                rwdtmp.dVchImportentLevel = dt.Rows[i][9].ToString();
                rwdtmp.dVchArea = dt.Rows[i][10].ToString();
                rwdtmp.dVchOthersEquip = dt.Rows[i][11].ToString();
                rwdtmp.dVchCheckQZ = dt.Rows[i][12].ToString();
                rwdtmp.dVchOwnerQZ = dt.Rows[i][13].ToString();
                rwdtmp.dVchEquipDepQZ = dt.Rows[i][14].ToString();
                rwdGrid.Add(rwdtmp);
            }
        }
        return returnStr = JsonConvert.SerializeObject(rwdGrid);

    }
    //添加任务单
    public string addrwd()
    {
        string lRwgdNum = common.GetRwdNum(common.SeqType.PCRWGD.ToString());
        string lStrSQL = @"insert into t_RWD(dVchRwNote,dVchRwCreatUnit,dVchRwCreatPeo,dDaeRwStart,dDaeSetEnd,dVchRecBranch,dVchRecEmployee,dDaeRecTime,dVchRwContent,dVchArea,dVchOthersEquip,dDaeSys) values ('" + lRwgdNum + "','" + RwCreatUnit + "','" + RwCreatPeo + "','" + RwStart + "','" +
            SetEnd + "','" + RecBranch + "','" + RecEmployee + "','" + RecTime + "','" + RwContent + "','" + Area + "','" + OthersEquip + "','" + DateTime.Now.ToString() + "')";
        int i = claSqlConnDB.ExecuteNonQuery(claSqlConnDB.gStrConnDefault, CommandType.Text, lStrSQL);
        return i.ToString();
    }
    //删除任务单
    private string delrwd(string rwdid)
    {
        string lStrSQL = @"delete from t_RWD where dVchRwNote ='" + rwdid + "'";
        int i = claSqlConnDB.ExecuteNonQuery(claSqlConnDB.gStrConnDefault, CommandType.Text, lStrSQL);
        return i.ToString();
    }
    //检修单位签字
    private string updateQZ1()
    {
        string lStrSQL = @"update t_RWD set dVchCheckQZ = '" + qzName + "' where dVchRwNote = '" + rwdNote + "'";
        int i = claSqlConnDB.ExecuteNonQuery(claSqlConnDB.gStrConnDefault, CommandType.Text, lStrSQL);
        return i.ToString();
    }
    //产权单位签字
    private string updateQZ2()
    {
        string lStrSQL = @"update t_RWD set dVchOwnerQZ = '" + qzName + "' where dVchRwNote = '" + rwdNote + "'";
        int i = claSqlConnDB.ExecuteNonQuery(claSqlConnDB.gStrConnDefault, CommandType.Text, lStrSQL);
        return i.ToString();
    }
    //设备部签字
    private string updateQZ3()
    {
        string lStrSQL = @"update t_RWD set dVchEquipDepQZ = '" + qzName + "' where dVchRwNote = '" + rwdNote + "'";
        int i = claSqlConnDB.ExecuteNonQuery(claSqlConnDB.gStrConnDefault, CommandType.Text, lStrSQL);
        return i.ToString();
    }
    public bool IsReusable {
        get {
            return false;
        }
    }

}