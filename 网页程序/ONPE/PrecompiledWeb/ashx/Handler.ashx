<%@ WebHandler Language="C#" Class="t_GZPHandler" %>
using System;
using System.Web;
using Newtonsoft.Json;
using NPE.UIDataClass;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Generic;
using ModelClass;
using System.Text;

public class t_GZPHandler : IHttpHandler {
	int page = 1;
    int rows = 10;
    string order = "";
    string sort = "";
    public void ProcessRequest (HttpContext context) {
        string workNote = "";
        string action = "";
        int mIntParamNullable=0;
        RequestReturn mRequestReturn = new RequestReturn();
        context.Response.ContentType = "text/plain";
        action = context.Request.Params["action"];
        switch (action)
        {
        	case "add":
								string m_add_dVchWorkNote="";
				if (context.Request.Params["dVchWorkNote"] !=null)
				{
				 	m_add_dVchWorkNote=context.Request.Params["dVchWorkNote"];
				}
				else
				{
				 	m_add_dVchWorkNote=context.Request.Params["dVchWorkNote"];
					mIntParamNullable=mIntParamNullable+1;
				}
				string m_add_dVchWorkCreatUnit="";
				if (context.Request.Params["dVchWorkCreatUnit"] !=null)
				{
				 	m_add_dVchWorkCreatUnit=context.Request.Params["dVchWorkCreatUnit"];
				}
				else
				{
				 	m_add_dVchWorkCreatUnit=context.Request.Params["dVchWorkCreatUnit"];
					mIntParamNullable=mIntParamNullable+1;
				}
				string m_add_dVchWorkCreatPeo="";
				if (context.Request.Params["dVchWorkCreatPeo"] !=null)
				{
				 	m_add_dVchWorkCreatPeo=context.Request.Params["dVchWorkCreatPeo"];
				}
				else
				{
				 	m_add_dVchWorkCreatPeo=context.Request.Params["dVchWorkCreatPeo"];
					mIntParamNullable=mIntParamNullable + 1;
				}
				string m_add_dDaeWorkSys="";
				if (context.Request.Params["dDaeWorkSys"] !=null)
				{
				 	m_add_dDaeWorkSys=context.Request.Params["dDaeWorkSys"];
				}
				else
				{
				 	m_add_dDaeWorkSys=context.Request.Params["dDaeWorkSys"];
					mIntParamNullable=mIntParamNullable+1;
				}
				string m_add_dVchActionDep="";
				if (context.Request.Params["dVchActionDep"] !=null)
				{
				 	m_add_dVchActionDep=context.Request.Params["dVchActionDep"];
				}
				else
				{
				 	m_add_dVchActionDep=context.Request.Params["dVchActionDep"];
					mIntParamNullable=mIntParamNullable+1;
				}
				string m_add_dVchArea="";
				if (context.Request.Params["dVchArea"] !=null)
				{
				 	m_add_dVchArea=context.Request.Params["dVchArea"];
				}
				else
				{
				 	m_add_dVchArea=context.Request.Params["dVchArea"];
					mIntParamNullable=mIntParamNullable+1;
				}
				string m_add_dDaeWorkStart="";
				if (context.Request.Params["dDaeWorkStart"] !=null)
				{
				 	m_add_dDaeWorkStart=context.Request.Params["dDaeWorkStart"];
				}
				else
				{
				 	m_add_dDaeWorkStart=context.Request.Params["dDaeWorkStart"];
					mIntParamNullable=mIntParamNullable+1;
				}
				string m_add_dVchWorkPeo="";
				if (context.Request.Params["dVchWorkPeo"] !=null)
				{
				 	m_add_dVchWorkPeo=context.Request.Params["dVchWorkPeo"];
				}
				else
				{
				 	m_add_dVchWorkPeo=context.Request.Params["dVchWorkPeo"];
					mIntParamNullable=mIntParamNullable+1;
				}
				string m_add_dVchWorkPeoQZ="";
				if (context.Request.Params["dVchWorkPeoQZ"] !=null)
				{
				 	m_add_dVchWorkPeoQZ=context.Request.Params["dVchWorkPeoQZ"];
				}
				else
				{
				 	m_add_dVchWorkPeoQZ=context.Request.Params["dVchWorkPeoQZ"];
					mIntParamNullable=mIntParamNullable+1;
				}
				string m_add_dDaeWorkEnd="";
				if (context.Request.Params["dDaeWorkEnd"] !=null)
				{
				 	m_add_dDaeWorkEnd=context.Request.Params["dDaeWorkEnd"];
				}
				else
				{
				 	m_add_dDaeWorkEnd=context.Request.Params["dDaeWorkEnd"];
					mIntParamNullable=mIntParamNullable+1;
				}
				string m_add_dVchWorkPeo1="";
				if (context.Request.Params["dVchWorkPeo1"] !=null)
				{
				 	m_add_dVchWorkPeo1=context.Request.Params["dVchWorkPeo1"];
				}
				else
				{
				 	m_add_dVchWorkPeo1=context.Request.Params["dVchWorkPeo1"];
					mIntParamNullable=mIntParamNullable+1;
				}
				string m_add_dVchWorkPeoQZ1="";
				if (context.Request.Params["dVchWorkPeoQZ1"] !=null)
				{
				 	m_add_dVchWorkPeoQZ1=context.Request.Params["dVchWorkPeoQZ1"];
				}
				else
				{
				 	m_add_dVchWorkPeoQZ1=context.Request.Params["dVchWorkPeoQZ1"];
					mIntParamNullable=mIntParamNullable+1;
				}
				string m_add_dVchFromType="";
				if (context.Request.Params["dVchFromType"] !=null)
				{
				 	m_add_dVchFromType=context.Request.Params["dVchFromType"];
				}
				else
				{
				 	m_add_dVchFromType=context.Request.Params["dVchFromType"];
					mIntParamNullable=mIntParamNullable+1;
				}
				if (mIntParamNullable == 0 )
                {
                    mRequestReturn.responstResult = true;
                    mRequestReturn.responstDetial =Addt_GZPData(m_add_dVchWorkNote,m_add_dVchWorkCreatUnit,m_add_dVchWorkCreatPeo,m_add_dDaeWorkSys,m_add_dVchActionDep,m_add_dVchArea,m_add_dDaeWorkStart,m_add_dVchWorkPeo,m_add_dVchWorkPeoQZ,m_add_dDaeWorkEnd,m_add_dVchWorkPeo1,m_add_dVchWorkPeoQZ1,m_add_dVchFromType);
                    mRequestReturn.responstMsg = "所请求的数据已成功返回";
                }
                else
                {
                    mRequestReturn.responstResult = false;
                    mRequestReturn.responstDetial = "缺少必要参数";
                    mRequestReturn.responstMsg = "缺少必要参数";
                }
        		break;
        	case "edit":
								string m_edit_dVchWorkNote="";
				if (context.Request.Params["dVchWorkNote"] !=null)
				{
				 	m_edit_dVchWorkNote=context.Request.Params["dVchWorkNote"];
				}
				else
				{
					mIntParamNullable=mIntParamNullable+1;
				}
				string m_edit_dVchWorkCreatUnit="";
				if (context.Request.Params["dVchWorkCreatUnit"] !=null)
				{
				 	m_edit_dVchWorkCreatUnit=context.Request.Params["dVchWorkCreatUnit"];
				}
				else
				{
					mIntParamNullable=mIntParamNullable+1;
				}
				string m_edit_dVchWorkCreatPeo="";
				if (context.Request.Params["dVchWorkCreatPeo"] !=null)
				{
				 	m_edit_dVchWorkCreatPeo=context.Request.Params["dVchWorkCreatPeo"];
				}
				else
				{
					mIntParamNullable=mIntParamNullable+1;
				}
				string m_edit_dDaeWorkSys="";
				if (context.Request.Params["dDaeWorkSys"] !=null)
				{
				 	m_edit_dDaeWorkSys=context.Request.Params["dDaeWorkSys"];
				}
				else
				{
					mIntParamNullable=mIntParamNullable+1;
				}
				string m_edit_dVchActionDep="";
				if (context.Request.Params["dVchActionDep"] !=null)
				{
				 	m_edit_dVchActionDep=context.Request.Params["dVchActionDep"];
				}
				else
				{
					mIntParamNullable=mIntParamNullable+1;
				}
				string m_edit_dVchArea="";
				if (context.Request.Params["dVchArea"] !=null)
				{
				 	m_edit_dVchArea=context.Request.Params["dVchArea"];
				}
				else
				{
					mIntParamNullable=mIntParamNullable+1;
				}
				string m_edit_dDaeWorkStart="";
				if (context.Request.Params["dDaeWorkStart"] !=null)
				{
				 	m_edit_dDaeWorkStart=context.Request.Params["dDaeWorkStart"];
				}
				else
				{
					mIntParamNullable=mIntParamNullable+1;
				}
				string m_edit_dVchWorkPeo="";
				if (context.Request.Params["dVchWorkPeo"] !=null)
				{
				 	m_edit_dVchWorkPeo=context.Request.Params["dVchWorkPeo"];
				}
				else
				{
					mIntParamNullable=mIntParamNullable+1;
				}
				string m_edit_dVchWorkPeoQZ="";
				if (context.Request.Params["dVchWorkPeoQZ"] !=null)
				{
				 	m_edit_dVchWorkPeoQZ=context.Request.Params["dVchWorkPeoQZ"];
				}
				else
				{
					mIntParamNullable=mIntParamNullable+1;
				}
				string m_edit_dDaeWorkEnd="";
				if (context.Request.Params["dDaeWorkEnd"] !=null)
				{
				 	m_edit_dDaeWorkEnd=context.Request.Params["dDaeWorkEnd"];
				}
				else
				{
					mIntParamNullable=mIntParamNullable+1;
				}
				string m_edit_dVchWorkPeo1="";
				if (context.Request.Params["dVchWorkPeo1"] !=null)
				{
				 	m_edit_dVchWorkPeo1=context.Request.Params["dVchWorkPeo1"];
				}
				else
				{
					mIntParamNullable=mIntParamNullable+1;
				}
				string m_edit_dVchWorkPeoQZ1="";
				if (context.Request.Params["dVchWorkPeoQZ1"] !=null)
				{
				 	m_edit_dVchWorkPeoQZ1=context.Request.Params["dVchWorkPeoQZ1"];
				}
				else
				{
					mIntParamNullable=mIntParamNullable+1;
				}
				string m_edit_dVchFromType="";
				if (context.Request.Params["dVchFromType"] !=null)
				{
				 	m_edit_dVchFromType=context.Request.Params["dVchFromType"];
				}
				else
				{
					mIntParamNullable=mIntParamNullable+1;
				}
				if (mIntParamNullable == 0 )
                {
                    mRequestReturn.responstResult = true;
                    mRequestReturn.responstDetial =Editt_GZPData(m_edit_dVchWorkNote,m_edit_dVchWorkCreatUnit,m_edit_dVchWorkCreatPeo,m_edit_dDaeWorkSys,m_edit_dVchActionDep,m_edit_dVchArea,m_edit_dDaeWorkStart,m_edit_dVchWorkPeo,m_edit_dVchWorkPeoQZ,m_edit_dDaeWorkEnd,m_edit_dVchWorkPeo1,m_edit_dVchWorkPeoQZ1,m_edit_dVchFromType);
                    mRequestReturn.responstMsg = "所请求的数据已成功返回";
                }
                else
                {
                    mRequestReturn.responstResult = false;
                    mRequestReturn.responstDetial = "缺少必要参数";
                    mRequestReturn.responstMsg = "缺少必要参数";
                }
        		break;
            case "prop":
                workNote = context.Request.Params["worknote"];
                if (workNote != "")
                {
                    mRequestReturn.responstResult = true;
                    mRequestReturn.responstDetial = GetGzpProp(workNote);
                    mRequestReturn.responstMsg = "所请求的数据已成功返回";
                }
                else
                {
                    mRequestReturn.responstResult = false;
                    mRequestReturn.responstDetial = "缺少必要参数";
                    mRequestReturn.responstMsg = "缺少必要参数";
                }
                break;
            case "item":
                workNote = context.Request.Params["worknote"];
                if (workNote != "")
                {
                    mRequestReturn.responstResult = true;
                    mRequestReturn.responstDetial = showItemData(workNote);
                    mRequestReturn.responstDetial = mRequestReturn.responstDetial;
                    mRequestReturn.responstMsg = "所请求的数据已成功返回";
                }
                else
                {
                    mRequestReturn.responstResult = false;
                    mRequestReturn.responstDetial = "缺少必要参数";
                    mRequestReturn.responstMsg = "缺少必要参数";
                }
                break;
            case "grid":
                order = context.Request.Params["order"];
                sort = context.Request.Params["sort"];
                if (int.TryParse(context.Request.Params["page"], out page) == false)
                {
                    page = 1;
                }
                if (int.TryParse(context.Request.Params["rows"], out rows) == false)
                {
                    rows = 10;
                }
                mRequestReturn.responstResult = true;
                mRequestReturn.responstDetial = GetGzpData();
                mRequestReturn.responstMsg = string.Format("\"total\":{0},\"rows\":", GetCount());
                break;
            default:
                mRequestReturn.responstResult = false;
                mRequestReturn.responstDetial = "缺少必要参数";
                mRequestReturn.responstMsg = "缺少必要参数";
                break;
        }
        context.Response.Write(JsonConvert.SerializeObject(mRequestReturn));
    }
    private int Addt_GZPData(string v_dVchWorkNote,string v_dVchWorkCreatUnit,string v_dVchWorkCreatPeo,string v_dDaeWorkSys,string v_dVchActionDep,string v_dVchArea,string v_dDaeWorkStart,string v_dVchWorkPeo,string v_dVchWorkPeoQZ,string v_dDaeWorkEnd,string v_dVchWorkPeo1,string v_dVchWorkPeoQZ1,string v_dVchFromType)
    {
       StringBuilder strSql=new StringBuilder();
	   strSql.Append("insert into t_GZP(");			
       strSql.Append("dVchWorkNote,dVchWorkCreatUnit,dVchWorkCreatPeo,dDaeWorkSys,dVchActionDep,dVchArea,dDaeWorkStart,dVchWorkPeo,dVchWorkPeoQZ,dDaeWorkEnd,dVchWorkPeo1,dVchWorkPeoQZ1,dVchFromType");
	   strSql.Append(") values (");
       strSql.Append("@dVchWorkNote,@dVchWorkCreatUnit,@dVchWorkCreatPeo,@dDaeWorkSys,@dVchActionDep,@dVchArea,@dDaeWorkStart,@dVchWorkPeo,@dVchWorkPeoQZ,@dDaeWorkEnd,@dVchWorkPeo1,@dVchWorkPeoQZ1,@dVchFromType");            
       strSql.Append(") ");	
       SqlParameter[] parameters = {
			             new SqlParameter("@dVchWorkNote", SqlDbType.VarChar,30) ,            
                         new SqlParameter("@dVchWorkCreatUnit", SqlDbType.VarChar,20) ,            
                         new SqlParameter("@dVchWorkCreatPeo", SqlDbType.VarChar,20) ,            
                         new SqlParameter("@dDaeWorkSys", SqlDbType.DateTime) ,            
                         new SqlParameter("@dVchActionDep", SqlDbType.VarChar,30) ,            
                         new SqlParameter("@dVchArea", SqlDbType.VarChar,100) ,            
                         new SqlParameter("@dDaeWorkStart", SqlDbType.DateTime) ,            
                         new SqlParameter("@dVchWorkPeo", SqlDbType.VarChar,20) ,            
                         new SqlParameter("@dVchWorkPeoQZ", SqlDbType.VarChar,20) ,            
                         new SqlParameter("@dDaeWorkEnd", SqlDbType.DateTime) ,            
                         new SqlParameter("@dVchWorkPeo1", SqlDbType.VarChar,20) ,            
                         new SqlParameter("@dVchWorkPeoQZ1", SqlDbType.VarChar,20) ,            
                         new SqlParameter("@dVchFromType", SqlDbType.VarChar,20)             
             
            };
		            
       parameters[0].Value = v_dVchWorkNote;   		            
       parameters[1].Value = v_dVchWorkCreatUnit;   		            
       parameters[2].Value = v_dVchWorkCreatPeo;   		            
       parameters[3].Value = v_dDaeWorkSys;   		            
       parameters[4].Value = v_dVchActionDep;   		            
       parameters[5].Value = v_dVchArea;   		            
       parameters[6].Value = v_dDaeWorkStart;   		            
       parameters[7].Value = v_dVchWorkPeo;   		            
       parameters[8].Value = v_dVchWorkPeoQZ;   		            
       parameters[9].Value = v_dDaeWorkEnd;   		            
       parameters[10].Value = v_dVchWorkPeo1;   		            
       parameters[11].Value = v_dVchWorkPeoQZ1;   		            
       parameters[12].Value = v_dVchFromType;   		            
        int i = claSqlConnDB.ExecuteNonQuery(claSqlConnDB.gStrConnDefault, CommandType.Text, strSql.ToString(),parameters);
        return i;
    }
    private int Editt_GZPData(string v_dVchWorkNote,string v_dVchWorkCreatUnit,string v_dVchWorkCreatPeo,string v_dDaeWorkSys,string v_dVchActionDep,string v_dVchArea,string v_dDaeWorkStart,string v_dVchWorkPeo,string v_dVchWorkPeoQZ,string v_dDaeWorkEnd,string v_dVchWorkPeo1,string v_dVchWorkPeoQZ1,string v_dVchFromType)
    {
       StringBuilder strSql=new StringBuilder();
	   strSql.Append("insert into t_GZP(");			
       strSql.Append("dVchWorkNote,dVchWorkCreatUnit,dVchWorkCreatPeo,dDaeWorkSys,dVchActionDep,dVchArea,dDaeWorkStart,dVchWorkPeo,dVchWorkPeoQZ,dDaeWorkEnd,dVchWorkPeo1,dVchWorkPeoQZ1,dVchFromType");
	   strSql.Append(") values (");
       strSql.Append("@dVchWorkNote,@dVchWorkCreatUnit,@dVchWorkCreatPeo,@dDaeWorkSys,@dVchActionDep,@dVchArea,@dDaeWorkStart,@dVchWorkPeo,@dVchWorkPeoQZ,@dDaeWorkEnd,@dVchWorkPeo1,@dVchWorkPeoQZ1,@dVchFromType");            
       strSql.Append(") ");	
       SqlParameter[] parameters = {
			           new SqlParameter("@dVchWorkNote", SqlDbType.VarChar,30) ,            
                       new SqlParameter("@dVchWorkCreatUnit", SqlDbType.VarChar,20) ,            
                       new SqlParameter("@dVchWorkCreatPeo", SqlDbType.VarChar,20) ,            
                       new SqlParameter("@dDaeWorkSys", SqlDbType.DateTime) ,            
                       new SqlParameter("@dVchActionDep", SqlDbType.VarChar,30) ,            
                       new SqlParameter("@dVchArea", SqlDbType.VarChar,100) ,            
                       new SqlParameter("@dDaeWorkStart", SqlDbType.DateTime) ,            
                       new SqlParameter("@dVchWorkPeo", SqlDbType.VarChar,20) ,            
                       new SqlParameter("@dVchWorkPeoQZ", SqlDbType.VarChar,20) ,            
                       new SqlParameter("@dDaeWorkEnd", SqlDbType.DateTime) ,            
                       new SqlParameter("@dVchWorkPeo1", SqlDbType.VarChar,20) ,            
                       new SqlParameter("@dVchWorkPeoQZ1", SqlDbType.VarChar,20) ,            
                       new SqlParameter("@dVchFromType", SqlDbType.VarChar,20)             
             
            };
		            
        parameters[0].Value = v_dVchWorkNote;                    
        parameters[1].Value = v_dVchWorkCreatUnit;                    
        parameters[2].Value = v_dVchWorkCreatPeo;                    
        parameters[3].Value = v_dDaeWorkSys;                    
        parameters[4].Value = v_dVchActionDep;                    
        parameters[5].Value = v_dVchArea;                    
        parameters[6].Value = v_dDaeWorkStart;                    
        parameters[7].Value = v_dVchWorkPeo;                    
        parameters[8].Value = v_dVchWorkPeoQZ;                    
        parameters[9].Value = v_dDaeWorkEnd;                    
        parameters[10].Value = v_dVchWorkPeo1;                    
        parameters[11].Value = v_dVchWorkPeoQZ1;                    
        parameters[12].Value = v_dVchFromType;                    
        int i = claSqlConnDB.ExecuteNonQuery(claSqlConnDB.gStrConnDefault, CommandType.Text, strSql.ToString(),parameters);
        return i;
    }
    private string GetCount()
    {
        string mStrSQL = @" select count(0) from t_GZP ";
        int i = claSqlConnDB.GetRecordCount(claSqlConnDB.gStrConnDefault, mStrSQL);
        return i.ToString();
    }
    private List<gzp> GetGzpData()
    {
        List<gzp> gzpGrid = new List<gzp>();
        string lStrSQL = @"select dVchWorkNote,dVchWorkCreatUnit,dVchWorkCreatPeo,
                            dDaeWorkSys,dVchActionDep,dVchArea,dDaeWorkStart,dVchWorkPeo,
                            dVchWorkPeoQZ,dDaeWorkEnd,dVchWorkPeo1,dVchWorkPeoQZ1,dVchFromType 
                            from t_GZP ";
        DataTable dt = null;
        using (dt = claSqlConnDB.ExecuteDataset(rows, page, claSqlConnDB.gStrConnDefault, CommandType.Text, lStrSQL).Tables[0])
        {
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                gzp gzptmp = new gzp();
                gzptmp.dVchWorkNote = dt.Rows[i][0].ToString();
                gzptmp.dVchWorkCreatUnit = dt.Rows[i][1].ToString();
                gzptmp.dVchWorkCreatPeo = dt.Rows[i][2].ToString();
                gzptmp.dDaeWorkSys = dt.Rows[i][3].ToString();
                gzptmp.dVchActionDep = dt.Rows[i][4].ToString();
                gzptmp.dVchArea = dt.Rows[i][5].ToString();
                gzptmp.dDaeWorkStart = dt.Rows[i][6].ToString();
                gzptmp.dVchWorkPeo = dt.Rows[i][7].ToString();
                gzptmp.dVchWorkPeoQZ = dt.Rows[i][8].ToString();
                gzptmp.dDaeWorkEnd = dt.Rows[i][9].ToString();
                gzptmp.dVchWorkPeo1 = dt.Rows[i][10].ToString();
                gzptmp.dVchWorkPeoQZ1 = dt.Rows[i][11].ToString();
                gzptmp.dVchFromType = dt.Rows[i][12].ToString();
                gzptmp.Item = "";
                gzpGrid.Add(gzptmp);
            }
        }
        return gzpGrid;
    }
    private List<gzItem> showItemData(string workNote)
    {
        List<gzItem> gzItemGrid = new List<gzItem>();
        string lStrSQL = @"select equip_name,dVchWorkContent,dVchIsClose,dVchApplyPeo,dVchZKCheckPeo,dVchActionPeo,t_GZPItem.equip_code from t_GZPItem inner join t_Equips on t_Equips.equip_code = t_GZPItem.equip_code
            where dVchWorkNote = '" + workNote + "'";
        DataTable dt = null;
        using (dt = claSqlConnDB.ExecuteDataset(claSqlConnDB.gStrConnDefault, CommandType.Text, lStrSQL).Tables[0])
        {
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                gzItem tmp = new gzItem();
                tmp.equip_name = dt.Rows[i][0].ToString();
                tmp.dVchWorkContent = dt.Rows[i][1].ToString();
                tmp.dVchIsClose = dt.Rows[i][2].ToString();
                tmp.dVchApplyPeo = dt.Rows[i][3].ToString();
                tmp.dVchZKCheckPeo = dt.Rows[i][4].ToString();
                tmp.dVchActionPeo = dt.Rows[i][5].ToString();
                tmp.equip_code = dt.Rows[i][6].ToString();
                gzItemGrid.Add(tmp);
            }
        }
        return gzItemGrid;
    }

    private gzp GetGzpProp(string vStrWorkNote) 
    {
        gzp mGzp=new gzp();
        string mStrSQL = @"select dVchWorkNote,dVchWorkCreatUnit,dVchWorkCreatPeo,
                           dDaeWorkSys,dVchActionDep,dVchArea,dDaeWorkStart,dVchWorkPeo,
                           dVchWorkPeoQZ,dDaeWorkEnd,dVchWorkPeo1,dVchWorkPeoQZ1,dVchFromType 
                           from t_GZP where dVchWorkNote='" + vStrWorkNote + "' order by dDaeWorkSys desc";
        mGzp = (gzp)claSqlConnDB.GetDetail(claSqlConnDB.gStrConnDefault, mStrSQL, "ModelClass.gzp", null);
        return mGzp;
    }
    public bool IsReusable {
        get {
            return false;
        }
    }

}