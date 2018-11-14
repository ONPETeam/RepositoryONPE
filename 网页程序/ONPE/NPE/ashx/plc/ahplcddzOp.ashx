<%@ WebHandler Language="C#" Class="ahplcddzOp" %>

using System;
using System.Web;
using System.Data;
using System.Data.SqlClient;
using System.Collections;
using System.Text;
using System.IO;
using System.Threading;
using Newtonsoft.Json;
using Newtonsoft.Json.Converters;
using ModelClass;
using NPE.UIDataClass;
using System.Collections.Generic;

public class ahplcddzOp : IHttpHandler {
    
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
        context.Response.ContentType = "text/plain";
        string type = Request.Params["type"];
        string mStrck = Request.Params["ckv"];
        string mStrSb = Request.Params["eqd"];
        //arr = (string[])Request.Params["aaa"];
        if (context.Request.Params["area_parent"] != null)
        {
            area_parent = context.Request.Params["area_parent"];
        }

        
        switch (type)
        {
            case "add":  Add(context); break;
            case "delete": Delete(context); break;
            case "edit": Edit(context); break;
            case "ck": bind(context, mStrck, mStrSb); break;
            case"gscs":
                string mVariable = Request.Params["svar"];
                Response.Write(GetJsData(mVariable));
                break;
            //case"ddz":
            //    context.Response.Write(Getddz(area_parent));
            //    break;
           
        }
    }
    /// <summary>
    /// 添加
    /// </summary>
    private void Add(HttpContext context)
    {
        string mStrSb = context.Request.Params["nsb"];
        string mStrAllAdress = "";
        //string mStrAllAdress = Request.Form["ncjdz"];
        float mFltBeishu = 1f;
        float mFltMoniMax = 0f;
        
        int mIntjsl = 0;
        string mStrAddress = "";
        string mStrAdressName = "";
        string mStrDanwei = "";
        int mIntGongType = 0;
        int mIntSjXitong = 0;

        string mStrSjXiTong = "";
        
        int mIntXS = 0;
        string mStrDescription = "";
        mStrAdressName = Request.Form["AdressName"];
        //计算量1为计算量
        if (string.IsNullOrEmpty(Request.Form["njs"]) == false)
        {
            mIntjsl = Int32.Parse(Request.Form["njs"]);
        }
        if (mIntjsl == 1)
        {
            //点地址/变量编号
            mStrAddress = Request.Form["nBLBH"];
            //地址名称/变量名称
            mStrDescription = Request.Form["nBLName"];
            //单位
            mStrDanwei = Request.Form["nBLDW"];
            //功能分类
            if (string.IsNullOrEmpty(Request.Form["nBLGT"]) == false)
            {
                mIntGongType = Int32.Parse(Request.Form["nBLGT"]);
            }
            else
            {
                mIntGongType = 0;
            }
            //手机系统
            if (string.IsNullOrEmpty(Request.Form["nBLXT"]) == false)
            {
                //mIntSjXitong = Int32.Parse(Request.Form["nBLXT"]);
                mStrSjXiTong = Request.Form["nBLXT"];
            }
            //排序
            if (string.IsNullOrEmpty(Request.Form["nBLXS"]) == false)
            {
                mIntXS = Int32.Parse(Request.Form["nBLXS"]);
            }
        }
        else
        {
            //点地址/变量编号
            mStrAddress = Request.Form["Address"];
            
            //点地址描述/变量名称
            mStrDescription = Request.Form["Description"];
            
            //单位
            mStrDanwei = Request.Form["Danwei"];
            //功能分类

            if (string.IsNullOrEmpty(Request.Form["GongType"]) == false)
            {
                mIntGongType = Int32.Parse(Request.Form["GongType"]);
            }
            else
            {
                mIntGongType = 0;
            }
            //手机系统
            if (string.IsNullOrEmpty(Request.Form["nXitong"]) == false)
            {
                //mIntSjXitong = Int32.Parse(Request.Form["nXitong"]);
                mStrSjXiTong = Request.Form["nXitong"];
            }
            //排序
            if (string.IsNullOrEmpty(Request.Form["nXS"]) == false)
            {
                mIntXS = Int32.Parse(Request.Form["nXS"]);
            }
        }
        
        if (string.IsNullOrEmpty(Request.Form["MoniMax"]) == false)
        {
            mFltMoniMax = float.Parse(Request.Form["MoniMax"]);
        }
        float mFltMoniMin = 0f;
        if (string.IsNullOrEmpty(Request.Form["MoniMin"]) == false)
        {
            mFltMoniMin = float.Parse(Request.Form["MoniMin"]);
        }
        float mFltSjMax = 0f;
        if (string.IsNullOrEmpty(Request.Form["SjMax"]) == false)
        {
            mFltSjMax = float.Parse(Request.Form["SjMax"]);
        }
        float mFltSjMin = 0f;
        if (string.IsNullOrEmpty(Request.Form["SjMin"]) == false)
        {
            mFltSjMin = float.Parse(Request.Form["SjMin"]);
        }
        int mIntNY = 0;
        if (string.IsNullOrEmpty(Request.Form["nyt"]) == false)
        {
            mIntNY = Int32.Parse(Request.Form["nyt"]);
        }
        string mStrDataType = Request.Form["DataType"];
        int mIntZongGZ = 0;
        string mStrSheBei1 = Request.Form["SheBei1"];
        string mStrSheBei2 = Request.Form["SheBei2"];
        string mStrNeiBuBL1 = Request.Form["NeiBuBL1"];
        string mStrNeiBuBL2 = Request.Form["NeiBuBL2"];
        int mIntIOType = 0;
        if (string.IsNullOrEmpty(Request.Form["IOType"]) == false)
        {
             mIntIOType = Int32.Parse(Request.Form["IOType"]);
        }
        else
        {
            mIntIOType = 0;
        }
            
        int mIntPLCID = 0;
        if (string.IsNullOrEmpty(Request.Form["nplc"]) == false)
        {
             mIntPLCID = Int32.Parse(Request.Form["nplc"]);
        }
        else
        {
            mIntPLCID = 0;
        }
        int mIntGzorQd = 0;
        int mIntPLCXitong = 0;

        
        //公式参数计算
        string mStrCsa = Request.Form["ncsa"];
        string mStrCsb = Request.Form["ncsb"];
        string mStrCsc = Request.Form["ncsc"];
        string mStrFormula = Request.Form["ngs"];

        string mStrPlcBm = "";
        GJHF.Business.PLC.BPlcManager.GetPlcCode(mIntPLCID, out mStrPlcBm, out mIntPLCXitong);
        //判断是否为计算量
        if (mIntjsl != 1)
        {
            mStrAllAdress = mStrPlcBm + "." + mStrAddress;
        }
        else
        {
            mStrAddress = "BL" + "-" + DateTime.Now.ToString("yyMMddhhmmss");
            mStrAllAdress = "计算变量-" + mStrAddress;
        }
        
        int voIntdizhi;
        //string uid = Guid.NewGuid().ToString();
        //int i = (usersex == "男") ? 1 : (usersex == "女") ? 0 : 1;
        
        string mStrMsg = "";
        if (GJHF.Business.PLC.BPlcDdz.AddData(mStrAdressName, mStrAddress, mStrAllAdress, mStrDescription, 0, mFltBeishu, mFltMoniMax, mFltMoniMin, mFltSjMax, mFltSjMin, mStrDanwei, mIntGongType,
            mIntNY, mIntPLCXitong, mStrDataType, mIntZongGZ, mStrSheBei1, mStrSheBei2, mStrNeiBuBL1, mStrNeiBuBL2, mIntIOType, mIntPLCID, mIntGzorQd, mStrSjXiTong,char.Parse(","), mIntXS, mIntjsl, out voIntdizhi, out mStrMsg) == true)
        {
            if (mIntjsl == 1)
            {
                GJHF.Business.PLC.BPlcBLGX.AddData(mStrAllAdress, mStrCsa,"a", out mStrMsg);
                GJHF.Business.PLC.BPlcBLGX.AddData(mStrAllAdress, mStrCsb,"b",out mStrMsg);
                GJHF.Business.PLC.BPlcBLGX.AddData(mStrAllAdress, mStrCsc,"c", out mStrMsg);
                GJHF.Business.PLC.BPlcBLFormula.AddData(mStrAllAdress, mStrFormula,out mStrMsg);
            }

            if (mStrSb != "")
            {
                bind(context, voIntdizhi.ToString(), mStrSb);
            }
            context.Response.Write(0);
        }

    }
    
    /// <summary>
    /// 编辑
    /// </summary>
    private void Edit(HttpContext context)
    {
        int id = Int32.Parse(Request.QueryString["ID"]);
        string mStrAdressName = Request.Form["AdressName"];
        string mStrAllAdress = "";

        //计算变量
        int mIntjsl = 0;
        //计算量1为计算量
        if (string.IsNullOrEmpty(Request.Form["njs"]) == false)
        {
            mIntjsl = Int32.Parse(Request.Form["njs"]);
        }
        //点地址/变量编号
        string mStrAddress ="";
        //点地址描述/变量名称
        string mStrDescription = "";
        //单位
        string mStrDanwei = "";
        //功能分类
        int mIntGongType = 0;
        //手机系统
        int mIntSjXitong = 0;
        string mStrSjXiTong = "";
        //手机排序
        int mIntXS = 0;

        if (mIntjsl == 1)
        {
            //点地址/变量编号
            mStrAddress = Request.Form["nBLBH"];
            //地址名称/变量名称
            mStrDescription = Request.Form["nBLName"];

            //单位
            mStrDanwei = Request.Form["nBLDW"];
            //功能分类

            if (string.IsNullOrEmpty(Request.Form["nBLGT"]) == false)
            {
                mIntGongType = Int32.Parse(Request.Form["nBLGT"]);
            }
            else
            {
                mIntGongType = 0;
            }
            //手机系统
            if (string.IsNullOrEmpty(Request.Form["nBLXT"]) == false)
            {
                //mIntSjXitong = Int32.Parse(Request.Form["nBLXT"]);
                mStrSjXiTong = Request.Form["nBLXT"];
            }
            //排序
            if (string.IsNullOrEmpty(Request.Form["nBLXS"]) == false)
            {
                mIntXS = Int32.Parse(Request.Form["nBLXS"]);
            }
        }
        else
        {
            //点地址/变量编号
            mStrAddress = Request.Form["Address"];
            //点地址描述/变量名称
            mStrDescription = Request.Form["Description"];

            //单位
            mStrDanwei = Request.Form["Danwei"];
            //功能分类

            if (string.IsNullOrEmpty(Request.Form["GongType"]) == false)
            {
                mIntGongType = Int32.Parse(Request.Form["GongType"]);
            }
            else
            {
                mIntGongType = 0;
            }
            //手机系统
            if (string.IsNullOrEmpty(Request.Form["nXitong"]) == false)
            {
                //mIntSjXitong = Int32.Parse(Request.Form["nXitong"]);
                mStrSjXiTong = Request.Form["nXitong"];
            }
            //排序
            if (string.IsNullOrEmpty(Request.Form["nXS"]) == false)
            {
                mIntXS = Int32.Parse(Request.Form["nXS"]);
            }
        }
        
        float mFltBeishu = 1f;
        float mFltMoniMax = 0f;
        if (string.IsNullOrEmpty(Request.Form["MoniMax"]) == false)
        {
              mFltMoniMax = float.Parse(Request.Form["MoniMax"]);
        }
        float mFltMoniMin = 0f;
        if (string.IsNullOrEmpty(Request.Form["MoniMin"]) == false)
        {
            mFltMoniMin = float.Parse(Request.Form["MoniMin"]);
        }
        float mFltSjMax = 0f;
        if (string.IsNullOrEmpty(Request.Form["SjMax"]) == false)
        {
            mFltSjMax = float.Parse(Request.Form["SjMax"]);
        }
        float mFltSjMin = 0f;
        if (string.IsNullOrEmpty(Request.Form["SjMin"]) == false)
        {
            mFltSjMin = float.Parse(Request.Form["SjMin"]);
        }
        int mIntNY = 0;
        if (string.IsNullOrEmpty(Request.Form["nyt"]) == false)
        {
            mIntNY = Int32.Parse(Request.Form["nyt"]);
        }
        string mStrDataType = Request.Form["DataType"];
        int mIntZongGZ = 0;
        string mStrSheBei1 = Request.Form["SheBei1"];
        string mStrSheBei2 = Request.Form["SheBei2"];
        string mStrNeiBuBL1 = Request.Form["NeiBuBL1"];
        string mStrNeiBuBL2 = Request.Form["NeiBuBL2"];
        int mIntIOType = 0;
        if (string.IsNullOrEmpty(Request.Form["IOType"]) == false)
        {
            mIntIOType = Int32.Parse(Request.Form["IOType"]);
        }
        int mIntPLCID =0;
        if(string.IsNullOrEmpty(Request.Form["nplc"]) == false)
        {
             mIntPLCID = Int32.Parse(Request.Form["nplc"]);
        }
        int mIntGzorQd = 0;
        //if (Request.Params["vGZ"].ToString() != "null")
        //{
        //    mIntGzorQd = Int32.Parse(Request.Params["vGz"]);
        //}
        //if (string.IsNullOrEmpty(Request.Params["vGz"]) == false)
        //{
             
        //}
        
        string mStrCsa = Request.Form["ncsa"];
        string mStrCsb = Request.Form["ncsb"];
        string mStrCsc = Request.Form["ncsc"];
        string mStrFormula = Request.Form["ngs"];
        
        //int mIntPLCXitong = (int)claSqlConnDB.ExecuteScalar(claSqlConnDB.gStrConnDefault, CommandType.Text, "select dIntGongYiXitongID from tZPLCManager Where dIntPLCID = " + mIntPLCID);
        int mIntPLCXitong = 0;
        string mStrPlcBm = "";

        GJHF.Business.PLC.BPlcManager.GetPlcCode(mIntPLCID, out mStrPlcBm, out mIntPLCXitong);
        //判断是否为计算量
        if (mIntjsl != 1)
        {
            mStrAllAdress = mStrPlcBm + "." + mStrAddress;
        }
        else
        {
            mStrAllAdress = "计算变量-" + mStrAddress;
        }

        string mStrMsg = "";
        if (GJHF.Business.PLC.BPlcDdz.EditData(id, mStrAdressName, mStrAddress, mStrAllAdress, mStrDescription, 0, mFltBeishu, mFltMoniMax, mFltMoniMin, mFltSjMax, mFltSjMin, mStrDanwei,
            mIntGongType, mIntNY, mIntPLCXitong, mStrDataType, mIntZongGZ, mStrSheBei1, mStrSheBei2, mStrNeiBuBL1, mStrNeiBuBL2, mIntIOType, mIntPLCID, mIntGzorQd, mStrSjXiTong,char.Parse(","), mIntXS, mIntjsl, out mStrMsg) == true)
        {
            if (mIntjsl == 1)
            {

                GJHF.Business.PLC.BPlcBLGX.EditData(mStrAllAdress, mStrCsa, "a",out mStrMsg);
                GJHF.Business.PLC.BPlcBLGX.EditData(mStrAllAdress,mStrCsb,"b",out mStrMsg);
                GJHF.Business.PLC.BPlcBLGX.EditData(mStrAllAdress,mStrCsc,"c",out mStrMsg);
                GJHF.Business.PLC.BPlcBLFormula.EditData(mStrAllAdress, mStrFormula,out mStrMsg);
            }

            context.Response.Write(0);
        }
            
    }
    
    /// <summary>
    /// 删除操作
    /// </summary>
    private void Delete(HttpContext context)
    {
        int mIntID = Int32.Parse(Request.QueryString["ID"]);
        string mStrsb = Request.QueryString["dsb"];
        string mStrVariable = Request.Params["variable"];
        int mIntJsl = 0;
        if (string.IsNullOrEmpty(Request.Params["vjs"]) == false)
        {
            mIntJsl = Int32.Parse(Request.Params["vjs"].ToString());
        }
            
        string mStrMsg = "";
        if (GJHF.Business.PLC.BPlcDdz.DelData(mIntID, out mStrMsg) == true)
        {
            if (mIntJsl == 1)
            {
                GJHF.Business.PLC.BPlcBLGX.DelData(mStrVariable, out mStrMsg);
                GJHF.Business.PLC.BPlcBLFormula.DelData(mStrVariable,out mStrMsg);
            }

            if (string.IsNullOrEmpty(mStrsb) == false)
            {
                //DelBind(context, mIntID.ToString(), mStrsb);
                GJHF.Business.PLC.BPlcAndSb.DelData(mIntID.ToString(), mStrsb, out mStrMsg);
            }
            else
            {
                //清除所有关系表
                //DelBindAll(context, mIntID.ToString());
                GJHF.Business.PLC.BPlcAndSb.DelBindAll(mIntID.ToString(), out mStrMsg);
            }
            context.Response.Write(0);
        }
       

    }

    /// <summary>
    /// 绑定plc点地址
    /// </summary>
    private void bind(HttpContext context,string ddzID,string sbbh)
    {
        string mStrMsg = "";
        if (sbbh != "" && ddzID !="")
        {
            string temp = "";
            ddzID = ddzID + ",";

            while (ddzID != "")
            {
                //int voIntReturn = 0;
                temp = ddzID.Substring(0, ddzID.IndexOf(','));
                ddzID = ddzID.Substring(ddzID.IndexOf(',') + 1, ddzID.Length - temp.Length - 1);
                GJHF.Business.PLC.BPlcAndSb.AddData(sbbh, temp, out mStrMsg);
                
            }
            context.Response.Write(0);
        }
        else
        {
            if (sbbh == "")
            {
                context.Response.Write(-1);
            }
            if (ddzID == "")
            {
                context.Response.Write(-2);
            }
        }
    }

    //选择绑定点地址的combotree
    //private string Getddz(string areaParent)
    //{
    //    List<TreeNode> listTree = new List<TreeNode>();
    //    DataTable dt = null;
    //    string mStrSQL = " SELECT  dVchAllAdress, dVchAddress from tZPlcPointDiZhi where dIntDataID<>0 and dIntPLCID=" + areaParent;
    //    using (dt = claSqlConnDB.ExecuteDataset(claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL).Tables[0])
    //    {
    //        if (dt.Rows.Count > 0)
    //        {
    //            for (int i = 0; i < dt.Rows.Count; i++)
    //            {
    //                TreeNode treeTemp = new TreeNode();
    //                treeTemp.id = dt.Rows[i][0].ToString();
    //                treeTemp.text = dt.Rows[i][1].ToString();
    //                treeTemp.state = "open";
    //                treeTemp.attributes = "dc";
    //                treeTemp.iconCls = "icon-process";
    //                listTree.Add(treeTemp);
    //            }
    //        }
    //    }
    //    return JsonConvert.SerializeObject(listTree);
    //}
    
    //根据全地址来显示相关的计算变量数据
    private string GetJsData(string vCjdz)
    {
        string mStrResult = "";
        //string mStrSQL1 = "SELECT   dVchVariable, dVchCollectAddress, dVchParameterNum FROM      tZPLCVariableAndAddress where dVchVariable = '" + vCjdz + "'";
        //SqlDataReader dr1 = null;
        //dr1 = claSqlConnDB.ExecuteReader(claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL1);
        //while (dr1.Read())
        //{
        //    mStrResult = mStrResult + dr1[1].ToString() + ",";
        //}
        //dr1.Close();
        //dr1.Dispose();
        //string mStrSQL2 = "SELECT  dVchVariable, dVchFormula FROM      tZPLCVariableFormula where dVchVariable = '" + vCjdz + "'";
        //SqlDataReader dr2 = null;
        //dr2 = claSqlConnDB.ExecuteReader(claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL2);
        //if (dr2.Read())
        //{
        //    mStrResult = mStrResult + dr2[1].ToString() ;
        //}
        //dr2.Close();
        //dr2.Dispose();

        DataTable dt1 = GJHF.Business.PLC.BPlcBLGX.GetBlDdz(vCjdz);
        //for (int i = 0; i < dt1.Rows.Count; i++)
        //{
            
              
        //}
        switch (dt1.Rows.Count)
        {
            case 1:
                mStrResult = dt1.Rows[0]["dVchCollectAddress"].ToString() + "=" + "=" + "=";
                break;
            case 2:
                mStrResult = dt1.Rows[0]["dVchCollectAddress"].ToString() + "=" + dt1.Rows[1]["dVchCollectAddress"].ToString() + "=" + "=";
                break;
            case 3:
                mStrResult = dt1.Rows[0]["dVchCollectAddress"].ToString() + "=" + dt1.Rows[1]["dVchCollectAddress"].ToString() + "=" + dt1.Rows[2]["dVchCollectAddress"].ToString() + "=";
                break;
        }
        
        DataTable dt2 = GJHF.Business.PLC.BPlcBLFormula.GetFormula(vCjdz);
        if (dt2.Rows.Count>0)
        {
            mStrResult = mStrResult + dt2.Rows[0]["dVchFormula"].ToString();
        }
        return mStrResult;
    }
    public bool IsReusable {
        get {
            return false;
        }
    }

}