using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;

namespace GJHF.Business.HR
{
    
    public class Company
    {
        private GJHF.Data.Interface.HR.IHRCompany BHRCompany;
        public Company() {
            this.BHRCompany = GJHF.Data.Factory.HR.FHRCompany.Create();
        }
        public int AddCompany(string dVchCompanyName, string dVchShortName, string dVchZZJGDM, string dVchAddress, string dVchPhone, string dVchWeb, string dVchEmail, int dIntFlagSelf)
        {
            return BHRCompany.AddCompany(dVchCompanyName, dVchShortName, dVchZZJGDM, dVchAddress, dVchPhone, dVchWeb, dVchEmail, dIntFlagSelf);
        }

        public int EditCompany(int dIntCompanyID, string dVchCompanyName, string dVchShortName, string dVchZZJGDM, string dVchAddress, string dVchPhone, string dVchWeb, string dVchEmail, int dIntFlagSelf)
        {
            return BHRCompany.EditCompany(dIntCompanyID, dVchCompanyName, dVchShortName, dVchZZJGDM, dVchAddress, dVchPhone, dVchWeb, dVchEmail, dIntFlagSelf);
        }

        public int DelCompany(int dIntCompanyID)
        {
            return BHRCompany.DelCompany(dIntCompanyID);
        }

        public int GetCompanyCount(string dVchCompanyName, string dVchShortName, string dVchZZJGDM, string dVchAddress, string dVchPhone, string dVchWeb, string dVchEmail)
        {
            return BHRCompany.GetCompanyCount(dVchCompanyName, dVchShortName, dVchZZJGDM, dVchAddress, dVchPhone, dVchWeb, dVchEmail);
        }

        public DataTable GetCompany(string dVchCompanyName, string dVchShortName, string dVchZZJGDM, string dVchAddress, string dVchPhone, string dVchWeb, string dVchEmail)
        {
            return BHRCompany.GetCompany(dVchCompanyName, dVchShortName, dVchZZJGDM, dVchAddress, dVchPhone, dVchWeb, dVchEmail);
        }

        public DataTable GetCompany(string dVchCompanyName, string dVchShortName, string dVchZZJGDM, string dVchAddress, string dVchPhone, string dVchWeb, string dVchEmail, string v_sort, string v_order)
        {
            return BHRCompany.GetCompany(dVchCompanyName, dVchShortName, dVchZZJGDM, dVchAddress, dVchPhone, dVchWeb, dVchEmail,v_sort,v_order);
        }

        public DataTable GetCompany(int v_page, int v_rows, string dVchCompanyName, string dVchShortName, string dVchZZJGDM, string dVchAddress, string dVchPhone, string dVchWeb, string dVchEmail, string v_sort, string v_order)
        {
            return BHRCompany.GetCompany(v_page, v_rows, dVchCompanyName, dVchShortName, dVchZZJGDM, dVchAddress, dVchPhone, dVchWeb, dVchEmail, v_sort, v_order);
        }

        public Dictionary<string, object> GetCompanyDetail(int dIntCompanyID)
        {
            return BHRCompany.GetCompanyDetail(dIntCompanyID);
        }
    }
}
