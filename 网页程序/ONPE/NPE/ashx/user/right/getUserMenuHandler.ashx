<%@ WebHandler Language="C#" Class="getUserMenuHandler" %>

using System;
using System.Web;
using Newtonsoft.Json;
using NPE.UIDataClass;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Generic;
using ModelClass;
using System.Text;
using System.Web.Security;
using System.Web.Script.Serialization;

public class getUserMenuHandler : IHttpHandler
{
    FormsAuthenticationTicket ticket = null;
    FormsIdentity id = null;
    public void ProcessRequest(HttpContext context)
    {
        context.Response.ContentType = "text/plain";
        string action = "";
        int mIntParamNullable = 0;
        if (context.Request.Params["action"] != null)
        {
            action = context.Request.Params["action"].ToString();
        }
        switch (action)
        {
            case "getMenu":
                int m_getmenu_menu_class = 0;
                if (context.Request.Params["menu_class"] != null)
                {
                    if (int.TryParse(context.Request.Params["menu_class"], out m_getmenu_menu_class) == false)
                    {
                        m_getmenu_menu_class = 0; 
                    }
                }
                else
                {
                    mIntParamNullable = mIntParamNullable + 1;
                }
                if (mIntParamNullable == 0)
                {
                    id = (FormsIdentity)context.User.Identity;
                    ticket = id.Ticket;
                    string mStrUerRight = GJHF.Business.User.User.GetUserRight(ticket.UserData, m_getmenu_menu_class, 1, ",");
                    StringBuilder sb = new StringBuilder();
                    sb.Append("{");
                    sb.Append(string.Format("\"selected\":0,\"tabs\":{0}", JsonConvert.SerializeObject(getTabs(mStrUerRight, m_getmenu_menu_class))));
                    sb.Append("}");
                    context.Response.Write(sb.ToString());
                }
                else
                {
                    context.Response.Write(""); 
                }
                break;
            default:

                break;
        }
    }
    private List<tabs> getTabs(string v_user_right, int v_menu_class)
    {
        
        List<tabs> mLstTabs = new List<tabs>();
        string mStrSQL = @" SELECT  t_menugroup.menugroup_id, t_menugroup.menugroup_name,t_menugroup.font_color,t_menugroup.font_size,t_menugroup.background_color
                            FROM    t_menugroup 
                            RIGHT OUTER JOIN
                                    t_rights ON t_menugroup.menugroup_id = t_rights.right_menugroup 
                            WHERE  t_menugroup.menugroup_class=@menu_class and t_rights.right_menu = '' and t_rights.right_code in ('" + v_user_right.Replace(",", "','") + @"')
                            ORDER BY t_menugroup.menugroup_sort ";
                            
        SqlParameter[] parameter = new SqlParameter[]{
            new SqlParameter("@user_right",SqlDbType.VarChar,8000),
            new SqlParameter("@menu_class",SqlDbType.Int,4)
        };
        parameter[0].Value = v_user_right;
        parameter[1].Value = v_menu_class;
        DataTable dt = null;
        using (dt = claSqlConnDB.ExecuteDataset(claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL, parameter).Tables[0])
        {
            if (dt.Rows.Count > 0)
            {
                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    tabs mTabs = new tabs();
                    mTabs.title = dt.Rows[i][1].ToString();
                    mTabs.groups = GetTabsItemGroup(dt.Rows[i][0].ToString(), v_user_right,v_menu_class);
                    mTabs.font_color = dt.Rows[i][2].ToString();
                    mTabs.font_size = dt.Rows[i][3].ToString();
                    mTabs.background_color = dt.Rows[i][4].ToString();
                    mLstTabs.Add(mTabs);
                }
            }
        }
        return mLstTabs;
    }
    private List<tabsItemGroup> GetTabsItemGroup(string v_menugroup_id,string v_user_right,int v_menu_class)
    {
        List<tabsItemGroup> mLstTabsItemGroup = new List<tabsItemGroup>();
        DataTable dt = null;

        string mStrSQL = @"  SELECT    DISTINCT t_menugroup_menu.menu_no
                              FROM     t_rights LEFT OUTER JOIN
                                       t_menugroup_menu ON t_rights.right_menu = t_menugroup_menu.menu_id 
                              WHERE    (t_rights.right_code in ('" + v_user_right.Replace(",", "','") + @"')) 
                              and  t_menugroup_menu.menugroup_id = '" + v_menugroup_id + @"'";
        using (dt = claSqlConnDB.ExecuteDataset(claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL).Tables[0])
        {
            if (dt.Rows.Count > 0)
            {
                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    tabsItemGroup mTabsItemGroup = new tabsItemGroup();
                    mTabsItemGroup.tools = GetTabsItem(v_menugroup_id, dt.Rows[i][0].ToString(), v_user_right, v_menu_class);
                    mTabsItemGroup.text = "";
                    mLstTabsItemGroup.Add(mTabsItemGroup);
                }
            }
        }
        return mLstTabsItemGroup;
    }
    private List<tabsItem> GetTabsItem(string v_menugroup_id, string v_menu_no, string v_user_right,int v_menu_class)
    {
        List<tabsItem> mLstTabsItem = new List<tabsItem>();
        DataTable dt = null;
        string mStrSQL = @" select t_menu.menu_id ,t_menu.menu_link,t_menu.menu_title,t_menu.menu_iconcls,t_menu.menu_iconalign,t_menu.menu_iconsize,
                            t_menu.font_color,t_menu.font_size,t_menu.background_color
                            from 
                                (select t_rights.right_menugroup, t_rights.right_menu from  t_rights 
                                where 	t_rights.right_menugroup = @menugroup_id and t_rights.right_menu<>'' 
                                and t_rights.right_code in ('" + v_user_right.Replace(",", "','") + @"')) t 
                                right outer join t_menu on t.right_menu=t_menu.menu_id 
                                left outer join t_menugroup_menu on t.right_menugroup=t_menugroup_menu.menugroup_id 
                                and  t.right_menu=t_menugroup_menu.menu_id 
                            where t_menugroup_menu.menu_no=@menu_no and t_menu.menu_class=@menu_class order by t_menugroup_menu.menu_sort ";
        SqlParameter[] parameters = {
			new SqlParameter("@menugroup_id", SqlDbType.VarChar,30),
            new SqlParameter("@menu_no", SqlDbType.VarChar,30),
            new SqlParameter("@user_code",SqlDbType.VarChar,30),
            new SqlParameter("@menu_class",SqlDbType.Int,4)
            };
        parameters[0].Value = v_menugroup_id;
        parameters[1].Value = v_menu_no;
        parameters[2].Value = v_user_right;
        parameters[3].Value = v_menu_class;
        using (dt = claSqlConnDB.ExecuteDataset(claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL, parameters).Tables[0])
        {
            if (dt.Rows.Count > 0)
            {
                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    tabsItem mTabsItem = new tabsItem();
                    mTabsItem.name = dt.Rows[i][1].ToString();
                    mTabsItem.text = dt.Rows[i][2].ToString();
                    mTabsItem.iconCls = dt.Rows[i][3].ToString();
                    mTabsItem.iconAlign = dt.Rows[i][4].ToString();
                    mTabsItem.size = dt.Rows[i][5].ToString();
                    mTabsItem.font_color = dt.Rows[i][6].ToString();
                    mTabsItem.font_size = dt.Rows[i][7].ToString();
                    mTabsItem.background_color = dt.Rows[i][8].ToString();
                    mLstTabsItem.Add(mTabsItem);
                }
            }
        }
        return mLstTabsItem;
    }

    public bool IsReusable
    {
        get
        {
            return false;
        }
    }

}