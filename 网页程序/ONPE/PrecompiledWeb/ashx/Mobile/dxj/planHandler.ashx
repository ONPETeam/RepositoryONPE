<%@ WebHandler Language="C#" Class="planHandler" %>

using System;
using System.Web;
using ModelClass;
using Newtonsoft.Json;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using NPE.UIDataClass;

public class planHandler : IHttpHandler
{

    public void ProcessRequest(HttpContext context)
    {
        int mIntParaNullable = 0;
        object mObjReturn = null;
        string mStrReturn = "";
        context.Response.ContentType = "text/plain";
        string action = "";
        if (context.Request.Params["action"] != "")
        {
            action = context.Request.Params["action"];
        }
        switch (action)
        {
            case "treegrid":
                int mIntCachePlanCount = 0;
                string sort = "";
                if (context.Request.Params["sort"] != null)
                {
                    sort = context.Request.Params["sort"];
                }
                string order = "";
                if (context.Request.Params["order"] != null)
                {
                    order = context.Request.Params["order"];
                }
                int page = 1;
                if (context.Request.Params["page"] != null)
                {
                    if (int.TryParse(context.Request.Params["page"], out page) == false)
                    {
                        page = 1;
                    }
                }
                int rows = 10;
                if (context.Request.Params["rows"] != null)
                {
                    if (int.TryParse(context.Request.Params["rows"], out rows) == false)
                    {
                        rows = 10;
                    }
                }
                string m_treegrid_plan_date = "";
                if (context.Request.Params["plan_date"] != null)
                {
                    m_treegrid_plan_date = context.Request.Params["plan_date"];
                }
                string m_treegrid_equip_code = "";
                if (context.Request.Params["equip_code"] != null)
                {
                    m_treegrid_equip_code = context.Request.Params["equip_code"];
                }
                string m_treegrid_user_name = "";
                if (context.Request.Params["user_name"] != null)
                {
                    m_treegrid_user_name = context.Request.Params["user_name"];
                }
                else
                {
                    mIntParaNullable = mIntParaNullable + 1;
                }
                string m_treegrid_major_code = "";
                if (context.Request.Params["major_code"] != null)
                {
                    m_treegrid_major_code = context.Request.Params["major_code"];
                }
                string m_treegrid_request_from = "";
                if (context.Request.Params["request_from"] != null)
                {
                    m_treegrid_request_from = context.Request.Params["request_from"];
                }
                else
                {
                    mIntParaNullable = mIntParaNullable + 1;
                }
                if (mIntParaNullable == 0)
                {
                    int mIntAddCachePlan = AddCachePlan(m_treegrid_request_from, m_treegrid_user_name);

                    if (mIntAddCachePlan >= 0)
                    {
                        mObjReturn = GetTreeGrid(page, rows, m_treegrid_plan_date, m_treegrid_user_name, m_treegrid_equip_code, m_treegrid_major_code, sort, order);
                        mIntCachePlanCount = GetCount(m_treegrid_plan_date, m_treegrid_user_name, m_treegrid_equip_code, m_treegrid_major_code);
                        mStrReturn = "{\"total\":" + mIntCachePlanCount + ",\"rows\":" + JsonConvert.SerializeObject(mObjReturn) + "}";
                    }
                }

                break;
            case "combo":
                string m_combo_user_name = "";
                if (context.Request.Params["user_name"] != null)
                {
                    m_combo_user_name = context.Request.Params["user_name"];
                }
                else
                {
                    mIntParaNullable = mIntParaNullable + 1;
                }
                string m_combo_major_code = "";
                if (context.Request.Params["major_code"] != null)
                {
                    m_combo_major_code = context.Request.Params["major_code"];
                }
                if (mIntParaNullable == 0)
                {
                    mObjReturn = GetComboData(m_combo_user_name, m_combo_major_code);
                    mStrReturn = JsonConvert.SerializeObject(mObjReturn);
                }
                else
                {
                    mStrReturn = "";
                }
                break;
            default:

                break;
        }
        context.Response.Write(mStrReturn);
    }
    public List<combobox> GetComboData(string v_user_name, string v_major_code)
    {
        List<combobox> mLstCombo = new List<combobox>();
        string mStrSQL = @"SELECT distinct 
                t_TCNoteDetailCachePlan.equip_code,
                t_TCNoteDetailCachePlan.equip_name
            FROM t_TCNoteDetailCachePlan
                INNER JOIN t_TCStandard left outer join t_major on t_TCStandard.dVchPostName=t_major.major_code ON t_TCStandard.dIntStandardNote = t_TCNoteDetailCachePlan.dVchStandardName
                LEFT JOIN t_TCContentStandard ON t_TCContentStandard.dIntStandardNote = t_TCStandard.dIntStandardNote 
                INNER JOIN t_TCContent ON t_TCContent.dIntContentNote = t_TCContentStandard.dIntContentNote
                LEFT JOIN t_TCPartContent ON t_TCPartContent.dIntContentNote = t_TCContent.dIntContentNote
                INNER JOIN t_TCPart ON t_TCPart.dIntPartNote = t_TCPartContent.dIntPartNote
                left outer join t_Employee on  t_Employee.employee_code=t_TCNoteDetailCachePlan.employee_code" + GetWhere("", v_user_name, v_major_code, "");
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
    public int GetCount(string v_plan_date, string v_user_name, string v_equip_code, string v_major_code)
    {
        string mStrSQL = "";
        mStrSQL = @"SELECT COUNT(0) FROM t_TCNoteDetailCachePlan
                INNER JOIN t_TCStandard left outer join t_major on t_TCStandard.dVchPostName=t_major.major_code ON t_TCStandard.dIntStandardNote = t_TCNoteDetailCachePlan.dVchStandardName
                LEFT JOIN t_TCContentStandard ON t_TCContentStandard.dIntStandardNote = t_TCStandard.dIntStandardNote 
                INNER JOIN t_TCContent ON t_TCContent.dIntContentNote = t_TCContentStandard.dIntContentNote
                LEFT JOIN t_TCPartContent ON t_TCPartContent.dIntContentNote = t_TCContent.dIntContentNote
                INNER JOIN t_TCPart ON t_TCPart.dIntPartNote = t_TCPartContent.dIntPartNote
                left outer join t_Employee on  t_Employee.employee_code=t_TCNoteDetailCachePlan.employee_code" + GetWhere(v_plan_date, v_user_name, v_major_code, v_equip_code);
        int i = claSqlConnDB.GetRecordCount(claSqlConnDB.gStrConnDefault, mStrSQL);
        return i;
    }
    public int AddCachePlan(string v_request_from, string v_user_name)
    {
        int lIntReturn = -1;
        SqlParameter[] _Parameter = new SqlParameter[3]
            {
                new SqlParameter("@DataBaseCode",SqlDbType.VarChar,2),
                new SqlParameter("@userName",SqlDbType.VarChar,30),
                new SqlParameter("@voIntReturn",SqlDbType.Int),
            };
        _Parameter[0].Value = v_request_from;
        _Parameter[1].Value = v_user_name;
        _Parameter[2].Direction = System.Data.ParameterDirection.Output;
        claSqlConnDB.ExecuteNonQuery(claSqlConnDB.gStrConnDefault, CommandType.StoredProcedure, "pTCNoteAddCachePlan", _Parameter);
        lIntReturn = (int)_Parameter[2].Value;
        return lIntReturn;
    }

    public List<TCPlanDetail> GetTreeGrid(int v_page, int v_rows, string v_plan_date, string v_user_name, string v_equip_code, string v_major_code, string v_sort, string v_order)
    {
        List<TCPlanDetail> Grid = new List<TCPlanDetail>();
        string lStrSQL = @"SELECT t_TCNoteDetailCachePlan.dVchTCPlan,
                t_TCNoteDetailCachePlan.dVchName,
                t_TCNoteDetailCachePlan.equip_code,
                t_TCNoteDetailCachePlan.equip_name,
                t_TCPart.dVchPartName,
                t_TCContent.dVchContentName,
                t_TCStandard.dVchStandardName,
                t_TCStandard.dIntCheckDay,
                t_major.major_code,
                t_major.major_name,
                t_TCNoteDetailCachePlan.dDaeTCDetailDate,
                t_TCNoteDetailCachePlan.dDaeTCNextDate,
                t_Employee.employee_code,
                t_Employee.employee_name,
                t_TCNoteDetailCachePlan.dVchPlanData,
                t_TCNoteDetailCachePlan.dVchCheckState
            FROM t_TCNoteDetailCachePlan
                INNER JOIN t_TCStandard left outer join t_major on t_TCStandard.dVchPostName=t_major.major_code ON t_TCStandard.dIntStandardNote = t_TCNoteDetailCachePlan.dVchStandardName
                LEFT JOIN t_TCContentStandard ON t_TCContentStandard.dIntStandardNote = t_TCStandard.dIntStandardNote 
                INNER JOIN t_TCContent ON t_TCContent.dIntContentNote = t_TCContentStandard.dIntContentNote
                LEFT JOIN t_TCPartContent ON t_TCPartContent.dIntContentNote = t_TCContent.dIntContentNote
                INNER JOIN t_TCPart ON t_TCPart.dIntPartNote = t_TCPartContent.dIntPartNote
                left outer join t_Employee on  t_Employee.employee_code=t_TCNoteDetailCachePlan.employee_code" + GetWhere(v_plan_date, v_user_name, v_major_code, v_equip_code) + GetOrder(v_sort, v_order);
        System.Data.DataTable dt = null;
        using (dt = claSqlConnDB.ExecuteDataset(v_rows, v_page, claSqlConnDB.gStrConnDefault, System.Data.CommandType.Text, lStrSQL).Tables[0])
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
                tmp.dIntStandardCheck = int.Parse(dt.Rows[i][7] != null ? dt.Rows[i][7].ToString() : "0");
                tmp.dVchMajorCode = dt.Rows[i][8].ToString();
                tmp.dVchMajorName = dt.Rows[i][9].ToString();
                tmp.dDaeTCDetailDate = DateTime.Parse(dt.Rows[i][10].ToString());
                tmp.dDaeTCNextDate = DateTime.Parse(dt.Rows[i][11].ToString());
                tmp.employee_code = dt.Rows[i][12].ToString();
                tmp.employee_name = dt.Rows[i][13].ToString();
                tmp.dVchPlanData = dt.Rows[i][14].ToString();
                tmp.dVchCheckState = dt.Rows[i][15].ToString();
                Grid.Add(tmp);
            }
        }
        return Grid;
    }
    /// <summary>
    /// 获取TreeGrid的WHERE选项
    /// </summary>
    /// <param name="v_plan_date">日期</param>
    /// <param name="v_user_name">用户名</param>
    /// <param name="v_major_code">专业名称</param>
    /// <param name="v_equip_code">设备编码</param>
    /// <returns></returns>
    public string GetWhere(string v_plan_date, string v_user_name, string v_major_code, string v_equip_code)
    {
        string mStrWhere = "";
        if (v_plan_date != "")
        {
            if (mStrWhere != "")
            {
                mStrWhere = mStrWhere + " AND t_TCNoteDetailCachePlan.dVchPlanData ='" + v_plan_date + "'";
            }
            else
            {
                mStrWhere = " WHERE t_TCNoteDetailCachePlan.dVchPlanData ='" + v_plan_date + "'";
            }
        }
        if (v_user_name != "")
        {
            if (mStrWhere != "")
            {
                mStrWhere = mStrWhere + " AND t_TCNoteDetailCachePlan.dVchUser ='" + v_user_name + "'";
            }
            else
            {
                mStrWhere = " WHERE t_TCNoteDetailCachePlan.dVchUser ='" + v_user_name + "'";
            }
        }

        if (v_equip_code != "")
        {
            if (mStrWhere != "")
            {
                mStrWhere = mStrWhere + " AND t_TCNoteDetailCachePlan.equip_code in('" + v_equip_code.Replace(",", "','") + "')";
            }
            else
            {
                mStrWhere = " WHERE t_TCNoteDetailCachePlan.equip_code in('" + v_equip_code.Replace(",", "','") + "')";
            }
        }
        if (v_major_code != "")
        {
            if (mStrWhere != "")
            {
                mStrWhere = mStrWhere + " AND t_major.major_code ='" + v_major_code + "'";
            }
            else
            {
                mStrWhere = " WHERE t_major.major_code ='" + v_major_code + "'";
            }
        }
        return mStrWhere;
    }
    /// <summary>
    /// TREEGRID数据排序
    /// </summary>
    /// <param name="v_sort">排序列</param>
    /// <param name="v_order">排序名称</param>
    /// <returns></returns>
    public string GetOrder(string v_sort, string v_order)
    {
        string mStrOrder = "";
        if (v_sort != "")
        {
            mStrOrder = " order by t_TCNoteDetailCachePlan." + v_sort;
            if (v_order != "")
            {
                mStrOrder = mStrOrder + " " + v_order;
            }
        }
        return mStrOrder;
    }
    public bool IsReusable
    {
        get
        {
            return false;
        }
    }

}