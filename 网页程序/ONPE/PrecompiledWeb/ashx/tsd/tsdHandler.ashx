<%@ WebHandler Language="C#" Class="tsdHandler" %>

using System;
using System.Web;
using ModelClass;
using Newtonsoft.Json;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;

public class tsdHandler : IHttpHandler {

    string type = "";
    string tsdid = "";
    string equip_code = "";
    public void ProcessRequest (HttpContext context) {
        context.Response.ContentType = "text/plain";
        type = context.Request.Params["type"];
        string deleted = context.Request.Form["deleted"];
        string inserted = context.Request.Form["inserted"];
        string updated = context.Request.Form["updated"];

        List<tsd> lst = new List<tsd>();

        switch (type)
        {
            case "grid":
                context.Response.Write(showData());
                break;
            case "save":
                tsdid = context.Request.Params["tsdid"];
                if (deleted != null)
                {
                    lst = common.JsonDeserialize<List<tsd>>(deleted);
                    context.Response.Write(Delete(lst));
                }
                if (inserted != null)
                {
                    lst = common.JsonDeserialize<List<tsd>>(inserted);
                }
                if (updated != null)
                {
                    lst = common.JsonDeserialize<List<tsd>>(updated);
                    context.Response.Write(Update(lst));
                }
                break;
            case "end":
                equip_code = context.Request.Params["code"];
                context.Response.Write(IsSongDian());
                break;
            default:
                break;
        }

        //context.Response.Write(showData());
    }

    public string showData()
    {
        string returnStr = "";
        List<tsd> Grid = new List<tsd>();
        string lStrSQL = @"select dVchWorkNote,t_TSD.equip_code,equip_cdh,requestUnit,requestPeo,requestStopTime,actionStopTime,actionStopPeo,requestEndUnit,requestEndPeo,requestEndTime,actionEndTime,actionEndPeo,dVchRemark,equip_name,dIntNote from t_TSD 
                inner join t_Equips on t_Equips.equip_code = t_TSD.equip_code order by requestStopTime desc,dVchWorkNote,equip_code";
        System.Data.DataTable dt = null;
        using (dt = claSqlConnDB.ExecuteDataset(claSqlConnDB.gStrConnDefault, System.Data.CommandType.Text, lStrSQL).Tables[0])
        {
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                tsd tmp = new tsd();
                tmp.dVchWorkNote = dt.Rows[i][0].ToString();
                tmp.equip_code = dt.Rows[i][1].ToString();
                tmp.equip_cdh = dt.Rows[i][2].ToString();
                tmp.requestUnit = dt.Rows[i][3].ToString();
                tmp.requestPeo = dt.Rows[i][4].ToString();
                tmp.requestStopTime = dt.Rows[i][5].ToString() == "" ? "" : dt.Rows[i][5].ToString();
                tmp.actionStopTime = dt.Rows[i][6].ToString() == "" ? "" : dt.Rows[i][6].ToString();
                tmp.actionStopPeo = dt.Rows[i][7].ToString();
                tmp.requestEndUnit = dt.Rows[i][8].ToString();
                tmp.requestEndPeo = dt.Rows[i][9].ToString();
                tmp.requestEndTime = dt.Rows[i][10].ToString() == "" ? "" : dt.Rows[i][10].ToString();
                tmp.actionEndTime = dt.Rows[i][11].ToString() == "" ? "" : dt.Rows[i][11].ToString();
                tmp.actionEndPeo = dt.Rows[i][12].ToString();
                tmp.dVchRemark = dt.Rows[i][13].ToString();
                tmp.equip_name = dt.Rows[i][14].ToString();
                tmp.dIntNote = dt.Rows[i][15].ToString();
                Grid.Add(tmp);
            }
        }
        return returnStr = JsonConvert.SerializeObject(Grid);
    }
    private string Update(List<tsd> Item)
    {
        string lStrSQL = "";
        int j = 0;
        int k = 0;
        for (int i = 0; i < Item.Count; i++)
        {

            lStrSQL = @"update t_TSD set equip_cdh = '" + Item[i].equip_cdh + "',requestUnit = '" + Item[i].requestUnit + "',requestPeo = '" + Item[i].requestPeo + "',requestStopTime = '" + Item[i].requestStopTime +
                "',actionStopTime = '" + Item[i].actionStopTime + "',actionStopPeo = '" + Item[i].actionStopPeo + "',requestEndUnit = '" + Item[i].requestEndUnit + "',requestEndPeo = '" + Item[i].requestEndPeo +
                "',requestEndTime = '" + Item[i].requestEndTime + "',actionEndTime = '" + Item[i].actionEndTime + "',actionEndPeo = '" + Item[i].actionEndPeo + "',dVchRemark = '" + Item[i].dVchRemark + "' where dIntNote = " + Item[i].dIntNote + "";
            k = claSqlConnDB.ExecuteNonQuery(claSqlConnDB.gStrConnDefault, CommandType.Text, lStrSQL);
            if (k > 0)
            {
                lStrSQL = "select success_index from t_TSDManage where equip_code = '" + Item[i].equip_code + "'";
                SqlDataReader dr_success_index = null;
                using (dr_success_index = claSqlConnDB.ExecuteReader(claSqlConnDB.gStrConnDefault, CommandType.Text, lStrSQL))
                {
                    if (dr_success_index.Read())
                    {
                        if (dr_success_index.GetInt32(0) == 0)
                        {
                            //表示用户选择了正确的申请送电时间，则可以开始计数
                            if (Item[i].requestEndTime.Split(' ')[1] != "0:00:00" && Item[i].requestEndTime.Split(' ')[1] != "00:00:00")
                            {
                                //更新送电次数
                                lStrSQL = @"update t_TSDManage set end_count = end_count + 1 where equip_code = '" + Item[i].equip_code + "'";
                                claSqlConnDB.ExecuteNonQuery(claSqlConnDB.gStrConnDefault, CommandType.Text, lStrSQL);
                            }
                        }
                        else
                        {

                        }
                    }
                    dr_success_index.Close();
                    dr_success_index.Dispose();
                }

                //当用户修改了 送电执行时间 
                if (Item[i].actionEndTime != "")
                {
                    if (Item[i].actionEndTime.Split(' ')[1] != "0:00:00" && Item[i].actionEndTime.Split(' ')[1] != "00:00:00")
                    {
                        lStrSQL = @"select stop_count,end_count from t_TSDManage where equip_code = '" + Item[i].equip_code + "'";
                        SqlDataReader dr = null;
                        using (dr = claSqlConnDB.ExecuteReader(claSqlConnDB.gStrConnDefault, CommandType.Text, lStrSQL))
                        {
                            if (dr.Read())
                            {
                                //当送电申请与停电申请数一样时，将该设备完成标识置为1
                                if (dr.GetInt32(0) <= dr.GetInt32(1))
                                {
                                    lStrSQL = @"update t_TSDManage set success_index = 1 where equip_code = '" + Item[i].equip_code + "'";
                                    claSqlConnDB.ExecuteNonQuery(claSqlConnDB.gStrConnDefault, CommandType.Text, lStrSQL);

                                    lStrSQL = @"update t_TSDManage set end_count = stop_count where equip_code = '" + Item[i].equip_code + "'";
                                    claSqlConnDB.ExecuteNonQuery(claSqlConnDB.gStrConnDefault, CommandType.Text, lStrSQL);
                                }
                            }
                            dr.Close();
                            dr.Dispose();
                        }
                    }
                }
 
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
    private string Delete(List<tsd> Item)
    {
        string lStrSQL = "";
        int k = 0;
        int j = 0;
        for (int i = 0; i < Item.Count; i++)
        {
            lStrSQL = @"delete from t_TSD where dIntNote = " + Int32.Parse(Item[i].dIntNote) + "";
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
    //如果返回为1，表示不能送电   0可以送电
    public int IsSongDian()
    {
        int i = -100;
        string lStrSql = "select success_index from t_TSDManage where equip_code = '" + equip_code + "'";
        SqlDataReader dr = null;
        using (dr = claSqlConnDB.ExecuteReader(claSqlConnDB.gStrConnDefault, CommandType.Text, lStrSql))
        {
            if (dr.Read())
            {
                if (dr.GetInt32(0) == 0)//表示需要变色
                {
                    //返回为1表示 还有停电数  返回为0表示可以送电了，可以变绿
                    lStrSql = "select count(*) from t_TSDManage t inner join t_Equips on t_Equips.equip_code = t.equip_code  where t.equip_code = '" + equip_code + "' and t.stop_count > t.end_count and success_index = 0";
                    i = claSqlConnDB.GetRecordCount(claSqlConnDB.gStrConnDefault, lStrSql);
                }
                else
                {
                    
                }
            }
            dr.Close();
            dr.Dispose();
        }
        return i;
    }
    public bool IsReusable {
        get {
            return false;
        }
    }

}