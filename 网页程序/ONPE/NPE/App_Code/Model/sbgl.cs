using System;
using System.Collections.Generic;
using System.Web;

namespace ModelClass
{
    public class area
    {
        public int area_id { get; set; }
        public string area_name { get; set; }
        public int area_parent { get; set; }
        public string area_parent_name { get; set; }
        public string area_code { get; set; }
        public string area_remark { get; set; }

    }

    public class equip
    {
        public string equip_code { get; set; }
        public string equip_innum { get; set; }
        public string equip_name { get; set; }
        public string equip_mark { get; set; }
        public string equip_type { get; set; }
        public string equip_parent { get; set; }
        public string equip_parent_name { get; set; }
        public string area_id { get; set; }
        public string area_name { get; set; }
        public string equip_manageDep { get; set; }
        public string equip_manageDep_name { get; set; }
        public string equip_manage_company { get; set; }
        public string equip_manage_company_name { get; set; }
        public string equip_checkDep { get; set; }
        public string equip_checkDep_name { get; set; }
        public string equip_check_company { get; set; }
        public string equip_check_company_name { get; set; }
        public string equip_header { get; set; }
        public string equip_remark { get; set; }
    }

    public class correquip
    {
        public string correlation_id { get; set; }
        public string correlation_equip_master_id { get; set; }
        public string correlation_equip_master_name { get; set; }
        public string correlation_equip_master_parent_code { get; set; }
        public string correlation_equip_master_parent_name { get; set; }
        public string correlation_equip_master_area_id { get; set; }
        public string correlation_equip_master_area_name { get; set; }
        public string correlation_equip_servant_id { get; set; }
        public string correlation_equip_servant_name { get; set; }
        public string correlation_equip_servant_parent_code { get; set; }
        public string correlation_equip_servant_parent_name { get; set; }
        public string correlation_equip_servant_area_id { get; set; }
        public string correlation_equip_servant_area_name { get; set; }
    }

    public class fileequip
    {
        public string equipfile_code { get; set; }
        public string equip_code { get; set; }
        //public string equip_innum { get; set; }
        public string equip_name { get; set; }
        public string equip_parent_code { get; set; }
        public string equip_parent_name { get; set; }
        public string area_id { get; set; }
        public string area_name { get; set; }
        public string file_code { get; set; }
        public string file_name { get; set; }
        public string fileclass_code { get; set; }
        public string fileclass_name { get; set; }
        public string diretory_code { get; set; }
        public string diretory_name { get; set; }
    }
}


