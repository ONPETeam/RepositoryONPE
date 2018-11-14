<%@ WebHandler Language="C#" Class="ahplcXitong" %>

using System;
using System.Web;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using Newtonsoft.Json;
using ModelClass;
using System.Text;
using NPE.UIDataClass;

public class ahplcXitong : IHttpHandler {
    string sort = "";
    string order = "";

    int page = 1;
    int rows = 10;

    string mStrSArea = "";
    string mStrXTN = "";
    string mStrErr = "";
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
        
        switch (action)
        {
            case "treegrid":
                System.Text.StringBuilder sb1 = new System.Text.StringBuilder();
                sb1.Append("{ ");
                sb1.Append(string.Format("\"total\":{0},\"rows\":", GetRecord()));
                string s1 = GetTopXitong().Replace("]","") + "," + GetNodeXitong().Replace("[","");
                sb1.Append(s1);
                sb1.Append("}");
                context.Response.Write(sb1.ToString());
                break;
            case"combobox":
                context.Response.Write(this.GetCombox());
                break;
            case"topcombobox":
                context.Response.Write(this.GetTopCombobox());
                break;
             //区域信息
            case"AreaGrid":
                AreaGrid(context);
                break;
             //区域添加
            case"AreaAdd":
                this.AddArea(context);
                break;
            //区域修改    
            case"AreaEdit":
                this.EditArea(context);
                break;
            //区域删除    
            case"AreaDel":
                this.DelArea(context);
                break;
            //系统信息     
            case "grid":
                GetPointTypeGrid(context);
                break;
            //系统添加    
            case"PTAdd":
                this.AddPointType(context);
                break;
            //系统修改     
            case"PTEdit":
                this.EditPointType(context);
                break;
            //系统删除    
            case"PTDel":
                this.DelPointType(context);
                break;
            default:
                break;
        }
        
    }
    //Grid显示方法
    private void GetPointTypeGrid(HttpContext context)
    {
        DataTable dt = null;
        int count = 0;
        string mStrResult = "";
        if (context.Request.Params["vSArea"] != null)
        {
            mStrSArea = context.Request.Params["vSArea"].ToString();
        }
        if (context.Request.Params["vXTN"] != null)
        {
            mStrXTN = context.Request.Params["vXTN"].ToString();
        }
        dt = GJHF.Business.PLC.BPlcPointType.GetData(rows, page, mStrSArea, mStrXTN);
        count = GJHF.Business.PLC.BPlcPointType.GetRecordCount(mStrSArea, mStrXTN);
        mStrResult = GJHF.Utility.WEBUI.EasyuiControl.GetGridReturn(count, dt);
        context.Response.Write(mStrResult);
    }

    private string GetRecord()
    {
        string lStrSQL = "SELECT  count(*)  FROM t_XJPointType " + GetWhere();
        string total = "";
        total = claSqlConnDB.GetRecordCount(claSqlConnDB.gStrConnDefault, lStrSQL).ToString();
        return total;
    }
    private string GetWhere()
    {
        string mStrWhere = " where dIntNoteID <> 1";
        if (mStrSArea != "")
        {
            mStrWhere = mStrWhere + " and dIntSjNoteID in (" + mStrSArea + ")";
        }
        if (mStrXTN != "")
        {
            mStrWhere = mStrWhere + " and dIntNoteID in (" + mStrXTN + ")";
        }
        return mStrWhere; 
    }
    //private string GetOrder()
    //{
    //    string mStrOrder = "order by dIntSjNoteID,dIntPx";
    //    if (sort != "")
    //    {
    //        mStrOrder = "order by " + sort;
    //        if (order != "")
    //        {
    //            mStrOrder = mStrOrder + "" + order;
    //        }
    //    }
    //    return mStrOrder;
    //}
    //获取顶层树根数据
    private string GetTopXitong()
    {
        try
        {
            List<plcXitongTree> listTree = new List<plcXitongTree>();
            string lStrSql = @"SELECT  dIntNoteID, dVchPointType, dVchRemark, dIntSjNoteID FROM t_XJPointType where dIntSjNoteID = 0";

            DataTable dt = null;
            using (dt = claSqlConnDB.ExecuteDataset(rows,page,claSqlConnDB.gStrConnDefault, CommandType.Text, lStrSql).Tables[0])
            {
                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    plcXitongTree mModel = new plcXitongTree();

                    if (dt.Rows[i][0].ToString() != "")
                    {
                        mModel.id = (int)dt.Rows[i][0];
                    }
                    mModel.name = dt.Rows[i][1].ToString();
                    mModel.state = "closed";
                    listTree.Add(mModel);
                }
            }
            return JsonConvert.SerializeObject(listTree);

        }
        catch (Exception s)
        {
            mStrErr = s.ToString();
            return null;
        }
    }
    //获取各层节点数据
    private string GetNodeXitong()
    {
        try
        {
            List<plcXitongNode> listTree = new List<plcXitongNode>();
            string lStrSql = @"SELECT  dIntNoteID, dVchPointType, dVchRemark, dIntSjNoteID FROM t_XJPointType where dIntSjNoteID <> 0";
            DataTable dt = null;
            using (dt = claSqlConnDB.ExecuteDataset(claSqlConnDB.gStrConnDefault, CommandType.Text, lStrSql).Tables[0])
            {
                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    plcXitongNode mModel = new plcXitongNode();

                    if (dt.Rows[i][0].ToString() != "")
                    {
                        mModel.id = (int)dt.Rows[i][0];
                    }
                    mModel.name = dt.Rows[i][1].ToString();

                    
                    if (dt.Rows[i][3].ToString() != "")
                    {
                        mModel._parentId = (int)dt.Rows[i][3];
                    }

                    mModel.state = "open";
                    listTree.Add(mModel);
                }
            }

            return JsonConvert.SerializeObject(listTree);
        }
        catch (Exception s)
        {
            mStrErr = s.ToString();
            return null;
        }
    }
    private string GetTreeGrid()
    {
        try
        {
            List<plcXitongTree> treeGrid = new List<plcXitongTree>();
            string lStrSql = @"SELECT  dIntNoteID, dVchPointType, dVchRemark, dIntSjNoteID FROM t_XJPointType where dIntSjNoteID = 0";

            DataTable dt = null;
            using (dt = claSqlConnDB.ExecuteDataset(rows, page, claSqlConnDB.gStrConnDefault, CommandType.Text, lStrSql).Tables[0])
            {
                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    plcXitongTree mModel = new plcXitongTree();
                    
                    if (dt.Rows[i][0].ToString() != "")
                    {
                        mModel.id = (int)dt.Rows[i][0];
                    }
                    mModel.name = dt.Rows[i][1].ToString();

                    if (GetNodeRecord(dt.Rows[i][3].ToString()) > 0)
                    {
                         
                    }
                    
                    //mModel.dVchRemark = dt.Rows[i][2].ToString();
                    //if (dt.Rows[i][3].ToString() != "")
                    //{
                    //    mModel.dIntSjNoteID = (int)dt.Rows[i][3];
                    //    mModel._parentId = (int)dt.Rows[i][3];
                        
                    //}
                    
                    //mModel.state = "closed";
                    treeGrid.Add(mModel);
                }
            }

            return JsonConvert.SerializeObject(treeGrid);
        }
        catch (Exception s)
        {
            mStrErr = s.ToString();
            return mStrErr;
        }
    }

    private int GetNodeRecord(string mStrNodeid)
    {
        string lStrSQL = "select count(*) from t_XJPointType where dIntSjNoteID = " + mStrNodeid + "";
        return claSqlConnDB.GetRecordCount(claSqlConnDB.gStrConnDefault, lStrSQL);
    }
    
    //Combox显示
    private string GetCombox()
    {
        try
        {
            List<plcXitong> Grid = new List<plcXitong>();
            string lStrSql = @"SELECT dIntNoteID, dVchPointType, dVchRemark, dIntSjNoteID FROM t_XJPointType order by dIntSjNoteID";

            DataTable dt = null;
            using (dt = claSqlConnDB.ExecuteDataset(claSqlConnDB.gStrConnDefault, CommandType.Text, lStrSql).Tables[0])
            {
                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    plcXitong mModel = new plcXitong();
                    if (dt.Rows[i][0].ToString() != "")
                    {
                        mModel.dIntNoteID = (int)dt.Rows[i][0];
                    }
                    mModel.dVchPointType = dt.Rows[i][1].ToString();
                    mModel.dVchRemark = dt.Rows[i][2].ToString();
                    if (dt.Rows[i][3].ToString() != "")
                    {
                        mModel.dIntSjNoteID = (int)dt.Rows[i][3];
                    }
                    Grid.Add(mModel);
                }
            }

            return JsonConvert.SerializeObject(Grid);
        }
        catch (Exception s)
        {
            mStrErr = s.ToString();
            return mStrErr;
        } 
    }
    
    //combobox显示顶层数据
    private string GetTopCombobox()
    {
        try
        {
            List<plcArea> Grid = new List<plcArea>();
            string lStrSql = @"SELECT   dIntAreaID, dVchArea,dIntSJAreaID FROM tZPLCArea ";

            DataTable dt = null;
            using (dt = claSqlConnDB.ExecuteDataset(claSqlConnDB.gStrConnDefault, CommandType.Text, lStrSql).Tables[0])
            {
                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    plcArea mModel = new plcArea();
                    if (dt.Rows[i][0].ToString() != "")
                    {
                        mModel.dIntAreaID = (int)dt.Rows[i][0];
                    }
                    mModel.dVchArea = dt.Rows[i][1].ToString();
                    if (dt.Rows[i][2].ToString() != "")
                    {
                        mModel.dIntSJAreaID = (int)dt.Rows[i][2];
                    }
                    Grid.Add(mModel);
                }
            }

            return JsonConvert.SerializeObject(Grid);
        }
        catch (Exception s)
        {
            mStrErr = s.ToString();
            return mStrErr;
        } 
    }

    private void AreaGrid(HttpContext context)
    {
        string mStrResult = "";
        if (context.Request.Params["vSArea"] != null)
        {
            mStrSArea = context.Request.Params["vSArea"].ToString();
        }
        mStrResult = GJHF.Utility.WEBUI.EasyuiControl.GetGridReturn(GJHF.Business.PLC.BPlcArea.GetRecordCount(mStrSArea), GJHF.Business.PLC.BPlcArea.GetData(rows, page, mStrSArea));
        context.Response.Write(mStrResult);
    }
    //区域添加
    private void AddArea(HttpContext context)
    {
        string mStrArea = "";
        int mIntSJAreaID = 0;
        int mIntPx = 0;
        string str_msg = "";
        mStrArea = context.Request.Params["vQyName"].ToString();
        GJHF.Business.PLC.BPlcArea.AddData(mStrArea, mIntSJAreaID, mIntPx, out str_msg);
        context.Response.Write(str_msg);
    }

    //区域编辑
    private void EditArea(HttpContext context)
    {
        int mIntAreaID = 0;
        string mStrArea = "";
        int mIntSJAreaID = 0;
        int mIntPx = 0;
        if (context.Request.Params["vID"] != null)
        {
            mIntAreaID = Int32.Parse(context.Request.Params["vID"].ToString());
        }
        mStrArea = context.Request.Params["vQyName"].ToString();
        string str_msg = "";
        GJHF.Business.PLC.BPlcArea.EditData(mIntAreaID, mStrArea, mIntSJAreaID, mIntPx, out str_msg);
        context.Response.Write(str_msg);
    }

    //区域删除
    private void DelArea(HttpContext context)
    {
        int mIntAreaID = 0;
        if (context.Request.Params["vID"] != null)
        {
            mIntAreaID = Int32.Parse(context.Request.Params["vID"].ToString());
        }
        string str_msg = "";
        GJHF.Business.PLC.BPlcArea.DelData(mIntAreaID, out str_msg);
        context.Response.Write(str_msg);
    }

    //系统添加
    private void AddPointType(HttpContext context)
    {
        string mStrPointType = "";
        string mStrRemark = "";
        int mIntSjNoteID = 0;
        int mIntPx = 0;
        mStrPointType = context.Request.Params["vXtName"];

        if (context.Request.Params["vAreaID"] != null)
        {
            mIntSjNoteID = Int32.Parse(context.Request.Params["vAreaID"]);
        }
        mStrRemark = context.Request.Params["vAreaName"];
        if(context.Request.Params["vPx"] != null)
        {
            if(context.Request.Params["vPx"].ToString() != "")
            {
                mIntPx = Int32.Parse(context.Request.Params["vPx"]);
            }
        }
        string str_msg="";
        GJHF.Business.PLC.BPlcPointType.AddData(mStrPointType, mStrRemark, mIntSjNoteID, mIntPx, out str_msg);
        context.Response.Write(str_msg);
    }

    //系统编辑
    private void EditPointType(HttpContext context)
    {
        int mIntNoteID = 0;
        string mStrPointType = "";
        string mStrRemark = "";
        int mIntSjNoteID = 0;
        int mIntPx = 0;

        if (context.Request.Params["vID"] != null)
        {
            
            mIntNoteID = Int32.Parse(context.Request.Params["vID"]);
        }
        
        mStrPointType = context.Request.Params["vXtName"];
        
        if (context.Request.Params["vAreaID"] != null)
        {
            mIntSjNoteID = Int32.Parse(context.Request.Params["vAreaID"]);
        }
        mStrRemark = context.Request.Params["vAreaName"];
        if(context.Request.Params["vPx"] != null)
        {
            if(context.Request.Params["vPx"].ToString() != "")
            {
                mIntPx = Int32.Parse(context.Request.Params["vPx"]);
            }
        }
        string str_msg="";
        GJHF.Business.PLC.BPlcPointType.EditData(mIntNoteID, mStrPointType, mStrRemark, mIntSjNoteID, mIntPx, out str_msg);
        context.Response.Write(str_msg);
    }

    //系统删除
    private void DelPointType(HttpContext context)
    {
        int mIntNoteID = 0;
        if (context.Request.Params["vID"] != null)
        {

            mIntNoteID = Int32.Parse(context.Request.Params["vID"]);
        }

        string str_msg = "";
        GJHF.Business.PLC.BPlcPointType.DelData(mIntNoteID,out str_msg);
        context.Response.Write(str_msg);
    }
    
    public bool IsReusable {
        get {
            return false;
        }
    }


}