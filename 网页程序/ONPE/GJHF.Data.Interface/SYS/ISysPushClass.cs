using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;

namespace GJHF.Data.Interface.SYS
{
    public interface  ISysPushClass
    {
        int AddPushClass(string v_class_name, string v_class_remark, int v_android_buildid = 0, int v_ios_sound = 0);

        int EditPushClass(string v_class_id, string v_class_name, string v_class_remark, int v_android_buildid = 0, int v_ios_sound = 0);

        int DelPushClass(string v_class_id);

        int GetPushClassCount(string v_class_name, string v_class_remark, int v_android_buildid = -1, int v_ios_sound = -1);

        DataTable GetPushClassData(string v_class_name, string v_class_remark, int v_android_buildid = -1, int v_ios_sound = -1);

        DataTable GetPushClassData(string v_class_name, string v_class_remark, string v_sort, string v_order, int v_android_buildid = -1, int v_ios_sound = -1);

        DataTable GetPushClassData(int v_page, int v_rows, string v_class_name, string v_class_remark, string v_sort, string v_order, int v_android_buildid = -1, int v_ios_sound = -1);

        int GetAndroidBuildIDByClassID(string v_class_id);

        string GetIosSoundByClassID(string v_class_id);

    }
}
