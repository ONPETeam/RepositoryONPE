<%@ WebHandler Language="C#" Class="plcmanager" %>

using System;
using System.Web;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using Newtonsoft.Json;
using ModelClass;
using System.Text;
using NPE.UIDataClass;

public class plcmanager : IHttpHandler {
    string sort = "";
    string order = "";

    int page = 1;
    int rows = 10;

    string mStrPLCName = "";
    string mStrSxt = "";

    string mStrErr = "";
    
    string area_parent = "";
    public HttpRequest Request
    {
        get
        {
            return HttpContext.Current.Request;
        }
    }
    private HttpResponse Response
    {
        get { return HttpContext.Current.Response; }
    }
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
        if (context.Request.Params["area_parent"] != null)
        {
            area_parent = context.Request.Params["area_parent"]; 
        }
        if (Request.Form["plcname"] != null)
        {
            mStrPLCName = Request.Form["plcname"];
        }
        if (Request.Form["gyxt"] != null)
        {
            mStrSxt = Request.Form["gyxt"];
        }
        string mstrcondition = "";
        string mstrresult = "";
        switch (action) 
        {
            case "tree":
                context.Response.Write(this.GetAreaTreeJson(GetAreaTree(area_parent)));
                break;
            
            case "grid":
                //System.Text.StringBuilder sb = new System.Text.StringBuilder();
                //sb.Append("{ ");
                //sb.Append(string.Format("\"total\":{0},\"rows\":", GetRecord()));
                //string s = getGrid();
                //sb.Append(s);
                //sb.Append("}");
                //context.Response.Write(sb.ToString());
                mstrcondition = GetWhere() + GetOrder();
                mstrresult = GJHF.Utility.WEBUI.EasyuiControl.GetGridReturn(GJHF.Business.PLC.BPlcManager.GetRecordCount(GetWhere()), GJHF.Business.PLC.BPlcManager.GetData(rows, page, mstrcondition));
                context.Response.Write(mstrresult);
                break;
            case "add": 
                Add(context); 
                break;
            case "delete": 
                Delete(context); 
                break;
            case "edit": 
                Edit(context); 
                break;
            case "combox":
                mstrresult = JsonConvert.SerializeObject(GJHF.Business.PLC.BPlcManager.GetComboData(" order by tZPLCArea.dIntAreaID"));
                context.Response.Write(mstrresult);
                break;
            case "xt":
                context.Response.Write(this.GetAreaTreeJson(this.GetXitong(area_parent)));
                break;
            case "plc":
                context.Response.Write(this.GetAreaTreeJson(this.Getplc(area_parent)));
                break;
            case "ddz":
                context.Response.Write(this.GetAreaTreeJson(this.Getddz(area_parent)));
                break;
            case "AreaDdz":
                context.Response.Write(this.GetAreaTreeJson(this.GetAreaXTddz(area_parent)));
                break;
            case "prop":
                context.Response.Write(this.GetProperty(area_parent));
                break;
            case "propddz":
                context.Response.Write(this.GetPropertyddz(area_parent));
                break;
            case "treeIP":
                context.Response.Write(this.GetAreaTreeJson(GetPLCAreaTree(area_parent)));
                break;
            case "PlcIP":
                context.Response.Write(this.GetAreaTreeJson(GetTreeIPplc(area_parent)));
                break;
            case "PlcPP":
                context.Response.Write(this.GetPinPai());
                break;
            default:
                break;
                
        }
    }
    
//    private string getGrid()
//    {
//        List<PLCManager> plcGrid = new List<PLCManager>();
//        string lStrSql = @"select dIntPLCID, dVchPLCName, dVchIPAdress, tZPLCManager.dIntPLCPinPaiID, dIntGongYiXitongID, tZPLCManager.dVchRemark,tZPLCPinpai.dVchPLCPinPaiName,tZPLCArea.dVchArea,dVchPLCbianma
//                            from tZPLCManager left outer join tZPLCArea on tZPLCManager.dIntGongYiXitongID = tZPLCArea.dIntAreaID
//                            left outer join tZPLCPinpai on tZPLCManager.dIntPLCPinPaiID = tZPLCPinpai.dIntPLCPinPaiID " + GetWhere() + GetOrder();

//        DataTable dt = null;
//        using (dt = claSqlConnDB.ExecuteDataset(rows, page, claSqlConnDB.gStrConnDefault, CommandType.Text, lStrSql).Tables[0])
//        {
//            for (int i = 0; i < dt.Rows.Count; i++)
//            {
//                PLCManager mclaPLCManager = new PLCManager();
//                mclaPLCManager.dIntPLCID = (int)dt.Rows[i][0];
//                mclaPLCManager.dVchPLCName = dt.Rows[i][1].ToString();
//                mclaPLCManager.dVchIPAdress = dt.Rows[i][2].ToString();

//                if (dt.Rows[i][3].ToString() != "")
//                {
//                    mclaPLCManager.dIntPLCPinPaiID = (int)dt.Rows[i][3];
//                }
//                if (dt.Rows[i][4].ToString() != "")
//                {
//                    mclaPLCManager.dIntGongYiXitongID = (int)dt.Rows[i][4];
//                }
//                //mclaPLCManager.dIntPLCPinPaiID = (int)dt.Rows[i][3];
//                //mclaPLCManager.dIntGongYiXitongID = (int)dt.Rows[i][4];
//                mclaPLCManager.dVchRemark = dt.Rows[i][5].ToString();
//                mclaPLCManager.dVchPLCPinPaiName = dt.Rows[i][6].ToString();
//                mclaPLCManager.dVchArea = dt.Rows[i][7].ToString();
//                mclaPLCManager.dVchPLCbianma = dt.Rows[i][8].ToString();
//                plcGrid.Add(mclaPLCManager);
//            }
//        }
//        return JsonConvert.SerializeObject(plcGrid);

        
//    }
    private string GetRecord()
    {
        string total = "";
        string mStrSQL = @"select COUNT(*) from tZPLCManager left outer join tZGongyiXitong on tZPLCManager.dIntGongYiXitongID = tZGongyiXitong.dIntPLCXitong
                                                                        left outer join tZPLCPinpai on tZPLCManager.dIntPLCPinPaiID = tZPLCPinpai.dIntPLCPinPaiID ";
        total = claSqlConnDB.GetRecordCount(claSqlConnDB.gStrConnDefault, mStrSQL + GetWhere()).ToString();
        return total;
    }
    private string GetWhere()
    {
        string mStrWhere = "where dIntPLCID <> 0 ";
        if (mStrSxt != "0" && mStrSxt != "")
        {
            mStrWhere = mStrWhere + " and dIntGongYiXitongID = " + mStrSxt;
        }
        if (mStrPLCName != "" && mStrPLCName != null)
        {
            mStrWhere = mStrWhere + " and  tZPLCManager.dVchPLCName + dVchIPAdress + tZPLCPinpai.dVchPLCPinPaiName  like '%" + mStrPLCName + "%'"; 
        }
        return mStrWhere;
    }
    private string GetOrder()
    {
        string mStrOrder = "order by dIntPLCID desc";
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

    private string GetAreaTreeJson(List<TreeNode> treend)
    {
        string mStrReturn = "";
        mStrReturn = JsonConvert.SerializeObject(treend);
        return mStrReturn;
    }
    private List<TreeNode> GetAreaTree(string areaParent)
    {
        List<TreeNode> listTree = new List<TreeNode>();
        DataTable dt = null;
        string mStrSQL = " SELECT  area_id, area_name, area_parent from t_EquipArea where area_parent=" + areaParent;
        using (dt = claSqlConnDB.ExecuteDataset(claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL).Tables[0])
        {
            if (dt.Rows.Count > 0)
            {
                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    TreeNode treeTemp = new TreeNode();
                    treeTemp.id = dt.Rows[i][0].ToString();
                    treeTemp.text = dt.Rows[i][1].ToString();
                    //treeTemp.state = "closed";
                    treeTemp.attributes = "xitong";



                    if (GetGongYiXitong(dt.Rows[i][0].ToString()) > 0)
                    {
                        treeTemp.state = "closed";
                        //treeTemp.attributes = "xitong";
                    }
                    else
                    {
                        //treeTemp.attributes = "abc";
                        //if (GetGongYiXitong(dt.Rows[i][0].ToString()) > 0)
                        //{
                        //    treeTemp.state = "closed";
                        //}
                        //else
                        //{
                        //    treeTemp.state = "open";
                        //}
                        treeTemp.state = "open";
                    }
                    //treeTemp.children = GetAreaTree(dt.Rows[i][0].ToString());
                    listTree.Add(treeTemp);
                }
            }
        }
        return listTree;
    }
    private List<TreeNode> GetXitong(string areaParent)
    {
        List<TreeNode> listTree = new List<TreeNode>();
        DataTable dt = null;
        string mStrSQL = " SELECT  dIntPLCXitong, dVchPLCXitongName from tZGongyiXitong where dIntPLCXitong<>0 and area_id=" + areaParent;
        using (dt = claSqlConnDB.ExecuteDataset(claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL).Tables[0])
        {
            if (dt.Rows.Count > 0)
            {
                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    TreeNode treeTemp = new TreeNode();
                    treeTemp.id = dt.Rows[i][0].ToString();
                    treeTemp.text = dt.Rows[i][1].ToString();
                    treeTemp.state = "closed";
                    treeTemp.attributes = "plc";

                    //if (GetGongYiXitong(dt.Rows[i][0].ToString()) > 0)
                    //{
                    //    treeTemp.state = "closed";
                    //    //treeTemp.attributes = "xitong";
                    //}
                    //else
                    //{
                    //    //treeTemp.attributes = "lastArea";
                    //    //if (GetGongYiXitong(dt.Rows[i][0].ToString()) > 0)
                    //    //{
                    //    //    treeTemp.state = "closed";
                    //    //}
                    //    //else
                    //    //{
                    //    //    treeTemp.state = "open";
                    //    //}
                    //    treeTemp.state = "open";
                        
                    //}
                    //treeTemp.children = GetAreaTree(dt.Rows[i][0].ToString());
                    listTree.Add(treeTemp);
                }
            }
        }
        return listTree;
    }
    private List<TreeNode> Getplc(string areaParent)
    {
        List<TreeNode> listTree = new List<TreeNode>();
        DataTable dt = null;
        string mStrSQL = " SELECT  dIntPLCID, dVchPLCName from tZPLCManager where dIntPLCID<>0 and dIntGongYiXitongID=" + areaParent;
        using (dt = claSqlConnDB.ExecuteDataset(claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL).Tables[0])
        {
            if (dt.Rows.Count > 0)
            {
                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    TreeNode treeTemp = new TreeNode();
                    treeTemp.id = dt.Rows[i][0].ToString();
                    treeTemp.text = dt.Rows[i][1].ToString();
                    treeTemp.state = "closed";
                    treeTemp.attributes = "ddz";

    
                    listTree.Add(treeTemp);
                }
            }
        }
        return listTree;
    }
    private List<TreeNode> Getddz(string areaParent)
    {
        List<TreeNode> listTree = new List<TreeNode>();
        DataTable dt = null;
        string mStrSQL = " SELECT  dIntDataID, dVchAddress from tZPlcPointDiZhi where dIntDataID<>0 and dIntPLCID=" + areaParent;
        using (dt = claSqlConnDB.ExecuteDataset(claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL).Tables[0])
        {
            if (dt.Rows.Count > 0)
            {
                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    TreeNode treeTemp = new TreeNode();
                    treeTemp.id = dt.Rows[i][0].ToString();
                    treeTemp.text = dt.Rows[i][1].ToString();
                    treeTemp.state = "open";
                    treeTemp.attributes = "dc";
                    treeTemp.iconCls = "icon-process";
                    listTree.Add(treeTemp);
                }
            }
        }
        return listTree;
    }
    //增加根据区域系统来显示点地址的功能
    private List<TreeNode> GetAreaXTddz(string areaParent)
    {
        List<TreeNode> listTree = new List<TreeNode>();
        DataTable dt = null;
        string mStrSQL = " SELECT  dIntDataID, dVchAddress from tZPlcPointDiZhi where dIntDataID<>0 and dIntAreaXitongID=" + areaParent;
        using (dt = claSqlConnDB.ExecuteDataset(claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL).Tables[0])
        {
            if (dt.Rows.Count > 0)
            {
                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    TreeNode treeTemp = new TreeNode();
                    treeTemp.id = dt.Rows[i][0].ToString();
                    treeTemp.text = dt.Rows[i][1].ToString();
                    treeTemp.state = "open";
                    treeTemp.attributes = "dc";
                    treeTemp.iconCls = "icon-process";
                    listTree.Add(treeTemp);
                }
            }
        }
        return listTree;
    }
    //增加根据区域和PLCIP地址来显示点地址功能
    //刷到车间级区域
    private List<TreeNode> GetPLCAreaTree(string areaParent)
    {
        List<TreeNode> listTree = new List<TreeNode>();
        DataTable dt = null;
        
        int plccount = 0;
        string mStrSQL = " SELECT  area_id, area_name, area_parent from t_EquipArea where area_parent=" + areaParent + " order by area_name";
        using (dt = claSqlConnDB.ExecuteDataset(claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL).Tables[0])
        {
            if (dt.Rows.Count > 0)
            {
                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    TreeNode treeTemp = new TreeNode();
                    treeTemp.id = dt.Rows[i][0].ToString();
                    treeTemp.text = dt.Rows[i][1].ToString();
                    plccount = GetplcCount(treeTemp.id);
                    if (plccount > 0)
                    {
                        treeTemp.state = "closed";
                        treeTemp.attributes = "lastArea";
                        
                    }

                    else 
                    {
                        
                        if (GetAreaTreeNum(treeTemp.id) > 0)
                        {
                            treeTemp.state = "closed";
                            treeTemp.attributes = "area";
                        }
                        else
                        {
                            treeTemp.attributes = "lastArea";
                            
                        }
                    }
                    
                    
                    treeTemp.iconCls = "icon-area";
                    listTree.Add(treeTemp);
                }
                 
            }
        }

        return listTree;
        
    }
    private List<TreeNode> GetTreeIPplc(string areaParent)
    {
        List<TreeNode> listTree = new List<TreeNode>();
        DataTable dt = null;
        int ddzcount = 0;
        string mStrSQL = " SELECT  dIntPLCID, dVchPLCName from tZPLCManager where dIntPLCID<>0 and dIntAreaXitongID=" + areaParent;
        using (dt = claSqlConnDB.ExecuteDataset(claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL).Tables[0])
        {
            if (dt.Rows.Count > 0)
            {
                
                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    
                    TreeNode treeTemp = new TreeNode();
                    treeTemp.id = dt.Rows[i][0].ToString();
                    treeTemp.text = dt.Rows[i][1].ToString();
                    ddzcount = GetddzNum(treeTemp.id);

                    if (ddzcount > 0)
                    {
                        treeTemp.state = "closed";
                    }
                    else
                    {
                        treeTemp.state = "open"; 
                    }
                    treeTemp.attributes = "ddz";
                    treeTemp.iconCls = "icon-aaa";

                    listTree.Add(treeTemp);
                }
            }
        }
        return listTree;
    }
    
    //此区域ID下是否包含PLC数据
    private int GetplcCount(string areaParent)
    {
        string mStrSQL = "select count(*) from tZPLCManager where dIntAreaXitongID =" + areaParent;
        int i = claSqlConnDB.GetRecordCount(claSqlConnDB.gStrConnDefault,mStrSQL);
        return i;
    }
    
    
    
    private int GetAreaTreeNum(string areaID)
    {
        string mStrSQL = " select count(0) from t_EquipArea where area_parent =" + areaID;
        int i = claSqlConnDB.GetRecordCount(claSqlConnDB.gStrConnDefault, mStrSQL);
        return i;
    }

    private int GetGongYiXitong(string areaID)
    {
        string mStrSQL = " select count(0) from tZGongyiXitong where area_id =" + areaID;
        int i = claSqlConnDB.GetRecordCount(claSqlConnDB.gStrConnDefault, mStrSQL);
        return i;
    }

    private int GetplcNum(string mStrXt)
    {
        string mStrSQL = " select count(0) from tZPLCManager where dIntGongYiXitongID =" + mStrXt;
        int i = claSqlConnDB.GetRecordCount(claSqlConnDB.gStrConnDefault, mStrSQL);
        return i;
    }

    private int GetddzNum(string mStrplc)
    {
        string mStrSQL = " select count(0) from tZPlcPointDiZhi where dIntPLCID =" + mStrplc;
        int i = claSqlConnDB.GetRecordCount(claSqlConnDB.gStrConnDefault, mStrSQL);
        return i;
    }

    private string GetProperty(string areaParent)
    {
        string returnStr = "";
        PropertyGrid property = new PropertyGrid();
        List<PropertyGridNode> propertyNode = new List<PropertyGridNode>();

        string lStrSql = @"SELECT   dVchPLCName as PLC名称, dVchIPAdress as IP地址, tZPLCPinpai.dVchPLCPinPaiName as 品牌 , tZGongyiXitong.dVchPLCXitongName as 工艺系统
                                FROM         tZPLCManager left outer join tZGongyiXitong on tZPLCManager.dIntGongYiXitongID = tZGongyiXitong.dIntPLCXitong
                                left outer join tZPLCPinpai on tZPLCManager.dIntPLCPinPaiID = tZPLCPinpai.dIntPLCPinPaiID  where dIntPLCID =  " + areaParent;
        DataTable dt = null;
        using (dt = claSqlConnDB.ExecuteDataset(claSqlConnDB.gStrConnDefault, CommandType.Text, lStrSql).Tables[0])
        {
            property.total = dt.Columns.Count;
            for (int i = 0; i < dt.Columns.Count; i++)
            {
                PropertyGridNode propertytmp = new PropertyGridNode();
                propertytmp.name = dt.Columns[i].ColumnName;
                propertytmp.value = dt.Rows[0][i].ToString();
                propertytmp.group = "PLC信息";
                //if (i != 2 && i != 0)
                //{
                //    propertytmp.editor = "text";
                //}

                propertyNode.Add(propertytmp);
            }
            property.rows = propertyNode;
        }
        return returnStr = JsonConvert.SerializeObject(property);
    }

    private string GetPropertyddz(string areaParent)
    {
        string returnStr = "";
        PropertyGrid property = new PropertyGrid();
        List<PropertyGridNode> propertyNode = new List<PropertyGridNode>();

        string lStrSql = @"SELECT  dVchAddress as 名称,dVchAdressName as 简称, dVchDescription as 描述, tNGongNengType.dVchGongNengName as 功能类型, dVchDataType as 数据类型,tZPLCIOType.dVchIOTypeName as 输出类型
                        FROM tZPlcPointDiZhi 
                        left outer join tNGongNengType on tZPlcPointDiZhi.dIntGongType = tNGongNengType.dIntGongNengID
                        left outer join tZPLCIOType on tZPlcPointDiZhi.dIntIOType = tZPLCIOType.dIntIOType
                        where dIntDataID =  " + areaParent;
        DataTable dt = null;
        using (dt = claSqlConnDB.ExecuteDataset(claSqlConnDB.gStrConnDefault, CommandType.Text, lStrSql).Tables[0])
        {
            property.total = dt.Columns.Count;
            for (int i = 0; i < dt.Columns.Count; i++)
            {
                PropertyGridNode propertytmp = new PropertyGridNode();
                propertytmp.name = dt.Columns[i].ColumnName;
                propertytmp.value = dt.Rows[0][i].ToString();
                if (i < 3)
                {
                    propertytmp.group = "信息";
                }
                else
                {
                    propertytmp.group = "分类";
                }
                //if (i != 2 && i != 0)
                //{
                //    propertytmp.editor = "text";
                //}

                propertyNode.Add(propertytmp);
            }
            property.rows = propertyNode;
        }
        return returnStr = JsonConvert.SerializeObject(property);
    }

    //plc品牌combobox
    private string GetPinPai()
    {
        try
        {
            List<plcPinPian> mlist = new List<plcPinPian>();
            string lStrSql = "select dIntPLCPinPaiID,dVchPLCPinPaiName from tZPLCPinpai";

            DataTable dt = null;
            using (dt = claSqlConnDB.ExecuteDataset(claSqlConnDB.gStrConnDefault, CommandType.Text, lStrSql).Tables[0])
            {
                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    plcPinPian mModel = new plcPinPian();
                    if (dt.Rows[i][0].ToString() != "")
                    {
                        mModel.dIntPLCPinPaiID = (int)dt.Rows[i][0];
                    }
                    mModel.dVchPLCPinPaiName = dt.Rows[i][1].ToString();

                    mlist.Add(mModel);
                }
            }

            return JsonConvert.SerializeObject(mlist);
        }
        catch (Exception s)
        {
            mStrErr = s.ToString();
            return mStrErr;
        } 

    }
    
    /// <summary>
    /// 编辑
    /// </summary>
    private void Edit(HttpContext context)
    {
        try
        {
            string mStrResult = "未定义";
            int mIntPLCID = Int32.Parse(Request.QueryString["ID"]);
            if (string.IsNullOrEmpty(Request.QueryString["ID"]) == false)
            {

            }
            string mStrPLCName = Request.Form["PLCName"];
            string mStrIPAdress = Request.Form["IPAdress"];
            int mIntPLCPinPaiID = 0;
            if (string.IsNullOrEmpty(Request.Form["PLCPinPaiID"]) == false)
            {
                mIntPLCPinPaiID = Int32.Parse(Request.Form["PLCPinPaiID"]);
            }
            int mIntGongYiXitongID = 0;
            if (string.IsNullOrEmpty(Request.Form["GongYiXitongID"]) == false)
            {
                mIntGongYiXitongID = Int32.Parse(Request.Form["GongYiXitongID"]);
            }
            string mStrRemark = Request.Form["dVchRemark"];
            string mStrPlcCode = Request.Form["nPlcCode"];



            if (GJHF.Business.PLC.BPlcManager.EditData(mIntPLCID, mStrPLCName, mStrIPAdress, mIntPLCPinPaiID, mIntGongYiXitongID, mStrRemark, mStrPlcCode) >= 0)
            {
                mStrResult = "成功";
            }
            else
            {
                mStrResult = "失败";
            }
            context.Response.Write(mStrResult);
        }
        catch (Exception eee)
        {
            context.Response.Write(eee.ToString()); 
        }
        //string sql = string.Format("select  dIntDataID,dVchAdressName,dVchAddress from tZPlcPointDiZhi where dIntDataID='{0}'", userid);
        //string sql = "update tZPLCManager set dVchPLCName = '" + mStrPLCName + "',dVchIPAdress = '" + mStrIPAdress + "',dIntPLCPinPaiID = '" + mIntPLCPinPaiID + "',dIntGongYiXitongID = " + mIntGongYiXitongID + ",dVchRemark = '" + mStrRemark + "', dVchPLCbianma = '"+ mStrPlcCode +"' where dIntPLCID = " + mIntPLCID + "";
        //DataTable dt = new DataTable();
        //DataSet ds = new DataSet();
        //using (SqlConnection con = new SqlConnection(claSqlConnDB.gStrConnDefault))
        //{
        //    con.Open();
        //    SqlCommand cmd = new SqlCommand(sql, con);
        //    if (cmd.ExecuteNonQuery() >= 0)
        //    {
        //        context.Response.Write(1);
        //    }

        //    con.Close();
        //}
        //MessageShow(1, "ww", dt);
    }
    /// <summary>
    /// 添加
    /// </summary>
    private void Add(HttpContext context)
    {
        try
        {
            string mStrResult = "未定义";
            string mStrPLCName = Request.Form["PLCName"];
            string mStrIPAdress = Request.Form["IPAdress"];
            int mIntPLCPinPaiID = 0;
            if (string.IsNullOrEmpty(Request.Form["PLCPinPaiID"]) == false)
            {
                mIntPLCPinPaiID = Int32.Parse(Request.Form["PLCPinPaiID"]);
            }

            int mIntGongYiXitongID = 0;
            if (string.IsNullOrEmpty(Request.Form["GongYiXitongID"]) == false)
            {
                mIntGongYiXitongID = Int32.Parse(Request.Form["GongYiXitongID"]);
            }

            string mStrRemark = Request.Form["dVchRemark"];
            string mStrPlcCode = Request.Form["nPlcCode"];

            if (GJHF.Business.PLC.BPlcManager.AddData(mStrPLCName, mStrIPAdress, mIntPLCPinPaiID, mIntGongYiXitongID, mStrRemark, mStrPlcCode) >= 0)
            {
                mStrResult = "成功";
            }
            else
            {
                mStrResult = "失败";
            }
            context.Response.Write(mStrResult);
        }
        catch (Exception eee)
        {
            context.Response.Write(eee.ToString());
        }
        //top = (int)claSqlConnDB.ExecuteScalar(claSqlConnDB.gStrConnDefault, CommandType.Text, "select Max(dIntPLCID) from tZPLCManager") + 1;
        //string sql = "insert into tZPLCManager(dIntPLCID,dVchPLCName,dVchIPAdress,dIntPLCPinPaiID,dIntGongYiXitongID,dVchRemark,dVchPLCbianma) values (" + top + ",'" + mStrPLCName + "','" + mStrIPAdress + "'," + mIntPLCPinPaiID + "," + mIntGongYiXitongID + ",'" + mStrRemark + "','" + mStrPlcCode + "')";
        
        //using (SqlConnection con = new SqlConnection(claSqlConnDB.gStrConnDefault))
        //{
        //    con.Open();
        //    SqlCommand cmd = new SqlCommand(sql, con);
        //    if (cmd.ExecuteNonQuery() >= 0)
        //    {
        //        context.Response.Write(1);
        //    }

        //    con.Close();

        //    //MessageShow(1, "新增成功", null);
        //}


    }
    /// <summary>
    /// 删除操作
    /// </summary>
    private void Delete(HttpContext context)
    {
        try
        {
            string mStrResult = "未处理";
            int mIntPLCID = 0;
            if (string.IsNullOrEmpty(Request.QueryString["ID"]) == false)
            {
                mIntPLCID = Int32.Parse(Request.QueryString["ID"]);//删除的主键
            }
            if (GJHF.Business.PLC.BPlcManager.DelData(mIntPLCID) >= 0)
            {
                mStrResult = "成功";
            }
            else
            {
                mStrResult = "失败";
            }
            context.Response.Write(mStrResult);
        }
        catch (Exception eee)
        {
            context.Response.Write(eee.ToString());
        }
        
        
        //string sql = "delete from tZPLCManager where dIntPLCID=@mIntPLCID";
        //using (SqlConnection con = new SqlConnection(claSqlConnDB.gStrConnDefault))
        //{
        //    con.Open();
        //    SqlCommand cmd = new SqlCommand(sql, con);
        //    SqlParameter p = new SqlParameter("@mIntPLCID", mIntPLCID);
        //    cmd.Parameters.Add(p);

        //    if (cmd.ExecuteNonQuery() >= 0)
        //    {
        //        context.Response.Write(1);
        //    }
        //    con.Close();
        //    //MessageShow(1, "删除成功", null);
        //}
    }
    
    //combox显示
    //public string GetCombobox()
    //{
        
    //    StringBuilder sb = new StringBuilder();
    //    List<PLCManager> mList = new List<PLCManager>();
    //    string lStrSql = string.Format(@"select dIntPLCID,dVchPLCName,tZPLCArea.dVchArea from tZPLCManager left outer join tZPLCArea on tZPLCManager.dIntGongYiXitongID = tZPLCArea.dIntAreaID where dIntPLCID <> 0 order by tZPLCArea.dIntAreaID", "", null);

    //    DataTable dt = null;

    //    using (dt = claSqlConnDB.ExecuteDataset(claSqlConnDB.gStrConnDefault, CommandType.Text, lStrSql).Tables[0])
    //    {
            
    //        for (int i = 0; i < dt.Rows.Count; i++)
    //        {
    //            PLCManager mModel = new PLCManager();
    //            mModel.dIntPLCID = (int)dt.Rows[i][0];
    //            mModel.dVchPLCName = dt.Rows[i][1].ToString();
    //            mModel.dVchPLCXitongName = dt.Rows[i][2].ToString();
    //            mList.Add(mModel);

    //        }
    //    }
    //    return JsonConvert.SerializeObject(mList);
    //}
    
    public bool IsReusable {
        get {
            return false;
        }
    }

}