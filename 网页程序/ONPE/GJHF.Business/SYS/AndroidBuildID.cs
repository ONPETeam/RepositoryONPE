using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;

namespace GJHF.Business.SYS
{
    public class AndroidBuildID
    {
        private GJHF.Data.Interface.SYS.ISysAndroidBuildID BSysAndroidBuildID;
        public AndroidBuildID()
        {
            this.BSysAndroidBuildID = GJHF.Data.Factory.SYS.FSysAndroidBuildID.Create();
        }
        public int AddAndroidBuildID(string v_build_name, int v_build_id, string v_build_remark)
        {
            return BSysAndroidBuildID.AddAndroidBuildID(v_build_name, v_build_id, v_build_remark);
        }

        public int EditAndroidBuildID(int v_data_id, string v_build_name, int v_build_id, string v_build_remark)
        {
            return BSysAndroidBuildID.EditAndroidBuildID(v_data_id, v_build_name, v_build_id, v_build_remark);
        }

        public int DelAndroidBuildID(int v_data_id)
        {
            return BSysAndroidBuildID.DelAndroidBuildID(v_data_id);
        }

        public int GetAndroidBuildIDCount(string v_build_name, string v_build_remark, int v_build_id = -1)
        {
            return BSysAndroidBuildID.GetAndroidBuildIDCount(v_build_name, v_build_remark, v_build_id);
        }

        public DataTable GetAndroidBuildIDData(string v_build_name, string v_build_remark, int v_build_id = -1)
        {
            return BSysAndroidBuildID.GetAndroidBuildIDData(v_build_name, v_build_remark, v_build_id);
        }

        public DataTable GetAndroidBuildIDData(string v_build_name, string v_build_remark, string v_sort, string v_order, int v_build_id = -1)
        {
            return BSysAndroidBuildID.GetAndroidBuildIDData(v_build_name, v_build_remark, v_sort, v_order, v_build_id);
        }

        public DataTable GetAndroidBuildIDData(int v_page, int v_rows, string v_build_name, string v_build_remark, string v_sort, string v_order, int v_build_id = -1)
        {
            return BSysAndroidBuildID.GetAndroidBuildIDData(v_page, v_rows, v_build_name, v_build_remark, v_sort, v_order, v_build_id);
        }
    }
}
