<%@ WebHandler Language="C#" Class="stoneHandler" %>

using System;
using System.Web;
using ModelClass;
using Newtonsoft.Json;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;

public class stoneHandler : IHttpHandler
{
    string type = "";
    string StoneNum = "";
    string StoneWeight = "";
    string SongJianPeo = "";
    string JianYanPeo = "";
    string FatCaO = "";
    string FatMgO = "";
    string FatSiO2 = "";
    string FatLiDu = "";

    string StoneID = "";
    string picFile = "";
    public void ProcessRequest (HttpContext context) {
        context.Response.ContentType = "text/plain";
        type = context.Request.Params["type"];
        StoneNum = context.Request.Params["StoneNum"];
        StoneWeight = context.Request.Params["StoneWeight"];
        SongJianPeo = context.Request.Params["SongJianPeo"];
        JianYanPeo = context.Request.Params["JianYanPeo"];
        FatCaO = context.Request.Params["FatCaO"];
        FatMgO = context.Request.Params["FatMgO"];
        FatSiO2 = context.Request.Params["FatSiO2"];
        FatLiDu = context.Request.Params["FatLiDu"];

        StoneID = context.Request.Params["StoneID"];
        picFile = context.Request.Params["picFile"];
        
        switch (type)
        {
            case "para1":
                context.Response.Write(InsertStoneNote());
                break;
            case "para2":
                context.Response.Write(ShowStoneNote());
                break;
            case "para3":
                context.Response.Write(ShowStoneDetail());
                break;
            case "para4":
                context.Response.Write(DelStoneNote());
                break;
            case "para5":
                context.Response.Write(EditStoneNote());
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
        vStrSQL = "update t_SCYuanStone set dVchStonePic = '" + picFile + "' where dIntgStoneID = " + StoneID + "";
        lIntReturn = claSqlConnDB.ExecuteNonQuery(claSqlConnDB.gStrConnDefault, CommandType.Text, vStrSQL);
        return lIntReturn;
    }

    public string InsertStoneNote()
    {
        string lStrReturn = "";
        SqlParameter[] _Parameter = new SqlParameter[10]
            {
                new SqlParameter("@viVchStoneNum",SqlDbType.VarChar,30),
                new SqlParameter("@viFatStoneWeight",SqlDbType.Decimal,5),
                new SqlParameter("@viVchSongJianPeo",SqlDbType.VarChar,10),
                new SqlParameter("@viVchJianYanPeo",SqlDbType.VarChar,10),
                new SqlParameter("@viFatCaO",SqlDbType.Decimal,4),
                new SqlParameter("@viFatMgO",SqlDbType.Decimal,4),
                new SqlParameter("@viFatSiO2",SqlDbType.Decimal,4),
                new SqlParameter("@viFatLiDu",SqlDbType.Decimal,4),
                new SqlParameter("@voIntStoneID",SqlDbType.Int),
                new SqlParameter("@voIntReturn",SqlDbType.Int),
            };
        _Parameter[0].Value = StoneNum;
        _Parameter[1].Value = StoneWeight;
        _Parameter[2].Value = SongJianPeo;
        _Parameter[3].Value = JianYanPeo;
        _Parameter[4].Value = FatCaO;
        _Parameter[5].Value = FatMgO;
        _Parameter[6].Value = FatSiO2;
        _Parameter[7].Value = FatLiDu;
        _Parameter[8].Direction = System.Data.ParameterDirection.Output;
        _Parameter[9].Direction = System.Data.ParameterDirection.Output;
        claSqlConnDB.ExecuteNonQuery(claSqlConnDB.gStrConnDefault, CommandType.StoredProcedure, "pSCYuanStoneAdd", _Parameter);
        lStrReturn = _Parameter[9].Value.ToString() + "," + _Parameter[8].Value.ToString();
        return lStrReturn;
    }
    public int DelStoneNote()
    {
        int lIntReturn = -1;
        SqlParameter[] _Parameter = new SqlParameter[2]
            {
                new SqlParameter("@viIntgStoneID",SqlDbType.Int,4),
                new SqlParameter("@voIntReturn",SqlDbType.Int),
            };
        _Parameter[0].Value = StoneID;
        _Parameter[1].Direction = System.Data.ParameterDirection.Output;
        claSqlConnDB.ExecuteNonQuery(claSqlConnDB.gStrConnDefault, CommandType.StoredProcedure, "pSCYuanStoneDel", _Parameter);
        lIntReturn = (int)_Parameter[1].Value;
        return lIntReturn;
    }
    public int EditStoneNote()
    {
        int lIntReturn = -1;
        SqlParameter[] _Parameter = new SqlParameter[10]
            {
                new SqlParameter("@viIntgStoneID",SqlDbType.Int,4),
                new SqlParameter("@viVchStoneNum",SqlDbType.VarChar,30),
                new SqlParameter("@viFatStoneWeight",SqlDbType.Decimal,5),
                new SqlParameter("@viVchSongJianPeo",SqlDbType.VarChar,10),
                new SqlParameter("@viVchJianYanPeo",SqlDbType.VarChar,10),
                new SqlParameter("@viFatCaO",SqlDbType.Decimal,4),
                new SqlParameter("@viFatMgO",SqlDbType.Decimal,4),
                new SqlParameter("@viFatSiO2",SqlDbType.Decimal,4),
                new SqlParameter("@viFatLiDu",SqlDbType.Decimal,4),
                new SqlParameter("@voIntReturn",SqlDbType.Int),
            };
        _Parameter[0].Value = StoneID;
        _Parameter[1].Value = StoneNum;
        _Parameter[2].Value = StoneWeight;
        _Parameter[3].Value = SongJianPeo;
        _Parameter[4].Value = JianYanPeo;
        _Parameter[5].Value = FatCaO;
        _Parameter[6].Value = FatMgO;
        _Parameter[7].Value = FatSiO2;
        _Parameter[8].Value = FatLiDu;
        _Parameter[9].Direction = System.Data.ParameterDirection.Output;
        claSqlConnDB.ExecuteNonQuery(claSqlConnDB.gStrConnDefault, CommandType.StoredProcedure, "pSCYuanStoneEdit", _Parameter);
        lIntReturn = (int)_Parameter[9].Value;
        return lIntReturn;
    }
    public string ShowStoneNote()
    {
        string returnStr = "";
        List<SCYuanStone> Grid = new List<SCYuanStone>();

        string lStrSQL = @"SELECT dIntgStoneID,
                dDaeInDate,
                dVchStoneNum,
                dFatStoneWeight,
                dVchSongJianPeo,
                dVchJianYanPeo,
                dFatCaO,
                dFatMgO,
                dFatSiO2,
                dFatLiDu,
                dVchStonePic    
            FROM t_SCYuanStone 
            ORDER BY dDaeInDate DESC";
        System.Data.DataTable dt = null;
        using (dt = claSqlConnDB.ExecuteDataset(claSqlConnDB.gStrConnDefault, System.Data.CommandType.Text, lStrSQL).Tables[0])
        {
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                SCYuanStone tmp = new SCYuanStone();
                tmp.dIntgStoneID = dt.Rows[i][0].ToString();
                tmp.dDaeInDate = DateTime.Parse(dt.Rows[i][1].ToString());
                tmp.dVchStoneNum = dt.Rows[i][2].ToString();
                tmp.dFatStoneWeight = float.Parse(dt.Rows[i][3].ToString());
                tmp.dVchSongJianPeo = dt.Rows[i][4].ToString();
                tmp.dVchJianYanPeo = dt.Rows[i][5].ToString();
                tmp.dFatCaO = float.Parse(dt.Rows[i][6].ToString());
                tmp.dFatMgO = float.Parse(dt.Rows[i][7].ToString());
                tmp.dFatSiO2 = float.Parse(dt.Rows[i][8].ToString());
                tmp.dFatLiDu = float.Parse(dt.Rows[i][9].ToString());
                tmp.dVchStonePic = dt.Rows[i][10].ToString();
                Grid.Add(tmp);
            }
        }
        return returnStr = JsonConvert.SerializeObject(Grid);
    }

    public string ShowStoneDetail()
    {
        string returnStr = "";
        List<SCYuanStone> Grid = new List<SCYuanStone>();

        string lStrSQL = @"SELECT dIntgStoneID,
                dDaeInDate,
                dVchStoneNum,
                dFatStoneWeight,
                dVchSongJianPeo,
                dVchJianYanPeo,
                dFatCaO,
                dFatMgO,
                dFatSiO2,
                dFatLiDu,dVchStonePic FROM t_SCYuanStone  
                where dIntgStoneID = " + StoneID + "";
        System.Data.DataTable dt = null;
        using (dt = claSqlConnDB.ExecuteDataset(claSqlConnDB.gStrConnDefault, System.Data.CommandType.Text, lStrSQL).Tables[0])
        {
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                SCYuanStone tmp = new SCYuanStone();
                tmp.dIntgStoneID = dt.Rows[i][0].ToString();
                tmp.dDaeInDate = DateTime.Parse(dt.Rows[i][1].ToString());
                tmp.dVchStoneNum = dt.Rows[i][2].ToString();
                tmp.dFatStoneWeight = float.Parse(dt.Rows[i][3].ToString());
                tmp.dVchSongJianPeo = dt.Rows[i][4].ToString();
                tmp.dVchJianYanPeo = dt.Rows[i][5].ToString();
                tmp.dFatCaO = float.Parse(dt.Rows[i][6].ToString());
                tmp.dFatMgO = float.Parse(dt.Rows[i][7].ToString());
                tmp.dFatSiO2 = float.Parse(dt.Rows[i][8].ToString());
                tmp.dFatLiDu = float.Parse(dt.Rows[i][9].ToString());
                tmp.dVchStonePic = dt.Rows[i][10].ToString();
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