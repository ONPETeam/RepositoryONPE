<%@ WebHandler Language="C#" Class="gzpHandler" %>

using System;
using System.Web;
using System.Data;
using ModelClass;
using Newtonsoft.Json;
using System.Collections.Generic;
using System.Data.SqlClient;

public class gzpHandler : IHttpHandler {

    int rows = 10;
    int page = 1;
    
    string type = "";
    string WorkCreatUnit = "";
    string WorkCreatPeo = "";
    string WorkSys = "";
    string ActionDep = "";
    string Area = "";
    string FromType = "";
    string gzpSepValue = "";
    string gzp = "";
    List<gzItem> lst = new List<gzItem>();

    string rwdNote = "";
    string qzName = "";
    string ttime = "";

    string gzpid = "";
    public void ProcessRequest(HttpContext context)
    {
        context.Response.ContentType = "text/plain";
        type = context.Request.Params["type"];
        WorkCreatUnit = context.Request.Params["WorkCreatUnit"];
        WorkCreatPeo = context.Request.Params["WorkCreatPeo"];
        WorkSys = context.Request.Params["WorkSys"];
        ActionDep = context.Request.Params["ActionDep"];
        Area = context.Request.Params["Area"];
        FromType = context.Request.Params["FromType"];
        gzpSepValue = context.Request.Params["gzpSeqValue"];

        string deleted = context.Request.Form["deleted"];
        string inserted = context.Request.Form["inserted"];
        string updated = context.Request.Form["updated"];

        gzpid = context.Request.Params["gzpid"];

        rwdNote = context.Request.Params["rwdNote"];
        qzName = context.Request.Params["qzName"];
        ttime = context.Request.Params["ttime"];
        
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
                context.Response.Write(add());
                break;
            case "del":
                context.Response.Write(del(gzpid));
                break;
            case "edit":

                break;
            case "save":

                if (deleted != null)
                {
                    lst = common.JsonDeserialize<List<gzItem>>(deleted);
                    context.Response.Write(Delete(lst));
                }
                if (inserted != null)
                {
                    lst = common.JsonDeserialize<List<gzItem>>(inserted);
                }
                if (updated != null)
                {
                    lst = common.JsonDeserialize<List<gzItem>>(updated);
                    context.Response.Write(Update(lst));
                }
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
            case "item":
                context.Response.Write(showItemData(gzpid));
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
            case "qz4":
                context.Response.Write(updateQZ4());
                break;
            case "qz5":
                context.Response.Write(updateQZ5());
                break;
            case "qz6":
                context.Response.Write(updateQZ6());
                break;
            case "additem":
                gzp = context.Request.Params["gzp"];
                if (deleted != null)
                {
                    lst = common.JsonDeserialize<List<gzItem>>(deleted);
                }
                if (inserted != null)
                {
                    lst = common.JsonDeserialize<List<gzItem>>(inserted);
                }
                if (updated != null)
                {
                    lst = common.JsonDeserialize<List<gzItem>>(updated);
                }
                context.Response.Write(addItem(lst));
                break;
            
            default:
                break;
        }
    }
    private string GetCount()
    {
        string mStrSQL = @" select count(0) from t_GZP ";
        int i = claSqlConnDB.GetRecordCount(claSqlConnDB.gStrConnDefault, mStrSQL);
        return i.ToString();
    }
    public string showItemData(string workNote)
    {
        string returnStr = "";
        List<gzItem> gzItemGrid = new List<gzItem>();
        string lStrSQL = @"select equip_name,dVchWorkContent,dVchIsClose,dVchApplyPeo,dVchZKCheckPeo,dVchActionPeo,t_GZPItem.equip_code from t_GZPItem inner join t_Equips on t_Equips.equip_code = t_GZPItem.equip_code
            where dVchWorkNote = '" + workNote + "'";
        DataTable dt = null;
        using (dt = claSqlConnDB.ExecuteDataset(claSqlConnDB.gStrConnDefault, CommandType.Text, lStrSQL).Tables[0])
        {
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                gzItem tmp = new gzItem();
                tmp.equip_name = dt.Rows[i][0].ToString();
                tmp.dVchWorkContent = dt.Rows[i][1].ToString();
                tmp.dVchIsClose = dt.Rows[i][2].ToString();
                tmp.dVchApplyPeo = dt.Rows[i][3].ToString();
                tmp.dVchZKCheckPeo = dt.Rows[i][4].ToString();
                tmp.dVchActionPeo = dt.Rows[i][5].ToString();
                tmp.equip_code = dt.Rows[i][6].ToString();
                gzItemGrid.Add(tmp);
            }
        }
        return returnStr = JsonConvert.SerializeObject(gzItemGrid);
    }
    public string showData()
    {
        string returnStr = "";
        List<gzp> gzpGrid = new List<gzp>();
        string lStrSQL = "select dVchWorkNote,dVchWorkCreatUnit,dVchWorkCreatPeo,dDaeWorkSys,dVchActionDep,dVchArea,dDaeWorkStart,dVchWorkPeo,dVchWorkPeoQZ,dDaeWorkEnd,dVchWorkPeo1,dVchWorkPeoQZ1,dVchFromType from t_GZP order by dDaeWorkSys desc";
        DataTable dt = null;
        using (dt = claSqlConnDB.ExecuteDataset(rows, page, claSqlConnDB.gStrConnDefault, CommandType.Text, lStrSQL).Tables[0])
        {
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                gzp gzptmp = new gzp();
                gzptmp.dVchWorkNote = dt.Rows[i][0].ToString();
                gzptmp.dVchWorkCreatUnit = dt.Rows[i][1].ToString();
                gzptmp.dVchWorkCreatPeo = dt.Rows[i][2].ToString();
                gzptmp.dDaeWorkSys = dt.Rows[i][3].ToString();
                gzptmp.dVchActionDep = dt.Rows[i][4].ToString();
                gzptmp.dVchArea = dt.Rows[i][5].ToString();
                gzptmp.dDaeWorkStart = dt.Rows[i][6].ToString();
                gzptmp.dVchWorkPeo = dt.Rows[i][7].ToString();
                gzptmp.dVchWorkPeoQZ = dt.Rows[i][8].ToString();
                gzptmp.dDaeWorkEnd = dt.Rows[i][9].ToString();
                gzptmp.dVchWorkPeo1 = dt.Rows[i][10].ToString();
                gzptmp.dVchWorkPeoQZ1 = dt.Rows[i][11].ToString();
                gzptmp.dVchFromType = dt.Rows[i][12].ToString();
                gzptmp.Item = "";
                gzpGrid.Add(gzptmp);
            }
        }
        return returnStr = JsonConvert.SerializeObject(gzpGrid);
    }
    private string add()
    {
        //string lRwgdNum = common.GetRwdNum(common.SeqType.PCRWGP.ToString());
        string lStrSQL = @"insert into t_GZP(dVchWorkNote,dVchWorkCreatUnit,dVchWorkCreatPeo,dDaeWorkSys,dVchActionDep,dVchArea,dVchFromType) values ('" + gzpSepValue + "','" + WorkCreatUnit + "','" + WorkCreatPeo + "','" + WorkSys + "','" +
            ActionDep + "','" + Area + "','" + FromType + "')";
        int i = claSqlConnDB.ExecuteNonQuery(claSqlConnDB.gStrConnDefault, CommandType.Text, lStrSQL);        
        return i.ToString();
    }
    //删除工作票
    private string del(string gzpid)
    {
        int i = -100;
        try
        {
            string lStrSQL = @"delete from t_GZP where dVchWorkNote ='" + gzpid + "'";
            i = claSqlConnDB.ExecuteNonQuery(claSqlConnDB.gStrConnDefault, CommandType.Text, lStrSQL);
        }
        catch(Exception e)
        {
            string err = e.ToString();
            i = 0;
        }

        return i.ToString();
    }
    private string addItem(List<gzItem> gzItem)
    {
        string lStrSQL = "";
        int j = 0;
        int k = 0;
        for (int i = 0; i < gzItem.Count; i++)
        {
            lStrSQL = @"insert into t_GZPItem(dVchWorkNote,equip_code,dVchWorkContent,dVchIsClose,dVchApplyPeo,dVchZKCheckPeo,dVchActionPeo) values ('" + gzp + "','" + gzItem[i].equip_code + "','" + gzItem[i].dVchWorkContent + "','" + gzItem[i].dVchIsClose + "','" +
                gzItem[i].dVchApplyPeo + "','" + gzItem[i].dVchZKCheckPeo + "','" + gzItem[i].dVchActionPeo + "')";
            k = claSqlConnDB.ExecuteNonQuery(claSqlConnDB.gStrConnDefault, CommandType.Text, lStrSQL);
            if(k>0)
            {
                if (gzItem[i].dVchIsClose == "是")//需要停电的设备
                {
                    lStrSQL = @"insert into t_TSD(dVchWorkNote,equip_code,requestStopTime) values('" + gzp + "','" + gzItem[i].equip_code + "','" + DateTime.Now.ToString() + "')";
                    claSqlConnDB.ExecuteNonQuery(claSqlConnDB.gStrConnDefault, CommandType.Text, lStrSQL);


                    lStrSQL = @"select count(*) from t_TSDManage where equip_code = '" + gzItem[i].equip_code + "'";
                    SqlDataReader dr = null;
                    using(dr = claSqlConnDB.ExecuteReader(claSqlConnDB.gStrConnDefault, CommandType.Text, lStrSQL))
                    {
                        if(dr.Read())
                        {
                            if(dr.GetInt32(0) == 0)
                            {
                                lStrSQL = @"insert into t_TSDManage (equip_code,stop_count,end_count,success_index) values('" + gzItem[i].equip_code + "',1,0,0)";
                                claSqlConnDB.ExecuteNonQuery(claSqlConnDB.gStrConnDefault, CommandType.Text, lStrSQL);
                            }
                            else
                            {
                                lStrSQL = @"select success_index from t_TSDManage where equip_code = '" + gzItem[i].equip_code + "'";
                                SqlDataReader dr1 = null;
                                using (dr1 = claSqlConnDB.ExecuteReader(claSqlConnDB.gStrConnDefault, CommandType.Text, lStrSQL))
                                {
                                    if (dr1.Read())
                                    {
                                        if(dr.GetInt32(0) == 1)//表示前一次停送电流程完毕
                                        {
                                            //重新开始一轮
                                            lStrSQL = @"update t_TSDManage set success_index = 0,stop_count = stop_count + 1 where equip_code = '" + gzItem[i].equip_code + "'";
                                            claSqlConnDB.ExecuteNonQuery(claSqlConnDB.gStrConnDefault, CommandType.Text, lStrSQL);
                                        }
                                        else
                                        {
                                            lStrSQL = @"update t_TSDManage set stop_count = stop_count + 1 where equip_code = '" + gzItem[i].equip_code + "'";
                                            claSqlConnDB.ExecuteNonQuery(claSqlConnDB.gStrConnDefault, CommandType.Text, lStrSQL);
                                        }
                                    }
                                    dr1.Close();
                                    dr1.Dispose();
                                }
                            }
                        }
                    }
                }
                
                j++;
            }
            k = 0;
        }
        if (j == gzItem.Count)
        {
            return "ok";
        }
        else
        {
            return "error";
        }
    }
    /// <summary>
    /// 更新作业项目内容
    /// </summary>
    /// <param name="Item"></param>
    /// <returns></returns>
    private string Update(List<gzItem> Item)
    {
        string lStrSQL = "";
        int j = 0;
        int k = 0;
        for (int i = 0; i < Item.Count; i++)
        {
            lStrSQL = @"update t_GZPItem set dVchZKCheckPeo = '" + Item[i].dVchZKCheckPeo + "',dVchActionPeo = '" + Item[i].dVchActionPeo + "' where dVchWorkNote = '" + gzpid + "' and equip_code = '" + Item[i].equip_code + "'";
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
    /// <summary>
    /// 删除作业项目内容
    /// </summary>
    /// <param name="Item"></param>
    /// <returns></returns>
    private string Delete(List<gzItem> Item)
    {
        string lStrSQL = "";
        int k = 0;
        int j = 0;
        for (int i = 0; i < Item.Count; i++)
        {
            lStrSQL = @"delete from t_GZPItem where dVchWorkNote = '" + gzpid + "' and equip_code = '" + Item[i].equip_code + "'";
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
    //作业负责人签字
    private string updateQZ1()
    {
        string lStrSQL = @"update t_GZP set dVchWorkPeo = '" + qzName + "' where dVchWorkNote = '" + rwdNote + "'";
        int i = claSqlConnDB.ExecuteNonQuery(claSqlConnDB.gStrConnDefault, CommandType.Text, lStrSQL);
        return i.ToString();
    }
    //岗位签字
    private string updateQZ2()
    {
        string lStrSQL = @"update t_GZP set dVchWorkPeoQZ = '" + qzName + "' where dVchWorkNote = '" + rwdNote + "'";
        int i = claSqlConnDB.ExecuteNonQuery(claSqlConnDB.gStrConnDefault, CommandType.Text, lStrSQL);
        return i.ToString();
    }
    //作业负责人签字
    private string updateQZ3()
    {
        string lStrSQL = @"update t_GZP set dVchWorkPeo1 = '" + qzName + "' where dVchWorkNote = '" + rwdNote + "'";
        int i = claSqlConnDB.ExecuteNonQuery(claSqlConnDB.gStrConnDefault, CommandType.Text, lStrSQL);
        return i.ToString();
    }
    //岗位签字
    private string updateQZ4()
    {
        string lStrSQL = @"update t_GZP set dVchWorkPeoQZ1 = '" + qzName + "' where dVchWorkNote = '" + rwdNote + "'";
        int i = claSqlConnDB.ExecuteNonQuery(claSqlConnDB.gStrConnDefault, CommandType.Text, lStrSQL);
        return i.ToString();
    }

    private string updateQZ5()
    {
        string lStrSQL = @"update t_GZP set dDaeWorkStart = '" + ttime + "' where dVchWorkNote = '" + rwdNote + "'";
        int i = claSqlConnDB.ExecuteNonQuery(claSqlConnDB.gStrConnDefault, CommandType.Text, lStrSQL);
        return i.ToString();
    }

    private string updateQZ6()
    {
        string lStrSQL = @"update t_GZP set dDaeWorkEnd = '" + ttime + "' where dVchWorkNote = '" + rwdNote + "'";
        int i = claSqlConnDB.ExecuteNonQuery(claSqlConnDB.gStrConnDefault, CommandType.Text, lStrSQL);
        return i.ToString();
    }
    public bool IsReusable {
        get {
            return false;
        }
    }
   
}