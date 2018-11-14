using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace GJHF.Data.Interface.PUSH
{
    public interface IPushTarget
    {
        string GetRegistrationIDByEmployeeCode(string v_employee_code);
        /// <summary>
        /// 根据员工编号获取推送注册ID
        /// </summary>
        /// <param name="v_employee_codes">员工编号集</param>
        /// <returns>以员工编号为主键的键值对，当值为空时，表示未获取到注册ID</returns>
        Dictionary<string,string> GetRegistrationIDsByEmployeeCodes(HashSet<string> v_employee_codes);

    }
}
