using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;

namespace GJHF.Data.Interface.HR
{
    public interface IHRCompany
    {
        int AddCompany( string dVchCompanyName, string dVchShortName, string dVchZZJGDM, string dVchAddress, string dVchPhone, string dVchWeb, string dVchEmail, int dIntFlagSelf);

        int EditCompany(int dIntCompanyID, string dVchCompanyName, string dVchShortName, string dVchZZJGDM, string dVchAddress, string dVchPhone, string dVchWeb, string dVchEmail, int dIntFlagSelf);

        int DelCompany(int dIntCompanyID);

        int GetCompanyCount(string dVchCompanyName, string dVchShortName, string dVchZZJGDM, string dVchAddress, string dVchPhone, string dVchWeb, string dVchEmail);

        DataTable GetCompany(string dVchCompanyName, string dVchShortName, string dVchZZJGDM, string dVchAddress, string dVchPhone, string dVchWeb, string dVchEmail);

        DataTable GetCompany(string dVchCompanyName, string dVchShortName, string dVchZZJGDM, string dVchAddress, string dVchPhone, string dVchWeb, string dVchEmail,string v_sort,string v_order);

        DataTable GetCompany(int v_page,int v_rows,string dVchCompanyName, string dVchShortName, string dVchZZJGDM, string dVchAddress, string dVchPhone, string dVchWeb, string dVchEmail, string v_sort, string v_order);

        Dictionary<string,object> GetCompanyDetail(int dIntCompanyID);
    }
}
