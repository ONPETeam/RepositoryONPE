using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace GJHF.Data.Interface.User
{
    public interface IUser
    {
        string GetOldUserRight(string v_user_code, int v_right_class, int v_right_type, string v_spara_code);
        string GetAllUserRight(int v_right_class, int v_right_type, string v_spara_code);
        string GetUserRight(string v_user_code, int v_right_class, int v_right_type, string v_spara_code);
        string ConvertIdToRemark(string vStrIDString, string v_spara_code);

        int SetDefaultRightGroup(string v_user_id);

        bool IsExistUser(string v_user_id);
    }
}
