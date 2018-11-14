<%@ WebHandler Language="C#" Class="userHandler" %>

using System;
using System.Web;
using ModelClass;
using Newtonsoft.Json;
using NPE.UIDataClass;
using System.Data;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Web.Security;
using System.Web.Script.Serialization;
using System.Text;

public class userHandler : IHttpHandler
{
    FormsAuthenticationTicket ticket = null;
    FormsIdentity id = null;
    private GJHF.Business.HR.Employee BEmployee;
    public userHandler() {
        this.BEmployee = new GJHF.Business.HR.Employee();
    }
    public void ProcessRequest(HttpContext context)
    {
        string mStrReturn = "";
        context.Response.ContentType = "text/plain";
        string action = "";

        if (context.Request.Params["action"] != null)
        {
            action = context.Request.Params["action"].ToString();
        }
        switch (action.ToLower())
        {
            case "getuserright":
                mStrReturn = GetUserRight(context);
                break;
            case "getemployee":
                string mStrEmployeeInfo = "";
                if (context.User.Identity != null)
                {
                    id = (FormsIdentity)context.User.Identity;
                    ticket = id.Ticket;
                    string mStrUserID = GJHF.Business.User.User.GetUserID(ticket.UserData);
                    mStrEmployeeInfo = GJHF.Utility.WEBUI.EasyuiControl.GetPropReturn(BEmployee.GetEmployeeByToken(mStrUserID));
                }
                mStrReturn="{\"msg\":" + mStrEmployeeInfo + ",\"success\":true}";
                break;
            
            case "grid":
                int page = 1;
                int rows = 10;
                string order = "";
                string sort = "";
                if (context.Request.Params["order"] != null)
                {
                    order = context.Request.Params["order"].ToString();
                }
                if (context.Request.Params["sort"] != null)
                {
                    sort = context.Request.Params["sort"];
                }
                if (context.Request.Params["page"] != null)
                {
                    if (int.TryParse(context.Request.Params["page"], out page) == false)
                    {
                        page = 1;
                    }
                }
                if (context.Request.Params["rows"] != null)
                {
                    if (int.TryParse(context.Request.Params["rows"], out rows) == false)
                    {
                        rows = 10;
                    }
                }
                string m_grid_employee_name = "";
                if (context.Request.Params["employee_name"] != null)
                {
                    m_grid_employee_name = context.Request.Params["employee_name"];
                }

                string m_grid_auto_lock = "";
                if (context.Request.Params["auto_lock"] != null)
                {
                    m_grid_auto_lock = context.Request.Params["auto_lock"];
                }
                mStrReturn = GJHF.Utility.WEBUI.EasyuiControl.GetGridReturn(BEmployee.GetEmployeeCount(m_grid_employee_name, "", "", "", 0, 0, "", 0, ""), BEmployee.GetEmployee(page,rows,m_grid_employee_name, "", "", "", 0, 0, "", 0, "",sort,order));
                break;
            case "operate":
                mStrReturn = AddUserOperateRecord(context);
                break;
            case "confirmpush":
                mStrReturn = ConfirmPush(context);
                break;
            default:
                mStrReturn = GJHF.Utility.WEBUI.EasyuiControl.GetMissParamReturn();
                break;
        }
        context.Response.Write(mStrReturn);
    }
    private string ConfirmPush(HttpContext context)
    {
        string m_push_id = "";
        if (context.Request.Params["push_id"] != null)
        {
            m_push_id = context.Request.Params["push_id"].ToString();
        }
        if (m_push_id == "") return GJHF.Utility.WEBUI.EasyuiControl.GetReturn(false, "缺少push_id", false);
        string m_user_id = "";
        if (context.User.Identity != null)
        {
            id = (FormsIdentity)context.User.Identity;
            ticket = id.Ticket;
            m_user_id = GJHF.Business.User.User.GetUserID(ticket.UserData);
        }
        if (m_user_id == "") return GJHF.Utility.WEBUI.EasyuiControl.GetReturn(false, "缺少Cookies", false);
        DateTime m_confirm_time = System.DateTime.Now;
        int i = GJHF.Business.PUSH.PushMessage.ConfirmPush(m_push_id, m_user_id, m_confirm_time);
        if (i == 1)
        {
            return GJHF.Utility.WEBUI.EasyuiControl.GetReturn(true, "推送消息确认操作成功", false);
        }
        else
        {
            return GJHF.Utility.WEBUI.EasyuiControl.GetReturn(false, "收到推送消息确认操作失败", false);
        }
    }
    private string GetUserRight(HttpContext context)
    {
        string mStrRights = "";
        if (context.User.Identity != null)
        {
            int m_get_right_class = 0;
            if (context.Request.Params["right_class"] != null)
            {
                m_get_right_class = int.Parse(context.Request.Params["right_class"]);
            }
            if (m_get_right_class == 0) return GJHF.Utility.WEBUI.EasyuiControl.GetParamFailRetuen();

            int m_get_right_type = 0;
            if (context.Request.Params["right_type"] != null)
            {
                m_get_right_type = int.Parse(context.Request.Params["right_type"]);
            }
            if (m_get_right_type == 0) return GJHF.Utility.WEBUI.EasyuiControl.GetParamFailRetuen();
            string m_get_right_spara = ",";
            if (context.Request.Params["right_para"] != null)
            {
                m_get_right_spara = context.Request.Params["right_para"];
            }
            id = (FormsIdentity)context.User.Identity;
            ticket = id.Ticket;
            mStrRights = GJHF.Business.User.User.GetUserRight(ticket.UserData, m_get_right_class, m_get_right_type, m_get_right_spara);
        }
        else
        {
            return GJHF.Utility.WEBUI.EasyuiControl.GetParamFailRetuen();
        }
        return GJHF.Utility.WEBUI.EasyuiControl.GetReturn(true, mStrRights, false);
    }
    
    ///// <summary>
    ///// 添加用户登录记录
    ///// </summary>
    ///// <param name="v_user_code">用户编号</param>
    ///// <param name="v_equip_type">设备类型 1 PC端 2 手机端 3 其他</param>
    ///// <param name="v_equip_sign">设备标识</param>
    ///// <param name="v_login_time">登录时间</param>
    ///// <param name="v_way_type">登录方式类型 1 浏览器 2 应用程序 3 其他</param>
    ///// <param name="v_way_sign">登录方式标识</param>
    ///// <param name="v_login_remark">登录说明</param>
    ///// <returns></returns>
    //private int AddUserLoginRecord(string v_user_code, int v_equip_type, string v_equip_sign, string v_login_time, int v_way_type, string v_way_sign, string v_login_remark)
    //{
    //    SqlParameter[] parameters = {
    //                     new SqlParameter("@vi_user_code", SqlDbType.VarChar,30) ,            
    //                     new SqlParameter("@vi_equip_type", SqlDbType.Int,4) ,            
    //                     new SqlParameter("@vi_equip_sign", SqlDbType.VarChar,50) ,            
    //                     new SqlParameter("@vi_login_time", SqlDbType.DateTime) ,            
    //                     new SqlParameter("@vi_way_type", SqlDbType.Int,4) ,                  
    //                     new SqlParameter("@vi_way_sign", SqlDbType.VarChar,50) ,            
    //                     new SqlParameter("@vi_login_remark", SqlDbType.VarChar,100),
    //                     new SqlParameter("@vo_return",SqlDbType.Int,4)
    //        };

    //    parameters[0].Value = v_user_code;
    //    parameters[1].Value = v_equip_type;
    //    parameters[2].Value = v_equip_sign;
    //    parameters[3].Value = v_login_time;
    //    parameters[4].Value = v_way_type;
    //    parameters[5].Value = v_way_sign;
    //    parameters[6].Value = v_login_remark;
    //    parameters[7].Direction = System.Data.ParameterDirection.Output;
    //    claSqlConnDB.ExecuteNonQuery(claSqlConnDB.gStrConnDefault, CommandType.StoredProcedure,"p_add_login_record",parameters);
    //    int i = (int)parameters[7].Value;
    //    return i;
    //}
    private string AddUserOperateRecord(HttpContext context)
    {
        string m_user_id = "";
        if (context.User.Identity != null)
        {
            id = (FormsIdentity)context.User.Identity;
            ticket = id.Ticket;
            m_user_id = GJHF.Business.User.User.GetUserID(ticket.UserData);
        }
        if (m_user_id == "") return GJHF.Utility.WEBUI.EasyuiControl.GetParamFailRetuen();
        string m_employee_name="";
        if (context.Request.Params["employee_name"] != null)
        {
            m_employee_name = context.Request.Params["employee_name"];
        }
        int m_equip_type=0;
        if (context.Request.Params["equip_type"] != null)
        {
            if (int.TryParse(context.Request.Params["equip_type"], out m_equip_type) == false)
            {
                m_equip_type = 0; 
            }
        }
        if (m_equip_type == 0) return GJHF.Utility.WEBUI.EasyuiControl.GetParamFailRetuen();
        string m_equip_sign="";
        if (context.Request.Params["equip_sign"] != null)
        {
            m_equip_sign = context.Request.Params["equip_sign"];
        }
        int m_way_type=0;
        if (context.Request.Params["way_type"] != null)
        {
            if (int.TryParse(context.Request.Params["way_type"], out m_way_type) == false)
            {
                m_way_type = 0;
            }
        }
        if (m_way_type == 0) return GJHF.Utility.WEBUI.EasyuiControl.GetParamFailRetuen();
        string m_way_sign="";
        if (context.Request.Params["way_sign"] != null)
        {
            m_way_sign = context.Request.Params["way_sign"];
        }
        string m_menu_link="";
        if (context.Request.Params["menu_link"] != null)
        {
            m_menu_link = context.Request.Params["menu_link"];
        }
        string m_menu_title="";
        if (context.Request.Params["menu_title"] != null)
        {
            m_menu_title = context.Request.Params["menu_title"];
        }
        string m_menu_extra="";
        if (context.Request.Params["menu_extra"] != null)
        {
            m_menu_extra = context.Request.Params["menu_extra"];
        }
        string m_operate_remark = "";
        if (context.Request.Params["operate_remark"] != null)
        {
            m_operate_remark = context.Request.Params["operate_remark"];
        }
        int mIntReturn = GJHF.Business.User.User.AddUserOperateRecord(m_user_id, m_employee_name, m_equip_type, m_equip_sign, m_way_type, m_way_sign, m_menu_link, m_menu_title, m_menu_extra, m_operate_remark);
        return GJHF.Utility.WEBUI.EasyuiControl.GetAddReturn(mIntReturn, 1);
    }
    
//    /// <summary>
//    /// 用户登录
//    /// </summary>
//    /// <param name="vStrUserName">用户名</param>
//    /// <param name="vStrPWD">密码</param>
//    /// <returns></returns>
//    [Obsolete("该方法已过期，请使用LoginUser！", true)]
//    private useremployee LoginUserInfo(string vStrUserName, string vStrPWD)
//    {
//        useremployee mUserEmployee = new useremployee();
//        string mStrSQL = @"SELECT     t_User.user_code, t_User.user_name, t_User.auto_lock, t_User.user_state, t_User.create_time, t_User.lastlogin_time, t_User.login_num, t_User.login_address, 
//                                      t_User.user_remark, t_Employee.employee_code, t_Employee.employee_Name, tHRBranchInfo.dIntBranchID AS branch_id, tHRBranchInfo.dVchBranchName AS branch_name, 
//                                      tHRCompany.dIntCompanyID AS company_id, tHRCompany.dVchCompanyName AS company_name, t_User.login_time
//                            FROM         t_User LEFT OUTER JOIN
//                                      tHRCompany RIGHT OUTER JOIN
//                                      tHRBranchInfo ON tHRCompany.dIntCompanyID = tHRBranchInfo.dIntCompanyID RIGHT OUTER JOIN
//                                      t_Employee ON tHRBranchInfo.dIntBranchID = t_Employee.branch_id RIGHT OUTER JOIN
//                                      t_EmployeeUser ON t_Employee.employee_code = t_EmployeeUser.employee_code ON t_User.user_code = t_EmployeeUser.user_code 
//                            WHERE     t_User.user_name='" + vStrUserName + "' AND CONVERT(VARCHAR(MAX),CONVERT(VARCHAR(MAX ),DECRYPTBYCERT(CERT_ID('GjhfRight'),t_User.user_pwd,N'<GJHF>1478963250')))='" + vStrPWD + "'";
//        DataTable dt = null;
//        using (dt = claSqlConnDB.ExecuteDataset(claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL).Tables[0])
//        {
//            if (dt.Rows.Count > 0)
//            {
//                for (int i = 0; i < dt.Rows.Count; i++)
//                {
//                    mUserEmployee.user_code = dt.Rows[i][0].ToString();
//                    mUserEmployee.user_name = dt.Rows[i][1].ToString();
//                    mUserEmployee.user_pwd = vStrPWD;
//                    if ("" != dt.Rows[i][2].ToString())
//                    {
//                        mUserEmployee.auto_lock = int.Parse(dt.Rows[i][2].ToString());
//                    }
//                    else
//                    {
//                        mUserEmployee.auto_lock = 0;
//                    }
//                    if ("" != dt.Rows[i][3].ToString())
//                    {
//                        mUserEmployee.user_state = int.Parse(dt.Rows[i][3].ToString());
//                    }
//                    else
//                    {
//                        mUserEmployee.user_state = 0;
//                    }
//                    mUserEmployee.create_time = DateTime.Parse(dt.Rows[i][4].ToString());
//                    mUserEmployee.lastlogin_time = DateTime.Parse(dt.Rows[i][5].ToString());
//                    mUserEmployee.login_num = long.Parse(dt.Rows[i][6].ToString());
//                    mUserEmployee.login_address = dt.Rows[i][7].ToString();
//                    mUserEmployee.user_remark = dt.Rows[i][8].ToString();
//                    mUserEmployee.employee_code = dt.Rows[i][9].ToString();
//                    mUserEmployee.employee_name = dt.Rows[i][10].ToString();
//                    mUserEmployee.branch_id = dt.Rows[i][11].ToString();
//                    mUserEmployee.branch_name = dt.Rows[i][12].ToString();
//                    mUserEmployee.company_id = dt.Rows[i][13].ToString();
//                    mUserEmployee.company_name = dt.Rows[i][14].ToString();
//                    mUserEmployee.login_time = DateTime.Parse(dt.Rows[i][15].ToString());
//                }
//            }
//        }
//        return mUserEmployee;
//    }

//    /// <summary>
//    /// 注销用户
//    /// </summary>
//    /// <param name="v_user_code">用户编号</param>
//    /// <param name="v_equip_type">设备类型 1 PC端 2 手机端 3 其他</param>
//    /// <param name="v_way_type">登录方式类型 1 浏览器 2 应用程序 3 其他</param>
//    /// <param name="logout_time">注销时间</param>
//    /// <returns></returns>
//    private int UserLogOut(string v_user_code, int v_equip_type, int v_way_type,string v_logout_time)
//    {
//        string mStrSQL = "";
//        mStrSQL = @"UPDATE t_UserLoginRecord set logout_time=@logout_time 
//                   where user_code=@user_code
//                    AND  equip_type=@equip_type
//                    AND  way_type=@way_type 
//                    AND  logout_time IS NULL";
//        SqlParameter[] paramater = new SqlParameter[]{
//            new SqlParameter("@user_code",SqlDbType.VarChar,30),
//            new SqlParameter("@equip_type",SqlDbType.Int,4),
//            new SqlParameter("@way_type",SqlDbType.Int,4),
//            new SqlParameter("@logout_time",SqlDbType.DateTime)
//        };
//        paramater[0].Value = v_user_code;
//        paramater[1].Value = v_equip_type;
//        paramater[2].Value = v_way_type;
//        paramater[3].Value = v_logout_time;
//        int i = claSqlConnDB.ExecuteNonQuery(claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL, paramater);
//        return i; 
//    } 
//    /// <summary>
//    /// 根据用户编号获取用户信息
//    /// </summary>
//    /// <param name="vStrUserCode">用户编号</param>
//    /// <returns>用户信息</returns>
//    private useremployee GetUserInfo(string vStrUserCode)
//    {
//        useremployee mUserEmployee = new useremployee();
//        string mStrSQL = @"SELECT     t_User.user_code, t_User.user_name, t_User.auto_lock, t_User.user_state, t_User.create_time, t_User.lastlogin_time, t_User.login_num, t_User.login_address, 
//                                      t_User.user_remark, t_Employee.employee_code, t_Employee.employee_Name, tHRBranchInfo.dIntBranchID AS branch_id, tHRBranchInfo.dVchBranchName AS branch_name, 
//                                      tHRCompany.dIntCompanyID AS company_id, tHRCompany.dVchCompanyName AS company_name, t_User.login_time,t_Employee.major_code,t_major.major_innum,
//                                      t_major.major_name,t_Employee.patrolgrade_id,t_PatrolGrade.patrolgrade_name
//                            FROM         t_User LEFT OUTER JOIN
//                                      tHRCompany RIGHT OUTER JOIN
//                                      tHRBranchInfo ON tHRCompany.dIntCompanyID = tHRBranchInfo.dIntCompanyID RIGHT OUTER JOIN
//                                      t_Employee ON tHRBranchInfo.dIntBranchID = t_Employee.branch_id RIGHT OUTER JOIN
//                                      t_EmployeeUser ON t_Employee.employee_code = t_EmployeeUser.employee_code ON t_User.user_code = t_EmployeeUser.user_code 
//                                      LEFT OUTER JOIN t_major on t_Employee.major_code=t_major.major_code
//                                      LEFT OUTER JOIN t_PatrolGrade ON t_Employee.patrolgrade_id=t_PatrolGrade.patrolgrade_id
//                            where     t_User.user_code='" + vStrUserCode + "'";
//        DataTable dt = null;
//        using (dt = claSqlConnDB.ExecuteDataset(claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL).Tables[0])
//        {
//            if (dt.Rows.Count > 0)
//            {
//                for (int i = 0; i < dt.Rows.Count; i++)
//                {
//                    mUserEmployee.user_code = dt.Rows[i][0].ToString();
//                    mUserEmployee.user_name = dt.Rows[i][1].ToString();
//                    if ("" != dt.Rows[i][2].ToString())
//                    {
//                        mUserEmployee.auto_lock = int.Parse(dt.Rows[i][2].ToString());
//                    }
//                    else
//                    {
//                        mUserEmployee.auto_lock = 0;
//                    }
//                    if ("" != dt.Rows[i][3].ToString())
//                    {
//                        mUserEmployee.user_state = int.Parse(dt.Rows[i][3].ToString());
//                    }
//                    else
//                    {
//                        mUserEmployee.user_state = 0;
//                    }
//                    mUserEmployee.create_time = DateTime.Parse(dt.Rows[i][4].ToString());
//                    mUserEmployee.lastlogin_time = DateTime.Parse(dt.Rows[i][5].ToString() == "" ? "1900-01-01" : dt.Rows[i][5].ToString());
//                    mUserEmployee.login_num = long.Parse(dt.Rows[i][6].ToString() == "" ? "0" : dt.Rows[i][6].ToString());
//                    mUserEmployee.login_address = dt.Rows[i][7].ToString();
//                    mUserEmployee.user_remark = dt.Rows[i][8].ToString();
//                    mUserEmployee.employee_code = dt.Rows[i][9].ToString();
//                    mUserEmployee.employee_name = dt.Rows[i][10].ToString();
//                    mUserEmployee.branch_id = dt.Rows[i][11].ToString();
//                    mUserEmployee.branch_name = dt.Rows[i][12].ToString();
//                    mUserEmployee.company_id = dt.Rows[i][13].ToString();
//                    mUserEmployee.company_name = dt.Rows[i][14].ToString();
//                    mUserEmployee.login_time = DateTime.Parse(dt.Rows[i][15].ToString() == "" ? "1900-01-01" : dt.Rows[i][15].ToString());
//                    mUserEmployee.major_code = dt.Rows[i][16].ToString();
//                    mUserEmployee.major_name = dt.Rows[i][18].ToString();
//                    mUserEmployee.patrolgrade_id = dt.Rows[i][19].ToString();
//                    mUserEmployee.patrolgrade_name = dt.Rows[i][20].ToString();
//                }
//            }
//        }
//        return mUserEmployee;
//    }
    ///// <summary>
    ///// 添加员工账号
    ///// </summary>
    ///// <param name="vStrUserName">账号名称</param>
    ///// <param name="vStrUserPwd">账号密码</param>
    ///// <param name="vStrEmployeeCode">员工编号</param>
    ///// <returns>
    ///// -9 添加失败
    ///// -1 已存在该员工的账号
    ///// 0 添加成功
    ///// </returns>
    //private string addNewUser(string vStrUserName, string vStrUserPwd, string vStrEmployeeCode)
    //{
    //    int mIntReturn;
    //    SqlParameter[] l0lcParameter = new SqlParameter[5]
    //        {
    //            new SqlParameter("@viVchEmployeeID",SqlDbType.VarChar,30),
    //            new SqlParameter("@viVchUserName",SqlDbType.VarChar,20),
    //            new SqlParameter("@viVchUserPwd",SqlDbType.VarChar,100),
    //            new SqlParameter("@viDtmUserCreateTime",SqlDbType.DateTime),
    //            new SqlParameter("@voIntReturn",SqlDbType.Int),
    //        };
    //    l0lcParameter[0].Value = vStrEmployeeCode;
    //    l0lcParameter[1].Value = vStrUserName;
    //    l0lcParameter[2].Value = vStrUserPwd;
    //    l0lcParameter[3].Value = System.DateTime.Now;
    //    l0lcParameter[4].Direction = System.Data.ParameterDirection.Output;
    //    claSqlConnDB.ExecuteNonQuery(claSqlConnDB.gStrConnDefault, CommandType.StoredProcedure, "pSSHUserAdd", l0lcParameter);
    //    mIntReturn = (int)l0lcParameter[4].Value;
    //    return mIntReturn.ToString();
    //}
    ///// <summary>
    ///// 修改用户密码
    ///// </summary>
    ///// <param name="vStrUserCode">用户编号</param>
    ///// <param name="vStrNewPassWord">新密码</param>
    ///// <returns>
    ///// 0 修改成功
    ///// 非0 修改失败
    ///// </returns>
    //private string editUserPwd(string vStrUserCode, string vStrNewPassWord)
    //{
    //    int mIntReturn;
    //    SqlParameter[] l0lcParameter = new SqlParameter[3]
    //        {
    //            new SqlParameter("@viVchUserCode",SqlDbType.VarChar,30),
    //            new SqlParameter("@viVchNewUserPwd",SqlDbType.VarChar,100),
    //            new SqlParameter("@voIntReturn",SqlDbType.Int),
    //        };
    //    l0lcParameter[0].Value = vStrUserCode;
    //    l0lcParameter[1].Value = vStrNewPassWord;
    //    l0lcParameter[2].Direction = System.Data.ParameterDirection.Output;
    //    claSqlConnDB.ExecuteNonQuery(claSqlConnDB.gStrConnDefault, CommandType.StoredProcedure, "pSSHUpdateUserPwd", l0lcParameter);
    //    mIntReturn = (int)l0lcParameter[2].Value;
    //    return mIntReturn.ToString();
    //}
    ///// <summary>
    ///// 删除用户
    ///// </summary>
    ///// <param name="v_user_code">用户编号</param>
    ///// <returns></returns>
    //private int DelUserData(string v_user_code)
    //{
    //    StringBuilder strSql = new StringBuilder();
    //    strSql.Append("DELETE FROM t_User WHERE ");
    //    strSql.Append(" user_code=@user_code");
    //    SqlParameter[] parameters = {
    //                   new SqlParameter("@user_code", SqlDbType.VarChar,30)       
    //        };
    //    parameters[0].Value = v_user_code;
    //    int i = claSqlConnDB.ExecuteNonQuery(claSqlConnDB.gStrConnDefault, CommandType.Text, strSql.ToString(), parameters);
    //    return i;
    //}
    

//    /// <summary>
//    /// 根据用户编号获取员工信息
//    /// </summary>
//    /// <param name="v_user_code">用户编号</param>
//    /// <returns>员工信息</returns>
//    private employee GetUserEmployeeByUserCode(string v_user_code)
//    {
//        employee mEmployee = new employee();
//        string mStrSQL = @"SELECT tHRCompany.dVchCompanyName as company_name, tHRBranchInfo.dVchBranchName as branch_name,t_Employee.employee_Name,
//		                           case t_Employee.birthday_date when '1900-01-01 00:00:00' then '未知' else cast(DATEDIFF(YEAR,t_Employee.birthday_date,GETDATE()) as varchar(4)) end as employee_age , 
//		                           t_Employee.employee_sex,t_Employee.major_code,t_major.major_innum,t_major.major_name,t_Employee.patrolgrade_id,t_PatrolGrade.patrolgrade_name
//                             FROM     t_EmployeeUser 
//                             LEFT OUTER JOIN  tHRBranchInfo 
//                                              LEFT OUTER JOIN tHRCompany ON tHRBranchInfo.dIntCompanyID = tHRCompany.dIntCompanyID 
//                                              RIGHT OUTER JOIN t_Employee ON tHRBranchInfo.dIntBranchID = t_Employee.branch_id 
//                             ON t_EmployeeUser.employee_code = t_Employee.employee_code
//                             LEFT OUTER JOIN t_major on t_Employee.major_code=t_major.major_code
//                             LEFT OUTER JOIN t_PatrolGrade ON t_Employee.patrolgrade_id=t_PatrolGrade.patrolgrade_id
//                            WHERE     t_EmployeeUser.user_code=@user_code";
//        SqlParameter[] parameters = {
//                       new SqlParameter("@user_code", SqlDbType.VarChar,30)
//            };
//        parameters[0].Value = v_user_code;
//        mEmployee = (employee)claSqlConnDB.GetDetail(claSqlConnDB.gStrConnDefault, mStrSQL, "ModelClass.employee", parameters);
//        return mEmployee;
//    }

//    private int EditUserStatus(string v_user_code, string v_auto_lock, string v_user_status, string v_user_remark)
//    {
//        StringBuilder strSql = new StringBuilder();
//        strSql.Append(" UPDATE t_User SET ");
//        strSql.Append(" auto_lock=@auto_lock, ");
//        strSql.Append(" user_state=@user_status, ");
//        strSql.Append(" user_remark=@user_remark ");
//        strSql.Append(" WHERE user_code=@user_code");
//        SqlParameter[] parameters = {
//                       new SqlParameter("@user_code", SqlDbType.VarChar,30), 
//                       new SqlParameter("@auto_lock", SqlDbType.Int,4), 
//                       new SqlParameter("@user_status", SqlDbType.Int,4),
//                       new SqlParameter("@user_remark", SqlDbType.VarChar,200)
//            };
//        parameters[0].Value = v_user_code;
//        parameters[1].Value = v_auto_lock;
//        parameters[2].Value = v_user_status;
//        parameters[3].Value = v_user_remark;
//        int i = claSqlConnDB.ExecuteNonQuery(claSqlConnDB.gStrConnDefault, CommandType.Text, strSql.ToString(), parameters);
//        return i;
//    }
    
    
    public bool IsReusable
    {
        get
        {
            return false;
        }
    }

}


//case "login":
//                int m_login_equip_type = 0;
//                if (context.Request.Params["equip_type"] != null)
//                {
//                    if (int.TryParse(context.Request.Params["equip_type"].ToString(), out m_login_equip_type) == false)
//                    {
//                        mIntParaNullable = mIntParaNullable + 1;
//                    }
//                }
//                else
//                {
//                    mIntParaNullable = mIntParaNullable + 1; 
//                }
//                string m_login_equip_sign = "";
//                if (context.Request.Params["equip_sign"] != null)
//                {
//                    m_login_equip_sign = context.Request.Params["equip_sign"].ToString();
//                }
//                else
//                {
//                    mIntParaNullable = mIntParaNullable + 1; 
//                }
//                int m_login_way_type = 0;
//                if (context.Request.Params["way_type"] != null)
//                {
//                    if (int.TryParse(context.Request.Params["way_type"].ToString(), out m_login_way_type) == false)
//                    {
//                        mIntParaNullable = mIntParaNullable + 1;
//                    }
//                }
//                else
//                {
//                    mIntParaNullable = mIntParaNullable + 1; 
//                }
//                string m_login_way_sign = "";
//                if (context.Request.Params["way_sign"] != null)
//                {
//                    m_login_way_sign = context.Request.Params["way_sign"].ToString();
//                }
//                else
//                {
//                    m_login_way_sign = "";
//                }
//                string m_login_user_name = "";
//                if (context.Request.Params["user_name"] != null)
//                {
//                    m_login_user_name = context.Request.Params["user_name"].ToString();
//                }
//                else
//                {
//                    mIntParaNullable = mIntParaNullable + 1;
//                }
//                string m_login_user_pwd = "";
//                if (context.Request.Params["user_pwd"] != null)
//                {
//                    m_login_user_pwd = context.Request.Params["user_pwd"].ToString();
//                }
//                else
//                {
//                    mIntParaNullable = mIntParaNullable + 1;
//                }
//                string m_login_remember_pwd = "";
//                DateTime m_login_login_time = DateTime.Now;
//                DateTime m_expiration_time;
//                if (context.Request.Params["remember_pwd"] != null)
//                {
//                    m_login_remember_pwd = context.Request.Params["remember_pwd"].ToString();
//                }
//                switch (m_login_remember_pwd)
//                {
//                    case "0":
//                        m_expiration_time = m_login_login_time.AddMinutes(30);
//                        break;
//                    case "1":
//                        m_expiration_time = m_login_login_time.AddHours(3);
//                        break;
//                    case "2":
//                        m_expiration_time = m_login_login_time.AddDays(1);
//                        break;
//                    case "3":
//                        m_expiration_time = m_login_login_time.AddYears(99);
//                        break;
//                    default:
//                        m_expiration_time = m_login_login_time.AddMinutes(30);
//                        break;
//                }
//                if (mIntParaNullable == 0)
//                {
//                    useremployee mUserEmployee_login = null;//LoginUser(m_login_user_name, m_login_user_pwd);
//                    if (mUserEmployee_login.user_code == null)
//                    {
//                        FormsAuthentication.SignOut();
//                        context.Response.Write("{\"msg\":\"用户名或密码错误！\",\"success\":false}");
//                    }
//                    else if (mUserEmployee_login.user_state == 1)
//                    {
//                        FormsAuthentication.SignOut();
//                        context.Response.Write("{\"msg\":\"该用户账号已被锁定！\",\"success\":false}");
//                    }
//                    else if (mUserEmployee_login.user_state == -1)
//                    {
//                        FormsAuthentication.SignOut();
//                        context.Response.Write("{\"msg\":\"该用户账号已被注销！\",\"success\":false}");
//                    }
//                    else
//                    {
//                        mUserEmployee_login.user_pwd = m_login_user_pwd;
//                        ticket = new FormsAuthenticationTicket(
//                            2,
//                            m_login_user_name,
//                            m_login_login_time,
//                            m_expiration_time,
//                            false,
//                            JsonConvert.SerializeObject(mUserEmployee_login));
//                        string mStrTicket = FormsAuthentication.Encrypt(ticket);
//                        HttpCookie cookie = new HttpCookie(FormsAuthentication.FormsCookieName, mStrTicket);
//                        cookie.Expires = m_expiration_time;
//                        context.Response.Cookies.Add(cookie);
//                        context.Response.Write("{\"msg\":\"登陆成功\",\"success\":true}");
                        
//                        int i = AddUserLoginRecord(mUserEmployee_login.user_code, m_login_equip_type, m_login_equip_sign, m_login_login_time.ToString(), m_login_way_type, m_login_way_sign, "");
//                    }
//                }
//                else
//                {
//                    context.Response.Write("{\"msg\":\"缺少必要参数！\",\"success\":false}");
//                }
//                break;