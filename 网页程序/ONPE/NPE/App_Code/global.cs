using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data.SqlClient;
using System.Data;
/// <summary>
///global 的摘要说明
/// </summary>
public class global
{
    public global()
    {
        //
        //TODO: 在此处添加构造函数逻辑
        //
    }
    public string GetIdentityID(string vStrDataBaseCode, string vStrSystemCode, string vStrFunctionCode, DateTime vDtmDatatime, int vIntCodeLength)
    {
        string lRwgdNum = "";
        int intreturn = -1;
        SqlParameter[] _Parameter = new SqlParameter[7]
            {
                new SqlParameter("@viVchDatabaseCode",SqlDbType.VarChar,2),
                new SqlParameter("@viVchSubsystem",SqlDbType.VarChar,2),
                new SqlParameter("@viVchFunction",SqlDbType.VarChar,2),
                new SqlParameter("@viDmeTime",SqlDbType.DateTime,30),
                new SqlParameter("@viIntSerialNo",SqlDbType.Int,4),
                new SqlParameter("@voVchNumberValue",SqlDbType.VarChar,30),
                new SqlParameter("@voIntReturn",SqlDbType.Int),
            };
        _Parameter[0].Value = vStrDataBaseCode;
        _Parameter[1].Value = vStrSystemCode;
        _Parameter[2].Value = vStrFunctionCode;
        _Parameter[3].Value = vDtmDatatime;
        _Parameter[4].Value = vIntCodeLength;
        _Parameter[5].Direction = System.Data.ParameterDirection.Output;
        _Parameter[6].Direction = System.Data.ParameterDirection.Output;
        claSqlConnDB.ExecuteNonQuery(claSqlConnDB.gStrConnDefault, CommandType.StoredProcedure, "pPBGetNumberValue", _Parameter);
        intreturn = (int)_Parameter[6].Value;
        lRwgdNum = _Parameter[5].Value.ToString();
        return lRwgdNum;
    }
    
    /// <summary>
    /// 设置设备相关联属性或对象的数量
    /// </summary>
    /// <param name="v_equip_code">设备编码</param>
    /// <param name="v_prop_name">属性或对象的名称</param>
    /// <param name="v_prop_way">改变方式 1 添加一条关联，-1 删除一条关联记录</param>
    /// <returns>执行结果</returns>
    public static int SetEquipConnectProp(string v_equip_code, string v_prop_name, int v_prop_way)
    {
        int mIntReturn = 0;
        SqlParameter[] parameters ={
                                  new SqlParameter("@vi_equip_code",SqlDbType.VarChar,30),
                                  new SqlParameter("@vi_prop_name",SqlDbType.Int,20),
                                  new SqlParameter("@vi_prop_way",SqlDbType.Int,4),
                                  new SqlParameter("@vo_return",SqlDbType.Int,4)
                                  };
        parameters[0].Value = v_equip_code;
        parameters[1].Value = v_prop_name;
        parameters[2].Value = v_prop_way;
        parameters[3].Direction = System.Data.ParameterDirection.Output;
        claSqlConnDB.ExecuteNonQuery(claSqlConnDB.gStrConnDefault, CommandType.StoredProcedure, "p_set_connect_prop", parameters);
        mIntReturn = (int)parameters[3].Value;
        return mIntReturn;
    }
}