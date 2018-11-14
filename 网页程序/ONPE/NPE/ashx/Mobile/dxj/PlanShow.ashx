<%@ WebHandler Language="C#" Class="PlanShow" %>

using System;
using System.Web;
using System.Data;
using System.Collections.Generic;
using NPE.UIDataClass;
using Newtonsoft.Json;

public class PlanShow : IHttpHandler
{
    public void ProcessRequest(HttpContext context)
    {
        context.Response.ContentType = "text/plain";
        string type = "";
        object mObjReturn = null;
        string mStrReturn = "";
        if (context.Request.Params["type"] != null)
        {
            type = context.Request.Params["type"].ToString();
        }
        switch (type.ToLower())
        {
            case "para1":
                int m_para1_page = 1;
                if (context.Request.Params["page"] != null)
                {
                    if (int.TryParse(context.Request.Params["page"], out m_para1_page) == false)
                    {
                        m_para1_page = 1;
                    }
                }
                int m_para1_rows = 10;
                if (context.Request.Params["rows"] != null)
                {
                    if (int.TryParse(context.Request.Params["rows"], out m_para1_rows) == false)
                    {
                        m_para1_rows = 10;
                    }
                }
                string m_para1_patrol_grade = "";
                if (context.Request.Params["PatrolGradeID"] != null)
                {
                    m_para1_patrol_grade = context.Request.Params["PatrolGradeID"].ToString();
                }
                string m_para1_equip_code = "";
                if (context.Request.Params["equipCode"] != null)
                {
                    m_para1_equip_code = context.Request.Params["equipCode"].ToString();
                }
                mStrReturn = "{\"total\":" + GetEquipStandardRangeCount(m_para1_patrol_grade, m_para1_equip_code) + ",\"rows\":" + "[" + GetEquipStandardRange(m_para1_patrol_grade, m_para1_equip_code, m_para1_rows, m_para1_page) + "]" + "}";
                break;
            case "para2":
                int m_para2_page = 1;
                if (context.Request.Params["page"] != null)
                {
                    if (int.TryParse(context.Request.Params["page"], out m_para2_page) == false)
                    {
                        m_para2_page = 1;
                    }
                }
                int m_para2_rows = 10;
                if (context.Request.Params["rows"] != null)
                {
                    if (int.TryParse(context.Request.Params["rows"], out m_para2_rows) == false)
                    {
                        m_para2_rows = 10;
                    }
                }
                string m_para2_branch_id = "";
                if (context.Request.Params["branchID"] != null)
                {
                    m_para2_branch_id = context.Request.Params["branchID"].ToString();
                }
                string m_para2_patrol_grade = "";
                if (context.Request.Params["PatrolGradeID"] != null)
                {
                    m_para2_patrol_grade = context.Request.Params["PatrolGradeID"].ToString();
                }
                string m_para2_equip_code = "";
                if (context.Request.Params["equipCode"] != null)
                {
                    m_para2_equip_code = context.Request.Params["equipCode"].ToString();
                }
                mStrReturn = "{\"total\":" + GetEquipStandardRangeByBranchIDCount(m_para2_branch_id, m_para2_patrol_grade, m_para2_equip_code) + ",\"rows\":" + "[" + GetEquipStandardRangeByBranchID(m_para2_branch_id, m_para2_patrol_grade, m_para2_equip_code, m_para2_rows, m_para2_page) + "]" + "}";
                break;
            case "para3":
                int m_para3_page = 1;
                if (context.Request.Params["page"] != null)
                {
                    if (int.TryParse(context.Request.Params["page"], out m_para3_page) == false)
                    {
                        m_para3_page = 1;
                    }
                }
                int m_para3_rows = 10;
                if (context.Request.Params["rows"] != null)
                {
                    if (int.TryParse(context.Request.Params["rows"], out m_para3_rows) == false)
                    {
                        m_para3_rows = 10;
                    }
                }
                string m_para3_branch_id = "";
                if (context.Request.Params["branchID"] != null)
                {
                    m_para3_branch_id = context.Request.Params["branchID"].ToString();
                }
                string m_para3_patrol_grade = "";
                if (context.Request.Params["PatrolGradeID"] != null)
                {
                    m_para3_patrol_grade = context.Request.Params["PatrolGradeID"].ToString();
                }
                string m_para3_equip_code = "";
                if (context.Request.Params["equipCode"] != null)
                {
                    m_para3_equip_code = context.Request.Params["equipCode"].ToString();
                }
                string m_para3_check_state = "";
                if (context.Request.Params["checkState"] != null)
                {
                    m_para3_check_state = context.Request.Params["checkState"].ToString();
                }
                string m_startdate3 = "";
                if (context.Request.Params["startdate"] != null)
                {
                    m_startdate3 = context.Request.Params["startdate"].ToString();
                }
                string m_enddate3 = "";
                if (context.Request.Params["enddate"] != null)
                {
                    m_enddate3 = context.Request.Params["enddate"].ToString();
                }
                mStrReturn = "{\"total\":" + GetPlanByCondition2Count(m_para3_branch_id, m_para3_patrol_grade, m_para3_equip_code, m_startdate3, m_enddate3, m_para3_check_state)
                    + ",\"rows\":" + "["
                    + GetPlanByCondition2(m_para3_branch_id, m_para3_patrol_grade, m_para3_equip_code, m_para3_check_state, m_startdate3, m_enddate3, m_para3_rows, m_para3_page) + "]" + "}";
                break;
            case "para4":
                int m_para4_page = 1;
                if (context.Request.Params["page"] != null)
                {
                    if (int.TryParse(context.Request.Params["page"], out m_para4_page) == false)
                    {
                        m_para4_page = 1;
                    }
                }
                int m_para4_rows = 10;
                if (context.Request.Params["rows"] != null)
                {
                    if (int.TryParse(context.Request.Params["rows"], out m_para4_rows) == false)
                    {
                        m_para4_rows = 10;
                    }
                }
                string m_para4_employee_code = "";
                if (context.Request.Params["employeecode"] != null)
                {
                    m_para4_employee_code = context.Request.Params["employeecode"].ToString();
                }
                string m_para4_equip_code = "";
                if (context.Request.Params["equipCode"] != null)
                {
                    m_para4_equip_code = context.Request.Params["equipCode"].ToString();
                }
                string m_para4_check_state = "";
                if (context.Request.Params["checkState"] != null)
                {
                    m_para4_check_state = context.Request.Params["checkState"].ToString();
                }
                string m_startdate4 = "";
                if (context.Request.Params["startdate"] != null)
                {
                    m_startdate4 = context.Request.Params["startdate"].ToString();
                }
                string m_enddate4 = "";
                if (context.Request.Params["enddate"] != null)
                {
                    m_enddate4 = context.Request.Params["enddate"].ToString();
                }
                mStrReturn = "{\"total\":"
                    + GetPlanByPeopleCount(m_para4_employee_code, m_para4_equip_code, m_para4_check_state,m_startdate4,m_enddate4)
                    + ",\"rows\":["
                    + GetPlanByPeople(m_para4_employee_code, m_para4_equip_code, m_para4_check_state,m_startdate4, m_enddate4,m_para4_rows, m_para4_page) + "]}";
                break;
            case "para11":
                string m_para11_branch_id = "";
                if (context.Request.Params["branchID"] != null)
                {
                    m_para11_branch_id = context.Request.Params["branchID"].ToString();
                }
                string m_para11_patrol_grade = "";
                if (context.Request.Params["PatrolGradeID"] != null)
                {
                    m_para11_patrol_grade = context.Request.Params["PatrolGradeID"].ToString();
                }
                string m_para11_equip_code = "";
                if (context.Request.Params["equipCode"] != null)
                {
                    m_para11_equip_code = context.Request.Params["equipCode"].ToString();
                }
                string m_para11_check_state = "";
                if (context.Request.Params["checkState"] != null)
                {
                    m_para11_check_state = context.Request.Params["checkState"].ToString();
                }
                mObjReturn = GetEquipCombox(m_para11_branch_id,m_para11_patrol_grade, m_para11_equip_code, m_para11_check_state);
                mStrReturn = JsonConvert.SerializeObject(mObjReturn);
                break;
            case "para12":

                string m_para12_patrol_grade = "";
                if (context.Request.Params["PatrolGradeID"] != null)
                {
                    m_para12_patrol_grade = context.Request.Params["PatrolGradeID"].ToString();
                }
                string m_para12_equip_code = "";
                if (context.Request.Params["equipCode"] != null)
                {
                    m_para12_equip_code = context.Request.Params["equipCode"].ToString();
                }
                string m_para12_check_state = "";
                if (context.Request.Params["checkState"] != null)
                {
                    m_para12_check_state = context.Request.Params["checkState"].ToString();
                }
                mObjReturn = GetEquipComboxAll(m_para12_patrol_grade, m_para12_equip_code, m_para12_check_state);
                mStrReturn = JsonConvert.SerializeObject(mObjReturn);
                break;

            case "para5":
                int m_para13_page = 1;
                if (context.Request.Params["page"] != null)
                {
                    if (int.TryParse(context.Request.Params["page"], out m_para13_page) == false)
                    {
                        m_para13_page = 1;
                    }
                }
                int m_para13_rows = 10;
                if (context.Request.Params["rows"] != null)
                {
                    if (int.TryParse(context.Request.Params["rows"], out m_para13_rows) == false)
                    {
                        m_para13_rows = 10;
                    }
                }
                string m_para13_equip_code = "";
                if (context.Request.Params["equipCode"] != null)
                {
                    m_para13_equip_code = context.Request.Params["equipCode"].ToString();
                }

                mStrReturn = "{\"total\":" + GetPlanReportByEquipCodeCount(m_para13_equip_code) + ",\"rows\":" + "[" + GetPlanReportByEquipCode(m_para13_equip_code, m_para13_rows, m_para13_page) + "]" + "}";
                break;

            case "para6":
                int m_para14_page = 1;
                if (context.Request.Params["page"] != null)
                {
                    if (int.TryParse(context.Request.Params["page"], out m_para14_page) == false)
                    {
                        m_para14_page = 1;
                    }
                }
                int m_para14_rows = 10;
                if (context.Request.Params["rows"] != null)
                {
                    if (int.TryParse(context.Request.Params["rows"], out m_para14_rows) == false)
                    {
                        m_para14_rows = 10;
                    }
                }
                string m_para14_employee_code = "";
                if (context.Request.Params["EmployeeCode"] != null)
                {
                    m_para14_employee_code = context.Request.Params["EmployeeCode"].ToString();
                }

                mStrReturn = "{\"total\":" + GetPlanReportByEmployeeCodeCount(m_para14_employee_code) + ",\"rows\":" + "[" + GetPlanReportByEmployeeCode(m_para14_employee_code, m_para14_rows, m_para14_page) + "]" + "}";
                break;
            case "para9":
                int m_para9_page = 1;
                if (context.Request.Params["page"] != null)
                {
                    if (int.TryParse(context.Request.Params["page"], out m_para9_page) == false)
                    {
                        m_para9_page = 1;
                    }
                }
                int m_para9_rows = 10;
                if (context.Request.Params["rows"] != null)
                {
                    if (int.TryParse(context.Request.Params["rows"], out m_para9_rows) == false)
                    {
                        m_para9_rows = 10;
                    }
                }
                string m_para9_user = "";
                if (context.Request.Params["user"] != null)
                {
                    m_para9_user = context.Request.Params["user"].ToString();
                }

                mStrReturn = "{\"total\":" + GetPlanReportByUserCount(m_para9_user) + ",\"rows\":" + "[" + GetPlanReportByUser(m_para9_user, m_para9_rows, m_para9_page) + "]" + "}";
                break;
            case "para13":
                int m_Condition_page = 1;
                if (context.Request.Params["page"] != null)
                {
                    if (int.TryParse(context.Request.Params["page"], out m_Condition_page) == false)
                    {
                        m_Condition_page = 1;
                    }
                }
                int m_Condition_rows = 10;
                if (context.Request.Params["rows"] != null)
                {
                    if (int.TryParse(context.Request.Params["rows"], out m_Condition_rows) == false)
                    {
                        m_Condition_rows = 10;
                    }
                }
                string m_AlotUser = "";
                if (context.Request.Params["AlotUser"] != null)
                {
                    m_AlotUser = context.Request.Params["AlotUser"].ToString();
                }
                string m_equip_code = "";
                if (context.Request.Params["equip_code"] != null)
                {
                    m_equip_code = context.Request.Params["equip_code"].ToString();
                }
                string m_employee_code = "";
                if (context.Request.Params["employee_code"] != null)
                {
                    m_employee_code = context.Request.Params["employee_code"].ToString();
                }
                string m_startdate = "";
                if (context.Request.Params["startdate"] != null)
                {
                    m_startdate = context.Request.Params["startdate"].ToString();
                }
                string m_enddate = "";
                if (context.Request.Params["enddate"] != null)
                {
                    m_enddate = context.Request.Params["enddate"].ToString();
                }

                mStrReturn = "{\"total\":" + GetPlanByConditionCount(m_AlotUser, m_equip_code, m_employee_code, m_startdate, m_enddate) + ",\"rows\":" + "[" + GetPlanByCondition(m_AlotUser, m_equip_code, m_employee_code, m_startdate, m_enddate, m_Condition_rows, m_Condition_page) + "]" + "}";
                break;
            case "para7":
                int m_para15_page = 1;
                if (context.Request.Params["page"] != null)
                {
                    if (int.TryParse(context.Request.Params["page"], out m_para15_page) == false)
                    {
                        m_para15_page = 1;
                    }
                }
                int m_para15_rows = 10;
                if (context.Request.Params["rows"] != null)
                {
                    if (int.TryParse(context.Request.Params["rows"], out m_para15_rows) == false)
                    {
                        m_para15_rows = 10;
                    }
                }
                string m_para15_StartDate = "";
                string m_para15_EndtDate = "";
                if (context.Request.Params["StartDate"] != null)
                {
                    m_para15_StartDate = context.Request.Params["StartDate"].ToString();
                }
                if (context.Request.Params["EndDate"] != null)
                {
                    m_para15_EndtDate = context.Request.Params["EndDate"].ToString();
                }
                mStrReturn = "{\"total\":" + GetPlanReportByDateCount(DateTime.Parse(m_para15_StartDate), DateTime.Parse(m_para15_EndtDate)) + ",\"rows\":" + "[" + GetPlanReportByDate(DateTime.Parse(m_para15_StartDate), DateTime.Parse(m_para15_EndtDate), m_para15_rows, m_para15_page) + "]" + "}";
                break;

            case "para8"://重新做一个页面，取名【设备计划】，然后也有【计划分配】按钮
                int m_para16_page = 1;
                if (context.Request.Params["page"] != null)
                {
                    if (int.TryParse(context.Request.Params["page"], out m_para16_page) == false)
                    {
                        m_para16_page = 1;
                    }
                }
                int m_para16_rows = 10;
                if (context.Request.Params["rows"] != null)
                {
                    if (int.TryParse(context.Request.Params["rows"], out m_para16_rows) == false)
                    {
                        m_para16_rows = 10;
                    }
                }
                string m_para8_branch_id = "";
                if (context.Request.Params["branch_id"] != null)
                {
                    m_para8_branch_id = context.Request.Params["branch_id"].ToString();
                }
                mStrReturn = "{\"total\":" + GetPlanByCondition3Count(m_para8_branch_id) + ",\"rows\":" + "[" + GetPlanByCondition3(m_para8_branch_id, m_para16_rows, m_para16_page) + "]" + "}";
                break;
            case "para71":
                int m_para71_page = 1;
                if (context.Request.Params["page"] != null)
                {
                    if (int.TryParse(context.Request.Params["page"], out m_para71_page) == false)
                    {
                        m_para71_page = 1;
                    }
                }
                int m_para71_rows = 10;
                if (context.Request.Params["rows"] != null)
                {
                    if (int.TryParse(context.Request.Params["rows"], out m_para71_rows) == false)
                    {
                        m_para71_rows = 10;
                    }
                }
                string m_para71_StartDate = "";
                string m_para71_EndtDate = "";
                if (context.Request.Params["StartDate"] != null)
                {
                    m_para71_StartDate = context.Request.Params["StartDate"].ToString();
                }
                if (context.Request.Params["EndDate"] != null)
                {
                    m_para71_EndtDate = context.Request.Params["EndDate"].ToString();
                }
                mStrReturn = "{\"total\":" + GetPlanReportByDateCount2(DateTime.Parse(m_para71_StartDate), DateTime.Parse(m_para71_EndtDate)) + ",\"rows\":" + "[" + GetPlanReportByDate2(DateTime.Parse(m_para71_StartDate), DateTime.Parse(m_para71_EndtDate), m_para71_rows, m_para71_page) + "]" + "}";
                break;
            case "para72":
                int m_para72_page = 1;
                if (context.Request.Params["page"] != null)
                {
                    if (int.TryParse(context.Request.Params["page"], out m_para72_page) == false)
                    {
                        m_para72_page = 1;
                    }
                }
                int m_para72_rows = 10;
                if (context.Request.Params["rows"] != null)
                {
                    if (int.TryParse(context.Request.Params["rows"], out m_para72_rows) == false)
                    {
                        m_para72_rows = 10;
                    }
                }
                string m_equip72_code = "";
                if (context.Request.Params["equip_code"] != null)
                {
                    m_equip72_code = context.Request.Params["equip_code"].ToString();
                }
                string m_para72_StartDate = "";
                string m_para72_EndtDate = "";
                if (context.Request.Params["StartDate"] != null)
                {
                    m_para72_StartDate = context.Request.Params["StartDate"].ToString();
                }
                if (context.Request.Params["EndDate"] != null)
                {
                    m_para72_EndtDate = context.Request.Params["EndDate"].ToString();
                }
                mStrReturn = "{\"total\":" + GetPlanReportByCodeCount3(m_equip72_code, DateTime.Parse(m_para72_StartDate), DateTime.Parse(m_para72_EndtDate)) + ",\"rows\":" + "[" + GetPlanReportByCode3(m_equip72_code,DateTime.Parse(m_para72_StartDate), DateTime.Parse(m_para72_EndtDate), m_para72_rows, m_para72_page) + "]" + "}";
                break;
            case "para100":
                int m_para100_page = 1;
                if (context.Request.Params["page"] != null)
                {
                    if (int.TryParse(context.Request.Params["page"], out m_para100_page) == false)
                    {
                        m_para100_page = 1;
                    }
                }
                int m_para100rows = 10;
                if (context.Request.Params["rows"] != null)
                {
                    if (int.TryParse(context.Request.Params["rows"], out m_para100rows) == false)
                    {
                        m_para100rows = 10;
                    }
                }
                string m_user_employee_code = "";
                if (context.Request.Params["user"] != null)
                {
                    m_user_employee_code = context.Request.Params["user"].ToString();
                }
                string m_para100_StartDate = "";
                string m_para100_EndtDate = "";
                if (context.Request.Params["StartDate"] != null)
                {
                    m_para100_StartDate = context.Request.Params["StartDate"].ToString();
                }
                if (context.Request.Params["EndDate"] != null)
                {
                    m_para100_EndtDate = context.Request.Params["EndDate"].ToString();
                }
                mStrReturn = "{\"total\":" + GetPlanReportByUserDateCount(m_user_employee_code, DateTime.Parse(m_para100_StartDate), DateTime.Parse(m_para100_EndtDate)) + ",\"rows\":" + "[" + GetPlanReportByUserDate(m_user_employee_code, DateTime.Parse(m_para100_StartDate), DateTime.Parse(m_para100_EndtDate), m_para100rows, m_para100_page) + "]" + "}";
                break;
                       
            default:
                mStrReturn = "";
                break;
        }
        context.Response.Write(mStrReturn);
    }
    //根据人、日期，对该时间段内的巡检统计
    private int GetPlanReportByUserDateCount(string v_user_code, DateTime v_StartDate, DateTime v_EndDate)
    {
        string mStrSQL = "";
        mStrSQL = @"SELECT COUNT(0) FROM dbo.fGetPlanReportByUserDate('" + v_user_code + "','" + v_StartDate + "','" + v_EndDate + "') ";
        int i = claSqlConnDB.GetRecordCount(claSqlConnDB.gStrConnDefault, mStrSQL);
        return i;
    }
    //根据人、日期，对该时间段内的巡检统计
    private string GetPlanReportByUserDate(string v_user_code, DateTime v_StartDate, DateTime v_EndDate, int v_rows, int v_page)
    {
        string returnJson = "";
        string strSQL = "";
        strSQL = "SELECT * FROM dbo.fGetPlanReportByUserDate('" + v_user_code + "','" + v_StartDate + "','" + v_EndDate + "') ";
        DataSet ds = null;
        using (ds = claSqlConnDB.ExecuteDataset(v_rows, v_page, claSqlConnDB.gStrConnDefault, CommandType.Text, strSQL))
        {
            returnJson = common.GetJsonByDataset1(ds);
        }
        return returnJson;
    }
    
    
    //根据设备编码、日期，对该时间段内的该设备巡检情况进行查询
    private int GetPlanReportByCodeCount3(string v_equip_code, DateTime v_StartDate, DateTime v_EndDate)
    {
        string mStrSQL = "";
        mStrSQL = @"SELECT COUNT(0) FROM dbo.fGetPlanReportByDate3('" + v_equip_code + "','" + v_StartDate + "','" + v_EndDate + "') ";
        int i = claSqlConnDB.GetRecordCount(claSqlConnDB.gStrConnDefault, mStrSQL);
        return i;
    }
    public string GetPlanReportByCode3(string v_equip_code, DateTime v_StartDate, DateTime v_EndDate, int v_rows, int v_page)
    {
        string returnJson = "";
        string strSQL = "";
        strSQL = "select * from dbo.fGetPlanReportByDate3('" + v_equip_code + "','" + v_StartDate + "','" + v_EndDate + "') ";
        DataSet ds = null;
        using (ds = claSqlConnDB.ExecuteDataset(v_rows, v_page, claSqlConnDB.gStrConnDefault, CommandType.Text, strSQL))
        {
            returnJson = common.GetJsonByDataset1(ds);
        }
        return returnJson;
    }
    //根据日期，对该时间段内的设备巡检情况进行统计
    private int GetPlanReportByDateCount2(DateTime v_StartDate, DateTime v_EndDate)
    {
        string mStrSQL = "";
        mStrSQL = @"SELECT COUNT(0) FROM dbo.fGetPlanReportByDate2('" + v_StartDate + "','" + v_EndDate + "') ";
        int i = claSqlConnDB.GetRecordCount(claSqlConnDB.gStrConnDefault, mStrSQL);
        return i;
    }
    public string GetPlanReportByDate2(DateTime v_StartDate, DateTime v_EndDate, int v_rows, int v_page)
    {
        string returnJson = "";
        string strSQL = "";
        strSQL = "select * from dbo.fGetPlanReportByDate2('" + v_StartDate + "','" + v_EndDate + "') ";
        DataSet ds = null;
        using (ds = claSqlConnDB.ExecuteDataset(v_rows, v_page, claSqlConnDB.gStrConnDefault, CommandType.Text, strSQL))
        {
            returnJson = common.GetJsonByDataset1(ds);
        }
        return returnJson;
    }
    
    private int GetPlanReportByDateCount(DateTime v_StartDate, DateTime v_EndDate)
    {
        string mStrSQL = "";
        mStrSQL = @"SELECT COUNT(0) FROM dbo.fGetPlanReportByDate('" + v_StartDate + "','" + v_EndDate + "') ";
        int i = claSqlConnDB.GetRecordCount(claSqlConnDB.gStrConnDefault, mStrSQL);
        return i;
    }
    public string GetPlanReportByDate(DateTime v_StartDate, DateTime v_EndDate, int v_rows, int v_page)
    {
        string returnJson = "";
        string strSQL = "";
        strSQL = "select * from dbo.fGetPlanReportByDate('" + v_StartDate + "','" + v_EndDate + "') order by dDaePlanCompuleted desc ";
        DataSet ds = null;
        using (ds = claSqlConnDB.ExecuteDataset(v_rows, v_page, claSqlConnDB.gStrConnDefault, CommandType.Text, strSQL))
        {
            returnJson = common.GetJsonByDataset1(ds);
        }
        return returnJson;
    }

    private int GetPlanReportByUserCount(string v_user)
    {
        string mStrSQL = "";
        mStrSQL = @"SELECT COUNT(0) FROM dbo.fGetPlanReportByUser('" + v_user + "') ";
        int i = claSqlConnDB.GetRecordCount(claSqlConnDB.gStrConnDefault, mStrSQL);
        return i;
    }
    public string GetPlanReportByUser(string v_user, int v_rows, int v_page)
    {
        string returnJson = "";
        string strSQL = "";
        strSQL = "select * from dbo.fGetPlanReportByUser('" + v_user + "') order by dDaeAllotSystime desc ";
        DataSet ds = null;
        using (ds = claSqlConnDB.ExecuteDataset(v_rows, v_page, claSqlConnDB.gStrConnDefault, CommandType.Text, strSQL))
        {
            returnJson = common.GetJsonByDataset1(ds);
        }
        return returnJson;
    }
    
    private int GetPlanReportByEmployeeCodeCount(string v_employee_code)
    {
        string mStrSQL = "";
        mStrSQL = @"SELECT COUNT(0) FROM dbo.fGetPlanReportByEmployeeCode('" + v_employee_code + "') ";
        int i = claSqlConnDB.GetRecordCount(claSqlConnDB.gStrConnDefault, mStrSQL);
        return i;
    }
    public string GetPlanReportByEmployeeCode(string v_employee_code, int v_rows, int v_page)
    {
        string returnJson = "";
        string strSQL = "";
        strSQL = "select * from dbo.fGetPlanReportByEmployeeCode('" + v_employee_code + "') order by dDaeAllotSystime desc ";
        DataSet ds = null;
        using (ds = claSqlConnDB.ExecuteDataset(v_rows, v_page, claSqlConnDB.gStrConnDefault, CommandType.Text, strSQL))
        {
            returnJson = common.GetJsonByDataset1(ds);
        }
        return returnJson;
    }
    
    private int GetPlanReportByEquipCodeCount(string v_equip_code)
    {
        string mStrSQL = "";
        mStrSQL = @"SELECT COUNT(0) FROM dbo.fGetPlanReportByEquipCode('" + v_equip_code + "') ";
        int i = claSqlConnDB.GetRecordCount(claSqlConnDB.gStrConnDefault, mStrSQL);
        return i;
    }
    public string GetPlanReportByEquipCode(string v_equip_code, int v_rows, int v_page)
    {
        string returnJson = "";
        string strSQL = "";
        strSQL = "select * from dbo.fGetPlanReportByEquipCode('" + v_equip_code + "') order by dDaeAllotSystime desc ";
        DataSet ds = null;
        using (ds = claSqlConnDB.ExecuteDataset(v_rows, v_page, claSqlConnDB.gStrConnDefault, CommandType.Text, strSQL))
        {
            returnJson = common.GetJsonByDataset1(ds);
        }
        return returnJson;
    }
    
    private List<combobox> GetEquipComboxAll(string v_patrol_grade, string v_equip_code, string v_check_state)
    {
        List<combobox> mLstCombo = new List<combobox>();
        string mStrSQL = @"select distinct equip_code,equip_name from dbo.fGetEquipStandardRange() where equip_code <> '-1' " + GetWhere(v_patrol_grade, v_equip_code, v_check_state, "", "");
        System.Data.DataTable dt = null;
        using (dt = claSqlConnDB.ExecuteDataset(claSqlConnDB.gStrConnDefault, System.Data.CommandType.Text, mStrSQL).Tables[0])
        {
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                combobox mCombo = new combobox();
                mCombo.id = dt.Rows[i][0].ToString();
                mCombo.text = dt.Rows[i][1].ToString();
                mLstCombo.Add(mCombo);
            }
        }
        return mLstCombo;
    }
    private List<combobox> GetEquipCombox(string v_branch_id,string v_patrol_grade, string v_equip_code, string v_check_state)
    {
        List<combobox> mLstCombo = new List<combobox>();
        string mStrSQL = @"select distinct equip_code,equip_name from dbo.fGetEquipStandardRangeByBranchID(" + v_branch_id + ") where equip_code <> '-1' " + GetWhere(v_patrol_grade, v_equip_code, v_check_state, "", "");
        System.Data.DataTable dt = null;
        using (dt = claSqlConnDB.ExecuteDataset(claSqlConnDB.gStrConnDefault, System.Data.CommandType.Text, mStrSQL).Tables[0])
        {
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                combobox mCombo = new combobox();
                mCombo.id = dt.Rows[i][0].ToString();
                mCombo.text = dt.Rows[i][1].ToString();
                mLstCombo.Add(mCombo);
            }
        }
        return mLstCombo;
    }

    private string GetEquipStandardRangeByBranchID(string v_branch_id, string v_patrol_grade, string v_equip_code, int v_rows, int v_page)
    {
        string returnJson = "";
        string strSQL = "";
        strSQL = "select * from dbo.fGetEquipStandardRangeByBranchID(" + v_branch_id + ") where equip_code <> '-1' " + GetWhere(v_patrol_grade, v_equip_code, "","","");
        DataSet ds = null;
        using (ds = claSqlConnDB.ExecuteDataset(v_rows, v_page, claSqlConnDB.gStrConnDefault, CommandType.Text, strSQL))
        {
            returnJson = common.GetJsonByDataset1(ds);
        }

        return returnJson;
    }
    private int GetEquipStandardRangeByBranchIDCount(string v_branch_id, string v_patrol_grade, string v_equip_code)
    {
        string mStrSQL = "";
        mStrSQL = "SELECT COUNT(0) FROM dbo.fGetEquipStandardRangeByBranchID(" + v_branch_id + ") where equip_code <> '-1' " + GetWhere(v_patrol_grade, v_equip_code, "","","");
        int i = claSqlConnDB.GetRecordCount(claSqlConnDB.gStrConnDefault, mStrSQL);
        return i;
    }
    private string GetEquipStandardRange(string v_patrol_grade, string v_equip_code, int v_rows, int v_page)
    {
        string returnJson = "";
        string strSQL = "";
        strSQL = "select * from dbo.fGetEquipStandardRange() where equip_code <> '-1' " + GetWhere(v_patrol_grade, v_equip_code, "","","");
        DataSet ds = null;
        using (ds = claSqlConnDB.ExecuteDataset(v_rows, v_page, claSqlConnDB.gStrConnDefault, CommandType.Text, strSQL))
        {
            returnJson = common.GetJsonByDataset1(ds);
        }
        return returnJson;
    }
    private int GetEquipStandardRangeCount(string v_patrol_grade, string v_equip_code)
    {
        string mStrSQL = "";
        mStrSQL = @"SELECT COUNT(0) FROM dbo.fGetEquipStandardRange() where equip_code <> '-1' " + GetWhere(v_patrol_grade, v_equip_code, "", "", "");
        int i = claSqlConnDB.GetRecordCount(claSqlConnDB.gStrConnDefault, mStrSQL);
        return i;
    }
    

    private string GetPlanByCondition3(string v_branch_id, int v_rows, int v_page)
    {
        string returnJson = "";
        string strSQL = "";
        strSQL = "select * from dbo.fGetPlanByCondition3(" + v_branch_id + ") where equip_code <> '-1' ";
        DataSet ds = null;
        using (ds = claSqlConnDB.ExecuteDataset(v_rows, v_page, claSqlConnDB.gStrConnDefault, CommandType.Text, strSQL))
        {
            returnJson = common.GetJsonByDataset1(ds);
        }

        return returnJson;
    }
    private int GetPlanByCondition3Count(string v_branch_id)
    {
        string mStrSQL = "";
        mStrSQL = "SELECT COUNT(0) from dbo.fGetPlanByCondition3(" + v_branch_id + ") where equip_code <> '-1' ";
        int i = claSqlConnDB.GetRecordCount(claSqlConnDB.gStrConnDefault, mStrSQL);
        return i;
    }
    
    
    private string GetPlanByCondition2(string v_branch_id, string v_patrol_grade, string v_equip_code, string v_check_state, string v_startdate, string v_enddate, int v_rows, int v_page)
    {
        string returnJson = "";
        string strSQL = "";
        strSQL = "select * from dbo.fGetPlanByCondition2(" + v_branch_id + ") where dIntgPlanNote <> -1 " + GetWhere(v_patrol_grade, v_equip_code, v_check_state, v_startdate, v_enddate);
        DataSet ds = null;
        using (ds = claSqlConnDB.ExecuteDataset(v_rows, v_page, claSqlConnDB.gStrConnDefault, CommandType.Text, strSQL))
        {
            returnJson = common.GetJsonByDataset1(ds);
        }

        return returnJson;
    }
    private int GetPlanByCondition2Count(string v_branch_id, string v_patrol_grade, string v_equip_code, string v_startdate, string v_enddate, string v_check_state)
    {
        string mStrSQL = "";
        mStrSQL = "SELECT COUNT(0) from dbo.fGetPlanByCondition2(" + v_branch_id + ") where dIntgPlanNote <> -1 " + GetWhere(v_patrol_grade, v_equip_code, v_check_state, v_startdate, v_enddate);
        int i = claSqlConnDB.GetRecordCount(claSqlConnDB.gStrConnDefault, mStrSQL);
        return i;
    }
    private string GetPlanByPeople(string v_employee_code, string v_equip_code, string v_check_state, string v_startdate, string v_enddate, int v_rows, int v_page)
    {
        string returnJson = "";
        string strSQL = "";
        strSQL = "select * from dbo.fGetPlanByPeople('" + v_employee_code + "') where dIntgPlanNote <> -1 " + GetWhere("", v_equip_code, v_check_state, v_startdate, v_enddate);
        DataSet ds = null;
        using (ds = claSqlConnDB.ExecuteDataset(v_rows, v_page, claSqlConnDB.gStrConnDefault, CommandType.Text, strSQL))
        {
            returnJson = common.GetJsonByDataset1(ds);
        }
        return returnJson;
    }
    private int GetPlanByPeopleCount(string v_employee_code, string v_equip_code, string v_check_state, string v_startdate, string v_enddate)
    {
        string mStrSQL = "";
        mStrSQL = "SELECT COUNT(0) from dbo.fGetPlanByPeople('" + v_employee_code + "') where dIntgPlanNote <> -1 " + GetWhere("", v_equip_code, v_check_state, v_startdate, v_enddate);
        int i = claSqlConnDB.GetRecordCount(claSqlConnDB.gStrConnDefault, mStrSQL);
        return i;
    }

    private int GetPlanByConditionCount(string v_AlotUser, string v_equip_code, string v_employee_code, string v_startdate, string v_enddate)
    {
        string mStrSQL = "";
        mStrSQL = @"SELECT COUNT(0) from (SELECT t_TCPlan2.dIntgPlanNote,t_TCEquipStandardRange.equip_code,t_Equips.equip_name,
                    t_TCEquipStandardRange.dIntStandardNote,t_TCStandard.dVchStandardName,
                    t_TCEquipStandardRange.dIntContentNote,t_TCContent.dVchContentName,
                    t_TCEquipStandardRange.dIntPartNote,t_TCPart.dVchPartName,
                    t_TCEquipStandardRange.area_id,t_EquipArea.area_name,
                    t_TCPlanAllotRecord.dVchUser,t_TCPlanAllotRecord.dVchUserName,
                    t_TCEquipStandardRange.dVchPostName,t_major.major_name,
                    t_TCEquipStandardRange.dIntPatrolGrade,t_PatrolGrade.patrolgrade_name,
                    t_TCPlan2.dDaeTCDetailDate,t_TCPlan2.dDaeTCNextDate,t_TCPlan2.dVchCheckState,
                    t_TCPlanAllotRecord.dDaeAllotSystime,t_TCPlan2.dDaePlanSystime,t_TCPlan2.dDaePlanCompuleted,
                    t_Employee.employee_code,t_Employee.employee_Name,
                    t_TCNoteDetail.dVchTCDetail,t_TCNoteDetail.dVchTCResult,
                    t_TCNoteDetail.dVchXYZ,t_TCNoteDetail.dVchRunNum,t_TCNoteDetail.dVchTCPic,t_TCPlanAllotRecord.dVchRemark
                FROM t_TCEquipStandardRange
                INNER JOIN t_TCStandard ON t_TCStandard.dIntStandardNote = t_TCEquipStandardRange.dIntStandardNote
                INNER JOIN t_TCContent ON t_TCContent.dIntContentNote = t_TCEquipStandardRange.dIntContentNote
                INNER JOIN t_TCPart ON t_TCPart.dIntPartNote = t_TCEquipStandardRange.dIntPartNote
                INNER JOIN t_major ON t_major.major_code = t_TCEquipStandardRange.dVchPostName
                INNER JOIN t_PatrolGrade ON t_PatrolGrade.patrolgrade_id = t_TCEquipStandardRange.dIntPatrolGrade
                INNER JOIN t_Equips ON t_Equips.equip_code = t_TCEquipStandardRange.equip_code
                INNER JOIN t_EquipArea ON t_EquipArea.area_id = t_TCEquipStandardRange.area_id
                INNER JOIN t_TCPlan2 ON t_TCPlan2.dVchStandardName = t_TCEquipStandardRange.dIntStandardNote
                INNER JOIN t_TCPlanAllotRecord ON t_TCPlanAllotRecord.dIntgPlanNote = t_TCPlan2.dIntgPlanNote
                INNER JOIN t_Employee ON t_Employee.employee_code = t_TCPlanAllotRecord.employee_code
                LEFT JOIN t_TCNoteDetail ON t_TCNoteDetail.dVchTCDetail = t_TCPlan2.dVchTCDetail where t_TCEquipStandardRange.dIntStandardNote <> -1 " + GetWhere1(v_AlotUser, v_equip_code, v_employee_code, v_startdate, v_enddate) + @") A";
        int i = claSqlConnDB.GetRecordCount(claSqlConnDB.gStrConnDefault, mStrSQL);
        return i;
    }
    //综合查询   分配者、设备编码、巡检人、日期四种条件混合查询，可随意选择，在SQL语句上做拼接处理
    private string GetPlanByCondition(string v_AlotUser, string v_equip_code, string v_employee_code, string v_startdate, string v_enddate, int v_rows, int v_page)
    {
        string returnJson = "";
        string mStrSQ = "";
        mStrSQ = @" SELECT t_TCPlan2.dIntgPlanNote,t_TCEquipStandardRange.equip_code,t_Equips.equip_name,
                    t_TCEquipStandardRange.dIntStandardNote,t_TCStandard.dVchStandardName,
                    t_TCEquipStandardRange.dIntContentNote,t_TCContent.dVchContentName,
                    t_TCEquipStandardRange.dIntPartNote,t_TCPart.dVchPartName,
                    t_TCEquipStandardRange.area_id,t_EquipArea.area_name,
                    t_TCPlanAllotRecord.dVchUser,t_TCPlanAllotRecord.dVchUserName,
                    t_TCEquipStandardRange.dVchPostName,t_major.major_name,
                    t_TCEquipStandardRange.dIntPatrolGrade,t_PatrolGrade.patrolgrade_name,
                    t_TCPlan2.dDaeTCDetailDate,t_TCPlan2.dDaeTCNextDate,t_TCPlan2.dVchCheckState,
                    t_TCPlanAllotRecord.dDaeAllotSystime,t_TCPlan2.dDaePlanSystime,t_TCPlan2.dDaePlanCompuleted,
                    t_Employee.employee_code,t_Employee.employee_Name,
                    t_TCNoteDetail.dVchTCDetail,t_TCNoteDetail.dVchTCResult,
                    t_TCNoteDetail.dVchXYZ,t_TCNoteDetail.dVchRunNum,t_TCNoteDetail.dVchTCPic,t_TCPlanAllotRecord.dVchRemark
                FROM t_TCEquipStandardRange
                INNER JOIN t_TCStandard ON t_TCStandard.dIntStandardNote = t_TCEquipStandardRange.dIntStandardNote
                INNER JOIN t_TCContent ON t_TCContent.dIntContentNote = t_TCEquipStandardRange.dIntContentNote
                INNER JOIN t_TCPart ON t_TCPart.dIntPartNote = t_TCEquipStandardRange.dIntPartNote
                INNER JOIN t_major ON t_major.major_code = t_TCEquipStandardRange.dVchPostName
                INNER JOIN t_PatrolGrade ON t_PatrolGrade.patrolgrade_id = t_TCEquipStandardRange.dIntPatrolGrade
                INNER JOIN t_Equips ON t_Equips.equip_code = t_TCEquipStandardRange.equip_code
                INNER JOIN t_EquipArea ON t_EquipArea.area_id = t_TCEquipStandardRange.area_id
                INNER JOIN t_TCPlan2 ON t_TCPlan2.dVchStandardName = t_TCEquipStandardRange.dIntStandardNote
                INNER JOIN t_TCPlanAllotRecord ON t_TCPlanAllotRecord.dIntgPlanNote = t_TCPlan2.dIntgPlanNote
                INNER JOIN t_Employee ON t_Employee.employee_code = t_TCPlanAllotRecord.employee_code
                LEFT JOIN t_TCNoteDetail ON t_TCNoteDetail.dVchTCDetail = t_TCPlan2.dVchTCDetail where t_TCEquipStandardRange.dIntStandardNote <> -1 " + GetWhere1(v_AlotUser, v_equip_code, v_employee_code, v_startdate, v_enddate) + @" ORDER BY dDaeAllotSystime DESC ";
        DataSet ds = null;
        using (ds = claSqlConnDB.ExecuteDataset(v_rows, v_page, claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQ))
        {
            returnJson = common.GetJsonByDataset1(ds);
        }

        return returnJson;
    }
    private string GetWhere1(string v_AlotUser, string v_equip_code, string v_employee_code, string v_startdate, string v_enddate)
    {
        string mStrWhere = "";
        if (v_AlotUser != "")
        {
            mStrWhere = mStrWhere + " and t_TCPlanAllotRecord.dVchUser = '" + v_AlotUser + "'";
        }
        if (v_equip_code != "")
        {
            mStrWhere = mStrWhere + " and t_TCPlan2.equip_code = '" + v_equip_code + "'";
        }
        if (v_employee_code != "")
        {
            mStrWhere = mStrWhere + " and t_TCPlanAllotRecord.employee_code ='" + v_employee_code + "'";
        }
        if (v_startdate != "")
        {
            mStrWhere = mStrWhere + " and t_TCPlan2.dDaePlanCompuleted >'" + v_startdate + "'";
        }
        if (v_enddate != "")
        {
            mStrWhere = mStrWhere + " and t_TCPlan2.dDaePlanCompuleted <'" + v_enddate + "'";
        }
        return mStrWhere;
    }
    
    
    
    
    private string GetWhere(string v_PatrolGrade, string v_equip_code, string v_checkState,string v_startdate,string v_enddate)
    {
        string mStrWhere = "";
        if (v_PatrolGrade != "")
        {
            mStrWhere = mStrWhere + " and dIntPatrolGrade ='" + v_PatrolGrade + "'";
        }
        if (v_equip_code != "")
        {
            mStrWhere = mStrWhere + " and equip_code in('" + v_equip_code.Replace(",", "','") + "')";
        }
        if (v_checkState != "")
        {
            mStrWhere = mStrWhere + " and dVchCheckState ='" + v_checkState + "'";
        }
        if (v_startdate != "")
        {
            mStrWhere = mStrWhere + " and dDaePlanSystime >'" + v_startdate + "'";
        }
        if (v_enddate != "")
        {
            mStrWhere = mStrWhere + " and dDaePlanSystime <'" + v_enddate + "'";
        }
        return mStrWhere;
    }
    public bool IsReusable
    {
        get
        {
            return false;
        }
    }


}