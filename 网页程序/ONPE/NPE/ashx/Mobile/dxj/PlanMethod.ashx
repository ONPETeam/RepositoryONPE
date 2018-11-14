<%@ WebHandler Language="C#" Class="PlanMethod" %>

using System;
using System.Web;
using ModelClass;
using Newtonsoft.Json;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;

public class PlanMethod : IHttpHandler {

    string type = "";
    string user = "";
    string userName = "";
    string branchID = "";
    string area_id = "";
    string postID = "";
    string PatrolGrade = "";
    string PlanNote = "";//计划ID
    string employeecode = "";//分配目标员工

    string equipCode = "";//设备编码
    string remark = "";//分配时的备注
    
    public void ProcessRequest (HttpContext context) {
        context.Response.ContentType = "text/plain";

        type = context.Request.Params["type"];
        user = context.Request.Params["user"];//直接就用户表里的user吧
        userName = context.Request.Params["userName"];//人员姓名
        branchID = context.Request.Params["branchID"];//分配给目标部门，比如 中控室 分配给 钢建华飞的 二烧车间部门ID
        area_id = context.Request.Params["areaid"];
        postID = context.Request.Params["postID"];//岗位ID
        PatrolGrade = context.Request.Params["PatrolGrade"];//巡检级别ID
        PlanNote = context.Request.Params["PlanNote"];//计划ID
        employeecode = context.Request.Params["employeecode"];//员工code
        equipCode = context.Request.Params["equipCode"];//设备编码
        remark = context.Request.Params["remark"];//设备编码

        switch (type)
        {
            //单一区域分配的存储过程，多个区域可循环执行
            case "para1":
                context.Response.Write(EquipStandardRangeAdd());
                break;
            //根据设备标准的划分范围，生成各自的计划
            case "para2":
                context.Response.Write(AddCachePlan2());
                break;
            //二级单位分配计划给相关人员
            case "para3":
                context.Response.Write(NotePlanAllotPeople());
                break;
            //二级单位分配计划给相关人员,按设备来选择，批量分配
            case "para31":
                context.Response.Write(GetAlotInfoAndAlot(equipCode));
                break;
            default:
                break;
        }
        
        //context.Response.Write("Hello World");
    }

    private int GetAlotInfoAndAlot(string equipCode)
    {
        int lIntReturn = -1;
        string lStrSQL="select dIntgPlanNote from t_TCPlan2 where equip_code = '"+equipCode+"'";
        SqlDataReader dr = null;
        using (dr = claSqlConnDB.ExecuteReader(claSqlConnDB.gStrConnDefault, CommandType.Text, lStrSQL))
        {
            while (dr.Read())
            {
                
                SqlParameter[] _Parameter = new SqlParameter[6]
                {
                    new SqlParameter("@viIntgPlanNote",SqlDbType.Int,4),
                    new SqlParameter("@viVchUser",SqlDbType.VarChar,30),
                    new SqlParameter("@viVchUserName",SqlDbType.VarChar,10),
                    new SqlParameter("@employee_code",SqlDbType.VarChar,30),
                    new SqlParameter("@viVchRemark",SqlDbType.VarChar,200),
                    new SqlParameter("@voIntReturn",SqlDbType.Int),
                };
                _Parameter[0].Value = dr.GetInt32(0);
                _Parameter[1].Value = user;
                _Parameter[2].Value = userName;
                _Parameter[3].Value = employeecode;
                _Parameter[4].Value = remark;
                _Parameter[5].Direction = System.Data.ParameterDirection.Output;
                claSqlConnDB.ExecuteNonQuery(claSqlConnDB.gStrConnDefault, CommandType.StoredProcedure, "pNotePlanAllotPeople", _Parameter);
                lIntReturn = (int)_Parameter[5].Value;
            }

            dr.Close();
        }
        dr.Dispose();
        SendMessage("employee", employeecode, userName + "已经分配巡检计划，请登陆查看！");
        return lIntReturn;
    }
    
    public int EquipStandardRangeAdd()
    {
        int lIntReturn = -1;
        SqlParameter[] _Parameter = new SqlParameter[6]
            {
                new SqlParameter("@viVchUser",SqlDbType.VarChar,30),
                new SqlParameter("@viIntBranchID",SqlDbType.Int,4),
                new SqlParameter("@area_id",SqlDbType.Int,4),
                new SqlParameter("@viVchPostName",SqlDbType.VarChar,20),//岗位ID
                new SqlParameter("@viIntPatrolGrade",SqlDbType.Int,4),
                new SqlParameter("@voIntReturn",SqlDbType.Int),
            };
        _Parameter[0].Value = user;
        _Parameter[1].Value = branchID;
        _Parameter[2].Value = area_id;
        _Parameter[3].Value = postID;
        _Parameter[4].Value = PatrolGrade;
        _Parameter[5].Direction = System.Data.ParameterDirection.Output;
        claSqlConnDB.ExecuteNonQuery(claSqlConnDB.gStrConnDefault, CommandType.StoredProcedure, "pEquipStandardRangeAddN", _Parameter);
        lIntReturn = (int)_Parameter[5].Value;
        return lIntReturn;
    }

    public int AddCachePlan2()
    {
        int lIntReturn = -1;
        SqlParameter[] _Parameter = new SqlParameter[2]
            {
                new SqlParameter("@viIntBranchID",SqlDbType.Int,4),
                new SqlParameter("@voIntReturn",SqlDbType.Int),
            };
        _Parameter[0].Value = branchID;
        _Parameter[1].Direction = System.Data.ParameterDirection.Output;
        claSqlConnDB.ExecuteNonQuery(claSqlConnDB.gStrConnDefault, CommandType.StoredProcedure, "pTCNoteAddCachePlan2", _Parameter);
        lIntReturn = (int)_Parameter[1].Value;

        return lIntReturn;
    }

    public int NotePlanAllotPeople()
    {
        int lIntReturn = -1;
        SqlParameter[] _Parameter = new SqlParameter[6]
            {
                new SqlParameter("@viIntgPlanNote",SqlDbType.Int,4),
                new SqlParameter("@viVchUser",SqlDbType.VarChar,30),
                new SqlParameter("@viVchUserName",SqlDbType.VarChar,10),
                new SqlParameter("@employee_code",SqlDbType.VarChar,30),
                new SqlParameter("@viVchRemark",SqlDbType.VarChar,200),
                new SqlParameter("@voIntReturn",SqlDbType.Int),
            };
        _Parameter[0].Value = PlanNote;
        _Parameter[1].Value = user;
        _Parameter[2].Value = userName;
        _Parameter[3].Value = employeecode;
        _Parameter[4].Value = remark;
        _Parameter[5].Direction = System.Data.ParameterDirection.Output;
        claSqlConnDB.ExecuteNonQuery(claSqlConnDB.gStrConnDefault, CommandType.StoredProcedure, "pNotePlanAllotPeople", _Parameter);
        lIntReturn = (int)_Parameter[5].Value;

        SendMessage("employee", employeecode, userName + "已经分配巡检计划，请登陆查看！");
        
        return lIntReturn;
    }

    public void SendMessage(string v_target_type,string v_target_value,string v_notification_content)
    {
        GJHF.Business.PUSH.PushMessage.SendNotification(4, PlanNote.ToString(),v_target_type, v_target_value, v_notification_content, null);
    }
    
    
    public bool IsReusable {
        get {
            return false;
        }
    }

}