<%@ WebHandler Language="C#" Class="productorHandler" %>

using System;
using System.Web;
using ModelClass;
using Newtonsoft.Json;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;

public class productorHandler : IHttpHandler {

    string type = "";
    string ProductoNum = "";
    string ProductoWeight = "";
    string SongJianPeo = "";
    string JianYanPeo = "";
    string FatCaO = "";
    string FatMgO = "";
    string FatSiO2 = "";
    string FatHuoxingDu = "";
    string FatFailLv = "";
    
    string ProductoID = "";
    string picFile = "";
    public void ProcessRequest (HttpContext context) {
        context.Response.ContentType = "text/plain";
        type = context.Request.Params["type"];

        ProductoNum = context.Request.Params["ProductoNum"];
        ProductoWeight = context.Request.Params["ProductoWeight"];
        SongJianPeo = context.Request.Params["SongJianPeo"];
        JianYanPeo = context.Request.Params["JianYanPeo"];
        FatCaO = context.Request.Params["FatCaO"];
        FatMgO = context.Request.Params["FatMgO"];
        FatSiO2 = context.Request.Params["FatSiO2"];
        FatHuoxingDu = context.Request.Params["FatHuoxingDu"];
        FatFailLv = context.Request.Params["FatFailLv"];

        ProductoID = context.Request.Params["ProductoID"];
        picFile = context.Request.Params["picFile"];
        switch (type)
        {
            case "para1":
                context.Response.Write(InsertProductorNote());
                break;
            case "para2":
                context.Response.Write(ShowProductorNote());
                break;
            case "para3":
                context.Response.Write(ShowProductorDetail());
                break;
            case "para4":
                context.Response.Write(DelProductorNote());
                break;
            case "para5":
                context.Response.Write(EditProductorNote());
                break;
            case "para6":
                context.Response.Write(AddPic());
                break;   
            default:
                break;
        }

    }
    public int AddPic()
    {
        int lIntReturn = -1;
        string vStrSQL = "";
        vStrSQL = "update t_SCProductor set dVchStonePic = '" + picFile + "' where dIntgProductorID = " + ProductoID + "";
        lIntReturn = claSqlConnDB.ExecuteNonQuery(claSqlConnDB.gStrConnDefault, CommandType.Text, vStrSQL);
        return lIntReturn;
    }

    public string InsertProductorNote()
    {
        string lStrReturn = "";
        SqlParameter[] _Parameter = new SqlParameter[11]
            {
                new SqlParameter("@viVchProductoNum",SqlDbType.VarChar,30),
                new SqlParameter("@viFatProductoWeight",SqlDbType.Decimal,5),
                new SqlParameter("@viVchSongJianPeo",SqlDbType.VarChar,10),
                new SqlParameter("@viVchJianYanPeo",SqlDbType.VarChar,10),
                new SqlParameter("@viFatCaO",SqlDbType.Decimal,4),
                new SqlParameter("@viFatMgO",SqlDbType.Decimal,4),
                new SqlParameter("@viFatSiO2",SqlDbType.Decimal,4),
                new SqlParameter("@viFatHuoxingDu",SqlDbType.Decimal,5),
                new SqlParameter("@viFatFailLv",SqlDbType.Decimal,5),
                new SqlParameter("@voIntProductorID",SqlDbType.Int),
                new SqlParameter("@voIntReturn",SqlDbType.Int),
            };
        _Parameter[0].Value = ProductoNum;
        _Parameter[1].Value = ProductoWeight;
        _Parameter[2].Value = SongJianPeo;
        _Parameter[3].Value = JianYanPeo;
        _Parameter[4].Value = FatCaO;
        _Parameter[5].Value = FatMgO;
        _Parameter[6].Value = FatSiO2;
        _Parameter[7].Value = FatHuoxingDu;
        _Parameter[8].Value = FatFailLv;
        _Parameter[9].Direction = System.Data.ParameterDirection.Output;
        _Parameter[10].Direction = System.Data.ParameterDirection.Output;
        claSqlConnDB.ExecuteNonQuery(claSqlConnDB.gStrConnDefault, CommandType.StoredProcedure, "pSCProductorAdd", _Parameter);
        lStrReturn = _Parameter[10].Value.ToString() + "," + _Parameter[9].Value.ToString();
        return lStrReturn;
    }

    public int DelProductorNote()
    {
        int lIntReturn = -1;
        SqlParameter[] _Parameter = new SqlParameter[2]
            {
                new SqlParameter("@viIntgProductorID",SqlDbType.Int,4),
                new SqlParameter("@voIntReturn",SqlDbType.Int),
            };
        _Parameter[0].Value = ProductoID;
        _Parameter[1].Direction = System.Data.ParameterDirection.Output;
        claSqlConnDB.ExecuteNonQuery(claSqlConnDB.gStrConnDefault, CommandType.StoredProcedure, "pSCProductorDel", _Parameter);
        lIntReturn = (int)_Parameter[1].Value;
        return lIntReturn;
    }

    public int EditProductorNote()
    {
        int lIntReturn = -1;
        SqlParameter[] _Parameter = new SqlParameter[11]
            {
                new SqlParameter("@viIntgProductorID",SqlDbType.Int,4),
                new SqlParameter("@viVchProductoNum",SqlDbType.VarChar,30),
                new SqlParameter("@viFatProductoWeight",SqlDbType.Decimal,5),
                new SqlParameter("@viVchSongJianPeo",SqlDbType.VarChar,10),
                new SqlParameter("@viVchJianYanPeo",SqlDbType.VarChar,10),
                new SqlParameter("@viFatCaO",SqlDbType.Decimal,4),
                new SqlParameter("@viFatMgO",SqlDbType.Decimal,4),
                new SqlParameter("@viFatSiO2",SqlDbType.Decimal,4),
                new SqlParameter("@viFatHuoxingDu",SqlDbType.Decimal,5),
                new SqlParameter("@viFatFailLv",SqlDbType.Decimal,4),
                new SqlParameter("@voIntReturn",SqlDbType.Int),
            };
        _Parameter[0].Value = ProductoID;
        _Parameter[1].Value = ProductoNum;
        _Parameter[2].Value = ProductoWeight;
        _Parameter[3].Value = SongJianPeo;
        _Parameter[4].Value = JianYanPeo;
        _Parameter[5].Value = FatCaO;
        _Parameter[6].Value = FatMgO;
        _Parameter[7].Value = FatSiO2;
        _Parameter[8].Value = FatHuoxingDu;
        _Parameter[9].Value = FatFailLv;
        _Parameter[10].Direction = System.Data.ParameterDirection.Output;
        claSqlConnDB.ExecuteNonQuery(claSqlConnDB.gStrConnDefault, CommandType.StoredProcedure, "pSCProductorEdit", _Parameter);
        lIntReturn = (int)_Parameter[10].Value;
        return lIntReturn;
    }
    public string ShowProductorNote()
    {
        string returnStr = "";
        List<SCProductor> Grid = new List<SCProductor>();

        string lStrSQL = @"SELECT dIntgProductorID,
                dDaeInDate,
                dVchProductoNum,
                dFatProductoWeight,
                dVchSongJianPeo,
                dVchJianYanPeo,
                dFatCaO,
                dFatMgO,
                dFatSiO2,
                dFatHuoxingDu,dFatFailLv,dVchStonePic FROM t_SCProductor 
                ORDER BY dDaeInDate DESC";
        System.Data.DataTable dt = null;
        using (dt = claSqlConnDB.ExecuteDataset(claSqlConnDB.gStrConnDefault, System.Data.CommandType.Text, lStrSQL).Tables[0])
        {
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                SCProductor tmp = new SCProductor();
                tmp.dIntgProductorID = dt.Rows[i][0].ToString();
                tmp.dDaeInDate = DateTime.Parse(dt.Rows[i][1].ToString());
                tmp.dVchProductoNum = dt.Rows[i][2].ToString();
                tmp.dFatProductoWeight = float.Parse(dt.Rows[i][3].ToString());
                tmp.dVchSongJianPeo = dt.Rows[i][4].ToString();
                tmp.dVchJianYanPeo = dt.Rows[i][5].ToString();
                tmp.dFatCaO = float.Parse(dt.Rows[i][6].ToString());
                tmp.dFatMgO = float.Parse(dt.Rows[i][7].ToString());
                tmp.dFatSiO2 = float.Parse(dt.Rows[i][8].ToString());
                tmp.dFatHuoxingDu = float.Parse(dt.Rows[i][9].ToString());
                tmp.dFatFailLv = float.Parse(dt.Rows[i][10].ToString());
                tmp.dVchStonePic = dt.Rows[i][11].ToString();
                Grid.Add(tmp);
            }
        }
        return returnStr = JsonConvert.SerializeObject(Grid);
    }
    
    public string ShowProductorDetail()
    {
        string returnStr = "";
        List<SCProductor> Grid = new List<SCProductor>();

        string lStrSQL = @"SELECT dIntgProductorID,
                dDaeInDate,
                dVchProductoNum,
                dFatProductoWeight,
                dVchSongJianPeo,
                dVchJianYanPeo,
                dFatCaO,
                dFatMgO,
                dFatSiO2,
                dFatHuoxingDu,dFatFailLv,dVchStonePic FROM t_SCProductor  
                where dIntgProductorID = " + ProductoID + "";
        System.Data.DataTable dt = null;
        using (dt = claSqlConnDB.ExecuteDataset(claSqlConnDB.gStrConnDefault, System.Data.CommandType.Text, lStrSQL).Tables[0])
        {
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                SCProductor tmp = new SCProductor();
                tmp.dIntgProductorID = dt.Rows[i][0].ToString();
                tmp.dDaeInDate = DateTime.Parse(dt.Rows[i][1].ToString());
                tmp.dVchProductoNum = dt.Rows[i][2].ToString();
                tmp.dFatProductoWeight = float.Parse(dt.Rows[i][3].ToString());
                tmp.dVchSongJianPeo = dt.Rows[i][4].ToString();
                tmp.dVchJianYanPeo = dt.Rows[i][5].ToString();
                tmp.dFatCaO = float.Parse(dt.Rows[i][6].ToString());
                tmp.dFatMgO = float.Parse(dt.Rows[i][7].ToString());
                tmp.dFatSiO2 = float.Parse(dt.Rows[i][8].ToString());
                tmp.dFatHuoxingDu = float.Parse(dt.Rows[i][9].ToString());
                tmp.dFatFailLv = float.Parse(dt.Rows[i][10].ToString());
                tmp.dVchStonePic = dt.Rows[i][11].ToString();
                Grid.Add(tmp);
            }
        }
        return returnStr = JsonConvert.SerializeObject(Grid);
    }
    
    public bool IsReusable {
        get {
            return false;
        }
    }

}