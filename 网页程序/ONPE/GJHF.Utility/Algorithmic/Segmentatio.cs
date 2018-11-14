using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;

namespace GJHF.Utility.Algorithmic
{
    public class Segmentatio
    {
        public static DataTable DataSegmentationAlongEnt(DataTable v_source_datatable, int v_segmentation_number)
        {
            DataTable dt = null;

            if (v_source_datatable == null) return v_source_datatable;

            int t = v_source_datatable.Rows.Count;
            if (v_segmentation_number < 2) return v_source_datatable;//如果分段数小于2，则不分段

            int mIntSlice = t / v_segmentation_number;//切片大小
            if (mIntSlice < 2) return v_source_datatable;//如果每个切片大小中数据量小于2，则不分段

            dt = v_source_datatable.Clone();
            dt.Clear();
            //取第一片的中间值
            int mIntMiddleSlice = (mIntSlice + 1) / 2;
            for (int i = 0; i < v_segmentation_number; i++)
            {
                int mIntPoint = (i * mIntSlice) + mIntMiddleSlice; //每一个点的坐标
                DataRow dr = v_source_datatable.Rows[mIntPoint];
                dt.Rows.Add(dr.ItemArray);
            }
            return dt;
        }
        //public static DataTable DataSegmentationExtremum(DataTable v_source_datatable, int v_extremum_number,string v_data_column_name)
        //{
        //    DataTable dt = null;
        //    if (v_source_datatable == null) return v_source_datatable;

        //    int t = v_source_datatable.Rows.Count;
        //    if (t < v_extremum_number) return v_source_datatable;//如果数据总数小于待取的极值点数，则返回原数据

        //    v_source_datatable.DefaultView.Sort = v_data_column_name + " ASC";
        //    DataTable mDTTemp = v_source_datatable.DefaultView.ToTable();
        //    if (v_extremum_number % 2 == 0)
        //    {
                
        //    }

        //    return dt;
        //}
    }
}
