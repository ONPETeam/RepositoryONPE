<%@ WebHandler Language="C#" Class="ahplcAndSb" %>

using System;
using System.Web;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using Newtonsoft.Json;
using ModelClass;
using System.Text;
using NPE.UIDataClass;

public class ahplcAndSb : IHttpHandler {
    string sort = "";
    string order = "";
    string ddz = "";
    string mStreqd = "";
    int page = 1;
    int rows = 10;
    public void ProcessRequest(HttpContext context)
    {
        string action = "";
        context.Response.ContentType = "text/plain";
        if (context.Request.Params["sort"] != null)
        {
            sort = context.Request.Params["sort"];
        }
        if (context.Request.Params["order"] != null)
        {
            order = context.Request.Params["order"];
        }
        if (context.Request.Form["page"] != null)
        {
            page = int.Parse(context.Request.Form["page"]);//页码
        }
        if (context.Request.Form["rows"] != null)
        {
            rows = int.Parse(context.Request.Form["rows"]);//页容量
        }

        if (context.Request.Params["action"] != null)
        {
            action = context.Request.Params["action"];
        }
        if (context.Request.Params["vddz"] != null)
        {
            ddz = context.Request.Params["vddz"];
        }
        if (context.Request.Params["eqd"] != null)
        {
            mStreqd = context.Request.Params["eqd"];
        }
        switch (action)
        {
            case "grid":
                //System.Text.StringBuilder sb = new System.Text.StringBuilder();
                //sb.Append("{ ");
                //sb.Append(string.Format("\"total\":{0},\"rows\":", GetRecord()));
                //string s = getGrid();
                //sb.Append(s);
                //sb.Append("}");
                //context.Response.Write(sb.ToString());
                getGridS(context);
                break;
            case "gridbd":
                //System.Text.StringBuilder sbbd = new System.Text.StringBuilder();
                //sbbd.Append("{ ");
                //sbbd.Append(string.Format("\"total\":{0},\"rows\":", GetRecordbd()));
                //string sbd = Girdbd();
                //sbbd.Append(sbd);
                //sbbd.Append("}");
                //context.Response.Write(sbbd.ToString());
                getGridbdS(context);
                break;
            case"del":
                //Del(context);
                GetDelid(context);
                break;
            default:
                break;
        }
    }
    private void getGridS(HttpContext context)
    {
        DataTable dt = GJHF.Business.PLC.BPlcAndSb.GetGrid(rows, page, ddz);
        int count = GJHF.Business.PLC.BPlcAndSb.GetRecord(ddz);
        string mStrJson = GJHF.Utility.WEBUI.EasyuiControl.GetGridReturn(count, dt);
        context.Response.Write(mStrJson);
    }

    private void getGridbdS(HttpContext context)
    {
        DataTable dt = GJHF.Business.PLC.BPlcAndSb.GetGridbd(rows,page,mStreqd);
        int count = GJHF.Business.PLC.BPlcAndSb.GetRecordbd(mStreqd);
        string mStrJson = GJHF.Utility.WEBUI.EasyuiControl.GetGridReturn(count,dt);
        context.Response.Write(mStrJson);
         
    }
    private void GetDelid(HttpContext context)
    {
         int mbd = Int32.Parse(context.Request.QueryString["ID"]);//删除的主键
        string mStrMsg = "";
        if (GJHF.Business.PLC.BPlcAndSb.Delid(mbd.ToString(), out mStrMsg) == true)
        {
            context.Response.Write(1);
        }
        else
        {
            context.Response.Write(-1); 
        }
    }
    private string getGrid()
    {
        StringBuilder sb = new StringBuilder();
        List<plcAndSb> Grid = new List<plcAndSb>();
        string lStrSql = @"select dIntID,dVchSbBianHao,dVchPLCAddress,equip_code,equip_innum,equip_name,equip_mark,equip_type,equip_parent,
                            t_Equips.area_id,t_EquipArea.area_name  from tZSbAndPLC left outer join t_Equips on  tZSbAndPLC.dVchSbBianHao = t_Equips.equip_code 
                            left outer join t_EquipArea on t_Equips.area_id = t_EquipArea.area_id" + GetWhere() + GetOrder();

        DataTable dt = null;
        using (dt = claSqlConnDB.ExecuteDataset(rows, page, claSqlConnDB.gStrConnDefault, CommandType.Text, lStrSql).Tables[0])
        {
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                plcAndSb mModel = new plcAndSb();
                if (dt.Rows[i][0].ToString() != "")
                {
                    mModel.dIntID = Int32.Parse(dt.Rows[i][0].ToString());
                }

                mModel.dVchSbBianHao = dt.Rows[i][1].ToString();
                mModel.dVchPLCAddress = dt.Rows[i][2].ToString();
                mModel.equip_code = dt.Rows[i][3].ToString();
                mModel.equip_innum = dt.Rows[i][4].ToString();
                mModel.equip_name = dt.Rows[i][5].ToString();
                mModel.equip_mark = dt.Rows[i][6].ToString();
                mModel.equip_type = dt.Rows[i][7].ToString();
                mModel.equip_parent = dt.Rows[i][8].ToString();
                mModel.area_id = dt.Rows[i][9].ToString();
                mModel.area_name = dt.Rows[i][10].ToString();

                Grid.Add(mModel);

            }


        }

        return JsonConvert.SerializeObject(Grid);

    }
    private string GetRecord()
    {
        string total = "";
        total = claSqlConnDB.GetRecordCount(claSqlConnDB.gStrConnDefault, "select count(*) from tZSbAndPLC " + GetWhere()).ToString();
        return total;
    }
    private string GetWhere()
    {
        string mStrWhere = " where dIntID <> -10";
        if (ddz != "")
        {
            mStrWhere = mStrWhere + " and dVchPLCAddress = " + ddz;
        }

        return mStrWhere;
    }

    private string GetOrder()
    {
        string mStrOrder = "order by dIntID  ";
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

    //点地址绑定grid
    public string Girdbd()
    {
        StringBuilder sb = new StringBuilder();
        List<plcbd> Grid = new List<plcbd>();
        string lStrSql = @"SELECT  dIntID, dVchSbBianHao, dVchPLCAddress,tZPlcPointDiZhi.dVchAddress,tZPlcPointDiZhi.dVchAdressName,
                            tZPlcPointDiZhi.dVchDescription,dIntBaojingType,dVchDataValue FROM   tZSbAndPLC left outer join tZPlcPointDiZhi on tZSbAndPLC.dVchPLCAddress =   tZPlcPointDiZhi.dIntDataID 
                            left outer join tZPLCNowData on tZSbAndPLC.dVchPLCAddress = tZPLCNowData.dIntdizhiID" + GetBdWhere() + GetOrder();

     
        DataTable dt = null;
        using (dt = claSqlConnDB.ExecuteDataset(rows, page, claSqlConnDB.gStrConnDefault, CommandType.Text, lStrSql).Tables[0])
        {

            for (int i = 0; i < dt.Rows.Count; i++)
            {
                plcbd mModel = new plcbd();
                if (dt.Rows[i][0].ToString() != "")
                {
                    mModel.dIntID = Int32.Parse(dt.Rows[i][0].ToString());
                }

                mModel.dVchSbBianHao = dt.Rows[i][1].ToString();
                mModel.dVchPLCAddress = dt.Rows[i][2].ToString();
                mModel.dVchAddress = dt.Rows[i][3].ToString();
                mModel.dVchAdressName = dt.Rows[i][4].ToString();
                mModel.dVchDescription = dt.Rows[i][5].ToString();
                if (string.IsNullOrEmpty(dt.Rows[i][6].ToString()) == false)
                {
                    mModel.dIntBaojingType = (int)dt.Rows[i][6];
                }
                else
                {
                    mModel.dIntBaojingType = 0;
                }
                mModel.dVchDataValue = dt.Rows[i][7].ToString();
                Grid.Add(mModel);
            }
        }

        return JsonConvert.SerializeObject(Grid); 
    }
    private string GetRecordbd()
    {
        string total = "";
        total = claSqlConnDB.GetRecordCount(claSqlConnDB.gStrConnDefault, "select count(*) from tZSbAndPLC " + GetBdWhere()).ToString();
        return total;
    }
    private string GetBdWhere()
    {
        string mStrWhere = " where dIntID <> -10";
        if (mStreqd != "")
        {
            mStrWhere = mStrWhere + " and dVchSbBianHao = '" + mStreqd + "'";
        }
      
        return mStrWhere;
    }
  
    /// <summary>
    /// 删除操作
    /// </summary>
    private void Del(HttpContext context)
    {
        int mbd = Int32.Parse(context.Request.QueryString["ID"]);//删除的主键
        string sql = "delete from tZSbAndPLC where dIntID=@mIntbd";
        using (SqlConnection con = new SqlConnection(claSqlConnDB.gStrConnDefault))
        {
            con.Open();
            SqlCommand cmd = new SqlCommand(sql, con);
            SqlParameter p = new SqlParameter("@mIntbd", mbd);
            cmd.Parameters.Add(p);

            if (cmd.ExecuteNonQuery() >= 0)
            {
                context.Response.Write(1);
            }
            else
            {
                context.Response.Write(-1); 
            }
            con.Close();
            
        }
    }


    public bool IsReusable
    {
        get
        {
            return false;
        }
    }

}