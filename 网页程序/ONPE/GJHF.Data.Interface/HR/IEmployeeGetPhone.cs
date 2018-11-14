using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace GJHF.Data.Interface.HR
{
    public interface IEmployeeGetPhone
    {
        Dictionary<string, string> GetEmployeePhoneNoByCode(List<string> v_employee_code);

        Dictionary<string, string> GetPhoneByUserGroup(List<string> v_employee_code);
        Dictionary<string, string> GetPhoneByUserRole(List<string> v_employee_code);
        Dictionary<string, string> GetPhoneByBranchID(List<string> v_employee_code);
        Dictionary<string, string> GetPhoneByCompanyID(List<string> v_employee_code);
        Dictionary<string, string> GetPhoneByMajorCode(List<string> v_employee_code);
        Dictionary<string, string> GetPhoneByPostCode(List<string> v_employee_code);
        Dictionary<string, string> GetPhoneByJobCode(List<string> v_employee_code);
    }
}
