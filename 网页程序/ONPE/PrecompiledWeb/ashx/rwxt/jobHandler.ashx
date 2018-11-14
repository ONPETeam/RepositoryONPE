<%@ WebHandler Language="C#" Class="jobHandler" %>

using System;
using System.Web;
using Newtonsoft.Json;
using NPE.UIDataClass;
using System.Data;
using System.Collections.Generic;
using ModelClass;
using System.Text;

public class jobHandler : IHttpHandler {
    int page = 1;
    int rows = 10;
    string order = "";
    string sort = "";
    public void ProcessRequest (HttpContext context) {
        string workNote = "";
        string action = "";
        RequestReturn mRequestReturn = new RequestReturn();
        context.Response.ContentType = "text/plain";
        action = context.Request.Params["action"];

        switch (action)
        {
            case "prop":
                workNote = context.Request.Params["worknote"];
                if (workNote != "")
                {
                    mRequestReturn.responstResult = true;
                    mRequestReturn.responstDetial = GetGzpProp(workNote);
                    mRequestReturn.responstMsg = "所请求的数据已成功返回";
                }
                else
                {
                    mRequestReturn.responstResult = false;
                    mRequestReturn.responstDetial = "缺少必要参数";
                    mRequestReturn.responstMsg = "缺少必要参数";
                }
                break;
            case "item":
                workNote = context.Request.Params["worknote"];
                if (workNote != "")
                {
                    mRequestReturn.responstResult = true;
                    mRequestReturn.responstDetial = showItemData(workNote);
                    mRequestReturn.responstDetial = mRequestReturn.responstDetial;
                    mRequestReturn.responstMsg = "所请求的数据已成功返回";
                }
                else
                {
                    mRequestReturn.responstResult = false;
                    mRequestReturn.responstDetial = "缺少必要参数";
                    mRequestReturn.responstMsg = "缺少必要参数";
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
                mRequestReturn.responstResult = true;
                mRequestReturn.responstDetial = GetGzpData();
                mRequestReturn.responstMsg = string.Format("\"total\":{0},\"rows\":", GetCount());
                break;
            default:
                mRequestReturn.responstResult = false;
                mRequestReturn.responstDetial = "缺少必要参数";
                mRequestReturn.responstMsg = "缺少必要参数";
                break;
        }
        context.Response.Write(JsonConvert.SerializeObject(mRequestReturn));
    }
    private string GetCount()
    {
        string mStrSQL = @" select count(0) from t_GZP ";
        int i = claSqlConnDB.GetRecordCount(claSqlConnDB.gStrConnDefault, mStrSQL);
        return i.ToString();
    }
    private List<gzp> GetGzpData()
    {
        List<gzp> gzpGrid = new List<gzp>();
        string lStrSQL = @"select dVchWorkNote,dVchWorkCreatUnit,dVchWorkCreatPeo,
                            dDaeWorkSys,dVchActionDep,dVchArea,dDaeWorkStart,dVchWorkPeo,
                            dVchWorkPeoQZ,dDaeWorkEnd,dVchWorkPeo1,dVchWorkPeoQZ1,dVchFromType 
                            from t_GZP ";
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
        return gzpGrid;
    }
    private List<gzItem> showItemData(string workNote)
    {
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
        return gzItemGrid;
    }

    private gzp GetGzpProp(string vStrWorkNote) 
    {
        gzp mGzp=new gzp();
        string mStrSQL = @"select dVchWorkNote,dVchWorkCreatUnit,dVchWorkCreatPeo,
                           dDaeWorkSys,dVchActionDep,dVchArea,dDaeWorkStart,dVchWorkPeo,
                           dVchWorkPeoQZ,dDaeWorkEnd,dVchWorkPeo1,dVchWorkPeoQZ1,dVchFromType 
                           from t_GZP where dVchWorkNote='" + vStrWorkNote + "' order by dDaeWorkSys desc";
        mGzp = (gzp)claSqlConnDB.GetDetail(claSqlConnDB.gStrConnDefault, mStrSQL, "ModelClass.gzp", null);
        return mGzp;
    }
    public bool IsReusable {
        get {
            return false;
        }
    }

}