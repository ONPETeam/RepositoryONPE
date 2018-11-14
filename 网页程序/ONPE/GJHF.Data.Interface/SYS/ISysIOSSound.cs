using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;

namespace GJHF.Data.Interface.SYS
{
    public interface ISysIOSSound
    {
        int AddIOSSound(string v_sound_name, string v_sound_code, string v_sound_remark);

        int EditIOSSound(int v_sound_id,string v_sound_name, string v_sound_code, string v_sound_remark);

        int DelIOSSound(int v_sound_id);

        int GetIOSSoundCount(string v_sound_name, string v_sound_code, string v_sound_remark);

        DataTable GetIOSSoundData(string v_sound_name, string v_sound_code, string v_sound_remark);

        DataTable GetIOSSoundData(string v_sound_name, string v_sound_code, string v_sound_remark,string v_sort,string v_order);

        DataTable GetIOSSoundData(int v_page,int v_rows,string v_sound_name, string v_sound_code, string v_sound_remark, string v_sort, string v_order);
    }
}
