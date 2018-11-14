<%@ WebHandler Language="C#" Class="ShowTCHandler" %>

using System;
using System.Web;
using ModelClass;
using Newtonsoft.Json;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;

public class ShowTCHandler : IHttpHandler {
        
    object mObjReturn = null;
    string mStrReturn = "";
    public void ProcessRequest (HttpContext context) {
        context.Response.ContentType = "text/plain";
        string type = context.Request.Params["type"];
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
                string m_para1_equip_code = "";
                if (context.Request.Params["equipcode"] != null)
                {
                    m_para1_equip_code = context.Request.Params["equipcode"].ToString();
                }
                mObjReturn = ShowTCData(m_para1_page, m_para1_rows, m_para1_equip_code);
                mStrReturn = "{\"total\":" + GetTCDataCount(m_para1_equip_code) + ",\"rows\":" + JsonConvert.SerializeObject(mObjReturn) + "}";
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
                string m_para2_TCNote = "";
                string m_para2_TCDetail = "";
                if (context.Request.Params["TCNote"] != null)
                {
                    m_para2_TCNote = context.Request.Params["TCNote"].ToString();
                }
                if (context.Request.Params["TCDetail"] != null)
                {
                    m_para2_TCDetail = context.Request.Params["TCDetail"].ToString();
                }
                mObjReturn = ShowTCBadData(m_para2_page, m_para2_rows, m_para2_TCNote, m_para2_TCDetail);
                mStrReturn = "{\"total\":" + GetTCBadDataCount(m_para2_TCNote, m_para2_TCDetail) + ",\"rows\":" + JsonConvert.SerializeObject(mObjReturn) + "}";
                break;
        }
        context.Response.Write(mStrReturn);
        
    }
    /// <summary>
    /// 获取点巡检记录集数量
    /// </summary>
    /// <param name="v_equip_code">设备编码</param>
    /// <returns></returns>
    public int GetTCDataCount(string v_equip_code)
    {
        int mIntCount = 0;
        string mStrSQL = @"SELECT COUNT(0) FROM         t_TCNote INNER JOIN
                      t_PatrolGrade ON t_PatrolGrade.patrolgrade_id = t_TCNote.dVchTCType INNER JOIN
                      tHRCompany ON tHRCompany.dIntCompanyID = t_TCNote.dVchTCUnit INNER JOIN
                      t_major ON t_major.major_code = t_TCNote.dVchTCSpecialty INNER JOIN
                      t_Employee ON t_TCNote.dVchTCPeople = t_Employee.employee_code INNER JOIN
                      tHRBranchInfo ON t_Employee.branch_id = tHRBranchInfo.dIntBranchID INNER JOIN
                      t_Equips ON t_TCNote.equip_code = t_Equips.equip_code INNER JOIN
                      t_EquipArea ON t_Equips.area_id = t_EquipArea.area_id " + GetShowTCDataWhere(v_equip_code);
        mIntCount = claSqlConnDB.GetRecordCount(claSqlConnDB.gStrConnDefault, mStrSQL);
        return mIntCount;
    }
    
    /// <summary>
    /// 点巡检记录集
    /// </summary>
    /// <param name="v_page">当前页码</param>
    /// <param name="v_rows">页面数据量</param>
    /// <param name="v_equip_code">设备编码</param>
    /// <returns>点巡检记录集</returns>
    public List<TCNote> ShowTCData(int v_page, int v_rows, string v_equip_code)
    {
        List<TCNote> mLstTCNote = new List<TCNote>();
        string lStrSQL = @"SELECT     t_TCNote.dVchTCNote, t_TCNote.equip_code, t_Equips.equip_name, t_EquipArea.area_id, 
                      t_EquipArea.area_name, t_PatrolGrade.patrolgrade_name, tHRCompany.dVchCompanyName, t_major.major_name, t_TCNote.dDaeTCDate, t_TCNote.dVchRemark, 
                      tHRBranchInfo.dIntBranchID, tHRBranchInfo.dVchBranchName, t_Employee.employee_code, t_Employee.employee_Name
                    FROM         t_TCNote INNER JOIN
                      t_PatrolGrade ON t_PatrolGrade.patrolgrade_id = t_TCNote.dVchTCType INNER JOIN
                      tHRCompany ON tHRCompany.dIntCompanyID = t_TCNote.dVchTCUnit INNER JOIN
                      t_major ON t_major.major_code = t_TCNote.dVchTCSpecialty INNER JOIN
                      t_Employee ON t_TCNote.dVchTCPeople = t_Employee.employee_code INNER JOIN
                      tHRBranchInfo ON t_Employee.branch_id = tHRBranchInfo.dIntBranchID INNER JOIN
                      t_Equips ON t_TCNote.equip_code = t_Equips.equip_code INNER JOIN
                      t_EquipArea ON t_Equips.area_id = t_EquipArea.area_id "
            + GetShowTCDataWhere(v_equip_code) + " ORDER BY dDaeTCDate DESC";
        System.Data.DataTable dt = null;
        using (dt = claSqlConnDB.ExecuteDataset(v_rows,v_page,claSqlConnDB.gStrConnDefault, System.Data.CommandType.Text, lStrSQL).Tables[0])
        {
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                TCNote tmp = new TCNote();
                tmp.dVchTCNote = dt.Rows[i][0].ToString();
                tmp.equip_code = dt.Rows[i][1].ToString();
                tmp.equip_name = dt.Rows[i][2].ToString();
                tmp.area_id = dt.Rows[i][3].ToString();
                tmp.area_name = dt.Rows[i][4].ToString();
                tmp.dVchTCType = dt.Rows[i][5].ToString();
                tmp.dVchTCUnit = dt.Rows[i][6].ToString();
                tmp.dVchTCSpecialty = dt.Rows[i][7].ToString();
                tmp.dDaeTCDate = DateTime.Parse(dt.Rows[i][8].ToString());
                tmp.dVchRemark =dt.Rows[i][9].ToString();
                tmp.branch_id = dt.Rows[i][10].ToString();
                tmp.branch_name = dt.Rows[i][11].ToString();
                tmp.employee_code = dt.Rows[i][12].ToString();
                tmp.dVchTCPeople = dt.Rows[i][13].ToString();
                mLstTCNote.Add(tmp);
            }
        }
        return mLstTCNote;
    }
    
    public string GetShowTCDataWhere(string v_equip_code)
    {
        string mStrWhere = "";
        if (v_equip_code != "")
        {
            if (mStrWhere != "")
            {
                mStrWhere = mStrWhere + " and t_TCNote.equip_code in('" + v_equip_code.Replace(",","','") + "')";
            }
            else
            {
                mStrWhere = " where t_TCNote.equip_code in('" + v_equip_code.Replace(",", "','") + "')";
            }
        }
        return mStrWhere;
    }
    
    public int GetTCBadDataCount(string v_TCNote, string v_TCDetail)
    {
        int mIntCount = 0;
        string mStrSQL = @"SELECT COUNT(0) FROM t_TCNoteDetailBad INNER JOIN t_TCPart ON t_TCPart.dIntPartNote = t_TCNoteDetailBad.dVchPartName
                INNER JOIN t_TCContent ON t_TCContent.dIntContentNote = t_TCNoteDetailBad.dVchContentName
                INNER JOIN t_TCStandard ON t_TCStandard.dIntStandardNote = t_TCNoteDetailBad.dVchStandardName " 
            + GetShowTCBadDataWhere(v_TCNote, v_TCDetail);
        mIntCount = claSqlConnDB.GetRecordCount(claSqlConnDB.gStrConnDefault, mStrSQL);
        return mIntCount;
    }
    
    public List<TCBadNote> ShowTCBadData(int v_page,int v_rows, string v_TCNote,string v_TCDetail)
    {
        List<TCBadNote> mLstTCBadNote = new List<TCBadNote>();

        string lStrSQL = @"SELECT dVchTCNote,
                dVchTCDetail,
                t_TCPart.dVchPartName,
                t_TCContent.dVchContentName,
                t_TCStandard.dVchStandardName,
                dVchBanContent,t_TCPart.dIntPartNote,t_TCContent.dIntContentNote,t_TCStandard.dIntStandardNote
                FROM t_TCNoteDetailBad
                INNER JOIN t_TCPart ON t_TCPart.dIntPartNote = t_TCNoteDetailBad.dVchPartName
                INNER JOIN t_TCContent ON t_TCContent.dIntContentNote = t_TCNoteDetailBad.dVchContentName
                INNER JOIN t_TCStandard ON t_TCStandard.dIntStandardNote = t_TCNoteDetailBad.dVchStandardName "
                + GetShowTCBadDataWhere(v_TCNote, v_TCDetail);                
        System.Data.DataTable dt = null;
        using (dt = claSqlConnDB.ExecuteDataset(claSqlConnDB.gStrConnDefault, System.Data.CommandType.Text, lStrSQL).Tables[0])
        {
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                TCBadNote tmp = new TCBadNote();
                tmp.dVchTCNote = dt.Rows[i][0].ToString();
                tmp.dVchTCDetail = dt.Rows[i][1].ToString();
                tmp.dVchPartName = dt.Rows[i][2].ToString();
                tmp.dVchContentName = dt.Rows[i][3].ToString();
                tmp.dVchStandardName = dt.Rows[i][4].ToString();
                tmp.dVchBanContent = dt.Rows[i][5].ToString();
                tmp.dVchPartID = dt.Rows[i][6].ToString();
                tmp.dVchContentID = dt.Rows[i][7].ToString();
                tmp.dVchStandardID = dt.Rows[i][8].ToString();
                mLstTCBadNote.Add(tmp);
            }
        }
        return mLstTCBadNote;
    }

    public string GetShowTCBadDataWhere(string v_TCNote, string v_TCDetail)
    {
        string mStrWhere = "";
        if (v_TCNote != null)
        {
            if (mStrWhere != "")
            {
                mStrWhere = mStrWhere + " and t_TCNoteDetailBad.dVchTCNote ='" + v_TCNote + "'";
            }
            else
            {
                mStrWhere = " where t_TCNoteDetailBad.dVchTCNote ='" + v_TCNote + "'";
            }
        }
        if (v_TCDetail != null)
        {
            if (mStrWhere != "")
            {
                mStrWhere = mStrWhere + " and t_TCNoteDetailBad.dVchTCDetail ='" + v_TCDetail + "'";
            }
            else
            {
                mStrWhere = " where t_TCNoteDetailBad.dVchTCDetail ='" + v_TCDetail + "'";
            }
        }
        return mStrWhere;
    }
    
    public bool IsReusable {
        get {
            return false;
        }
    }

}