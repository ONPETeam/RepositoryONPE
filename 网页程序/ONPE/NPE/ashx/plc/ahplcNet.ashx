<%@ WebHandler Language="C#" Class="ahplcNet" %>

using System;
using System.Web;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using Newtonsoft.Json;
using ModelClass;
using System.Text;
using NPE.UIDataClass;

public class ahplcNet : IHttpHandler {

    string sort = "";
    string order = "";

    int page = 1;
    int rows = 10;
    
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
        if (context.Request.Form["page"] != null)
        {
            page = int.Parse(context.Request.Form["page"]);//页码
        }
        if (context.Request.Form["rows"] != null)
        {
            rows = int.Parse(context.Request.Form["rows"]);//页容量
        }

        if (context.Request.Params["action"] != null)
        {
            action = context.Request.Params["action"];
        }

        switch (action)
        {
            case "grid":
                System.Text.StringBuilder sb = new System.Text.StringBuilder();
                sb.Append("{ ");
                sb.Append(string.Format("\"total\":{0},\"rows\":", GetRecord()));
                string s = getGrid();
                sb.Append(s);
                sb.Append("}");
                context.Response.Write(sb.ToString());
                break;
            case "IpTypebox":
                context.Response.Write(this.GetIPTypeCombobox());
                break;
            //case "cboxgzfl":
            //    context.Response.Write(this.GetComboboxGzfl());
            //    break;
            case "add":
                Add(context);
                break;
            case "Edit":
                Edit(context);
                break;
            case "Del":
                Del(context);
                break;
            default:
                break;
        }
    }

    //Grid显示
    private string getGrid()
    {
        StringBuilder sb = new StringBuilder();
        List<plcNet> Grid = new List<plcNet>();
        string lStrSql = @"select dIntDataID,dVchName,dVchIP,dVchState,tZIPType.dIntType,tZIPType.dVchType,dIntAreaOrXt,t_XJPointType.dVchPointType from tZNetIP 
                            left outer join tZIPType on tZNetIP.dIntType = tZIPType.dIntType
                            left outer join t_XJPointType on tZNetIP.dIntAreaOrXt = t_XJPointType.dIntNoteID " + GetWhere() + GetOrder();

        DataTable dt = null;
        using (dt = claSqlConnDB.ExecuteDataset(rows, page, claSqlConnDB.gStrConnDefault, CommandType.Text, lStrSql).Tables[0])
        {
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                plcNet mModel = new plcNet();
                if(dt.Rows[i][0].ToString() != "")
                {
                    mModel.dIntDataID = (int)dt.Rows[i][0];
                }
                mModel.dVchName = dt.Rows[i][1].ToString();
                mModel.dVchIP = dt.Rows[i][2].ToString();
                mModel.dVchState = dt.Rows[i][3].ToString();
                if(dt.Rows[i][4].ToString() != "")
                {
                    mModel.dIntType = (int)dt.Rows[i][4];
                }
                mModel.dVchType = dt.Rows[i][5].ToString();
                if (dt.Rows[i][6].ToString() != "")
                {
                    mModel.dIntAreaOrXt = (int)dt.Rows[i][6]; 
                }
                mModel.dVchPointType = dt.Rows[i][7].ToString();
                Grid.Add(mModel);
            }
        }
        return JsonConvert.SerializeObject(Grid);
    }

    private string GetRecord()
    {
        string total = "";
        total = claSqlConnDB.GetRecordCount(claSqlConnDB.gStrConnDefault, "select count(*) from tZNetIP " + GetWhere()).ToString();
        return total;
    }
    private string GetWhere()
    {
        string mStrWhere = "";

        return mStrWhere;
    }
    private string GetOrder()
    {
        string mStrOrder = "order by dIntDataID desc ";
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

    //IP类型Combobox显示
    private string GetIPTypeCombobox()
    {
        StringBuilder sb = new StringBuilder();
        List<IPType> mlist = new List<IPType>();
        string lStrSql = @"select dIntType,dVchType from tZIPType ";

        DataTable dt = null;
        using (dt = claSqlConnDB.ExecuteDataset(claSqlConnDB.gStrConnDefault, CommandType.Text, lStrSql).Tables[0])
        {
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                IPType mModel = new IPType();
                if (dt.Rows[i][0].ToString() != "")
                {
                    mModel.dIntType = (int)dt.Rows[i][0];
                }
                mModel.dVchType = dt.Rows[i][1].ToString();
                mlist.Add(mModel);
            }
        }
        return JsonConvert.SerializeObject(mlist);
    }
    
    //添加
    private void Add(HttpContext context)
    {
        string mStrName = context.Request.Form["nName"];
        string mStrIP = context.Request.Form["nIP"];
        int mIntType = Int32.Parse(context.Request.Form["nLb"]);
        int mIntAreaOrXt = Int32.Parse(context.Request.Form["nXT"]);
        string mStrState = "";
        int voIntReturn;
        
        SqlParameter[] myParameter = new SqlParameter[6]
        {
              new SqlParameter("@viVchName",SqlDbType.VarChar,50),
              new SqlParameter("@viVchIP",SqlDbType.VarChar,50),
              new SqlParameter("@viIntType",SqlDbType.Int,4),
              new SqlParameter("@viIntAreaOrXt",SqlDbType.Int,4),
              new SqlParameter("@viVchState",SqlDbType.VarChar,20),
              new SqlParameter("@voIntReturn",SqlDbType.Int,4),
              
        };

        myParameter[0].Value = mStrName;
        myParameter[1].Value = mStrIP;
        myParameter[2].Value = mIntType;
        myParameter[3].Value = mIntAreaOrXt;
        myParameter[4].Value = mStrState;
        myParameter[5].Direction = ParameterDirection.Output;
        claSqlConnDB.ExecuteNonQuery(claSqlConnDB.gStrConnDefault, CommandType.StoredProcedure, "pZNetIPAdd", myParameter);
        voIntReturn = (int)myParameter[5].Value;
        if (voIntReturn == 0)
        {
            context.Response.Write(voIntReturn);
        }

    }

    //编辑
    private void Edit(HttpContext context)
    {
        int mIntDataID = Int32.Parse(context.Request.Params["vID"]);
        string mStrName = context.Request.Form["nName"];
        string mStrIP = context.Request.Form["nIP"];
        int mIntType = Int32.Parse(context.Request.Form["nLb"]);
        int mIntAreaOrXt = Int32.Parse(context.Request.Form["nXT"]);
        string mStrState = "";
        int voIntReturn;

        SqlParameter[] myParameter = new SqlParameter[7]
        {
              new SqlParameter("@viIntDataID",SqlDbType.Int,4),
              new SqlParameter("@viVchName",SqlDbType.VarChar,50),
              new SqlParameter("@viVchIP",SqlDbType.VarChar,50),
              new SqlParameter("@viIntType",SqlDbType.Int,4),
              new SqlParameter("@viIntAreaOrXt",SqlDbType.Int,4),
              new SqlParameter("@viVchState",SqlDbType.VarChar,20),
              new SqlParameter("@voIntReturn",SqlDbType.Int,4),
            
        };

        myParameter[0].Value = mIntDataID;
        myParameter[1].Value = mStrName;
        myParameter[2].Value = mStrIP;
        myParameter[3].Value = mIntType;
        myParameter[4].Value = mIntAreaOrXt;
        myParameter[5].Value = mStrState;
        myParameter[6].Direction = ParameterDirection.Output;
        claSqlConnDB.ExecuteNonQuery(claSqlConnDB.gStrConnDefault, CommandType.StoredProcedure, "pZNetIPEdit", myParameter);
        voIntReturn = (int)myParameter[6].Value;
        if (voIntReturn == 0)
        {
            context.Response.Write(voIntReturn);
        }
    }

    //删除
    private void Del(HttpContext context)
    {
        int mIntDataID = Int32.Parse(context.Request.Params["vID"]);
        int voIntReturn;

        SqlParameter[] myParameter = new SqlParameter[2]
        {
            new SqlParameter("@viIntDataID",SqlDbType.Int,4),
            new SqlParameter("@voIntReturn",SqlDbType.Int,4),
        };

        myParameter[0].Value = mIntDataID;
        myParameter[1].Direction = ParameterDirection.Output;
        claSqlConnDB.ExecuteNonQuery(claSqlConnDB.gStrConnDefault, CommandType.StoredProcedure, "pZNetIPDel", myParameter);
        voIntReturn = (int)myParameter[1].Value;
        if (voIntReturn == 0)
        {
            context.Response.Write(voIntReturn);
        }
    }
    public bool IsReusable {
        get {
            return false;
        }
    }

}