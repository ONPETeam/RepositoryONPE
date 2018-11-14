using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.ComponentModel;

namespace GJHF.Data.Model.HR
{
    public class Company
    {
        [DisplayName("公司编号")]
        public int dIntCompanyID { get; set; }
        [DisplayName("公司名称")]
        public string dVchCompanyName { get; set; }
        [DisplayName("公司简称")]
        public string dVchShortName { get; set; }
        [DisplayName("组织机构代码")]
        public string dVchZZJGDM { get; set; }
        [DisplayName("公司地址")]
        public string dVchAddress { get; set; }
        [DisplayName("公司电话")]
        public string dVchPhone { get; set; }
        [DisplayName("公司网址")]
        public string dVchWeb { get; set; }
        [DisplayName("公司邮箱")]
        public string dVchEmail { get; set; }
        [DisplayName("是否本公司")]
        public int dIntFlagSelf { get; set; }
    }
}
