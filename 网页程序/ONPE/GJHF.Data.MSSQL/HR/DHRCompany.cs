using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using System.Data.SqlClient;
using GJHF.Data.Interface.HR;

namespace GJHF.Data.MSSQL.HR
{
    public class DHRCompany:IHRCompany
    {
        #region IHRCompany 成员

        public int AddCompany(string dVchCompanyName, string dVchShortName, string dVchZZJGDM, string dVchAddress, string dVchPhone, string dVchWeb, string dVchEmail, int dIntFlagSelf)
        {
            string mStrSQL = @"insert into tHRCompany(dVchCompanyName,dVchShortName,dVchZZJGDM,dVchAddress,dVchPhone,dVchWeb,dVchEmail) 
                        values(@company_name,@short_name,@zzjg_code,@company_address,@company_phone,@company_web,@company_mail)";
            SqlParameter[] parameter = new SqlParameter[]{
            new SqlParameter("@company_name",SqlDbType.VarChar,200),
            new SqlParameter("@short_name",SqlDbType.VarChar,10),
            new SqlParameter("@zzjg_code",SqlDbType.VarChar,100),
            new SqlParameter("@company_address",SqlDbType.VarChar,200),
            new SqlParameter("@company_phone",SqlDbType.VarChar,50),
            new SqlParameter("@company_web",SqlDbType.VarChar,100),
            new SqlParameter("@company_mail",SqlDbType.VarChar,100)
        };
            parameter[0].Value = dVchCompanyName;
            parameter[1].Value = dVchShortName;
            parameter[2].Value = dVchZZJGDM;
            parameter[3].Value = dVchAddress;
            parameter[4].Value = dVchPhone;
            parameter[5].Value = dVchWeb;
            parameter[6].Value = dVchEmail;
            int i = claSqlConnDB.ExecuteNonQuery(claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL, parameter);
            return i;
        }

        public int EditCompany(int dIntCompanyID, string dVchCompanyName, string dVchShortName, string dVchZZJGDM, string dVchAddress, string dVchPhone, string dVchWeb, string dVchEmail, int dIntFlagSelf)
        {
            string mStrSQL = @"UPDATE tHRCompany SET 
                            dVchCompanyName=@company_name,
                            dVchShortName=@short_name,
                            dVchZZJGDM=@zzjg_code,
                            dVchAddress=@company_address,
                            dVchPhone=@company_phone,
                            dVchWeb=@company_web,
                            dVchEmail=@company_mail 
                        Where dIntCompanyID=@company_id";
            SqlParameter[] parameter = new SqlParameter[]{
            new SqlParameter("@company_id",SqlDbType.Int,4),
            new SqlParameter("@company_name",SqlDbType.VarChar,200),
            new SqlParameter("@short_name",SqlDbType.VarChar,10),
            new SqlParameter("@zzjg_code",SqlDbType.VarChar,100),
            new SqlParameter("@company_address",SqlDbType.VarChar,200),
            new SqlParameter("@company_phone",SqlDbType.VarChar,50),
            new SqlParameter("@company_web",SqlDbType.VarChar,100),
            new SqlParameter("@company_mail",SqlDbType.VarChar,100)
        };
            parameter[0].Value = dIntCompanyID;
            parameter[1].Value = dVchCompanyName;
            parameter[2].Value = dVchShortName;
            parameter[3].Value = dVchZZJGDM;
            parameter[4].Value = dVchAddress;
            parameter[5].Value = dVchPhone;
            parameter[6].Value = dVchWeb;
            parameter[7].Value = dVchEmail;
            int i = claSqlConnDB.ExecuteNonQuery(claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL, parameter);
            return i;
        }

        public int DelCompany(int dIntCompanyID)
        {
            string mStrSQL = @"delete from tHRCompany where dIntCompanyID=@dIntCompanyID";
            SqlParameter[] parameter = new SqlParameter[]{
                new SqlParameter("@company_id",SqlDbType.Int,4){Value = dIntCompanyID}
            };
            return claSqlConnDB.ExecuteNonQuery(claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL);
        }

        public int GetCompanyCount(string dVchCompanyName, string dVchShortName, string dVchZZJGDM, string dVchAddress, string dVchPhone, string dVchWeb, string dVchEmail)
        {
            throw new NotImplementedException();
        }

        public DataTable GetCompany(string dVchCompanyName, string dVchShortName, string dVchZZJGDM, string dVchAddress, string dVchPhone, string dVchWeb, string dVchEmail)
        {
            string mStrSQL = @"select dIntCompanyID,dVchCompanyName,dVchShortName,dVchZZJGDM,dVchAddress,dVchPhone,dVchWeb,dVchEmail,dIntFlagSelf from tHRCompany " + GetWhere(dVchCompanyName, dVchShortName, dVchZZJGDM, dVchAddress, dVchPhone, dVchWeb, dVchEmail) ;
            return claSqlConnDB.ExecuteDataset(claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL).Tables[0];
        }

        public DataTable GetCompany(string dVchCompanyName, string dVchShortName, string dVchZZJGDM, string dVchAddress, string dVchPhone, string dVchWeb, string dVchEmail, string v_sort, string v_order)
        {
            string mStrSQL = @"select dIntCompanyID,dVchCompanyName,dVchShortName,dVchZZJGDM,dVchAddress,dVchPhone,dVchWeb,dVchEmail,dIntFlagSelf from tHRCompany " + GetWhere(dVchCompanyName, dVchShortName, dVchZZJGDM, dVchAddress, dVchPhone, dVchWeb, dVchEmail) + GetOrder(v_sort, v_order);
            return claSqlConnDB.ExecuteDataset(claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL).Tables[0];
        }

        public DataTable GetCompany(int v_page, int v_rows, string dVchCompanyName, string dVchShortName, string dVchZZJGDM, string dVchAddress, string dVchPhone, string dVchWeb, string dVchEmail, string v_sort, string v_order)
        {
            string mStrSQL = @"select dIntCompanyID,dVchCompanyName,dVchShortName,dVchZZJGDM,dVchAddress,dVchPhone,dVchWeb,dVchEmail,dIntFlagSelf from tHRCompany " + GetWhere(dVchCompanyName, dVchShortName, dVchZZJGDM, dVchAddress, dVchPhone, dVchWeb, dVchEmail) + GetOrder(v_sort, v_order);
            return claSqlConnDB.ExecuteDataset(v_rows, v_page,claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL).Tables[0];
        }

        public Dictionary<string, object> GetCompanyDetail(int dIntCompanyID)
        {
            string mStrSQL = @"select dIntCompanyID,dVchCompanyName,dVchShortName,dVchZZJGDM,dVchAddress,dVchPhone,dVchWeb,dVchEmail,dIntFlagSelf from tHRCompany WHERE dIntCompanyID=@dIntCompanyID";
            SqlParameter[] parameters = new SqlParameter[]{
                new SqlParameter("@dIntCompanyID",SqlDbType.Int,4){Value=dIntCompanyID}
            };
            return GJHF.Utility.Convert.ConvertModelToDictionary(claSqlConnDB.GetDetail(claSqlConnDB.gStrConnDefault, mStrSQL, "GJHF.Data.Model.HR.Company", "GJHF.Data.Model", parameters));
        }

        #endregion

        private string GetWhere(string dVchCompanyName, string dVchShortName, string dVchZZJGDM, string dVchAddress, string dVchPhone, string dVchWeb, string dVchEmail)
        {
            string mStrWhere = " Where 1=1 ";
            if (dVchCompanyName != "")
            {
                mStrWhere += " AND tHRCompany.dVchCompanyName like '%" + dVchCompanyName + "%'";
            }
            if (dVchShortName != "")
            {
                mStrWhere += " AND tHRCompany.dVchShortName LIKE '%" + dVchShortName + "%'";
            }
            if (dVchZZJGDM != "")
            {
                mStrWhere += " AND tHRCompany.dVchZZJGDM LIKE '%" + dVchZZJGDM + "%'";
            }
            if (dVchAddress != "")
            {
                mStrWhere += " AND tHRCompany.dVchAddress LIKE '%" + dVchAddress + "%'";
            }
            if (dVchPhone != "")
            {
                mStrWhere += " AND tHRCompany.dVchPhone LIKE '%" + dVchPhone + "%'";
            }
            if (dVchWeb != "")
            {
                mStrWhere += " AND tHRCompany.dVchWeb LIKE '%" + dVchWeb + "%'";
            }
            if (dVchEmail != "")
            {
                mStrWhere += " AND tHRCompany.dVchEmail LIKE '%" + dVchEmail + "%'";
            }
            return mStrWhere;
        }
        private string GetOrder(string v_sort, string v_order)
        {
            string mStrOrder = "";
            if (v_sort != "")
            {
                mStrOrder = " order by tHRCompany." + v_sort;
                if (v_order != "")
                {
                    mStrOrder = mStrOrder + " " + v_order;
                }
            }
            return mStrOrder;
        }
    }
}
