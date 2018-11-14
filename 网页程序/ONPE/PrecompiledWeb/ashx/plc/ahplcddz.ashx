<%@ WebHandler Language="C#" Class="ahplcddz" %>

using System;
using System.Web;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using Newtonsoft.Json;
using ModelClass;
using System.Text;
using NPE.UIDataClass;

public class ahplcddz : IHttpHandler {
    string sort = "";
    string order = "";

    int page = 1;
    int rows = 10;

    string mStrplc = "";
    string mStrddz = "";
    string mStreqd = "";
    string mStrsxt = "";
    string mStrSb = "";

    string equip_parent = "";
    string area_id = "";
    string glsOrbj = "";
    public void ProcessRequest (HttpContext context) {
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
        if (context.Request.Params["page"] != null)
        {
            page = int.Parse(context.Request.Params["page"]);//页码
        }
        if (context.Request.Params["rows"] != null)
        {
            rows = int.Parse(context.Request.Params["rows"]);//页容量
        }

        if (context.Request.Params["action"] != null)
        {
            action = context.Request.Params["action"];
        }
        if (context.Request.Form["plc"] != null)
        {
            mStrplc = context.Request.Form["plc"]; 
        }
        if(context.Request.Form["ddz"] != null)
        {
            mStrddz = context.Request.Form["ddz"];
        }
        if (context.Request.Params["eqd"] != null)
        {
            mStreqd = context.Request.Params["eqd"];
        }
        if (context.Request.Params["xt"] != null)
        {
            mStrsxt = context.Request.Params["xt"];
        }
        if (context.Request.Params["sb"] != null)
        {
            mStrSb = context.Request.Params["sb"];
        }
        if (context.Request.Params["equip_parent"] != null)
        {
            equip_parent = context.Request.Params["equip_parent"];
        }
        if (context.Request.Params["area_id"] != null)
        {
            area_id = context.Request.Params["area_id"];
        }
        glsOrbj = context.Request.Params["lsOrbj"];
        switch (action)
        {
            case "grid":
                GetGridMsg(context);
                break;
            case "combobox":
                //context.Response.Write(this.GetCombobox());
                GetComboboxMsg(context);
                break;
            case"eqddz":
                context.Response.Write(this.GetEquipTree(equip_parent, area_id));
                break;
            case"ddz":
                context.Response.Write(this.Getddz(mStrSb));
                break;
            case"tsjl":
                context.Response.Write(this.GetTsjl());
                break;
            default:
                break; 
        }

    }
    private void GetGridMsg(HttpContext context)
    {
        string mStrResult = "";
        GJHF.Business.PLC.BPlcDdz mBPlcDdz = new GJHF.Business.PLC.BPlcDdz();
        List<GJHF.Data.Model.PLC.MPlcCommon> mlist = mBPlcDdz.GetListData(rows, page, mStreqd, mStrplc, mStrsxt, mStrSb, mStrddz, glsOrbj);
        int count = GJHF.Business.PLC.BPlcDdz.GetRecordCount(mStreqd, mStrplc, mStrsxt, mStrSb, mStrddz,glsOrbj);
        //mStrResult = GJHF.Utility.WEBUI.EasyuiControl.GetGridReturn(GJHF.Business.PLC.BPlcDdz.GetRecordCount(mStreqd, mStrplc, mStrsxt, mStrSb, mStrddz), GJHF.Business.PLC.BPlcDdz.GetData(rows, page, mStreqd, mStrplc, mStrsxt, mStrSb, mStrddz));
        mStrResult = GJHF.Utility.WEBUI.EasyuiControl.GetGridReturn(count, mlist);
        context.Response.Write(mStrResult);
    }
    private void GetComboboxMsg(HttpContext context)
    {
        string mStrResult = "";
        mStrResult = JsonConvert.SerializeObject(GJHF.Business.PLC.BPlcAndSb.GetCombobox(mStreqd));
        context.Response.Write(mStrResult);
    }
    
    //设备树
    private string GetEquipTree(string equipParent, string areaID)
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
        string mStrSQL = " SELECT  equip_code, equip_name,connect_prop from t_Equips " + mStrWhere + " order by equip_name";

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
                    if (GetddzTreeNum(dt.Rows[i][0].ToString()) > 0)
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
        return JsonConvert.SerializeObject(listTree);
    }
    private int GetddzTreeNum(string equipParent)
    {
        string mStrSQL = " select count(0) from tZSbAndPLC where dVchSbBianHao ='" + equipParent + "'";
        int i = claSqlConnDB.GetRecordCount(claSqlConnDB.gStrConnDefault, mStrSQL);
        return i;
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
    
    //从设备树下显示点地址
    private string Getddz(string areaParent)
    {
        List<TreeNode> listTree = new List<TreeNode>();
        DataTable dt = null;
        string mStrSQL = @" SELECT   tZPlcPointDiZhi.dVchAllAdress, tZPlcPointDiZhi.dVchAddress,dVchDescription FROM   tZSbAndPLC 
                                         left outer join tZPlcPointDiZhi on tZSbAndPLC.dVchPLCAddress = tZPlcPointDiZhi.dIntDataID where  dVchSbBianHao='" + areaParent + "'";
        using (dt = claSqlConnDB.ExecuteDataset(claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL).Tables[0])
        {
            if (dt.Rows.Count > 0)
            {
                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    TreeNode treeTemp = new TreeNode();
                    treeTemp.id = dt.Rows[i][0].ToString();
                    treeTemp.text = dt.Rows[i][1].ToString() + "-" + dt.Rows[i][2].ToString();
                    treeTemp.state = "open";
                    treeTemp.attributes = "dc";
                    treeTemp.iconCls = "icon-process";
                    listTree.Add(treeTemp);
                }
            }
        }
        return JsonConvert.SerializeObject(listTree);
    }
    //推送记录
    private string GetTsjl()
    {
        string mStrResult = "";
        mStrResult = GJHF.Utility.WEBUI.EasyuiControl.GetGridReturn(GJHF.Business.PLC.BPlcPushTemp.GetRecord(""), GJHF.Business.PLC.BPlcPushTemp.GetData(rows, page, ""));
        return mStrResult;
        
    }
   
    
    public bool IsReusable {
        get {
            return false;
        }
    }

}