<%@ WebHandler Language="C#" Class="ahPlcDtTemp" %>

using System;
using System.Web;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using Newtonsoft.Json;
using ModelClass;
using System.Text;
using NPE.UIDataClass;
using formulaDll;


public class ahPlcDtTemp : IHttpHandler {

    string sort = "";
    string order = "";

    int page = 1;
    int rows = 10;
    
    string cb = "";
    string cj = "";
    string id ="";
    string pp = "";
    string AllAddress = "";
    formulaDll.GsComputer gs = new GsComputer();
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

        if (context.Request.Params["cb"] != null)
        {
            cb = context.Request.Params["cb"]; 
        }
        if (context.Request.Params["cj"] != null)
        {
            cj = context.Request.Params["cj"]; 
            
        }
        if (context.Request.Params["vID"] != "")
        {
            id = context.Request.Params["vID"];
        }
        if (context.Request.Params["vpp"] != "")
        {
            pp = context.Request.Params["vpp"]; 
        }
        if (string.IsNullOrEmpty(context.Request.Params["vAddress"]) == false)
        {
            AllAddress = context.Request.Params["vAddress"]; 
        }
        int count = 0;
        string mStrResult = "";
        switch (action)
        {
             //修改过
            case "grid":
                //context.Response.Write(getGrid());
                count = GJHF.Business.PLC.BPlcDtTemp.GetRecourd("");
                List<GJHF.Data.Model.PLC.MPlcDtTemp> mlist1 = GJHF.Business.PLC.BPlcDtTemp.GetData(rows, page);
                context.Response.Write(GJHF.Utility.WEBUI.EasyuiControl.GetGridReturn(count, mlist1));
                break;
              //修改过
            case"gridLS":
                count = GJHF.Business.PLC.BPlcDtTemp.GetRecordLS("");
                List<GJHF.Data.Model.PLC.MPlcDtTempLS> mlist2 = new List<GJHF.Data.Model.PLC.MPlcDtTempLS>();
                mlist2 = GJHF.Business.PLC.BPlcDtTemp.GetDataLS("");
                //context.Response.Write(getGridLS());
                context.Response.Write(GJHF.Utility.WEBUI.EasyuiControl.GetGridReturn(count,mlist2));
                break;    
                //此方法可能已经不用
            case "factory":
                context.Response.Write(this.GetComboxFactory());
                mStrResult = JsonConvert.SerializeObject(GJHF.Business.PLC.BPlcFactory.GetComboxData(""));
                break;
                //修改过
            case"plc":
                context.Response.Write(this.GetComboxPlc());
                break;
                //修改过
            case"add":
                context.Response.Write(AddData(context));
                break;
            //修改过
            case "del":
                context.Response.Write(Del());
                break;
            case "ddzid":
                context.Response.Write(GetStrResult(context));
                break;

            case"Area":
                context.Response.Write(GetComboArea(context));
                break;
            case"VT":
                context.Response.Write(GetVariableType());
                break;
            case "tc":
                context.Response.Write(GetCancel(context));
                break;
            case"GEdit":
                context.Response.Write(GetUpdate());
                break;
            //ashx/plc/ahPlcDtTemp.ashx?action=showAlerm&vAddress = 
            case"showAlerm":
                context.Response.Write(GetAlermRange());
                break;
            case"jsdisplay":
                context.Response.Write(GetGxddz(context));
                break;
            default:
                break;
        }
    }
    

    //根据全地址找到相关联的点地址
    private string GetGxddz(HttpContext context)
    {
      
        //var result = new { total = GetGxddzcount(vStrVariable), rows = mlist };
        string mVarible = "";
        int count = 0;
       
        
        if (string.IsNullOrEmpty(context.Request.Params["jsd"]) == false)
        {
            mVarible = context.Request.Params["jsd"];
        }
        count = GJHF.Business.PLC.BPlcBLGX.GetRecord(mVarible);
        DataTable dt = GJHF.Business.PLC.BPlcBLGX.GetBlDdz(mVarible);
        return GJHF.Utility.WEBUI.EasyuiControl.GetGridReturn(count, dt);
        //return JsonConvert.SerializeObject(GJHF.Business.PLC.BPlcBLGX.GetBlDdz(mVarible));
        
    }

   
    //显示报警点的上下限及范围
    private string GetAlermRange()
    {
   
        
        DataTable dt = GJHF.Business.PLC.BPlcBaojing.GetOneBjfwData(AllAddress);
        int count = dt.Rows.Count;
        return GJHF.Utility.WEBUI.EasyuiControl.GetGridReturn(count, GJHF.Business.PLC.BPlcBaojing.GetOneBjfwData(AllAddress));
        //return JsonConvert.SerializeObject(GJHF.Business.PLC.BPlcBaojing.GetOneBjfwData(AllAddress));
    }
 
    
    //确定添加
    private int AddData(HttpContext context)
    {
        try
        {
            string mStrFactoryCode = "";
            string mStrPLCCode = "";
            string mStraddress = "";
            string mStrCjdizhi = "";
            string mStrValue = "";
            string mStrSJValue = "";
            string mStrUnit = "";
            int mIntDqBz = 0;
            float mFltSjMax = 0f;
            float mFltSjMin = 0f;
            float mFltBdMax = 0f;
            float mFltBdMin = 0f;
            string mStrfwqdh = "";
            string mStrName = "";
            int mIntdizhiID = 0;
            string mStrequip_code = "";
            string mStrVariableType = "";
            int voIntReturn = -1;
            if (context.Request.Params["nfactory"] != null)
            {
                if (context.Request.Params["nfactory"].ToString() != "")
                {
                    mStrFactoryCode = context.Request.Params["nfactory"];
                }
            }
            if (context.Request.Params["nplc"] != null)
            {
                if (context.Request.Params["nplc"].ToString() != "")
                {
                    mStrPLCCode = context.Request.Params["nplc"];
                }
            }
            if (context.Request.Params["naddress"] != null)
            {
                if (context.Request.Params["naddress"].ToString() != "")
                {
                    mStraddress = context.Request.Params["naddress"];
                }
            }

            if (context.Request.Params["ncjdz"] != null)
            {
                if (context.Request.Params["ncjdz"].ToString() != "")
                {
                    mStrCjdizhi = context.Request.Params["ncjdz"];
                }
                else
                {
                    mStrCjdizhi = mStrPLCCode + "." + mStraddress;
                }
            }
            else
            {
                mStrCjdizhi = mStrPLCCode + "." + mStraddress;
            }
            if (context.Request.Params["nsjMax"] != null)
            {
                if (context.Request.Params["nsjMax"].ToString() != "")
                {
                    mFltSjMax = float.Parse(context.Request.Params["nsjMax"]);
                }
            }

            if (context.Request.Params["nsjMin"] != "")
            {
                if (context.Request.Params["nsjMin"].ToString() != "")
                {
                    mFltSjMin = float.Parse(context.Request.Params["nsjMin"]);
                }
            }

            if (context.Request.Params["nbdMax"] != null)
            {
                if (context.Request.Params["nbdMax"].ToString() != "")
                {
                    mFltBdMax = float.Parse(context.Request.Params["nbdMax"]);
                }
            }
            if (context.Request.Params["nbdMin"] != null)
            {
                if (context.Request.Params["nbdMin"].ToString() != "")
                {
                    mFltBdMin = float.Parse(context.Request.Params["nbdMin"]);
                }
            }
            if (context.Request.Params["nfwqdh"] != null)
            {
                if (context.Request.Params["nfwqdh"].ToString() != "")
                {
                    mStrfwqdh = context.Request.Params["nfwqdh"];
                }
            }
            if (context.Request.Params["nNm"] != null)
            {
                if (context.Request.Params["nNm"].ToString() != "")
                {
                    mStrName = context.Request.Params["nNm"];
                }
            }
            if (context.Request.Params["nddzid"] != null)
            {
                if (context.Request.Params["nddzid"].ToString() != "")
                {
                    mIntdizhiID = Int32.Parse(context.Request.Params["nddzid"]);
                }
            }
            if (context.Request.Params["nSbbm"] != null)
            {
                if (context.Request.Params["nSbbm"].ToString() != "")
                {
                    mStrequip_code = context.Request.Params["nSbbm"];
                }
            }

            if (context.Request.Params["nVT"] != null)
            {
                if (context.Request.Params["nVT"].ToString() != "")
                {
                    mStrVariableType = context.Request.Params["nVT"];
                }
            }
            if (context.Request.Params["nDqBz"] != null)
            {
                if (context.Request.Params["nDqBz"].ToString() != "")
                {
                    mIntDqBz = Int32.Parse(context.Request.Params["nDqBz"]); 
                }
            }
            int Intjsl = 0;
            int voInt = 0;
            if (context.Request.Params["njsl"] != null)
            {
                if (int.TryParse(context.Request.Params["njsl"], out voInt) == true)
                {
                    Intjsl = Int32.Parse(context.Request.Params["njsl"].ToString());
                }
            }

            if (mStrCjdizhi != "")
            {
                if (Intjsl == 1)
                {
                    voIntReturn = GetJsl(mStrCjdizhi);
                }
                else
                {
                    string mStrMsg = "";
                    //voIntReturn = AddMethod(mStrFactoryCode, mStrPLCCode, mStraddress, mStrCjdizhi, mStrValue, mStrSJValue, mStrUnit, mIntDqBz, mFltSjMax, mFltSjMin,
                    //mFltBdMax, mFltBdMin, mStrfwqdh, mStrName, mIntdizhiID, mStrequip_code, mStrVariableType);
                    GJHF.Business.PLC.BPlcDtTemp.AddData(mStrFactoryCode, mStrPLCCode, mStraddress, mStrCjdizhi, mStrValue, mStrSJValue, mStrUnit, mIntDqBz, mFltSjMax, mFltSjMin,
                       mFltBdMax, mFltBdMin, mStrfwqdh, mStrName, mIntdizhiID, mStrequip_code, mStrVariableType, out mStrMsg);
                    voIntReturn = 0;
                }
            }
            else
            {
                voIntReturn = -2;
            }
            return voIntReturn;
        }
        catch (Exception eee)
        {
            context.Response.Write(eee.ToString());
            return -3;
        }
        
    }
    
    
 
    //给定退出状态
    private int GetCancel(HttpContext context)
    {
        int mIntDataID = 0;
        if (context.Request.Params["vDid"] != null)
        {
            if (context.Request.Params["vDid"].ToString() != "")
            {
                mIntDataID = Int32.Parse(context.Request.Params["vDid"]);
            }
        }
        int vIntRetrun = 0;
        string mStrMsg = "";
        try
        {
            //string mStrSQL = "update tZPlcDtTemp set dIntDqBz = -1 where dIntDataID = " + mIntDataID;
            //vIntRetrun = claSqlConnDB.ExecuteNonQuery(claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL);
            if (GJHF.Business.PLC.BPlcDtTemp.GetCancel(mIntDataID, out mStrMsg) == true)
            {
                vIntRetrun = 1;
            }
        }
        catch (Exception eee)
        {
            string mStrErr = eee.ToString();
            vIntRetrun = -2;
        }
        return vIntRetrun;
    }
    
   
    //厂别combox
    private string GetComboxFactory()
    {
        StringBuilder sb = new StringBuilder();
        List<plcfactory> mList = new List<plcfactory>();
        string sql = string.Format("select dVchFactoryCode,dVchFactoryName from tZPlcFactory ", "", null);

        DataTable dt;
        using (dt = claSqlConnDB.ExecuteDataset(claSqlConnDB.gStrConnDefault, CommandType.Text, sql).Tables[0])
        {
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                plcfactory mModel = new plcfactory();
                mModel.dVchFactoryCode = dt.Rows[i][0].ToString();
                mModel.dVchFactoryName = dt.Rows[i][1].ToString();
                mList.Add(mModel);
            }
        }

        return JsonConvert.SerializeObject(mList);
    }
    //plc信息combox
    private string GetComboxPlc()
    {
        List<GJHF.Data.Model.PLC.MPlcManage_Combox> mlist = new List<GJHF.Data.Model.PLC.MPlcManage_Combox>();
        mlist = GJHF.Business.PLC.BPlcManager.GetComboxPlc(cb);
        return JsonConvert.SerializeObject(mlist);
    }
    //private string GetplcWhere()
    //{
    //    string lStrWhere = "where dVchPLCbianma <> '-11111'";
    //    if (cb != "")
    //    {
    //        lStrWhere = lStrWhere + " and dIntGongYiXitongID = " + cb ;
    //    }
    //    return lStrWhere;
    //}
    //删除数据
    private int Del()
    {
        //string mStrSQL = "delete from tZPlcDtTemp where dIntDataID = " + id;
        int voInReturn=-1;
        //voInReturn = claSqlConnDB.ExecuteNonQuery(claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL);
        string mStrMsg = "";
        if (GJHF.Business.PLC.BPlcDtTemp.DelData(Int32.Parse(id), out mStrMsg) == true)
        {
            voInReturn = 1;
        }
        return voInReturn;
         
    }
    //根据点地址id显示厂别编码、PLC编码、点地址
    private string GetStrResult(HttpContext context)
    {
        //string mStrRe = "";
        //string mStrFactory = "";
        //string mStrPlc = "";
        //string mStrAddress = "";
        //string mStrCaiji = "";
        //string mStrBdMax = "";
        //string mStrBdMin = "";
        //string mStrSjMax = "";
        //string mStrSjMin = "";
        //string mStrFwq = "";
        
        string mStrddz = "-99";
        if (context.Request.Params["iddz"] != null)
        {
            mStrddz = context.Request.Params["iddz"];
        }


        return GJHF.Business.PLC.BPlcDdz.GetStrResult(mStrddz);
    }
    
    //根据填写的最大值、最小值范围来计算机实际值
    private string GetGzXsWhere()
    {
        string mStrWhere = "  where dIntGZID <> -1";
        if (pp != "" && pp !=null)
        {
            mStrWhere = mStrWhere + " and dIntPLCPinPaiID = " + pp;
        }
        
        return mStrWhere;
    }
    //获取PLC品牌和服务器代号
    private string Getpp(HttpContext context)
    {
        string mStrResult = "";
        string mStrPLCID = "";
        if (context.Request.Params["vplcbm"] != null)
        {
            mStrPLCID = context.Request.Params["vplcbm"].ToString();
        }
        string mStrSQL = @"SELECT dIntPLCPinPaiID,dVchFwqdh FROM tZPLCManager where dVchPLCbianma = '" + mStrPLCID + "'";
        
        SqlDataReader dr = null;
        dr = claSqlConnDB.ExecuteReader(claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL);
        if (dr.Read())
        {
            mStrResult = dr[0].ToString() + "," + dr[1].ToString(); 
        }
        dr.Close();
        dr.Dispose();
        return mStrResult; 
        
    }
    
    
    //protected bool isNumberic(string message)
    //{
    //    if (message != "")
    //    {
    //        System.Text.RegularExpressions.Regex rex =
    //        new System.Text.RegularExpressions.Regex(@"^[+-]?\d*[.]?\d*$");

    //        if (rex.IsMatch(message))
    //        {
    //            return true;
    //        }
    //        else
    //            return false;
    //    }
    //    else
    //    {
    //        return false; 
    //    }
    //}
    
    //PLC区域Combobox
    private string GetComboArea(HttpContext context)
    {
        DataTable dt = GJHF.Business.PLC.BPlcFactory.GetAreaComboxData("");
        return JsonConvert.SerializeObject(dt);
    }
    
    //变量类型下拉框
    public string GetVariableType()
    {
        
        return JsonConvert.SerializeObject(GJHF.Business.PLC.BPlcBLGX.GetVariableType(""));
    }

    //添加计算量时的计算
    private int GetJsl(string mStrAllAddress)
    {
        int voIntReturn = 0; 
        string mStrMsg = "";
        List<PlcDtTemp> mlist = new List<PlcDtTemp>();
        string mStrSQL = @"select tZPlcPointDiZhi.dIntDataID,tZPlcPointDiZhi.dVchAddress,tZPlcPointDiZhi.dVchAdressName,tZPlcPointDiZhi.dVchAllAdress ,tZPlcPointDiZhi.dVchDanwei,
                                        tZPlcPointDiZhi.dFltMoniMax,tZPlcPointDiZhi.dFltMoniMin,tZPlcPointDiZhi.dFltSjMax,tZPlcPointDiZhi.dFltSjMin,tZPlcPointDiZhi.dVchDataType,tZPlcPointDiZhi.dIntJsBz
                                        from tZPLCVariableAndAddress  
                                        left outer join tZPlcPointDiZhi on tZPLCVariableAndAddress.dVchCollectAddress = tZPlcPointDiZhi.dVchAllAdress  where dVchVariable = '" + mStrAllAddress + "'";

        DataTable dt = null;
        using(dt = claSqlConnDB.ExecuteDataset(claSqlConnDB.gStrConnDefault,CommandType.Text,mStrSQL).Tables[0])
        {
            PlcDtTemp mModel = new PlcDtTemp();
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                if (string.IsNullOrEmpty(dt.Rows[i][0].ToString()) == false)
                {
                    mModel.dIntdizhiID = Int32.Parse(dt.Rows[i][0].ToString());
                }
                else
                {
                    mModel.dIntdizhiID = 0;
                }
                mModel.dVchAdress = dt.Rows[i][1].ToString();
                mModel.dVchName = dt.Rows[i][2].ToString();
                mModel.dVchCjdz = dt.Rows[i][3].ToString(); 
                mModel.dVchUnit = dt.Rows[i][4].ToString();
                if (string.IsNullOrEmpty(dt.Rows[i][5].ToString()) == false)
                {
                    mModel.dFltSjMax = dt.Rows[i][5].ToString();
                }
                else
                {
                    mModel.dFltSjMax = "0.0";
                }
                if (string.IsNullOrEmpty(dt.Rows[i][6].ToString()) == false)
                {
                    mModel.dFltSjMin = dt.Rows[i][6].ToString();
                }
                else
                {
                    mModel.dFltSjMin = "0.0";
                }

                if (string.IsNullOrEmpty(dt.Rows[i][7].ToString()) == false)
                {
                    mModel.dFltBdMax = dt.Rows[i][7].ToString();
                }
                else
                {
                    mModel.dFltBdMax = "0.0";
                }
                if (string.IsNullOrEmpty(dt.Rows[i][8].ToString()) == false)
                {
                    mModel.dFltBdMin = dt.Rows[i][8].ToString();
                }
                else
                {
                    mModel.dFltBdMin = "0.0";
                }
                mModel.dVchVariableType = dt.Rows[i][9].ToString();
                if (string.IsNullOrEmpty(dt.Rows[i][10].ToString()) == false)
                {
                    mModel.dIntJsBz = Int32.Parse(dt.Rows[i][10].ToString());
                }
                else
                {
                    mModel.dIntJsBz = 0; 
                }
                if (string.IsNullOrEmpty(mModel.dVchCjdz.ToString()) == false)
                {
                    if (GJHF.Business.PLC.BPlcDtTemp.AddData("", "", mModel.dVchAdress, mModel.dVchCjdz, "", "", mModel.dVchUnit, 0, float.Parse(mModel.dFltSjMax), float.Parse(mModel.dFltSjMin), float.Parse(mModel.dFltSjMax), float.Parse(mModel.dFltSjMin), "", mModel.dVchName, mModel.dIntDataID, "", mModel.dVchVariableType, out mStrMsg) == true)
                    {

                        voIntReturn = 0;
                    }
                }
                
            }
        }
        string mStrSQL2 = @"select dIntDataID,dVchAddress,dVchAdressName,dVchAllAdress,dVchDanwei, dFltMoniMax,dFltMoniMin,dFltSjMax,dFltSjMin,dVchDataType,dIntJsBz
                                        from  tZPlcPointDiZhi where dVchAllAdress = '"+ mStrAllAddress +"'";
        SqlDataReader dr = null;
        dr = claSqlConnDB.ExecuteReader(claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL2);
        plcddz Model = new plcddz();
        if (dr.Read())
        {
            if (string.IsNullOrEmpty(dr[0].ToString()) == false)
            {
                Model.dIntDataID = Int32.Parse(dr[0].ToString());
            }
            else
            {
                Model.dIntDataID = 0;
            }
            Model.dVchAddress = dr[1].ToString();
            Model.dVchAdressName = dr[2].ToString();
            Model.dVchAllAdress = dr[3].ToString();
            Model.dVchDanwei = dr[4].ToString();
            if (string.IsNullOrEmpty(dr[5].ToString()) == false)
            {
                Model.dFltMoniMax = float.Parse(dr[5].ToString());
            }
            else
            {
                Model.dFltMoniMax = 0f;
            }

            if (string.IsNullOrEmpty(dr[6].ToString()) == false)
            {
                Model.dFltMoniMin = float.Parse(dr[6].ToString());
            }
            else
            {
                Model.dFltMoniMin = 0f;
            }

            if (string.IsNullOrEmpty(dr[7].ToString()) == false)
            {
                Model.dFltSjMax = float.Parse(dr[7].ToString());
            }
            else
            {
                Model.dFltSjMax = 0f;
            }

            if (string.IsNullOrEmpty(dr[8].ToString()) == false)
            {
                Model.dFltSjMin = float.Parse(dr[8].ToString());
            }
            else
            {
                Model.dFltSjMin = 0f;
            }

            Model.dVchDataType = dr[9].ToString();

            if (string.IsNullOrEmpty(dr[10].ToString()) == false)
            {
                Model.dIntJsBz = Int32.Parse(dr[10].ToString());
            }
            else
            {
                Model.dIntJsBz = 0;
            }
            if (GJHF.Business.PLC.BPlcDtTemp.AddData("", "", Model.dVchAddress, Model.dVchAllAdress, "", "", Model.dVchDanwei, 0, Model.dFltMoniMax, Model.dFltMoniMin, Model.dFltSjMax, Model.dFltSjMin, "", Model.dVchAdressName, Model.dIntDataID, "", Model.dVchDataType, out mStrMsg) == true)
            {
                voIntReturn = 0; 
            }
            //voIntReturn = AddMethod("", "", Model.dVchAddress, Model.dVchAllAdress, "", "", Model.dVchDanwei, 0, Model.dFltMoniMax, Model.dFltMoniMin, Model.dFltSjMax, Model.dFltSjMin, "", Model.dVchAdressName, Model.dIntDataID, "", Model.dVchDataType);

            GetGXJSL(Model.dVchAllAdress);
        }
        dr.Close();
        dr.Dispose();
        return voIntReturn;
    }
    //更新计算量的状态
    private void GetGXJSL(string vStrCjdz)
    {
        string mStrSQL = "update tZPlcDtTemp set dIntJsBz = 1 where dVchCjdz = '" + vStrCjdz + "'";
        claSqlConnDB.ExecuteNonQuery(claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL);
    }


    private int GetUpdate()
    {
        try
        {
            int vIntReturn = -1;
            //SqlParameter[] mySqlParameter = new SqlParameter[3]
            //{
            //    new SqlParameter("@viDaeGXSJ",SqlDbType.DateTime,16),
            //    new SqlParameter("@viVchRemark",SqlDbType.VarChar,30),
            //    new SqlParameter("@voIntReturn",SqlDbType.Int,4)
            //};

            ////mySqlParameter[0].Value = "";
            ////mySqlParameter[1].Value = "";
            //mySqlParameter[2].Direction = ParameterDirection.Output;
            //claSqlConnDB.ExecuteNonQuery(claSqlConnDB.gStrConnDefault, CommandType.StoredProcedure, "pZPLCClearAdd", mySqlParameter);
            //vIntReturn = (int)mySqlParameter[2].Value;
            //return vIntReturn;
            string mStrMsg = "";
            if (GJHF.Business.PLC.BPlcDtTemp.GetUpdate(out mStrMsg) == true)
            {
                vIntReturn = 0; 
            }
            return vIntReturn;
        }
        catch(Exception eee)
        {
            string mStrErr = eee.ToString();
            return -2;
        }
    } 
    public bool IsReusable {
        get {
            return false;
        }
    }

}