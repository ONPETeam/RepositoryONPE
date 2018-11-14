using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;

namespace GJHF.Business.SYS
{
    public class IOSSound
    {
        private GJHF.Data.Interface.SYS.ISysIOSSound BSysIOSSound;
        public IOSSound()
        {
            this.BSysIOSSound = GJHF.Data.Factory.SYS.FSysIOSSound.Create();
        }
        public int AddIOSSound(string v_sound_name, string v_sound_code, string v_sound_remark)
        {
            return BSysIOSSound.AddIOSSound(v_sound_name, v_sound_code, v_sound_remark);
        }

        public int EditIOSSound(int v_sound_id, string v_sound_name, string v_sound_code, string v_sound_remark)
        {
            return BSysIOSSound.EditIOSSound(v_sound_id, v_sound_name, v_sound_code, v_sound_remark);
        }

        public int DelIOSSound(int v_sound_id)
        {
            return BSysIOSSound.DelIOSSound(v_sound_id);
        }

        public int GetIOSSoundCount(string v_sound_name, string v_sound_code, string v_sound_remark)
        {
            return BSysIOSSound.GetIOSSoundCount(v_sound_name, v_sound_code, v_sound_remark);
        }

        public DataTable GetIOSSoundData(string v_sound_name, string v_sound_code, string v_sound_remark)
        {
            return BSysIOSSound.GetIOSSoundData(v_sound_name, v_sound_code, v_sound_remark);
        }

        public DataTable GetIOSSoundData(string v_sound_name, string v_sound_code, string v_sound_remark, string v_sort, string v_order)
        {
            return BSysIOSSound.GetIOSSoundData(v_sound_name, v_sound_code, v_sound_remark, v_sort, v_order);
        }

        public DataTable GetIOSSoundData(int v_page, int v_rows, string v_sound_name, string v_sound_code, string v_sound_remark, string v_sort, string v_order)
        {
            return BSysIOSSound.GetIOSSoundData(v_page, v_rows, v_sound_name, v_sound_code, v_sound_remark, v_sort, v_order);
        }
    }
}
