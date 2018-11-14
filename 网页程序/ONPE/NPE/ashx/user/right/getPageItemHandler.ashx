<%@ WebHandler Language="C#" Class="getPageItemHandler" %>

using System;
using System.Web;
using Newtonsoft.Json;
using NPE.UIDataClass;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Generic;
using ModelClass;
using System.Text;

public class getPageItemHandler : IHttpHandler {
    
    public void ProcessRequest (HttpContext context) {
        context.Response.ContentType = "text/plain";
        string action = "";
        object mObjDetail = null;
        string mStrReturn = "";
        if (context.Request.Params["action"] != null)
        {
            action = context.Request.Params["action"]; 
        }
        switch (action)
        {
            case "getItem":
                string m_get_user_code = "";
                if (context.Request.Params["user_code"] != null)
                {
                    m_get_user_code = context.Request.Params["user_code"]; 
                }
                string m_get_menu_code = "";
                if (context.Request.Params["menu_code"] != null)
                {
                    m_get_menu_code = context.Request.Params["menu_code"];
                    mObjDetail = GetPageItem(m_get_user_code, m_get_menu_code);
                    mStrReturn = "{\"success\":true,\"msg\":" + JsonConvert.SerializeObject(mObjDetail) + "}";
                }
                else
                {
                    mStrReturn = "{\"success\":false,\"msg\":\"缺少必要的参数\"}";
                }
                break;
            default:
                break; 
        }
        context.Response.Write(mStrReturn);
    }

    private  List<pageItemModel> GetPageItem(string vStrUserID, string vStrMenuCode)
    {
        List<pageItemModel> mLstPageItem = new List<pageItemModel>();
        DataTable dt = null;
        string mStrSQL = @"";
        using (dt = claSqlConnDB.ExecuteDataset(claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL).Tables[0])
        {
            
                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    pageItemModel mPageItemModel = new pageItemModel();
                    mPageItemModel.text = dt.Rows[i][0].ToString();
                    mPageItemModel.iconCls = dt.Rows[i][1].ToString();
                    mPageItemModel.handler = dt.Rows[i][2].ToString();
                    mLstPageItem.Add(mPageItemModel);
                }
        }
        return mLstPageItem;
    }
    public bool IsReusable {
        get {
            return false;
        }
    }

}