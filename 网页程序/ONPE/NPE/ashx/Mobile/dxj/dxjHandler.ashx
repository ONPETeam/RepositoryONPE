<%@ WebHandler Language="C#" Class="dxjHandler" %>

using System;
using System.Web;
using ModelClass;
using Newtonsoft.Json;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;

public class dxjHandler : IHttpHandler
{
    string type = "";
    string equip_code = "";
    string username = "";

    string TCNote = "";
    string TCDetail = "";
    string PartName = "";
    string ContentName = "";
    string StandardName = "";

    string TCNote1 = "";
    string TCDetail1 = "";
    string BadContent = "";
    string picFile = "";
    string aviFile = "";
    string tcresult = "";
    string employee_code = "";
    string planCode = "";
    string xyz = "";
    string runnum = "";
    public void ProcessRequest (HttpContext context) {
        context.Response.ContentType = "text/plain";
        type = context.Request.Params["type"];
        equip_code = context.Request.Params["equipcode"];
        username = context.Request.Params["username"];
        employee_code = context.Request.Params["employeecode"];
        TCNote = context.Request.Params["TCNote"];
        TCDetail = context.Request.Params["TCDetail"];
        PartName = context.Request.Params["PartName"];
        ContentName = context.Request.Params["ContentName"];
        StandardName = context.Request.Params["StandardName"];

        TCNote1 = context.Request.Params["TCNote1"];
        TCDetail1 = context.Request.Params["TCDetail1"];
        BadContent = context.Request.Params["BadContent"];

        picFile = context.Request.Params["picFile"];
        aviFile = context.Request.Params["aviFile"];

        tcresult = context.Request.Params["tcresult"];
        xyz = context.Request.Params["xyz"];
        runnum = context.Request.Params["runnum"];
        planCode = context.Request.Params["planCode"];

        switch (type)
        {
            //生成点巡检记录
            case "para1":
                //context.Response.Write(InsertTCNote());
                break;
            //选择【不正常】时执行缺陷库记录生成
            case "para2":
                //context.Response.Write(SelException().ToString());
                break;
            //在缺陷页面【提交】时执行
            case "para3":
                //context.Response.Write(UpdateBadContent().ToString());
                break;
            case "para4":
                //context.Response.Write(showPara1Data());
                break;
            case "para5":
                context.Response.Write(showParaDetailData());
                break;

            //生成点巡检缓存记录
            case "para6":
                context.Response.Write(InsertTCNoteCache());
                break;
            case "para7":
                context.Response.Write(showPara1DataCache());
                break;
                
                
            case "para8":
                context.Response.Write(showParaDetailDataCache());
                break;

            case "para9":
                context.Response.Write(AddPic());
                break;
            case "para10":
                context.Response.Write(AddAvi());
                break;

            case "para11":
                context.Response.Write(ShowDetailPlan());
                break;
            //开辟一个点检记录单,并巡检
            case "para12":
                context.Response.Write(TCBegin());
                break;
            //新巡检系统中,开辟一个点检记录单,并巡检
            case "para1212":
                context.Response.Write(TCBegin1());
                break;
            //case "para121":
            //    context.Response.Write(TCDetailBegin());
            //    break;
            case "para121":
                //context.Response.Write(TCEnd());
                break;
            //显示用户下面的巡检计划
            case "para13":
                context.Response.Write(ShowPlanByEmpCode());
                break;
            //分配计划给employee_code
            case "para14":
                context.Response.Write(AllpotPlanToEmpCode());
                break;     
            default:
                break;
        }
    }
    public int AllpotPlanToEmpCode()
    {
        int lIntReturn = -1;
        SqlParameter[] _Parameter = new SqlParameter[3]
            {
                new SqlParameter("@viVchTCPlan",SqlDbType.VarChar,30),
                new SqlParameter("@employee_code",SqlDbType.VarChar,30),
                new SqlParameter("@voIntReturn",SqlDbType.Int),
            };
        _Parameter[0].Value = planCode;
        _Parameter[1].Value = employee_code;
        _Parameter[2].Direction = System.Data.ParameterDirection.Output;
        claSqlConnDB.ExecuteNonQuery(claSqlConnDB.gStrConnDefault, CommandType.StoredProcedure, "pTCNoteAddCachePlanAllot", _Parameter);
        lIntReturn = (int)_Parameter[2].Value;
        return lIntReturn;
    }
    public string ShowPlanByEmpCode()
    {
        string returnStr = "";
        List<TCPlanDetail> Grid = new List<TCPlanDetail>();
        string lStrSQL = @"SELECT dVchTCPlan,
                dVchName,
                equip_code,
                equip_name,
                t_TCPart.dVchPartName,
                t_TCContent.dVchContentName,
                t_TCStandard.dVchStandardName,
                dDaeTCDetailDate,
                dDaeTCNextDate,employee_code,t_TCNoteDetailCachePlan.dVchCheckState,t_TCNoteDetailCachePlan.dVchPartName,t_TCNoteDetailCachePlan.dVchContentName,t_TCNoteDetailCachePlan.dVchStandardName,
                t_TCNoteDetailCachePlan.dVchPlanData
                FROM t_TCNoteDetailCachePlan
                INNER JOIN t_TCStandard ON t_TCStandard.dIntStandardNote = t_TCNoteDetailCachePlan.dVchStandardName
                LEFT JOIN t_TCContentStandard ON t_TCContentStandard.dIntStandardNote = t_TCStandard.dIntStandardNote 
                INNER JOIN t_TCContent ON t_TCContent.dIntContentNote = t_TCContentStandard.dIntContentNote
                LEFT JOIN t_TCPartContent ON t_TCPartContent.dIntContentNote = t_TCContent.dIntContentNote
                INNER JOIN t_TCPart ON t_TCPart.dIntPartNote = t_TCPartContent.dIntPartNote
                WHERE employee_code = '" + employee_code + "' ";
        System.Data.DataTable dt = null;
        using (dt = claSqlConnDB.ExecuteDataset(claSqlConnDB.gStrConnDefault, System.Data.CommandType.Text, lStrSQL).Tables[0])
        {
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                TCPlanDetail tmp = new TCPlanDetail();
                tmp.dVchTCPlan = dt.Rows[i][0].ToString();
                tmp.dVchName = dt.Rows[i][1].ToString();
                tmp.equip_code = dt.Rows[i][2].ToString();
                tmp.equip_name = dt.Rows[i][3].ToString();
                tmp.dVchPartName = dt.Rows[i][4].ToString();
                tmp.dVchContentName = dt.Rows[i][5].ToString();
                tmp.dVchStandardName = dt.Rows[i][6].ToString();
                tmp.dDaeTCDetailDate = DateTime.Parse(dt.Rows[i][7].ToString());
                tmp.dDaeTCNextDate = DateTime.Parse(dt.Rows[i][8].ToString());
                tmp.employee_code = dt.Rows[i][9].ToString();
                tmp.dVchCheckState = dt.Rows[i][10].ToString();
                
                tmp.dVchPartID = dt.Rows[i][11].ToString();
                tmp.dVchContentID = dt.Rows[i][12].ToString();
                tmp.dVchStandardID = dt.Rows[i][13].ToString();
                tmp.dVchPlanData = dt.Rows[i][14].ToString();
                Grid.Add(tmp);
            }
        }
        return returnStr = JsonConvert.SerializeObject(Grid);
    }

    public string TCBegin()
    {
        int lIntReturn = -1;
        int lIntReturn1 = -1;
        string lStrTCNote = "";
        string lStrTCDetailid = "";
        string lStrTmp = "";
        SqlParameter[] _Parameter = new SqlParameter[5]
            {
                new SqlParameter("@DataBaseCode",SqlDbType.VarChar,2),
                new SqlParameter("@equip_code",SqlDbType.VarChar,30),
                new SqlParameter("@userName",SqlDbType.VarChar,30),
                new SqlParameter("@voVchTCNote",SqlDbType.VarChar,30),
                new SqlParameter("@voIntReturn",SqlDbType.Int),
            };
        _Parameter[0].Value = "SJ";
        _Parameter[1].Value = equip_code;
        _Parameter[2].Value = username;
        _Parameter[3].Direction = System.Data.ParameterDirection.Output;
        _Parameter[4].Direction = System.Data.ParameterDirection.Output;
        claSqlConnDB.ExecuteNonQuery(claSqlConnDB.gStrConnDefault, CommandType.StoredProcedure, "pTCNoteAdd1", _Parameter);
        lIntReturn = (int)_Parameter[4].Value;
        lStrTCNote = _Parameter[3].Value.ToString();

        if (lIntReturn == 0)
        {
            SqlParameter[] _Parameter1 = new SqlParameter[10]
                {
                    new SqlParameter("@DataBaseCode",SqlDbType.VarChar,2),
                    new SqlParameter("@viVchTCPlan",SqlDbType.VarChar,30),
                    new SqlParameter("@viVchTCNote",SqlDbType.VarChar,30),
                    new SqlParameter("@viVchPartName",SqlDbType.VarChar,10),
                    new SqlParameter("@viVchContentName",SqlDbType.VarChar,10),
                    new SqlParameter("@viVchStandardName",SqlDbType.VarChar,10),
                    new SqlParameter("@viVchTCResult",SqlDbType.VarChar,30),
                    new SqlParameter("@viVchXYZ",SqlDbType.VarChar,30),
                    new SqlParameter("@voVchTCDetailID",SqlDbType.VarChar,30),
                    new SqlParameter("@voIntReturn",SqlDbType.Int),
                };
            _Parameter1[0].Value = "SJ";
            _Parameter1[1].Value = planCode;
            _Parameter1[2].Value = lStrTCNote;
            _Parameter1[3].Value = PartName;
            _Parameter1[4].Value = ContentName;
            _Parameter1[5].Value = StandardName;
            _Parameter1[6].Value = tcresult;
            _Parameter1[7].Value = xyz;
            _Parameter1[8].Direction = System.Data.ParameterDirection.Output;
            _Parameter1[9].Direction = System.Data.ParameterDirection.Output;
            claSqlConnDB.ExecuteNonQuery(claSqlConnDB.gStrConnDefault, CommandType.StoredProcedure, "pTCNoteDetailAdd", _Parameter1);
            lIntReturn1 = (int)_Parameter1[9].Value;
            lStrTCDetailid = _Parameter1[8].Value.ToString();
        }
        lStrTmp = lStrTCNote + "," + lStrTCDetailid;
        return lStrTmp;
    }
    public string TCBegin1()
    {
        int lIntReturn = -1;
        int lIntReturn1 = -1;
        string lStrTCNote = "";
        string lStrTCDetailid = "";
        string lStrTmp = "";
        SqlParameter[] _Parameter = new SqlParameter[5]
            {
                new SqlParameter("@DataBaseCode",SqlDbType.VarChar,2),
                new SqlParameter("@equip_code",SqlDbType.VarChar,30),
                new SqlParameter("@userName",SqlDbType.VarChar,30),
                new SqlParameter("@voVchTCNote",SqlDbType.VarChar,30),
                new SqlParameter("@voIntReturn",SqlDbType.Int),
            };
        _Parameter[0].Value = "SJ";
        _Parameter[1].Value = equip_code;
        _Parameter[2].Value = username;
        _Parameter[3].Direction = System.Data.ParameterDirection.Output;
        _Parameter[4].Direction = System.Data.ParameterDirection.Output;
        claSqlConnDB.ExecuteNonQuery(claSqlConnDB.gStrConnDefault, CommandType.StoredProcedure, "pTCNoteAdd1", _Parameter);
        lIntReturn = (int)_Parameter[4].Value;
        lStrTCNote = _Parameter[3].Value.ToString();

        if (lIntReturn == 0)
        {
            SqlParameter[] _Parameter1 = new SqlParameter[10]
                {
                    new SqlParameter("@DataBaseCode",SqlDbType.VarChar,2),
                    new SqlParameter("@viVchTCNote",SqlDbType.VarChar,30),
                    new SqlParameter("@viVchPartName",SqlDbType.VarChar,10),
                    new SqlParameter("@viVchContentName",SqlDbType.VarChar,10),
                    new SqlParameter("@viVchStandardName",SqlDbType.VarChar,10),
                    new SqlParameter("@viVchTCResult",SqlDbType.VarChar,30),
                    new SqlParameter("@viVchXYZ",SqlDbType.VarChar,30),
                    new SqlParameter("@viVchRunNum",SqlDbType.VarChar,10),
                    new SqlParameter("@voVchTCDetailID",SqlDbType.VarChar,30),
                    new SqlParameter("@voIntReturn",SqlDbType.Int),
                };
            _Parameter1[0].Value = "SJ";
            _Parameter1[1].Value = lStrTCNote;
            _Parameter1[2].Value = PartName;
            _Parameter1[3].Value = ContentName;
            _Parameter1[4].Value = StandardName;
            _Parameter1[5].Value = tcresult;
            _Parameter1[6].Value = xyz;
            _Parameter1[7].Value = runnum;
            _Parameter1[8].Direction = System.Data.ParameterDirection.Output;
            _Parameter1[9].Direction = System.Data.ParameterDirection.Output;
            claSqlConnDB.ExecuteNonQuery(claSqlConnDB.gStrConnDefault, CommandType.StoredProcedure, "pTCNoteDetailAdd2", _Parameter1);
            lIntReturn1 = (int)_Parameter1[9].Value;
            lStrTCDetailid = _Parameter1[8].Value.ToString();
        }

        string strSQL1 = @"select t_TCPlanAllotRecord.dVchUser,t_TCPlan2.equip_name from t_TCPlanAllotRecord inner join t_TCPlan2 on t_TCPlan2.dIntgPlanNote = t_TCPlanAllotRecord.dIntgPlanNote 
                    inner join t_TCNoteDetail on t_TCNoteDetail.dVchTCDetail = t_TCPlan2.dVchTCDetail where t_TCNoteDetail.dVchTCDetail = '" + lStrTCDetailid + "'";
        SqlDataReader dr = null;
        string alotusercode = "";
        string equipname = "";
        using (dr = claSqlConnDB.ExecuteReader(claSqlConnDB.gStrConnDefault, CommandType.Text, strSQL1))
        {
            if (dr.Read())
            {
                alotusercode = dr.GetString(0);
                equipname = dr.GetString(1);
            }
        }

        if (lIntReturn1 == 0)
        {
            GJHF.Business.PUSH.PushMessage.SendNotification(4, equip_code, "employee", alotusercode, equipname + "---巡检计划已经完成，请登陆查看！", null);
        }
        lStrTmp = lStrTCNote + "," + lStrTCDetailid;
        return lStrTmp;
    }
    public int TCEnd()
    {
        int lIntReturn1 = -1;

        SqlParameter[] _Parameter1 = new SqlParameter[2]
        {
            new SqlParameter("@viVchTCPlan",SqlDbType.VarChar,30),
            new SqlParameter("@voIntReturn",SqlDbType.Int),
        };
        _Parameter1[0].Value = planCode;
        _Parameter1[1].Direction = System.Data.ParameterDirection.Output;
        claSqlConnDB.ExecuteNonQuery(claSqlConnDB.gStrConnDefault, CommandType.StoredProcedure, "pTCNoteAdd1End", _Parameter1);
        lIntReturn1 = (int)_Parameter1[1].Value;
        return lIntReturn1;
    }
    
    public string ShowDetailPlan()
    {
        string returnStr = "";
        int lIntReturn = -1;
        SqlParameter[] _Parameter = new SqlParameter[3]
            {
                new SqlParameter("@DataBaseCode",SqlDbType.VarChar,2),
                new SqlParameter("@userName",SqlDbType.VarChar,30),
                new SqlParameter("@voIntReturn",SqlDbType.Int),
            };
        _Parameter[0].Value = "SJ";
        _Parameter[1].Value = username;
        _Parameter[2].Direction = System.Data.ParameterDirection.Output;
        claSqlConnDB.ExecuteNonQuery(claSqlConnDB.gStrConnDefault, CommandType.StoredProcedure, "pTCNoteAddCachePlan", _Parameter);
        lIntReturn = (int)_Parameter[2].Value;
        
        List<TCPlanDetail> Grid = new List<TCPlanDetail>();
        if (lIntReturn == 0)
        {
            string lStrSQL = @"SELECT dVchTCPlan,
                dVchName,
                equip_code,
                equip_name,
                t_TCPart.dVchPartName,
                t_TCContent.dVchContentName,
                t_TCStandard.dVchStandardName,
                dDaeTCDetailDate,
                dDaeTCNextDate,
                t_TCNoteDetailCachePlan.dVchCheckState,
                employee_code,
                dVchUser
                FROM t_TCNoteDetailCachePlan
                INNER JOIN t_TCStandard ON t_TCStandard.dIntStandardNote = t_TCNoteDetailCachePlan.dVchStandardName
                LEFT JOIN t_TCContentStandard ON t_TCContentStandard.dIntStandardNote = t_TCStandard.dIntStandardNote 
                INNER JOIN t_TCContent ON t_TCContent.dIntContentNote = t_TCContentStandard.dIntContentNote
                LEFT JOIN t_TCPartContent ON t_TCPartContent.dIntContentNote = t_TCContent.dIntContentNote
                INNER JOIN t_TCPart ON t_TCPart.dIntPartNote = t_TCPartContent.dIntPartNote
                WHERE dVchUser = '" + username + "' and dDaeTCNextDate >= GetDate() ";
            System.Data.DataTable dt = null;
            using (dt = claSqlConnDB.ExecuteDataset(claSqlConnDB.gStrConnDefault, System.Data.CommandType.Text, lStrSQL).Tables[0])
            {
                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    TCPlanDetail tmp = new TCPlanDetail();
                    tmp.dVchTCPlan = dt.Rows[i][0].ToString();
                    tmp.dVchName = dt.Rows[i][1].ToString();
                    tmp.equip_code = dt.Rows[i][2].ToString();
                    tmp.equip_name = dt.Rows[i][3].ToString();
                    tmp.dVchPartName = dt.Rows[i][4].ToString();
                    tmp.dVchContentName = dt.Rows[i][5].ToString();
                    tmp.dVchStandardName = dt.Rows[i][6].ToString();
                    tmp.dDaeTCDetailDate = DateTime.Parse(dt.Rows[i][7].ToString());
                    tmp.dDaeTCNextDate = DateTime.Parse(dt.Rows[i][8].ToString());
                    tmp.dVchCheckState = dt.Rows[i][9].ToString();
                    tmp.employee_code = dt.Rows[i][10].ToString();
                    Grid.Add(tmp);
                }
            }
        }

        return returnStr = JsonConvert.SerializeObject(Grid);
    }
    
    public int AddPic()
    {
        int lIntReturn = -1;
        string vStrSQL = "";
        string tmp = "";
        vStrSQL = "select dVchTCPic from t_TCNoteDetail where dVchTCNote = '" + TCNote + "' and dVchTCDetail = '" + TCDetail + "'";
        SqlDataReader dr = null;
        using(dr = claSqlConnDB.ExecuteReader(claSqlConnDB.gStrConnDefault,CommandType.Text,vStrSQL))
        {
            if(dr.Read())
            {
                if(!dr.IsDBNull(0))
                {
                    tmp = dr.GetString(0);
                }
                else
                {
                    
                }
            }
        }
        tmp = tmp + "," + picFile;
        vStrSQL = "update t_TCNoteDetail set dVchTCPic = '" + tmp + "' where dVchTCNote = '" + TCNote + "' and dVchTCDetail = '" + TCDetail + "'";
        lIntReturn = claSqlConnDB.ExecuteNonQuery(claSqlConnDB.gStrConnDefault, CommandType.Text, vStrSQL);
        return lIntReturn;
    }
    public int AddAvi()
    {
        int lIntReturn = -1;
        string vStrSQL = "";
        vStrSQL = "update t_TCNoteDetail set dVchTCAvi = '" + aviFile + "' where dVchTCNote = '" + TCNote + "' and dVchTCDetail = '" + TCDetail + "'";
        lIntReturn = claSqlConnDB.ExecuteNonQuery(claSqlConnDB.gStrConnDefault, CommandType.Text, vStrSQL);
        return lIntReturn;
    }
    
    /// <summary>
    /// 返回为整数，为>=0表示成功
    /// </summary>
    /// <returns></returns>
    public int InsertTCNote()
    {
        int lIntReturn = -1;
        SqlParameter[] _Parameter = new SqlParameter[4]
            {
                new SqlParameter("@DataBaseCode",SqlDbType.VarChar,2),
                new SqlParameter("@equip_code",SqlDbType.VarChar,30),
                new SqlParameter("@userName",SqlDbType.VarChar,30),
                new SqlParameter("@voIntReturn",SqlDbType.Int),
            };
        _Parameter[0].Value = "SJ";
        _Parameter[1].Value = equip_code;
        _Parameter[2].Value = username;
        _Parameter[3].Direction = System.Data.ParameterDirection.Output;
        claSqlConnDB.ExecuteNonQuery(claSqlConnDB.gStrConnDefault, CommandType.StoredProcedure, "pTCNoteAdd", _Parameter);
        lIntReturn = (int)_Parameter[3].Value;
        return lIntReturn;
    }
    /// <summary>
    /// 返回为整数，为>=0表示成功
    /// </summary>
    /// <returns></returns>
    public int InsertTCNoteCache()
    {
        int lIntReturn = -1;
        SqlParameter[] _Parameter = new SqlParameter[4]
            {
                new SqlParameter("@DataBaseCode",SqlDbType.VarChar,2),
                new SqlParameter("@equip_code",SqlDbType.VarChar,30),
                new SqlParameter("@userName",SqlDbType.VarChar,30),
                new SqlParameter("@voIntReturn",SqlDbType.Int),
            };
        _Parameter[0].Value = "SJ";
        _Parameter[1].Value = equip_code;
        _Parameter[2].Value = username;
        _Parameter[3].Direction = System.Data.ParameterDirection.Output;
        claSqlConnDB.ExecuteNonQuery(claSqlConnDB.gStrConnDefault, CommandType.StoredProcedure, "pTCNoteAddCache", _Parameter);
        lIntReturn = (int)_Parameter[3].Value;
        return lIntReturn;
    }
    public int SelException()
    {
        int lIntReturn = -1;
        SqlParameter[] _Parameter = new SqlParameter[6]
            {
                new SqlParameter("@viVchTCNote",SqlDbType.VarChar,30),
                new SqlParameter("@viVchTCDetail",SqlDbType.VarChar,30),
                new SqlParameter("@viVchPartName",SqlDbType.VarChar,30),
                new SqlParameter("@viVchContentName",SqlDbType.VarChar,30),
                new SqlParameter("@viVchStandardName",SqlDbType.VarChar,30),
                new SqlParameter("@voIntReturn",SqlDbType.Int),
            };
        _Parameter[0].Value = TCNote;
        _Parameter[1].Value = TCDetail;
        _Parameter[2].Value = PartName;
        _Parameter[3].Value = ContentName;
        _Parameter[4].Value = StandardName;
        _Parameter[5].Direction = System.Data.ParameterDirection.Output;
        claSqlConnDB.ExecuteNonQuery(claSqlConnDB.gStrConnDefault, CommandType.StoredProcedure, "pTCNoteBadAdd", _Parameter);
        lIntReturn = (int)_Parameter[5].Value;
        return lIntReturn;
    }

    public int UpdateBadContent()
    {
        int lIntReturn = -1;
        SqlParameter[] _Parameter = new SqlParameter[4]
            {
                new SqlParameter("@viVchTCNote",SqlDbType.VarChar,30),
                new SqlParameter("@viVchTCDetail",SqlDbType.VarChar,30),
                new SqlParameter("@viVchBadContent",SqlDbType.VarChar,100),
                new SqlParameter("@voIntReturn",SqlDbType.Int),
            };
        _Parameter[0].Value = TCNote1;
        _Parameter[1].Value = TCDetail1;
        _Parameter[2].Value = BadContent;
        _Parameter[3].Direction = System.Data.ParameterDirection.Output;
        claSqlConnDB.ExecuteNonQuery(claSqlConnDB.gStrConnDefault, CommandType.StoredProcedure, "pTCNoteBadUpdate", _Parameter);
        lIntReturn = (int)_Parameter[3].Value;
        return lIntReturn;
    }

    /// <summary>
    /// 点巡检记录页面
    /// </summary>
    /// <returns></returns>
    public string showPara1Data()
    {
        string returnStr = "";
        List<TCNote> Grid = new List<TCNote>();

        string lStrSQL = @"SELECT TOP 1 dVchTCNote,
                equip_code,
                equip_name,
                t_PatrolGrade.patrolgrade_name,
                tHRCompany.dVchCompanyName,
                t_major.major_name,
                dVchTCPeople,
                dDaeTCDate,
                dVchRemark FROM t_TCNote
                INNER JOIN t_PatrolGrade ON t_PatrolGrade.patrolgrade_id = t_TCNote.dVchTCType
                INNER JOIN tHRCompany ON tHRCompany.dIntCompanyID = t_TCNote.dVchTCUnit
                INNER JOIN t_major ON t_major.major_code = t_TCNote.dVchTCSpecialty
                WHERE equip_code = '" + equip_code + "' ORDER BY dDaeTCDate DESC";
        System.Data.DataTable dt = null;
        using (dt = claSqlConnDB.ExecuteDataset(claSqlConnDB.gStrConnDefault, System.Data.CommandType.Text, lStrSQL).Tables[0])
        {
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                TCNote tmp = new TCNote();
                tmp.dVchTCNote = dt.Rows[i][0].ToString();
                tmp.equip_code = dt.Rows[i][1].ToString();
                tmp.equip_name = dt.Rows[i][2].ToString();
                tmp.dVchTCType = dt.Rows[i][3].ToString();
                tmp.dVchTCUnit = dt.Rows[i][4].ToString();
                tmp.dVchTCSpecialty = dt.Rows[i][5].ToString();
                tmp.dVchTCPeople = dt.Rows[i][6].ToString();
                tmp.dDaeTCDate = DateTime.Parse(dt.Rows[i][7].ToString());
                Grid.Add(tmp);
            }
        }
        return returnStr = JsonConvert.SerializeObject(Grid);
    }
    /// <summary>
    /// 点巡检明细数据
    /// </summary>
    /// <returns></returns>
    public string showParaDetailData()
    {
        string returnStr = "";
        List<TCDetail> Grid = new List<TCDetail>();

        string lStrSQL = @"SELECT dVchTCNote,
                dVchTCDetail,
                t_TCPart.dVchPartName,
                t_TCContent.dVchContentName,
                t_TCStandard.dVchStandardName,
                dVchTCResult,t_TCPart.dIntPartNote,t_TCContent.dIntContentNote,t_TCStandard.dIntStandardNote,dVchTCPic,dVchTCAvi,dDaeTCDetailDate,dDaeTCNextDate,dVchXYZ
                FROM t_TCNoteDetail
                INNER JOIN t_TCPart ON t_TCPart.dIntPartNote = t_TCNoteDetail.dVchPartName
                INNER JOIN t_TCContent ON t_TCContent.dIntContentNote = t_TCNoteDetail.dVchContentName
                INNER JOIN t_TCStandard ON t_TCStandard.dIntStandardNote = t_TCNoteDetail.dVchStandardName
                WHERE dVchTCNote = '" + TCNote + "' ";
        System.Data.DataTable dt = null;
        using (dt = claSqlConnDB.ExecuteDataset(claSqlConnDB.gStrConnDefault, System.Data.CommandType.Text, lStrSQL).Tables[0])
        {
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                TCDetail tmp = new TCDetail();
                tmp.dVchTCNote = dt.Rows[i][0].ToString();
                tmp.dVchTCDetail = dt.Rows[i][1].ToString();
                tmp.dVchPartName = dt.Rows[i][2].ToString();
                tmp.dVchContentName = dt.Rows[i][3].ToString();
                tmp.dVchStandardName = dt.Rows[i][4].ToString();
                tmp.dVchTCResult = dt.Rows[i][5].ToString();
                tmp.dVchPartID = dt.Rows[i][6].ToString();
                tmp.dVchContentID = dt.Rows[i][7].ToString();
                tmp.dVchStandardID = dt.Rows[i][8].ToString();
                tmp.dVchTCPic = dt.Rows[i][9].ToString();
                tmp.dVchTCAvi = dt.Rows[i][10].ToString();
                tmp.dDaeTCDetailDate = DateTime.Parse(dt.Rows[i][11].ToString() == "" ? "1900-1-1" : dt.Rows[i][11].ToString());
                tmp.dDaeTCNextDate = DateTime.Parse(dt.Rows[i][12].ToString() == "" ? "1900-1-1" : dt.Rows[i][12].ToString());
                tmp.dVchXYZ = dt.Rows[i][13].ToString();
                Grid.Add(tmp);
            }
        }
        return returnStr = JsonConvert.SerializeObject(Grid);
    }

    /// <summary>
    /// 点巡检缓存记录
    /// </summary>
    /// <returns></returns>
    public string showPara1DataCache()
    {
        string returnStr = "";
        List<TCNote> Grid = new List<TCNote>();

        string lStrSQL = @"SELECT TOP 1 dVchTCNote,
                equip_code,
                equip_name,
                t_PatrolGrade.patrolgrade_name,
                tHRCompany.dVchCompanyName,
                t_major.major_name,
                dVchTCPeople,
                dDaeTCDate
                FROM t_TCNoteCache
                INNER JOIN t_PatrolGrade ON t_PatrolGrade.patrolgrade_id = t_TCNoteCache.dVchTCType
                INNER JOIN tHRCompany ON tHRCompany.dIntCompanyID = t_TCNoteCache.dVchTCUnit
                INNER JOIN t_major ON t_major.major_code = t_TCNoteCache.dVchTCSpecialty
                WHERE equip_code = '" + equip_code + "' ORDER BY dDaeTCDate DESC";
        System.Data.DataTable dt = null;
        using (dt = claSqlConnDB.ExecuteDataset(claSqlConnDB.gStrConnDefault, System.Data.CommandType.Text, lStrSQL).Tables[0])
        {
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                TCNote tmp = new TCNote();
                tmp.dVchTCNote = dt.Rows[i][0].ToString();
                tmp.equip_code = dt.Rows[i][1].ToString();
                tmp.equip_name = dt.Rows[i][2].ToString();
                tmp.dVchTCType = dt.Rows[i][3].ToString();
                tmp.dVchTCUnit = dt.Rows[i][4].ToString();
                tmp.dVchTCSpecialty = dt.Rows[i][5].ToString();
                tmp.dVchTCPeople = dt.Rows[i][6].ToString();
                tmp.dDaeTCDate = DateTime.Parse(dt.Rows[i][7].ToString());
                Grid.Add(tmp);
            }
        }
        return returnStr = JsonConvert.SerializeObject(Grid);
    }
    /// <summary>
    /// 点巡检明细缓存
    /// </summary>
    /// <returns></returns>
    public string showParaDetailDataCache()
    {
        string returnStr = "";
        List<TCDetail> Grid = new List<TCDetail>();

        string lStrSQL = @"SELECT dVchTCNote,
                dVchTCDetail,
                t_TCPart.dVchPartName,
                t_TCContent.dVchContentName,
                t_TCStandard.dVchStandardName,
                t_TCPart.dIntPartNote,t_TCContent.dIntContentNote,t_TCStandard.dIntStandardNote
                FROM t_TCNoteDetailCache
                INNER JOIN t_TCPart ON t_TCPart.dIntPartNote = t_TCNoteDetailCache.dVchPartName
                INNER JOIN t_TCContent ON t_TCContent.dIntContentNote = t_TCNoteDetailCache.dVchContentName
                INNER JOIN t_TCStandard ON t_TCStandard.dIntStandardNote = t_TCNoteDetailCache.dVchStandardName
                WHERE dVchTCNote = '" + TCNote + "' ";
        System.Data.DataTable dt = null;
        using (dt = claSqlConnDB.ExecuteDataset(claSqlConnDB.gStrConnDefault, System.Data.CommandType.Text, lStrSQL).Tables[0])
        {
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                TCDetail tmp = new TCDetail();
                tmp.dVchTCNote = dt.Rows[i][0].ToString();
                tmp.dVchTCDetail = dt.Rows[i][1].ToString();
                tmp.dVchPartName = dt.Rows[i][2].ToString();
                tmp.dVchContentName = dt.Rows[i][3].ToString();
                tmp.dVchStandardName = dt.Rows[i][4].ToString();
                tmp.dVchPartID = dt.Rows[i][5].ToString();
                tmp.dVchContentID = dt.Rows[i][6].ToString();
                tmp.dVchStandardID = dt.Rows[i][7].ToString();
                Grid.Add(tmp);
            }
        }
        return returnStr = JsonConvert.SerializeObject(Grid);
    }
    public bool IsReusable {
        get {
            return false;
        }
    }

}