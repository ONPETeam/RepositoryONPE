using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;

namespace GJHF.Data.Interface.SYS
{
    public interface ISysAndroidBuildID
    {
        int AddAndroidBuildID(string v_build_name, int v_build_id, string v_build_remark);

        int EditAndroidBuildID(int v_data_id, string v_build_name, int v_build_id, string v_build_remark);

        int DelAndroidBuildID(int v_data_id);

        int GetAndroidBuildIDCount(string v_build_name, string v_build_remark, int v_build_id = -1);

        DataTable GetAndroidBuildIDData(string v_build_name, string v_build_remark, int v_build_id = -1);

        DataTable GetAndroidBuildIDData(string v_build_name, string v_build_remark, string v_sort, string v_order, int v_build_id = -1);

        DataTable GetAndroidBuildIDData(int v_page, int v_rows, string v_build_name,  string v_build_remark, string v_sort, string v_order,int v_build_id=-1);
    }
}
