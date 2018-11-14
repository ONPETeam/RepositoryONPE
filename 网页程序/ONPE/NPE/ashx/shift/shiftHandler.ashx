<%@ WebHandler Language="C#" Class="shiftHandler" %>

using System;
using System.Web;
using ModelClass;
using Newtonsoft.Json;
using NPE.UIDataClass;
using System.Data;
using System.Collections.Generic;
using System.Data.SqlClient;

public class shiftHandler : IHttpHandler
{

    string shift_code = "";
    string inti_time = "";
    string shift_date = "";
    string branch_id = "";
    string classtype_code = "";
    string classnum_code = "";
    string must_num = "";
    string must_peop = "";
    string attend_num = "";
    string attend_peop = "";
    string absente_peop = "";
    string absente_reason = "";
    string hand_over = "";
    string hand_time = "";
    string duty_peop = "";
    string duty_time = "";
    double effect_time = 0;
    string run_state = "";
    string work_context = "";
    string mater_defect = "";
    string instrument_state = "";
    string shift_remark = "";
    string jiaojie_flag = "";
    string order = "";
    string sort = "";
    int page = 1;
    int rows = 10;
    public void ProcessRequest(HttpContext context)
    {
        string action = "";
        
        context.Response.ContentType = "text/plain";
        if (context.Request.Params["shift_code"] != null)
        {
            shift_code = context.Request.Params["shift_code"].ToString();
        }
        if (context.Request.Params["inti_time"] != null)
        {
            inti_time = context.Request.Params["inti_time"].ToString();
        }
        if (context.Request.Params["shift_date"] != null)
        {
            shift_date = context.Request.Params["shift_date"].ToString();
        }
        if (context.Request.Params["branch_id"] != null)
        {
            branch_id = context.Request.Params["branch_id"].ToString();
        }
        if (context.Request.Params["classtype_code"] != null)
        {
            classtype_code = context.Request.Params["classtype_code"].ToString();
        }
        if (context.Request.Params["classnum_code"] != null)
        {
            classnum_code = context.Request.Params["classnum_code"].ToString();
        }
        if (context.Request.Params["must_num"] != null)
        {
            must_num = context.Request.Params["must_num"].ToString();
        }
        if (context.Request.Params["must_peop"] != null)
        {
            must_peop = context.Request.Params["must_peop"].ToString();
        }
        if (context.Request.Params["attend_num"] != null)
        {
            attend_num = context.Request.Params["attend_num"].ToString();
        }
        if (context.Request.Params["attend_peop"] != null)
        {
            attend_peop = context.Request.Params["attend_peop"].ToString();
        }
        if (context.Request.Params["absente_peop"] != null)
        {
            absente_peop = context.Request.Params["absente_peop"].ToString();
        }
        if (context.Request.Params["absente_reason"] != null)
        {
            absente_reason = context.Request.Params["absente_reason"].ToString();
        }
        if (context.Request.Params["hand_over"] != null)
        {
            hand_over = context.Request.Params["hand_over"].ToString();
        }
        if (context.Request.Params["hand_time"] != null)
        {
            hand_time = context.Request.Params["hand_time"].ToString();
        }
        if (context.Request.Params["duty_peop"] != null)
        {
            duty_peop = context.Request.Params["duty_peop"].ToString();
        }
        if (context.Request.Params["duty_time"] != null)
        {
            duty_time = context.Request.Params["duty_time"].ToString();
        }
        if (context.Request.Params["effect_time"] != null)
        {
            effect_time = double.Parse(context.Request.Params["effect_time"].ToString());
        }
        if (context.Request.Params["run_state"] != null)
        {
            run_state = context.Request.Params["run_state"].ToString();
        }
        if (context.Request.Params["work_context"] != null)
        {
            work_context = context.Request.Params["work_context"].ToString();
        }
        if (context.Request.Params["mater_defect"] != null)
        {
            mater_defect = context.Request.Params["mater_defect"].ToString();
        }
        if (context.Request.Params["instrument_state"] != null)
        {
            instrument_state = context.Request.Params["instrument_state"].ToString();
        }
        if (context.Request.Params["shift_remark"] != null)
        {
            shift_remark = context.Request.Params["shift_remark"].ToString();
        }
        if (context.Request.Params["jiaojie_flag"] != null)
        {
            jiaojie_flag = context.Request.Params["jiaojie_flag"].ToString();
        }
        
        
        if (context.Request.Params["sort"] != null)
        {
            sort = context.Request.Params["sort"].ToString();
        }
        if (context.Request.Params["order"] != null)
        {
            order = context.Request.Params["order"].ToString();
        }
        if (context.Request.Params["page"] != null)
        {
            page = int.Parse(context.Request.Params["page"].ToString());
        }
        if (context.Request.Params["rows"] != null)
        {
            rows = int.Parse(context.Request.Params["rows"].ToString());
        }
        if (context.Request.Params["action"] != null)
        {
            action = context.Request.Params["action"].ToString();
        }
        
        switch (action)
        {
            case "edit":
                context.Response.Write(editShift());
                break; 
            case "info":

                break;
            case "grid":
               
                System.Text.StringBuilder sb = new System.Text.StringBuilder();
                sb.Append("{ ");
                sb.Append(string.Format("\"total\":{0},\"rows\":", GetRocordCount().ToString()));
                string s = ShowShiftGrid();
                sb.Append(s);
                sb.Append("}");
                context.Response.Write(sb.ToString());
                break;
            case "hand":
                context.Response.Write(handShift());
                break;
            case "duty":
                context.Response.Write(dutyShift());
                break;
            default:

                break;
        }

        
    }
    private string handShift()
    {
        string mStrSQL = @"UPDATE t_shift set hand_time='" + hand_time + "' where shift_code='" + shift_code + "'";
        int i = claSqlConnDB.ExecuteNonQuery(claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL);
        return i.ToString(); 
    }
    private string dutyShift()
    {
        string mStrSQL = @"UPDATE t_shift set duty_time='" + duty_time + "' where shift_code='" + shift_code + "'";
        int i = claSqlConnDB.ExecuteNonQuery(claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL);
        return i.ToString();
    }
    private string ShowShiftGrid()
    {
        List<shift> mShift = new List<shift>();
        string mStrSQL = @" SELECT     t_shift.shift_code, t_shift.inti_time, t_shift.shift_date, 
                                       t_shift.branch_id, tHRBranchInfo.dVchBranchName AS branc_name, 
                                       t_shift.classtype_code,tCDType.dVchTypeName, t_shift.classnum_code,
                                       tCDClass.dVchClassName,t_shift.must_num, 
                                       t_shift.must_peop, t_shift.attend_num, t_shift.attend_peop, 
                                       t_shift.absente_peop, t_shift.absente_reason, t_shift.hand_over, 
                                       t_shift.hand_time, t_shift.duty_peop, t_shift.duty_time, t_shift.effect_time,
                                       t_shift.run_state, t_shift.work_context, t_shift.mater_defect, 
                                       t_shift.instrument_state, t_shift.shift_remark, t_shift.jiaojie_flag
                            FROM       t_shift LEFT OUTER JOIN
                                       tHRBranchInfo ON t_shift.branch_id = tHRBranchInfo.dIntBranchID
                                       LEFT OUTER JOIN tCDType ON  t_shift.classtype_code =tCDType.dVchTypeID
                                       LEFT OUTER JOIN tCDClass ON  t_shift.classnum_code =tCDClass.dVchClassID " + GetWhere() + GetOrder();
        DataTable dt = null;
        using (dt = claSqlConnDB.ExecuteDataset(rows, page, claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL).Tables[0])
        {
            if (dt.Rows.Count > 0)
            {
                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    shift shiftTemp = new shift();
                    shiftTemp.shift_code = dt.Rows[i][0].ToString();
                    shiftTemp.inti_time = dt.Rows[i][1].ToString();
                    shiftTemp.shift_date = ((DateTime)dt.Rows[i][2]).ToShortDateString();
                    shiftTemp.branch_id = dt.Rows[i][3].ToString();
                    shiftTemp.branch_name = dt.Rows[i][4].ToString();
                    shiftTemp.classtype_code = dt.Rows[i][5].ToString();
                    shiftTemp.classtype_name = dt.Rows[i][6].ToString();
                    shiftTemp.classnum_code = dt.Rows[i][7].ToString();
                    shiftTemp.classnum_name = dt.Rows[i][8].ToString();
                    shiftTemp.must_num = dt.Rows[i][9].ToString();
                    shiftTemp.must_peop_id = dt.Rows[i][10].ToString();

                    shiftTemp.must_peop_name = GetEmployeeNameCorr(dt.Rows[i][10].ToString());
                    shiftTemp.attend_num = dt.Rows[i][11].ToString();
                    shiftTemp.attend_peop_id = dt.Rows[i][12].ToString();
                    shiftTemp.attend_peop_name = GetEmployeeNameCorr(dt.Rows[i][12].ToString());
                    shiftTemp.absente_peop_id = dt.Rows[i][13].ToString();
                    shiftTemp.absente_peop_name = GetEmployeeNameCorr(dt.Rows[i][13].ToString());
                    shiftTemp.absente_reason = dt.Rows[i][14].ToString();
                    shiftTemp.hand_peop_id = dt.Rows[i][15].ToString();
                    shiftTemp.hand_peop_name = GetEmployeeNameCorr(dt.Rows[i][15].ToString());
                    shiftTemp.hand_time = dt.Rows[i][16].ToString();
                    shiftTemp.duty_peop_id = dt.Rows[i][17].ToString();
                    shiftTemp.duty_peop_name = GetEmployeeNameCorr(dt.Rows[i][17].ToString());
                    shiftTemp.duty_time = dt.Rows[i][18].ToString();
                    shiftTemp.effect_time = dt.Rows[i][19].ToString();
                    shiftTemp.run_state = dt.Rows[i][20].ToString();
                    shiftTemp.work_context = dt.Rows[i][21].ToString();
                    shiftTemp.mater_defect = dt.Rows[i][22].ToString();
                    shiftTemp.instrument_state = dt.Rows[i][23].ToString();
                    shiftTemp.shift_remark = dt.Rows[i][24].ToString();
                    shiftTemp.jiaojie_flag = dt.Rows[i][25].ToString();
                    mShift.Add(shiftTemp);
                }
            } 
        } 
        return JsonConvert.SerializeObject(mShift);
    }
    private string GetEmployeeNameCorr(string vStrEmployeeCodeCorr)
    {
         string mStrReturn = "";
         string [] mStrEmployeeCode=vStrEmployeeCodeCorr.Split(',');
         for (int i = 0; i < mStrEmployeeCode.Length; i++)
         {
             string mStrSQL = @"SELECT employee_Name from t_Employee where employee_code='" + mStrEmployeeCode[i] + "'";
             DataTable dt = null;
             using (dt = claSqlConnDB.ExecuteDataset(claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL).Tables[0])
             {
                 if (dt.Rows.Count > 0)
                 {
                     for (int j = 0; j < dt.Rows.Count; j++)
                     {
                         mStrReturn = mStrReturn  + dt.Rows[j][0].ToString() + ",";
                     } 
                 }
             }
         }
         return mStrReturn;
    }
    private int GetRocordCount()
    {
        string mStrSQL = @" select count(0) from  t_shift " + GetWhere();
        int i = claSqlConnDB.GetRecordCount(claSqlConnDB.gStrConnDefault, mStrSQL);
        return i;
    }
    private string GetWhere()
    {
        string mStrWhere = "";
        
        return mStrWhere;
    }
    private string GetOrder()
    {
        string mStrOrder = "";
        sort = "t_shift.shift_date";
        order = "desc";
        if (sort != "")
        {
            mStrOrder = " order by " + sort + " ";
            if (order != "")
            {
                mStrOrder = mStrOrder + order;
            }
        }
        return mStrOrder;
    }
    private string editShift()
    {
        string mStrSQL = @"update t_shift set 
                    effect_time=@effect_time,run_state=@run_state,work_context=@work_context,
                    mater_defect=@mater_defect,instrument_state=@instrument_state,
                    hand_over=@hand_over,duty_peop=@duty_peop
                    where shift_code=@shift_code";
        SqlParameter[] l0lSqlParameter = new SqlParameter[8]{
            new SqlParameter("@effect_time",SqlDbType.Decimal,7),
            new SqlParameter("@run_state",SqlDbType.VarChar,300),
            new SqlParameter("@work_context",SqlDbType.VarChar,8000),
            new SqlParameter("@mater_defect",SqlDbType.VarChar,8000),
            new SqlParameter("@instrument_state",SqlDbType.VarChar,200),
            new SqlParameter("@hand_over",SqlDbType.VarChar,300),
            new SqlParameter("@duty_peop",SqlDbType.VarChar,300),
            new SqlParameter("@shift_code",SqlDbType.VarChar,30)
        };
        l0lSqlParameter[0].Value = effect_time;
        l0lSqlParameter[1].Value = run_state;
        l0lSqlParameter[2].Value = work_context;
        l0lSqlParameter[3].Value = mater_defect;
        l0lSqlParameter[4].Value = instrument_state;
        l0lSqlParameter[5].Value = hand_over;
        l0lSqlParameter[6].Value = duty_peop;
        l0lSqlParameter[7].Value = shift_code;
        int i = claSqlConnDB.ExecuteNonQuery(claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL,l0lSqlParameter);
        return i.ToString();
    }
    public bool IsReusable
    {
        get
        {
            return false;
        }
    }

}