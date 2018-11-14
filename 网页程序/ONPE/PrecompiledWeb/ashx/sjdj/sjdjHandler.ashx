
<%@ WebHandler Language="C#" Class="sjdjHandler" %>

using System;
using System.Web;
using ModelClass;
using Newtonsoft.Json;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;

public class sjdjHandler : IHttpHandler {
    string type = "";
    string contentId = "";
    string partId = "";
    string nameID = "";
    string nID = "";
    string name = "";
    List<TCContent> lst = new List<TCContent>();
    List<TCStandard> lst1 = new List<TCStandard>();
    List<TCBW> lst2 = new List<TCBW>();

    string equipCode = "";
    
    public void ProcessRequest (HttpContext context) {
        context.Response.ContentType = "text/plain";
        type = context.Request.Params["type"];
        contentId = context.Request.Params["selid"];
        partId = context.Request.Params["partId"];
        nameID = context.Request.Params["nameId"];

        nID = context.Request.Params["nid"];
        name = context.Request.Params["name"];
        equipCode = context.Request.Params["equipCode"];
        string deleted = context.Request.Form["deleted"];
        string inserted = context.Request.Form["inserted"];
        string updated = context.Request.Form["updated"];

        switch (type)
        {
            case "saveName":
                context.Response.Write(AddNameData());
                break;
            case "DelName":
                context.Response.Write(DelNameData());
                break;
            case "name":
                context.Response.Write(showNameData());
                break;
                
            case "content":
                context.Response.Write(showContentData());
                break;
            case "bw":
                context.Response.Write(showBWData());
                break;
            case "saveB":
                if (deleted != null)
                {
                    lst2 = common.JsonDeserialize<List<TCBW>>(deleted);
                    context.Response.Write(DeleteB(lst2));
                }
                if (inserted != null)
                {
                    lst2 = common.JsonDeserialize<List<TCBW>>(inserted);
                    context.Response.Write(InsertB(lst2));
                }
                if (updated != null)
                {
                    lst2 = common.JsonDeserialize<List<TCBW>>(updated);
                    context.Response.Write(UpdateB(lst2));
                }
                break;
            //case "content":
            //    context.Response.Write(showData());
            //    break;
            case "saveC":
                if (deleted != null)
                {
                    lst = common.JsonDeserialize<List<TCContent>>(deleted);
                    context.Response.Write(DeleteC(lst));
                }
                if (inserted != null)
                {
                    lst = common.JsonDeserialize<List<TCContent>>(inserted);
                    context.Response.Write(InsertCByBW(lst));
                }
                if (updated != null)
                {
                    lst = common.JsonDeserialize<List<TCContent>>(updated);
                    context.Response.Write(UpdateC(lst));
                }
                break;
            case "standard":
                context.Response.Write(showStandardData());
                break;
            case "saveS":
                if (deleted != null)
                {
                    lst1 = common.JsonDeserialize<List<TCStandard>>(deleted);
                    context.Response.Write(DeleteS(lst1));
                }
                if (inserted != null)
                {
                    lst1 = common.JsonDeserialize<List<TCStandard>>(inserted);
                    context.Response.Write(InsertS(lst1));
                }
                if (updated != null)
                {
                    lst1 = common.JsonDeserialize<List<TCStandard>>(updated);
                    context.Response.Write(UpdateS(lst1));
                }
                break;
            case "And":
                context.Response.Write(showStandardAndEquip());
                break;
            case "UnAnd":
                context.Response.Write(UnStandardAndEquip());
                break;
            case "byEquipCode":
                context.Response.Write(showStandardbyEquipCode());
                break;
            default:
                break;
        }
    }
    private string UnStandardAndEquip()
    {
        string lStrSQL = "";
        int k = 0;
        lStrSQL = @"Delete from t_TCEquipStandard where equip_code = '" + equipCode + "' and dIntNameNote = " + nameID + "";
        k = claSqlConnDB.ExecuteNonQuery(claSqlConnDB.gStrConnDefault, CommandType.Text, lStrSQL);
        if (k > 0)
        {
            return "ok";
        }
        else
        {
            return "error";
        }
    }
    private string showStandardbyEquipCode()
    {
        string returnStr = "";
        string lStrSQL = @"select dIntNameNote from t_TCEquipStandard where equip_code = '" + equipCode + "'";
        SqlDataReader dr = null;
        using(dr=claSqlConnDB.ExecuteReader(claSqlConnDB.gStrConnDefault,CommandType.Text,lStrSQL))
        {
            if(dr.Read())
            {
                returnStr = dr.GetInt32(0).ToString();
            }
        }
        return returnStr;
    }
    private string showStandardAndEquip()
    {
        string lStrSQL = "";
        int k = 0;
        lStrSQL = @"insert into t_TCEquipStandard (equip_code,dIntNameNote) values ('" + equipCode + "'," + nameID + ")";
        k = claSqlConnDB.ExecuteNonQuery(claSqlConnDB.gStrConnDefault, CommandType.Text, lStrSQL);
        if (k > 0)
        {
            return "ok";
        }
        else
        {
            return "error";
        }
    }
    private string DelNameData()
    {
        string lStrSQL = "";
        int k = 0;
        lStrSQL = @"Delete from t_TCName where dIntNameNote = " + nID + "  ";

        k = claSqlConnDB.ExecuteNonQuery(claSqlConnDB.gStrConnDefault, CommandType.Text, lStrSQL);
        if (k > 0)
        {
            return "ok";
        }
        else
        {
            return "error";
        }
    }
    private string AddNameData()
    {
        string lStrSQL = "";
        int k = 0;
        lStrSQL = @"select count(*) from t_TCName where dIntNameNote = " + nID + "  ";
        SqlDataReader dr = null;
        using (dr = claSqlConnDB.ExecuteReader(claSqlConnDB.gStrConnDefault, CommandType.Text, lStrSQL))
        {
            if (dr.Read())
            {
                if (dr.GetInt32(0) > 0)
                {
                    lStrSQL = "update t_TCName set dVchName = '" + name + "' where dIntNameNote = " + nID + " "; 
                } 
                else
                {
                    lStrSQL = @"insert into t_TCName (dVchName) values('" + name + "')";
                }
            }
        }

        k = claSqlConnDB.ExecuteNonQuery(claSqlConnDB.gStrConnDefault, CommandType.Text, lStrSQL);
        if (k > 0)
        {
            return "ok";
        }
        else
        {
            return "error";
        }
    }
    private string DeleteS(List<TCStandard> Item)
    {
        string lStrSQL = "";
        int k = 0;
        int j = 0;
        for (int i = 0; i < Item.Count; i++)
        {
            lStrSQL = @"Delete from t_TCContentStandard where dIntStandardNote = " + Item[i].dIntStandardNote + "";
            k = claSqlConnDB.ExecuteNonQuery(claSqlConnDB.gStrConnDefault, CommandType.Text, lStrSQL);
            
            
            lStrSQL = @"Delete from t_TCStandard where dIntStandardNote = " + Item[i].dIntStandardNote + "";
            k = claSqlConnDB.ExecuteNonQuery(claSqlConnDB.gStrConnDefault, CommandType.Text, lStrSQL);
            if (k > 0)
            {
                j++;
            }
            k = 0;
        }

        if (j == Item.Count)
        {
            return "ok";
        }
        else
        {
            return "error";
        }

    }
    private string UpdateS(List<TCStandard> Item)
    {
        string lStrSQL = "";
        int k = 0;
        int j = 0;
        for (int i = 0; i < Item.Count; i++)
        {
            lStrSQL = @"Update t_TCStandard set dVchStandardName = '" + Item[i].dVchStandardName + "',dIngCheckType1 = " + Item[i].dIngCheckType1 + ", dIngCheckType2 = " + Item[i].dIngCheckType2
                + ", dIngCheckType3 = " + Item[i].dIngCheckType3 + ", dIngCheckType4 = " + Item[i].dIngCheckType4 + ",dVchCheckMethod = '" + Item[i].dVchCheckMethod + "',dIntCheckDay = " + Item[i].dIntCheckDay
                + ",dVchPostName = '" + Item[i].dVchPostName + "' , dVchCheckState = '" + Item[i].dVchCheckState + "',dVchExMethod = '" + Item[i].dVchExMethod + "',dVchSafeMethod = '" + Item[i].dVchSafeMethod + "' where dIntStandardNote = " + Item[i].dIntStandardNote + "";
            k = claSqlConnDB.ExecuteNonQuery(claSqlConnDB.gStrConnDefault, CommandType.Text, lStrSQL);
            if (k > 0)
            {
                j++;
            }
            k = 0;
        }

        if (j == Item.Count)
        {
            return "ok";
        }
        else
        {
            return "error";
        }

    }
    private string InsertS(List<TCStandard> Item)
    {
        string lStrSQL = "";
        int k = 0;
        int j = 0;
        for (int i = 0; i < Item.Count; i++)
        {
            lStrSQL = @"insert into t_TCStandard(dVchStandardName,dIngCheckType1,dIngCheckType2,dIngCheckType3,dIngCheckType4,dVchCheckMethod,dIntCheckDay,dVchPostName,dVchCheckState,dVchExMethod,dVchSafeMethod,dVchLevel,dIntBranchID,dIntCompanyID) 
                values('" + Item[i].dVchStandardName + "'," + Item[i].dIngCheckType1.ToString() + "," + Item[i].dIngCheckType2.ToString() + "," + Item[i].dIngCheckType3.ToString() + "," + Item[i].dIngCheckType4.ToString() + ",'" + Item[i].dVchCheckMethod + "'," + Item[i].dIntCheckDay.ToString() +
                ",'" + Item[i].dVchPostName + "','" + Item[i].dVchCheckState + "','" + Item[i].dVchExMethod + "','" + Item[i].dVchSafeMethod + "','" + Item[i].dVchLevel + "','" + Item[i].dVchBranchName + "','" + Item[i].dVchCompanyName + "')";
            k = claSqlConnDB.ExecuteNonQuery(claSqlConnDB.gStrConnDefault, CommandType.Text, lStrSQL);
            if (k > 0)
            {
                lStrSQL = @"declare @mIntStandardId int 
                    select @mIntStandardId = max(dIntStandardNote) from t_TCStandard
                    insert into t_TCContentStandard
                    values(" + Item[i].dIntContentNote.ToString() + ",@mIntStandardId)";
                claSqlConnDB.ExecuteNonQuery(claSqlConnDB.gStrConnDefault, CommandType.Text, lStrSQL);
                j++;
            }
            k = 0;
        }

        if (j == Item.Count)
        {
            return "ok";
        }
        else
        {
            return "error";
        }

    }
    private string UpdateB(List<TCBW> Item)
    {
        string lStrSQL = "";
        int k = 0;
        int j = 0;
        for (int i = 0; i < Item.Count; i++)
        {
            lStrSQL = @"Update t_TCPart set dVchPartName = '" + Item[i].dVchPartName + "',dVchRemark = '" + Item[i].dVchRemark + "' where dIntPartNote = " + Item[i].dIntPartNote + "";
            k = claSqlConnDB.ExecuteNonQuery(claSqlConnDB.gStrConnDefault, CommandType.Text, lStrSQL);
            if (k > 0)
            {
                j++;
            }
            k = 0;
        }

        if (j == Item.Count)
        {
            return "ok";
        }
        else
        {
            return "error";
        }

    }
    private string InsertB(List<TCBW> Item)
    {
        string lStrSQL = "";
        int k = 0;
        int j = 0;
        for (int i = 0; i < Item.Count; i++)
        {
            lStrSQL = @"insert into t_TCPart(dVchPartName,dVchRemark,dIntNameNote) values('" + Item[i].dVchPartName + "','" + Item[i].dVchRemark + "'," + Item[i].dIntNameNote + ")";
            k = claSqlConnDB.ExecuteNonQuery(claSqlConnDB.gStrConnDefault, CommandType.Text, lStrSQL);
            if (k > 0)
            {
                j++;
            }
            k = 0;
        }

        if (j == Item.Count)
        {
            return "ok";
        }
        else
        {
            return "error";
        }

    }
    private string DeleteB(List<TCBW> Item)
    {
        string lStrSQL = "";
        int k = 0;
        int j = 0;
        for (int i = 0; i < Item.Count; i++)
        {

            lStrSQL = @"Delete from t_TCPart where dIntPartNote = " + Item[i].dIntPartNote + "";
            k = claSqlConnDB.ExecuteNonQuery(claSqlConnDB.gStrConnDefault, CommandType.Text, lStrSQL);
            if (k > 0)
            {
                j++;
            }
            k = 0;
        }

        if (j == Item.Count)
        {
            return "ok";
        }
        else
        {
            return "error";
        }
    }
    private string InsertCByBW(List<TCContent> Item)
    {
        string lStrSQL = "";
        int k = 0;
        int j = 0;
        for (int i = 0; i < Item.Count; i++)
        {
            lStrSQL = @"insert into t_TCContent(dVchContentName,dVchRemark) values('" + Item[i].dVchContentName + "','" + Item[i].dVchRemark + "')";
            k = claSqlConnDB.ExecuteNonQuery(claSqlConnDB.gStrConnDefault, CommandType.Text, lStrSQL);
            if (k > 0)
            {
                lStrSQL = @"declare @mIntContentId int 
                    select @mIntContentId = max(dIntContentNote) from t_TCContent
                    insert into t_TCPartContent
                    values(" + Item[i].dIntPartNote.ToString() + ",@mIntContentId)";
                claSqlConnDB.ExecuteNonQuery(claSqlConnDB.gStrConnDefault, CommandType.Text, lStrSQL);
                j++;
            }
            k = 0;
        }

        if (j == Item.Count)
        {
            return "ok";
        }
        else
        {
            return "error";
        }

    }
    private string InsertC(List<TCContent> Item)
    {
        string lStrSQL = "";
        int k = 0;
        int j = 0;
        for (int i = 0; i < Item.Count; i++)
        {
            lStrSQL = @"insert into t_TCContent(dVchContentName,dVchRemark) values('" + Item[i].dVchContentName + "','" + Item[i].dVchRemark + "')";
            k = claSqlConnDB.ExecuteNonQuery(claSqlConnDB.gStrConnDefault, CommandType.Text, lStrSQL);
            if (k > 0)
            {
                j++;
            }
            k = 0;
        }

        if (j == Item.Count)
        {
            return "ok";
        }
        else
        {
            return "error";
        }
        
    }
    private string UpdateC(List<TCContent> Item)
    {
        string lStrSQL = "";
        int k = 0;
        int j = 0;
        for (int i = 0; i < Item.Count; i++)
        {
            lStrSQL = @"Update t_TCContent set dVchContentName = '" + Item[i].dVchContentName + "',dVchRemark = '" + Item[i].dVchRemark + "' where dIntContentNote = " + Item[i].dIntContentNote + "";
            k = claSqlConnDB.ExecuteNonQuery(claSqlConnDB.gStrConnDefault, CommandType.Text, lStrSQL);
            if (k > 0)
            {
                j++;
            }
            k = 0;
        }

        if (j == Item.Count)
        {
            return "ok";
        }
        else
        {
            return "error";
        }

    }
    private string DeleteC(List<TCContent> Item)
    {
        string lStrSQL = "";
        int k = 0;
        int j = 0;
        for (int i = 0; i < Item.Count; i++)
        {
            lStrSQL = @"Delete from t_TCPartContent where dIntContentNote = " + Item[i].dIntContentNote + "";
            k = claSqlConnDB.ExecuteNonQuery(claSqlConnDB.gStrConnDefault, CommandType.Text, lStrSQL);
            
            lStrSQL = @"Delete from t_TCContent where dIntContentNote = " + Item[i].dIntContentNote + "";
            k = claSqlConnDB.ExecuteNonQuery(claSqlConnDB.gStrConnDefault, CommandType.Text, lStrSQL);
            if (k > 0)
            {
                j++;
            }
            k = 0;
        }

        if (j == Item.Count)
        {
            return "ok";
        }
        else
        {
            return "error";
        }

    }
    public string showNameData()
    {
        string returnStr = "";
        List<TCName> Grid = new List<TCName>();
        string lStrSQL = @"select dIntNameNote,dVchName,dVchRemark from t_TCName order by dVchName";
        System.Data.DataTable dt = null;
        using (dt = claSqlConnDB.ExecuteDataset(claSqlConnDB.gStrConnDefault, System.Data.CommandType.Text, lStrSQL).Tables[0])
        {
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                TCName tmp = new TCName();
                tmp.dIntNameNote = Int32.Parse(dt.Rows[i][0].ToString());
                tmp.dVchName = dt.Rows[i][1].ToString();
                tmp.dVchRemark = dt.Rows[i][2].ToString();

                Grid.Add(tmp);
            }
        }
        return returnStr = JsonConvert.SerializeObject(Grid);
    }
    public string showData()
    {
        string returnStr = "";
        List<TCContent> Grid = new List<TCContent>();
        string lStrSQL = @"select dIntContentNote,dVchContentName,dVchRemark from t_TCContent ";
        System.Data.DataTable dt = null;
        using (dt = claSqlConnDB.ExecuteDataset(claSqlConnDB.gStrConnDefault, System.Data.CommandType.Text, lStrSQL).Tables[0])
        {
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                TCContent tmp = new TCContent();
                tmp.dIntContentNote = Int32.Parse(dt.Rows[i][0].ToString());
                tmp.dVchContentName = dt.Rows[i][1].ToString();
                tmp.dVchRemark = dt.Rows[i][2].ToString();

                Grid.Add(tmp);
            }
        }
        return returnStr = JsonConvert.SerializeObject(Grid);
    }
    public string showBWData()
    {
        string returnStr = "";
        List<TCBW> Grid = new List<TCBW>();
        string lStrSQL = @"select dIntPartNote,dVchPartName,t_TCPart.dVchRemark,t_TCName.dIntNameNote,t_TCName.dVchName from t_TCPart inner join t_TCName on t_TCName.dIntNameNote = t_TCPart.dIntNameNote where t_TCPart.dIntNameNote = " + nameID + "";
        System.Data.DataTable dt = null;
        using (dt = claSqlConnDB.ExecuteDataset(claSqlConnDB.gStrConnDefault, System.Data.CommandType.Text, lStrSQL).Tables[0])
        {
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                TCBW tmp = new TCBW();
                tmp.dIntPartNote = Int32.Parse(dt.Rows[i][0].ToString());
                tmp.dVchPartName = dt.Rows[i][1].ToString();
                tmp.dVchRemark = dt.Rows[i][2].ToString();
                tmp.dIntNameNote = Int32.Parse(dt.Rows[i][3].ToString());
                tmp.dVchName = dt.Rows[i][4].ToString();
                Grid.Add(tmp);
            }
        }
        return returnStr = JsonConvert.SerializeObject(Grid);
    }
    public string showContentData()
    {
        string returnStr = "";
        List<TCContent> Grid = new List<TCContent>();
        if (partId == "undefined" || partId == "")
        {
            return returnStr;
        }
        string lStrSQL = @"SELECT   t_TCContent.dIntContentNote, t_TCContent.dVchContentName, t_TCContent.dVchRemark, t_TCPart.dVchPartName,t_TCPart.dIntPartNote
                FROM      t_TCContent INNER JOIN
                                t_TCPartContent ON t_TCContent.dIntContentNote = t_TCPartContent.dIntContentNote INNER JOIN
                                t_TCPart ON t_TCPartContent.dIntPartNote = t_TCPart.dIntPartNote
                WHERE   (t_TCPart.dIntPartNote = " + partId + ")";
        System.Data.DataTable dt = null;
        using (dt = claSqlConnDB.ExecuteDataset(claSqlConnDB.gStrConnDefault, System.Data.CommandType.Text, lStrSQL).Tables[0])
        {
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                TCContent tmp = new TCContent();
                tmp.dIntContentNote = Int32.Parse(dt.Rows[i][0].ToString());
                tmp.dVchContentName = dt.Rows[i][1].ToString();
                tmp.dVchRemark = dt.Rows[i][2].ToString();
                tmp.dIntPartNote = Int32.Parse(dt.Rows[i][4].ToString());
                tmp.dVchPartName = dt.Rows[i][3].ToString();
                tmp.LineNode = "";
                Grid.Add(tmp);
            }
        }
        return returnStr = JsonConvert.SerializeObject(Grid);
    }
    public string showStandardData()
    {
        string returnStr = "";
        List<TCStandard> Grid = new List<TCStandard>();
        string lStrSQL = @"SELECT   t_TCContent.dVchContentName, t_TCContent.dIntContentNote, t_TCStandard.dVchStandardName, 
                            t_TCStandard.dIngCheckType1, t_TCStandard.dIngCheckType2, t_TCStandard.dIngCheckType3, 
                            t_TCStandard.dIngCheckType4, t_TCStandard.dVchCheckMethod, t_TCStandard.dIntCheckDay, 
                            t_TCStandard.dVchPostName, t_TCStandard.dVchCheckState, t_TCStandard.dVchExMethod, 
                            t_TCStandard.dVchSafeMethod, t_TCStandard.dIntStandardNote,
                            t_TCStandard.dIntBranchID,t_TCStandard.dIntCompanyID,
                            tHRBranchInfo.dVchBranchName,tHRCompany.dVchCompanyName,t_TCStandard.dVchLevel
            FROM      t_TCContentStandard INNER JOIN
                            t_TCStandard ON t_TCContentStandard.dIntStandardNote = t_TCStandard.dIntStandardNote INNER JOIN
                            t_TCContent ON t_TCContentStandard.dIntContentNote = t_TCContent.dIntContentNote
                       INNER JOIN tHRBranchInfo ON tHRBranchInfo.dIntBranchID = t_TCStandard.dIntBranchID
                       INNER JOIN tHRCompany ON tHRCompany.dIntCompanyID = t_TCStandard.dIntCompanyID
            WHERE   (t_TCContent.dIntContentNote = " + contentId + ")";
        System.Data.DataTable dt = null;
        using (dt = claSqlConnDB.ExecuteDataset(claSqlConnDB.gStrConnDefault, System.Data.CommandType.Text, lStrSQL).Tables[0])
        {
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                TCStandard tmp = new TCStandard();
                tmp.dIntContentNote = Int32.Parse(dt.Rows[i][1].ToString());
                tmp.dVchContentName = dt.Rows[i][0].ToString();
                tmp.dIntStandardNote = Int32.Parse(dt.Rows[i][13].ToString());
                tmp.dVchStandardName = dt.Rows[i][2].ToString();
                tmp.dIngCheckType1 = Int32.Parse(dt.Rows[i][3].ToString());
                tmp.dIngCheckType2 = Int32.Parse(dt.Rows[i][4].ToString());
                tmp.dIngCheckType3 = Int32.Parse(dt.Rows[i][5].ToString());
                tmp.dIngCheckType4 = Int32.Parse(dt.Rows[i][6].ToString());
                tmp.dVchCheckMethod = dt.Rows[i][7].ToString();
                tmp.dIntCheckDay = Int32.Parse(dt.Rows[i][8].ToString());
                tmp.dVchPostName = dt.Rows[i][9].ToString();
                tmp.dVchCheckState = dt.Rows[i][10].ToString();
                tmp.dVchExMethod = dt.Rows[i][11].ToString();
                tmp.dVchSafeMethod = dt.Rows[i][12].ToString();
                tmp.dIntBranchID = dt.Rows[i][14].ToString();
                tmp.dIntCompanyID = dt.Rows[i][15].ToString();
                tmp.dVchBranchName = dt.Rows[i][16].ToString();
                tmp.dVchCompanyName = dt.Rows[i][17].ToString();
                tmp.dVchLevel = dt.Rows[i][18].ToString();
                Grid.Add(tmp);
            }
        }
        return returnStr = JsonConvert.SerializeObject(Grid);
    }
    
    public bool IsReusable {
        get {
            return false;
        }
    }

}