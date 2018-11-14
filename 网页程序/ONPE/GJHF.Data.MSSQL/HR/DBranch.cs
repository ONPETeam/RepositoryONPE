using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using System.Data.SqlClient;

namespace GJHF.Data.MSSQL.HR
{
    public class DBranch:Interface.HR.IBranch
    {

        #region IBranch 成员

        public int AddBranch(string v_branch_name, string v_branch_innum, int v_branch_parent, int v_company_id)
        {
            string mStrSQL = @"insert into tHRBranchInfo(dVchBranchName,dVchBranchPY,dIntUpBranch,dIntCompanyID) 
                                values(@branch_name,@branch_innum,@branch_parent,@company_id)";
            SqlParameter[] parameters = new SqlParameter[]{
                new SqlParameter("@branch_name",SqlDbType.VarChar,200){Value=v_branch_name},
                new SqlParameter("@branch_innum",SqlDbType.VarChar,100){Value=v_branch_innum},
                new SqlParameter("@branch_parent",SqlDbType.Int){Value=v_branch_parent},
                new SqlParameter("@company_id",SqlDbType.Int){Value=v_company_id}
            };
            int i = claSqlConnDB.ExecuteNonQuery(claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL);
            return i;
        }

        public int EditBranch(int v_branch_id, string v_branch_name, string v_branch_innum, int v_branch_parent, int v_company_id)
        {
            string mStrSQL = @"update tHRBranchInfo set 
                    dVchBranchName=@branch_name,
                    dVchBranchPY=@branch_innum,
                    dIntUpBranch=@branch_parent,
                    dIntCompanyID=@company_id
                    where dIntBranchID=@branch_id";
            SqlParameter[] parameters = new SqlParameter[]{
            new SqlParameter("@branch_id",SqlDbType.Int,4),
            new SqlParameter("@branch_name",SqlDbType.VarChar,200),
            new SqlParameter("@branch_innum",SqlDbType.VarChar,100),
            new SqlParameter("@branch_parent",SqlDbType.Int,4),
            new SqlParameter("@company_id",SqlDbType.Int,4),
        };
            parameters[0].Value = v_branch_id;
            parameters[1].Value = v_branch_name;
            parameters[2].Value = v_branch_innum;
            parameters[3].Value = v_branch_parent;
            parameters[4].Value = v_company_id;
            int i = claSqlConnDB.ExecuteNonQuery(claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL, parameters);
            return i;
        }

        public int DelBranch(int v_branch_id)
        {
            string mStrSQL = @"delete from tHRBranchInfo where dIntBranchID=" + v_branch_id;
            int i = claSqlConnDB.ExecuteNonQuery(claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL);
            return i;
        }

        public int GetBranchCount(int v_company_id, int v_branch_parent, string v_branch_name, string v_branch_innum)
        {
            string mStrSQL = @"SELECT     count(0)
                            FROM      tHRBranchInfo left outer JOIN
                                      tHRBranchInfo AS tHRBranchInfo_1 ON tHRBranchInfo.dIntUpBranch = tHRBranchInfo_1.dIntBranchID LEFT OUTER JOIN
                                      tHRCompany ON tHRBranchInfo.dIntCompanyID = tHRCompany.dIntCompanyID" + GetWhere(v_company_id, v_branch_parent, v_branch_name, v_branch_innum);
            return claSqlConnDB.GetRecordCount(claSqlConnDB.gStrConnDefault, mStrSQL);
        }

        public DataTable GetBranch(int v_company_id, int v_branch_parent, string v_branch_name, string v_branch_innum)
        {
            string mStrSQL = @"SELECT     tHRBranchInfo.dIntBranchID, tHRBranchInfo.dVchBranchName, tHRBranchInfo.dVchBranchPY, tHRBranchInfo.dIntUpBranch, tHRBranchInfo_1.dVchBranchName AS dVchUpBranchName, 
                                      tHRBranchInfo.dIntCompanyID, tHRCompany.dVchCompanyName
                            FROM      tHRBranchInfo left outer JOIN
                                      tHRBranchInfo AS tHRBranchInfo_1 ON tHRBranchInfo.dIntUpBranch = tHRBranchInfo_1.dIntBranchID LEFT OUTER JOIN
                                      tHRCompany ON tHRBranchInfo.dIntCompanyID = tHRCompany.dIntCompanyID" + GetWhere(v_company_id, v_branch_parent, v_branch_name, v_branch_innum);
            return claSqlConnDB.ExecuteDataset(claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL).Tables[0];
        }

        public DataTable GetBranch(int v_company_id, int v_branch_parent, string v_branch_name, string v_branch_innum, string v_sort, string v_order)
        {
            string mStrSQL = @"SELECT     tHRBranchInfo.dIntBranchID, tHRBranchInfo.dVchBranchName, tHRBranchInfo.dVchBranchPY, tHRBranchInfo.dIntUpBranch, tHRBranchInfo_1.dVchBranchName AS dVchUpBranchName, 
                                      tHRBranchInfo.dIntCompanyID, tHRCompany.dVchCompanyName
                            FROM      tHRBranchInfo left outer JOIN
                                      tHRBranchInfo AS tHRBranchInfo_1 ON tHRBranchInfo.dIntUpBranch = tHRBranchInfo_1.dIntBranchID LEFT OUTER JOIN
                                      tHRCompany ON tHRBranchInfo.dIntCompanyID = tHRCompany.dIntCompanyID" + GetWhere(v_company_id, v_branch_parent, v_branch_name, v_branch_innum)
                                                                                                             + GetOrder(v_sort, v_order);
            return claSqlConnDB.ExecuteDataset(claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL).Tables[0];
        }

        public DataTable GetBranch(int v_page, int v_rows, int v_company_id, int v_branch_parent, string v_branch_name, string v_branch_innum, string v_sort, string v_order)
        {
            string mStrSQL = @"SELECT     tHRBranchInfo.dIntBranchID, tHRBranchInfo.dVchBranchName, tHRBranchInfo.dVchBranchPY, tHRBranchInfo.dIntUpBranch, tHRBranchInfo_1.dVchBranchName AS dVchUpBranchName, 
                                      tHRBranchInfo.dIntCompanyID, tHRCompany.dVchCompanyName
                            FROM      tHRBranchInfo left outer JOIN
                                      tHRBranchInfo AS tHRBranchInfo_1 ON tHRBranchInfo.dIntUpBranch = tHRBranchInfo_1.dIntBranchID LEFT OUTER JOIN
                                      tHRCompany ON tHRBranchInfo.dIntCompanyID = tHRCompany.dIntCompanyID" + GetWhere(v_company_id, v_branch_parent, v_branch_name, v_branch_innum)
                                                                                                            + GetOrder(v_sort, v_order);
            return claSqlConnDB.ExecuteDataset(v_rows,v_page,claSqlConnDB.gStrConnDefault, CommandType.Text, mStrSQL).Tables[0];
        }

        public Dictionary<string, object> GetBranchDetail(int v_branch_id)
        {
            Dictionary<string, object> mDic = new Dictionary<string, object>();
            string mStrSQL = @"SELECT tHRBranchInfo.dIntBranchID as branch_id, tHRBranchInfo.dVchBranchName as branch_name, tHRBranchInfo.dVchBranchPY as branch_innum, 
                                tHRBranchInfo.dIntUpBranch as branch_parent_id, tHRBranchInfo_1.dVchBranchName AS branch_parent_name, 
                                      tHRBranchInfo.dIntCompanyID as company_id, tHRCompany.dVchCompanyName as company_name WHERE tHRBranchInfo.dIntBranchID=@branch_id";
            SqlParameter[] paramters = new SqlParameter[]{
                new SqlParameter("@branch_id",SqlDbType.Int){Value=v_branch_id}
            };
            mDic = GJHF.Utility.Convert.ConvertModelToDictionary((Model.HR.Branch)claSqlConnDB.GetDetail(claSqlConnDB.gStrConnDefault, mStrSQL, "GJHF.Data.Model.HR.Branch", "GJHF.Data.Model", paramters));
            return mDic;
        }

        #endregion

        private string GetWhere(int v_company_id, int v_branch_parent, string v_branch_name, string v_branch_innum)
        {
            string mStrWhere = " WHERE 1=1 ";
            if (v_company_id > 0)
            {
                mStrWhere = mStrWhere + " AND tHRBranchInfo.dIntCompanyID =" + v_company_id + " ";
            }
            if (v_branch_parent > 0)
            {
                mStrWhere = mStrWhere + " AND tHRBranchInfo.dIntUpBranch =" + v_branch_parent + " ";
            }
            if (v_branch_name != "")
            {
                mStrWhere = mStrWhere + " AND tHRBranchInfo.dVchBranchName like '%" + v_branch_name + "%' ";
            }
            if (v_branch_innum != "")
            {
                mStrWhere = mStrWhere + " AND tHRBranchInfo.dVchBranchPY like '%" + v_branch_name + "%' ";
            }
            return mStrWhere;
        }
        private string GetOrder(string v_sort, string v_order)
        {
            string mStrOrder = "";
            if (v_sort != "")
            {
                mStrOrder = " ORDER BY tHRBranchInfo." + v_sort;
                if (v_order != "")
                {
                    mStrOrder = mStrOrder + " " + v_order;
                }
            }
            return mStrOrder;
        }
    }
}
