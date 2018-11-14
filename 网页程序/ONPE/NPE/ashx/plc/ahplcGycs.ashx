<%@ WebHandler Language="C#" Class="ahplcGycs" %>

using System;
using System.Web;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using Newtonsoft.Json;
using ModelClass;
using System.Text;
using NPE.UIDataClass;
using System.Threading.Tasks;
using System.Linq;


public class ahplcGycs : IHttpHandler {

        string sort = "";
        string order = "";

        int page = 1;
        int rows = 10;

        string mStrPointType = "";

        string mStrKs = "";
        string mStrJs = "";
        string mStrMH = "";
        string mStrHF = "";
        string mStrSB = "";
        string mStrQY = "";
        string mStrtsddz = "";
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
        if (context.Request.Params["vPT"] != null)
        {
            mStrPointType = context.Request.Params["vPT"];
        }
        if (context.Request.Params["vtsp"] != null)
        {
            mStrtsddz = context.Request.Params["vtsp"];
        }
        if (context.Request.Params["action"] != null)
        {
            action = context.Request.Params["action"];
        }
        
        switch (action)
        {
            case"grid":
                //System.Text.StringBuilder sb = new System.Text.StringBuilder();
                //sb.Append("{ ");
                //sb.Append(string.Format("\"total\":{0},\"rows\":", GetRecord()));
                //string s = GetPointddz();
                //sb.Append(s);
                //sb.Append("}");
                //context.Response.Write(sb.ToString());
                context.Response.Write(GetddzByGycs());
                
                break;
            case"Value":
                System.Text.StringBuilder sb1 = new System.Text.StringBuilder();
                sb1.Append("{ ");
                sb1.Append(string.Format("\"total\":{0},\"rows\":", GetRecord1()));
                string s1 = GetGycsValue();
                sb1.Append(s1);
                sb1.Append("}");
                context.Response.Write(sb1.ToString());
                break;
            case "add": 
                break;
            case"bj":
                context.Response.Write(GetBjSdMethod(context));
                break;
            case "bjsx":
                context.Response.Write(SetBjfw(context));
                break;
            case"bjqx":
                context.Response.Write(GetQxBj(context));
                break;
            case"bjd":
                if (context.Request.Params["vsb"] != null)
                {
                    mStrSB = context.Request.Params["vsb"].ToString();
                }
                if (context.Request.Params["vmh"] != null)
                {
                    mStrMH = context.Request.Params["vmh"].ToString();
                }
                context.Response.Write(GetBjSdData());
                break;
            
            case"bjsj":
                if (context.Request.Params["vks"] != null)
                {
                    mStrKs = context.Request.Params["vks"].ToString();
                }
                if (context.Request.Params["vjs"] != null)
                {
                    mStrJs = context.Request.Params["vjs"].ToString();
                }
                if (context.Request.Params["vmh"] != null)
                {
                    mStrMH = context.Request.Params["vmh"].ToString();
                }
                if (context.Request.Params["vhf"] != null )
                {
                    mStrHF = context.Request.Params["vhf"].ToString();
                }
                if (context.Request.Params["vsb"] != null)
                {
                    mStrSB = context.Request.Params["vsb"].ToString();
                }
                if (context.Request.Params["vqy"] != null)
                {
                    mStrQY = context.Request.Params["vqy"].ToString(); 
                }
                context.Response.Write(GetBjJL());
                break; 
            case"tree":
                context.Response.Write(GetCompany());
                break;  
            case"CompanyT":
                string str_Company = "";
                str_Company = context.Request.Params["vCompany"].ToString();
                if (string.IsNullOrEmpty(str_Company) == false)
                {
                    context.Response.Write(GetBranch(str_Company));
                }
                break;
            case"BranchT":
                string str_Branch = "";
                str_Branch = context.Request.Params["vBranch"].ToString();
                if (string.IsNullOrEmpty(str_Branch) == false)
                {
                    context.Response.Write(GetEmployee(str_Branch)); 
                }
                break; 
            case"Tsp":
                context.Response.Write(GetTsPeople());
                break;
            case"Tspdel":
                string strddz = context.Request.Params["vtspddz"].ToString();
                string stremp = context.Request.Params["vtspemp"].ToString();
                context.Response.Write(DelTsp(strddz,stremp));
                break;
            //设定历史点
            case "hs":
                int mIntResult = AddBjData(context);
                GxLsBzid(context);
                context.Response.Write(mIntResult);
                break;
            //取消历史点
            case "qxls":
                context.Response.Write(GxLsBz( context));
                break;
            default:
                break;   
                
        }
    }
    //获取采集地址、值
    public string GetGycsValue()
    {
        List <plcgycsValue> mList = new List<plcgycsValue>();
        string lStrSQL = "select dVchCjdz,dVchValue,dIntDqBz from tZPlcDtTemp ";
        
        DataTable dt = null;
        using (dt=claSqlConnDB.ExecuteDataset(claSqlConnDB.gStrConnDefault,CommandType.Text,lStrSQL).Tables[0])
        {
            for(int i=0;i<dt.Rows.Count;i++)
            {
                plcgycsValue mModel = new plcgycsValue();
                mModel.dVchAllAdress = dt.Rows[i][0].ToString();
                mModel.dVchValue = dt.Rows[i][1].ToString();
                if (dt.Rows[i][2].ToString() != "")
                {
                    mModel.dIntDqBz = Int32.Parse(dt.Rows[i][2].ToString()); 
                }
                mList.Add(mModel);
            }
        }
        return JsonConvert.SerializeObject(mList);
            
    }
    private string GetRecord1()
    {
        string total = "";
        total = claSqlConnDB.GetRecordCount(claSqlConnDB.gStrConnDefault, "select count(*) from tZPlcDtTemp ").ToString();
        return total;
    }
    //新修改的工艺参数下显示相关点信息
    //------------------------------------------------------------------
    public string GetddzByGycs()
    {
        string mStrResult = "";
        GJHF.Business.PLC.BPlcPointType mBPlcPointType = new GJHF.Business.PLC.BPlcPointType();
        mStrResult = GJHF.Utility.WEBUI.EasyuiControl.GetGridReturn(mBPlcPointType.GetRecordByGycs(mStrPointType, sort, order), mBPlcPointType.GetddzByGycs(mStrPointType, sort, order, 100, 1));
        return mStrResult;
    }
    //根据系统来获取相关工艺参数点信息
    public string GetPointddz()
    {
        List<plcgycs> Grid = new List<plcgycs>();
        string lStrSql = @"select  tZPlcPointDiZhi.dIntDataID, dVchAdressName, dVchAddress, tZPlcPointDiZhi.dVchAllAdress, dVchDescription, dIntDataType, 
                                    dFltBeishu, dFltMoniMax, dFltMoniMin, tZPlcPointDiZhi.dFltSjMax, tZPlcPointDiZhi.dFltSjMin, dVchDanwei, dVchDataType,dIntJsBz,dVchFormula,
                                    dfltMax,dfltMin,dVchKgAlermValue,tZSbBaojingFanwei.dVchRemark,tZSbBaojingFanwei.dIntAdressTypeID,tZPlcHistoryJK.dIntBjBz
                                    FROM tZPlcPointDiZhi left outer join tZPLCVariableFormula on tZPlcPointDiZhi.dVchAllAdress = tZPLCVariableFormula.dVchVariable 
                                     left outer join tZSbBaojingFanwei on tZPlcPointDiZhi.dVchAllAdress = tZSbBaojingFanwei.dVchAllAdress 
                                     left outer join tZPlcHistoryJK on tZPlcPointDiZhi.dVchAllAdress = tZPlcHistoryJK.dVchCjdz " + GetWhere() + GetOrder();

        
        DataTable dt = null;
        dt = claSqlConnDB.ExecuteDataset(claSqlConnDB.gStrConnDefault, CommandType.Text, lStrSql).Tables[0];
        var re =new { Total = GetRecord(), rows = dt };

        return JsonConvert.SerializeObject(re);
    }
    
    
    private string GetRecord()
    {
        string total = "";
        total = claSqlConnDB.GetRecordCount(claSqlConnDB.gStrConnDefault, "select count(*) from tZPlcPointDiZhi " + GetWhere()).ToString();
        return total;
    }
    private string GetWhere()
    {
        string mStrWhere = " where tZPlcPointDiZhi.dIntDataID <> -1 ";
        if (mStrPointType != "")
        {
            mStrWhere = mStrWhere + " and dIntPointType = " + mStrPointType;
        }
        else
        {
            mStrWhere = mStrWhere + " and dIntPointType = -100 ";
        }
        return mStrWhere;
    }

    private string GetOrder()
    {
        string mStrOrder = " order by dIntShouJiPx ";
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


    
    //报警点综合设置
    private int GetBjSdMethod(HttpContext context)
    {
        int voIntReturn = -2;
        int voIntReturn1;
        int voIntReturn2;
        //int voIntReturn3;
        int voIntReturn4;
        
        //添加数据到报警历史表中
        voIntReturn1 = AddBjData(context);
        //更改点地址的历史表中的报警标志
        voIntReturn2 = GetBjBZ(context);
        //更改点地址表中的标志
        //voIntReturn3 = GetDdzBjBz(context);
        //设置报警上线限
        voIntReturn4 = SetBjfw(context);
        if (voIntReturn1 == 0 && voIntReturn2 == 1 &&   voIntReturn4 == 1)
        {
            voIntReturn = 0;
        }
        else
        {
            voIntReturn = -1;
        }
        return voIntReturn; 
    }
    
    //添加历史数据（包括报警数据）
    private int AddBjData(HttpContext context)
    {
        
        int mIntDataID = 0;
        string mStrFactoryCode = "";
        string mStrPLCCode = "";
        string mStrAdress = "";
        string mStrCjdz = "";
        string mStrValue = "";
        string mStrSjValue = "";
        string mStrUnit = "";
        int mIntDqBz = 0;
        float mFltSjMax = 0f;
        float mFltSjMin = 0f;
        float mFltBdMax = 0f;
        float mFltBdMin = 0f;
        string mStrfwqdh = "";
        string mStrName = "";
        int mIntdizhiID = 0;
        string mequip_code = "";
        string mStrVariableType = "";
        int voIntReturn;

        if (context.Request.Params["vDid"] != null)
        {
            if (context.Request.Params["vDid"].ToString() != "")
            {
                mIntDataID = Int32.Parse(context.Request.Params["vDid"].ToString());
            }
        }
        
//        string mStrSQL = @"SELECT   TOP (1) dVchFactoryCode,dVchPLCbianma,dVchAddress, dVchAllAdress, dVchDanwei,dFltMoniMax, dFltMoniMin, dFltSjMax, dFltSjMin,
//                            dVchFwqdh,dVchDescription,dIntDataID,dVchSbBianHao,dVchDataType
//                            FROM      tZPlcPointDiZhi 
//                            left outer join tZPLCManager on tZPlcPointDiZhi.dIntPLCID = tZPLCManager.dIntPLCID
//                            left outer join tZSbAndPLC on tZPlcPointDiZhi.dIntDataID = tZSbAndPLC.dVchPLCAddress
//                            where dIntDataID = " + mIntDataID;

//        SqlDataReader dr = claSqlConnDB.ExecuteReader(claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL);
//        if (dr.Read())
//        {
//            mStrFactoryCode = dr[0].ToString();
//            mStrPLCCode = dr[1].ToString();
//            mStrAdress = dr[2].ToString();
//            if (dr[3].ToString() != null && dr[3].ToString() != "")
//            {
//                mStrCjdz = dr[3].ToString();
//            }
//            else
//            {
//                mStrCjdz = mStrPLCCode + "." + mStrAdress;
//            }
//            mStrUnit = dr[4].ToString();
//            if (isNumberic(dr[5].ToString()) == true)
//            {
//                mFltSjMax = float.Parse(dr[5].ToString());
//            }
//            else
//            {
//                mFltSjMax = 0f;
//            }
//            if (isNumberic(dr[6].ToString()) == true)
//            {
//                mFltSjMin = float.Parse(dr[6].ToString());
//            }
//            else
//            {
//                mFltSjMin = 0f;
//            }
//            if (isNumberic(dr[7].ToString()) == true)
//            {
//                mFltBdMax = float.Parse(dr[7].ToString());
//            }
//            else
//            {
//                mFltBdMax = 0f;
//            }
//            if (isNumberic(dr[8].ToString()) == true)
//            {
//                mFltBdMin = float.Parse(dr[8].ToString());
//            }
//            else
//            {
//                mFltBdMin = 0f;
//            }
//            mStrfwqdh = dr[9].ToString();
//            mStrName = dr[10].ToString();
//            if (isNumberic(dr[11].ToString()) == true)
//            {
//                mIntdizhiID = Int32.Parse(dr[11].ToString());
//            }
//            else
//            {
//                mIntdizhiID = 0;
//            }
//            mequip_code = dr[12].ToString();
//            mStrVariableType = dr[13].ToString();
            
//        }
//        dr.Close();
//        dr.Dispose();

        DataTable dt = GJHF.Business.PLC.BPlcDdz.GetOneData(mIntDataID);
        if (dt.Rows.Count > 0)
        {
            mStrFactoryCode = dt.Rows[0][0].ToString();
            mStrPLCCode = dt.Rows[0][1].ToString();
            mStrAdress = dt.Rows[0][2].ToString();
            if (dt.Rows[0][3].ToString() != null && dt.Rows[0][3].ToString() != "")
            {
                mStrCjdz = dt.Rows[0][3].ToString();
            }
            else
            {
                mStrCjdz = mStrPLCCode + "." + mStrAdress;
            }
            mStrUnit = dt.Rows[0][4].ToString();
            if (isNumberic(dt.Rows[0][5].ToString()) == true)
            {
                mFltSjMax = float.Parse(dt.Rows[0][5].ToString());
            }
            else
            {
                mFltSjMax = 0f;
            }
            if (isNumberic(dt.Rows[0][6].ToString()) == true)
            {
                mFltSjMin = float.Parse(dt.Rows[0][6].ToString());
            }
            else
            {
                mFltSjMin = 0f;
            }
            if (isNumberic(dt.Rows[0][7].ToString()) == true)
            {
                mFltBdMax = float.Parse(dt.Rows[0][7].ToString());
            }
            else
            {
                mFltBdMax = 0f;
            }
            if (isNumberic(dt.Rows[0][8].ToString()) == true)
            {
                mFltBdMin = float.Parse(dt.Rows[0][8].ToString());
            }
            else
            {
                mFltBdMin = 0f;
            }
            mStrfwqdh = dt.Rows[0][9].ToString();
            mStrName = dt.Rows[0][10].ToString();
            if (isNumberic(dt.Rows[0][11].ToString()) == true)
            {
                mIntdizhiID = Int32.Parse(dt.Rows[0][11].ToString());
            }
            else
            {
                mIntdizhiID = 0;
            }
            mequip_code = dt.Rows[0][12].ToString();
            mStrVariableType = dt.Rows[0][13].ToString();
        }

        //SqlParameter[] myParameter = new SqlParameter[18]
        //{
        //    new SqlParameter("@viVchFactoryCode",SqlDbType.VarChar,50),
        //    new SqlParameter("@viVchPLCCode",SqlDbType.VarChar,50),
        //    new SqlParameter("@viVchAdress",SqlDbType.VarChar,50),
        //    new SqlParameter("@viVchCjdz",SqlDbType.VarChar,100),
        //    new SqlParameter("@viVchValue",SqlDbType.VarChar,50),
        //    new SqlParameter("@viVchSjValue",SqlDbType.VarChar,50),
        //    new SqlParameter("@viVchUnit",SqlDbType.VarChar,50),
        //    new SqlParameter("@viIntDqBz",SqlDbType.Int,4),
        //    new SqlParameter("@viFltSjMax",SqlDbType.Float,8),
        //    new SqlParameter("@viFltSjMin",SqlDbType.Float,8),
        //    new SqlParameter("@viFltBdMax",SqlDbType.Float,8),
        //    new SqlParameter("@viFltBdMin",SqlDbType.Float,8),
        //    new SqlParameter("@viVchfwqdh",SqlDbType.VarChar,50),
        //    new SqlParameter("@viVchName",SqlDbType.VarChar,50),
        //    new SqlParameter("@viIntdizhiID",SqlDbType.Int,4),
        //    new SqlParameter("@viequip_code",SqlDbType.VarChar,50),
        //    new SqlParameter("@viVchVariableType",SqlDbType.VarChar,20),
        //    new SqlParameter("@voIntReturn",SqlDbType.Int,4)
              
        //};

        //myParameter[0].Value = mStrFactoryCode;
        //myParameter[1].Value = mStrPLCCode;
        //myParameter[2].Value = mStrAdress;
        //myParameter[3].Value = mStrCjdz;
        //myParameter[4].Value = mStrValue;
        //myParameter[5].Value = mStrSjValue;
        //myParameter[6].Value = mStrUnit;
        //myParameter[7].Value = mIntDqBz;
        //myParameter[8].Value = mFltSjMax;
        //myParameter[9].Value = mFltSjMin;
        //myParameter[10].Value = mFltBdMax;
        //myParameter[11].Value = mFltBdMin;
        //myParameter[12].Value = mStrfwqdh;
        //myParameter[13].Value = mStrName;
        //myParameter[14].Value = mIntdizhiID;
        //myParameter[15].Value = mequip_code;
        //myParameter[16].Value = mStrVariableType;
        //myParameter[17].Direction = ParameterDirection.Output;
        //claSqlConnDB.ExecuteNonQuery(claSqlConnDB.gStrConnDefault, CommandType.StoredProcedure, "pZPlcHistoryJKAdd", myParameter);
        //voIntReturn = (int)myParameter[17].Value;
        voIntReturn = GJHF.Business.PLC.BPlcBaojing.AddBjData(mStrFactoryCode, mStrPLCCode, mStrAdress, mStrCjdz, mStrValue, mStrSjValue, mStrUnit, mIntDqBz, mFltSjMax, mFltSjMin, mFltBdMax,
           mFltBdMin, mStrfwqdh, mStrName, mIntdizhiID, mequip_code, mStrVariableType);
        return voIntReturn;
        
    }
    //设定报警标识
    private int GetBjBZ(HttpContext context)
    {
        int voIntReturn = -2;
        int mIntBjBz = -1;
        try
        {
            string mStrCjdz = "";
            //int mIntBjBz = 0;

            if (context.Request.Params["vcjdz"] != null)
            {
                if (context.Request.Params["vcjdz"].ToString() != "")
                {
                    mStrCjdz = context.Request.Params["vcjdz"].ToString();
                }
            }
            if (context.Request.Params["vBjBz"] != null)
            {
                if (isNumberic(context.Request.Params["vBjBz"].ToString()) == true)
                {
                    mIntBjBz = Int32.Parse(context.Request.Params["vBjBz"]);
                }
            }
            //string mStrSQL = "update tZPlcHistoryJK set dIntBjBz = " + mIntBjBz + " where dVchCjdz = '" + mStrCjdz + "'";
            ////claSqlConnDB.RunSql(claSqlConnDB.gStrConnDefault, mStrSQL);
            //voIntReturn = claSqlConnDB.ExecuteNonQuery(claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL);
            voIntReturn = GJHF.Business.PLC.BPlcBaojing.GetBJBZ(mStrCjdz, mIntBjBz);
            return voIntReturn;
        }
        catch (Exception eee)
        {
            return voIntReturn;
        }
    }

    
    
    //更改点地址报警标志
    private int GetDdzBjBz(HttpContext context)
    {
        int voIntReturn = -2;
        int mIntDataID = 0;
        int mIntGzOrQd = -1;
        string mStrSQL = "";
        try
        {
            if (context.Request.Params["vDid"] != null)
            {
                if (context.Request.Params["vDid"].ToString() != "")
                {
                    mIntDataID = Int32.Parse(context.Request.Params["vDid"].ToString());
                }
            }
            if (context.Request.Params["vGz"] != null)
            {
                if (context.Request.Params["vGz"].ToString() != "")
                {
                    mIntGzOrQd = Int32.Parse(context.Request.Params["vGz"].ToString());
                } 
            }
            mStrSQL = "update tZPlcPointDiZhi set dIntGzOrQd = " + mIntGzOrQd + " where dIntDataID = " + mIntDataID;
            voIntReturn = claSqlConnDB.ExecuteNonQuery(claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL);
            return voIntReturn;
        }
        catch (Exception eee)
        {
            return voIntReturn;
        }
        
    }

    //更改历史点标志1
    private string GxLsBzid(HttpContext context)
    {
        try
        {
            int mIntCjdzid = -1;
            int voIntRetrun = 0;
            int mIntBjBz = -1;
            string mStrSQL = "";

            if (context.Request.Params["vDid"] != null)
            {
                if (context.Request.Params["vDid"].ToString() != "")
                {
                    mIntCjdzid = Int32.Parse(context.Request.Params["vDid"].ToString());
                }
            }
            if (context.Request.Params["vlsbz"] != null)
            {
                if (isNumberic(context.Request.Params["vlsbz"].ToString()) == true)
                {
                    mIntBjBz = Int32.Parse(context.Request.Params["vlsbz"]);
                }
            }
            mStrSQL = "update tZPlcHistoryJK set dIntHsBz = " + mIntBjBz + " where dIntdizhiID = '" + mIntCjdzid + "'";
            voIntRetrun = claSqlConnDB.ExecuteNonQuery(claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL);
            return voIntRetrun.ToString();
        }
        catch (Exception eee)
        {
            return "-2";
        }
    }
    //取消历史点1.更新历史表中的标志2.如果只有一个历史标志，那么可以删除这条数据。暂时只是更新历史标志，删除再考虑。
    private string GxLsBz(HttpContext context)
    {
        try
        {
            string mStrCjdz = "";
            int voIntRetrun = 0;
            int mIntBjBz = -1;
            string mStrSQL = "";

            if (context.Request.Params["vCjdz"] != null)
            {
                if (context.Request.Params["vCjdz"].ToString() != "")
                {
                    mStrCjdz = context.Request.Params["vCjdz"].ToString();
                }
            }
            if (context.Request.Params["vlsbz"] != null)
            {
                if (isNumberic(context.Request.Params["vlsbz"].ToString()) == true)
                {
                    mIntBjBz = Int32.Parse(context.Request.Params["vlsbz"]);
                }
            }
            mStrSQL = "update tZPlcHistoryJK set dIntHsBz = " + mIntBjBz + " where dVchCjdz = '" + mStrCjdz + "'";
            voIntRetrun = claSqlConnDB.ExecuteNonQuery(claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL);
            return voIntRetrun.ToString();
        }
        catch (Exception eee)
        {
            return "-2";
        }
    }
    
    //删除相关上线限的设定
    private int  DelAlermRange(HttpContext context)
    {
        int result = 0;
        string mStrCjdz = "";
        if (context.Request.Params["vcjdz"] != null)
        {
            if (context.Request.Params["vcjdz"].ToString() != "")
            {
                mStrCjdz = context.Request.Params["vcjdz"].ToString();
            }
        }
        //string mStrSQL = "delete from tZSbBaojingFanwei where dVchAllAdress = '" + mStrCjdz + "'";
        //result = claSqlConnDB.ExecuteNonQuery(claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL);
        result = GJHF.Business.PLC.BPlcBaojing.DelAlermRange(mStrCjdz);
        return result;
    }
    //取消报警综合
    private int GetQxBj(HttpContext context)
    {
        int voIntReturn = -2;
        int voIntReturn1;
        //int voIntReturn2;
        int voIntReturn3;

        voIntReturn1 = GetBjBZ(context);
        //voIntReturn2 = GetDdzBjBz(context);
        voIntReturn3 = DelAlermRange(context);
        
        if (voIntReturn1 >= 0  && voIntReturn3 >=0)
        {
            voIntReturn = 0;
        }
        else
        {
            voIntReturn = -1;
        }
        return voIntReturn;


    }
   
    
    //查看设定报警信息
    private string GetBjSdData()
    {
        List<PlcHistoryJK> mList = new List<PlcHistoryJK>();
      

        string lStrSql = @"SELECT dIntDataID, dVchFactoryCode, dVchPLCCode, dVchAdress, dVchCjdz, dVchValue, dVchSjValue, dVchUnit, 
                            dIntDqBz, dVchUser, dIntYzBz, dFltSjMax, dFltSjMin, dFltBdMax, dFltBdMin, dVchfwqdh, dVchName, dIntdizhiID, 
                            tZPlcHistoryJK.equip_code, dVchVariableType, dIntHsBz, dIntBjBz, dIntDxjBz, dIntTsdBz,equip_name
                            FROM  tZPlcHistoryJK left outer join t_Equips on  tZPlcHistoryJK.equip_code = t_Equips.equip_code " + GetWhere2() + GetOrder2();

        DataTable dt = null;
        using (dt = claSqlConnDB.ExecuteDataset(rows, page, claSqlConnDB.gStrConnDefault, CommandType.Text, lStrSql).Tables[0])
        {
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                PlcHistoryJK mModel = new PlcHistoryJK();
                if (dt.Rows[i][0].ToString() != "")
                {
                    mModel.dIntDataID = Int32.Parse(dt.Rows[i][0].ToString());
                }
                mModel.dVchFactoryCode = dt.Rows[i][1].ToString();
                mModel.dVchPLCCode = dt.Rows[i][2].ToString();
                mModel.dVchAdress = dt.Rows[i][3].ToString();
                mModel.dVchCjdz = dt.Rows[i][4].ToString();
                mModel.dVchValue = dt.Rows[i][5].ToString();
                mModel.dVchSjValue = dt.Rows[i][6].ToString();
                mModel.dVchUnit = dt.Rows[i][7].ToString();
                if (dt.Rows[i][8].ToString() != "")
                {
                    mModel.dIntDqBz = Int32.Parse(dt.Rows[i][8].ToString());
                }
                mModel.dVchUser = dt.Rows[i][9].ToString();
                if (dt.Rows[i][10].ToString() != "")
                {
                    mModel.dIntYzBz = Int32.Parse(dt.Rows[i][10].ToString());
                }
                if (dt.Rows[i][11].ToString() != "")
                {
                    mModel.dFltSjMax = float.Parse(dt.Rows[i][11].ToString());
                }
                if (dt.Rows[i][12].ToString() != "")
                {
                    mModel.dFltSjMin = float.Parse(dt.Rows[i][12].ToString());
                }
                if (dt.Rows[i][13].ToString() != "")
                {
                    mModel.dFltBdMax = float.Parse(dt.Rows[i][13].ToString());
                }
                if (dt.Rows[i][14].ToString() != "")
                {
                    mModel.dFltBdMin = float.Parse(dt.Rows[i][14].ToString());
                }
               
                mModel.dVchfwqdh = dt.Rows[i][15].ToString();
                mModel.dVchName = dt.Rows[i][16].ToString();
                if (dt.Rows[i][17].ToString() != "")
                {
                    mModel.dIntdizhiID = Int32.Parse(dt.Rows[i][17].ToString());
                }
                mModel.equip_code = dt.Rows[i][18].ToString();
                mModel.dVchVariableType = dt.Rows[i][19].ToString();
                if (dt.Rows[i][20].ToString() != "")
                {
                    mModel.dIntHsBz = Int32.Parse(dt.Rows[i][20].ToString());
                }
                if (dt.Rows[i][21].ToString() != "")
                {
                    mModel.dIntBjBz = Int32.Parse(dt.Rows[i][21].ToString()); 
                }
                if (dt.Rows[i][22].ToString() != "")
                {
                    mModel.dIntDxjBz = Int32.Parse(dt.Rows[i][22].ToString());
                }
                if (dt.Rows[i][23].ToString() != "")
                {
                    mModel.dIntTsdBz = Int32.Parse(dt.Rows[i][23].ToString());
                }
                mModel.equip_name = dt.Rows[i][24].ToString();
                mList.Add(mModel);
            }

        }
        var result = new { total = GetRecord2(), rows = mList };

        //return Json(result, JsonRequestBehavior.AllowGet);
        return JsonConvert.SerializeObject(result);
        
    }
    private string GetRecord2()
    {
        string total = "";
        total = claSqlConnDB.GetRecordCount(claSqlConnDB.gStrConnDefault, "select count(*) FROM  tZPlcHistoryJK left outer join t_Equips on  tZPlcHistoryJK.equip_code = t_Equips.equip_code " + GetWhere2()).ToString();
        return total;
    }
    private string GetWhere2()
    {
        string mStrWhere = " where dIntBjBz = 1";

        if (mStrSB != "")
        {
            mStrWhere = mStrWhere + " and tZPlcHistoryJK.equip_code = '" + mStrSB + "'";
        }
        if (mStrMH != "")
        {
            mStrWhere = mStrWhere + " and dVchAdress + dVchName like '%" + mStrMH + "%'";
        }
        return mStrWhere;
    }
    private string GetOrder2()
    {
        string mStrOrder = "order by dIntDataID ";
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
    //报警记录信息
    private string GetBjJL()
    {
        List<PlcBjGxDisplay> mList = new List<PlcBjGxDisplay>();
        DataTable dt = null;   
        string mStrSQL = @"SELECT  dIntID, dIntdizhiID, dVchCjdz, dVchEquip_code,equip_name, dVchAdress, dVchName, dDaeGzCs, dDaeGzHf, dVchValue,tZPlcBjGxDisplay.dVchRemark
                            FROM      tZPlcBjGxDisplay left outer join t_Equips on tZPlcBjGxDisplay.dVchEquip_code = t_Equips.equip_code 
                            left outer join tZPlcPointDiZhi on dIntdizhiID = tZPlcPointDiZhi.dIntDataID
                            left outer join tZPLCManager on  tZPlcPointDiZhi.dIntPLCID = tZPLCManager.dIntPLCID " + GetWhere3() + GetOrder3();
        using (dt = claSqlConnDB.ExecuteDataset(rows,page,claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL).Tables[0])
        {
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                PlcBjGxDisplay mModel = new PlcBjGxDisplay();
                if (dt.Rows[i][0].ToString() != "")
                {
                    mModel.dIntID = Int32.Parse(dt.Rows[i][0].ToString());
                }
                if (dt.Rows[i][1].ToString() != "")
                {
                    mModel.dIntdizhiID = (int)dt.Rows[i][1]; 
                }
                mModel.dVchCjdz = dt.Rows[i][2].ToString();
                mModel.dVchEquip_code = dt.Rows[i][3].ToString();
                mModel.equip_name = dt.Rows[i][4].ToString();
                mModel.dVchAdress = dt.Rows[i][5].ToString();
                mModel.dVchName = dt.Rows[i][6].ToString();
                if (dt.Rows[i][7].ToString() != "")
                {
                    mModel.dDaeGzCs = (DateTime)dt.Rows[i][7];
                }
                if (dt.Rows[i][8].ToString() != "")
                {
                    mModel.dDaeGzHf = (DateTime)dt.Rows[i][8];
                }
                mModel.dVchValue = dt.Rows[i][9].ToString();
                mModel.dVchRemark = dt.Rows[i][10].ToString();
                mList.Add(mModel);
            }
        }

        var result = new { total = GetRecord3(), rows = mList };
        return JsonConvert.SerializeObject(result);
    }
    private string GetRecord3()
    {
        string total = "";
        string mStrSQL = @"select count(*) from tZPlcBjGxDisplay left outer join t_Equips on tZPlcBjGxDisplay.dVchEquip_code = t_Equips.equip_code 
                            left outer join tZPlcPointDiZhi on dIntdizhiID = tZPlcPointDiZhi.dIntDataID
                            left outer join tZPLCManager on  tZPlcPointDiZhi.dIntPLCID = tZPLCManager.dIntPLCID " + GetWhere3();
        total = claSqlConnDB.GetRecordCount(claSqlConnDB.gStrConnDefault, mStrSQL).ToString();
        return total;
    }
    private string GetWhere3()
    {
        string mStrWhere = " where dIntID <> 0 ";
        if (mStrSB != "")
        {
            mStrWhere = mStrWhere + " and dVchEquip_code = '" + mStrSB + "'";
        };
        if(mStrKs != "" && mStrJs != "")
        {
            mStrWhere = mStrWhere + " and dDaeGzCs >= '" + mStrKs + "' and dDaeGzCs <= '" + mStrJs + "'";
        }
        if (mStrHF != "" )
        {
            if (mStrHF != "-1")
            {
                mStrWhere = mStrWhere + " and dIntBiaozhi = " + mStrHF;
            }
        }
        if (mStrMH != "")
        {
            mStrWhere = mStrWhere + " and t_Equips.equip_name+ dVchAdress + dVchName like '%" + mStrMH + "%' "; 
        }

        if (mStrQY != "")
        {
            mStrWhere = mStrWhere + " and tZPLCManager.dIntGongYiXitongID = " + mStrQY + "" ; 
        }
        
        
        return mStrWhere;
    }
    private string GetOrder3()
    {
        string mStrOrder = " order by dDaeGzCs desc ";
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
    
   

    //设定报警上下限
    public int SetBjfw(HttpContext context)
    {
        string mStrSbbm = "";
        string mStrcjdz = "";
        int mIntdzlb = 0;
        float mfltMax = 0f;
        float mfltMin = 0f;
        string mStrKgl = "";
        string mStrRemark = "";
        string  mStrPeople = "";
        string mStrError = "";
        int result;
        try
        {
            mStrSbbm = context.Request.Params["bjSbbm"];
            mStrcjdz = context.Request.Params["bjcjdz"];

            if (string.IsNullOrEmpty(context.Request.Params["bjdzlb"].ToString()) ==false)
            {
                mIntdzlb = Int32.Parse(context.Request.Params["bjdzlb"]);
            }
            if (string.IsNullOrEmpty(context.Request.Params["bjMax"].ToString()) == false)
            {
                mfltMax = float.Parse(context.Request.Params["bjMax"]);
            }
            if (string.IsNullOrEmpty(context.Request.Params["bjMin"].ToString()) == false)
            {
                mfltMin = float.Parse(context.Request.Params["bjMin"]);
            }
            mStrKgl = context.Request.Params["bjKgl"];
            mStrRemark = context.Request.Params["bjRemark"];
            mStrPeople = context.Request.Params["bjNodes"];
            
        //    SqlParameter[] myparamter = new SqlParameter[9]
        //{
        //    new SqlParameter("@viVchSbCode",SqlDbType.VarChar,50),
        //    new SqlParameter("@viVchAllAdress",SqlDbType.VarChar,50),
        //    new SqlParameter("@viIntAdressTypeID",SqlDbType.Int,4),
        //    new SqlParameter("@vifltMax",SqlDbType.Float,8),
        //    new SqlParameter("@vifltMin",SqlDbType.Float,8),
        //    new SqlParameter("@viVchKgAlermValue",SqlDbType.VarChar,50),
        //    new SqlParameter("@viIntBaojingJBID",SqlDbType.Int,4),
        //    new SqlParameter("@viVchRemark",SqlDbType.VarChar,50),
        //    new SqlParameter("@voIntReturn",SqlDbType.Int,4)
        //};

        //    myparamter[0].Value = mStrSbbm;
        //    myparamter[1].Value = mStrcjdz;
        //    myparamter[2].Value = mIntdzlb;
        //    myparamter[3].Value = mfltMax;
        //    myparamter[4].Value = mfltMin;
        //    myparamter[5].Value = mStrKgl;
        //    myparamter[6].Value = 0;
        //    myparamter[7].Value = mStrRemark;
        //    myparamter[8].Direction = ParameterDirection.Output;
        //    result = claSqlConnDB.ExecuteNonQuery(claSqlConnDB.gStrConnDefault, CommandType.StoredProcedure, "pZSbBaojingFanweiAdd", myparamter);
            result = GJHF.Business.PLC.BPlcBaojing.AddBjFw(mStrSbbm, mStrcjdz, mIntdzlb, mfltMax, mfltMin, mStrKgl, 0, mStrRemark);
            //SetTsPeople(0,mStrcjdz, mStrPeople);
            GJHF.Business.PLC.BPlcBaojing.SetTsPeople(0,mStrcjdz,mStrPeople);
            return result;
        }
        catch (Exception eee)
        {
            mStrError = eee.ToString();
            return -1;
        }
    }
   //设置报警与推送人员方法
    private void SetTsPeople(int vIntdizhiID,string vcjdz,string vpeople)
    {
        int reslut = 0;
        SqlParameter[] myparameter = new SqlParameter[4]
         {
             new SqlParameter("@viIntdizhiID",SqlDbType.Int,8),
             new SqlParameter("@viVchCjdz",SqlDbType.VarChar,50),
             new SqlParameter("@viVchMbValue",SqlDbType.VarChar,5000),
             new SqlParameter("@voIntReturn",SqlDbType.Int,4)
         };
        //地址id暂时给0，预留字段
        myparameter[0].Value = vIntdizhiID;
        myparameter[1].Value = vcjdz;
        myparameter[2].Value = vpeople;
        myparameter[3].Direction = ParameterDirection.Output;
        reslut = claSqlConnDB.ExecuteNonQuery(claSqlConnDB.gStrConnDefault, CommandType.StoredProcedure, "pZPlcddzAndPeople", myparameter);
        
    }
   
    
    
    //获取所有公司
    private string GetCompany()
    {
        List<combotree> mlist = new List<combotree>();
        DataTable dt;
        string mStrSQL =@"SELECT   TOP (200) dIntCompanyID, dVchCompanyName, dVchShortName, dVchZZJGDM, dVchAddress, dVchPhone, dVchWeb,  dVchEmail, dIntFlagSelf FROM      tHRCompany ";
        using (dt = claSqlConnDB.ExecuteDataset(claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL).Tables[0])
        {
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                combotree mModel = new combotree();
                mModel.id = dt.Rows[i][0].ToString();
                if (GetBranchCount(mModel.id) > 0)
                {
                    mModel.state = "closed";
                    
                }
                else
                {
                    mModel.state = "open";
                }
                
                mModel.text = dt.Rows[i][1].ToString();
                mModel.iconCls = "icon-area";
                mModel.attributes = "Company";
                mlist.Add(mModel);
            }
        }

        return JsonConvert.SerializeObject(mlist);
        
    }
    //获取所有公司下的部门条数
    private int GetBranchCount(string vStrCompanyID)
    {
        int count = 0;
        string mStrSQL = "select count(*) from tHRBranchInfo where dIntCompanyID = " + vStrCompanyID + "";
        count = claSqlConnDB.GetRecordCount(claSqlConnDB.gStrConnDefault,mStrSQL);
        return count;
    }
    
    //获取公司下的部门
    private string GetBranch(string vStrCompanyID)
    {
        List<combotree> mlist = new List<combotree>();
        DataTable dt = null;
        string mStrSQL = @"SELECT  dIntBranchID, dVchBranchName, dVchBranchPY, dIntUpBranch, dIntCompanyID FROM      tHRBranchInfo where dIntCompanyID = " + vStrCompanyID;
        
        using(dt = claSqlConnDB.ExecuteDataset(claSqlConnDB.gStrConnDefault,CommandType.Text,mStrSQL).Tables[0])
        {
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                combotree mModel = new combotree();
                mModel.id = dt.Rows[i][0].ToString();
                if (GetEmployeeRecord(mModel.id) > 0)
                {
                    mModel.state = "closed";
                }
                else
                {
                    mModel.state = "open";
                }
                mModel.text = dt.Rows[i][1].ToString();
                mModel.iconCls = "icon-area";
                mModel.attributes = "Branch";
                mlist.Add(mModel);
            }
        }

        return JsonConvert.SerializeObject(mlist);
        
    }
    //获取部门下人员的个数
    private int GetEmployeeRecord(string vStrBranchID)
    {
        int count = 0;
        string mStrSQL = "select count(*) from t_Employee where branch_id = " + vStrBranchID;
        count = claSqlConnDB.GetRecordCount(claSqlConnDB.gStrConnDefault, mStrSQL);
        return count;
    }
    //获取部门下的人员
    private string GetEmployee(string vStrBranchID)
    {
        List<combotree> mlist = new List<combotree>();
        DataTable dt = null;
        string mStrSQL = @"SELECT  employee_code,  employee_Name
                                        FROM      t_Employee where branch_id = " + vStrBranchID;

        using (dt = claSqlConnDB.ExecuteDataset(claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL).Tables[0])
        {
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                combotree mModel = new combotree();
                mModel.id = dt.Rows[i][0].ToString();
                mModel.text = dt.Rows[i][1].ToString();
                mModel.attributes = "people";
                mModel.iconCls = "icon-man";
                
                mlist.Add(mModel);
            } 
        }
        return JsonConvert.SerializeObject(mlist);
    }
    //获取绑定的推送人信息
    private string GetTsPeople()
    {
        List<plctsp> mlist = new List<plctsp>();
        DataTable dt = null;
        string mStrSQL = @"select  t_Employee.employee_Name, tHRBranchInfo.dVchBranchName,tHRCompany.dVchCompanyName,tZPlcddzAndPeopleMore.dVchCjdz,tZPlcddzAndPeopleMore.employee_code from tZPlcddzAndPeopleMore 
                                        left outer join t_Employee on tZPlcddzAndPeopleMore.employee_code = t_Employee.employee_code 
                                        left outer join tHRBranchInfo on t_Employee.branch_id = tHRBranchInfo.dIntBranchID
                                        left outer join tHRCompany on tHRBranchInfo.dIntCompanyID = tHRCompany.dIntCompanyID
                                        " + GetWhereTsp();

        using (dt = claSqlConnDB.ExecuteDataset(claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL).Tables[0])
        {
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                plctsp mModel = new plctsp();
                mModel.employee_name = dt.Rows[i][0].ToString();
                mModel.branch_name = dt.Rows[i][1].ToString();
                mModel.company_name = dt.Rows[i][2].ToString();
                mModel.dVchCjdz = dt.Rows[i][3].ToString();
                mModel.employee_code = dt.Rows[i][4].ToString();
                mlist.Add(mModel);
            }
        }
        var result = new { total = GetRecordTsp(), rows = mlist };
        return JsonConvert.SerializeObject(result);
    }
    private string GetRecordTsp()
    {
        string mStrSQL = "select count(0) from tZPlcddzAndPeopleMore " + GetWhereTsp();
        return claSqlConnDB.GetRecordCount(claSqlConnDB.gStrConnDefault, mStrSQL).ToString();
    }
    private string GetWhereTsp()
    {
        string mStrWhere = " where tZPlcddzAndPeopleMore.dVchCjdz <> '00000000'";
        if (string.IsNullOrEmpty(mStrtsddz) == false)
        {
            mStrWhere = mStrWhere + " and tZPlcddzAndPeopleMore.dVchCjdz = '" + mStrtsddz + "'"; 
        }
        return mStrWhere;
    }
    //删除推送人员
    private int DelTsp(string vStrCjdz, string vStremployee_code)
    {
        int reslut = 0;
        SqlParameter[] myparameter = new SqlParameter[3]
         {
             new SqlParameter("@viVchCjdz",SqlDbType.VarChar,50),
             new SqlParameter("@viemployee_code",SqlDbType.VarChar,100),
             new SqlParameter("@voIntReutrn",SqlDbType.Int,4)
         };
        //地址id暂时给0，预留字段
        myparameter[0].Value = vStrCjdz;
        myparameter[1].Value = vStremployee_code;
        myparameter[2].Direction = ParameterDirection.Output;
        reslut = claSqlConnDB.ExecuteNonQuery(claSqlConnDB.gStrConnDefault, CommandType.StoredProcedure, "pZPlcddzAndPeopleMoreDel", myparameter);
        return reslut; 
    }
    protected bool isNumberic(string message)
    {
        if (message != "")
        {
            System.Text.RegularExpressions.Regex rex =
            new System.Text.RegularExpressions.Regex(@"^[+-]?\d*[.]?\d*$");

            if (rex.IsMatch(message))
            {
                return true;
            }
            else
                return false;
        }
        else
        {
            return false;
        }
    }
    
    
    public bool IsReusable {
        get {
            return false;
        }
    }


  
}