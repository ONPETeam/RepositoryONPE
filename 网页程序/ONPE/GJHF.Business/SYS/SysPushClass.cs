using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;

namespace GJHF.Business.SYS
{
    public class SysPushClass
    {
        private GJHF.Data.Interface.SYS.ISysPushClass BSysPushClass;
        public SysPushClass()
        {
            this.BSysPushClass = GJHF.Data.Factory.SYS.FSysPushClass.Create();
        }
        public int AddPushClass(string v_class_name, string v_class_remark, int v_android_buildid=0, int v_ios_sound=0)
        {
            return BSysPushClass.AddPushClass(v_class_name, v_class_remark, v_android_buildid, v_ios_sound);
        }

        public int EditPushClass(string v_class_id, string v_class_name, string v_class_remark, int v_android_buildid = 0, int v_ios_sound = 0)
        {
            return BSysPushClass.EditPushClass(v_class_id, v_class_name, v_class_remark, v_android_buildid, v_ios_sound);
        }

        public int DelPushClass(string v_class_id)
        {
            return BSysPushClass.DelPushClass(v_class_id);
        }

        public int GetPushClassCount(string v_class_name, string v_class_remark, int v_android_buildid = -1, int v_ios_sound = -1)
        {
            return BSysPushClass.GetPushClassCount(v_class_name, v_class_remark, v_android_buildid, v_ios_sound);
        }

        public DataTable GetPushClassData(string v_class_name, string v_class_remark, int v_android_buildid = -1, int v_ios_sound = -1)
        {
            return BSysPushClass.GetPushClassData(v_class_name, v_class_remark, v_android_buildid, v_ios_sound);
        }

        public DataTable GetPushClassData(string v_class_name, string v_class_remark, string v_sort, string v_order, int v_android_buildid = -1, int v_ios_sound = -1)
        {
            return BSysPushClass.GetPushClassData(v_class_name, v_class_remark, v_sort, v_order, v_android_buildid, v_ios_sound);
        }

        public DataTable GetPushClassData(int v_page, int v_rows, string v_class_name, string v_class_remark, string v_sort, string v_order, int v_android_buildid = -1, int v_ios_sound = -1)
        {
            return BSysPushClass.GetPushClassData(v_page, v_rows, v_class_name, v_class_remark, v_sort, v_order, v_android_buildid, v_ios_sound);
        }

        public int GetAndroidBuildIDByClassID(string v_class_id)
        {
            return BSysPushClass.GetAndroidBuildIDByClassID(v_class_id);
        }

        public string GetIosSoundByClassID(string v_class_id)
        {
            return BSysPushClass.GetIosSoundByClassID(v_class_id);
        }
    }
}
