using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace GJHF.Utility.Algorithmic
{
    public class FindPeaks
    {
        public static List<int> GetPeaksIndex(List<double> v_source_data, int v_dis_peak)
        {
            List<int> mIntIndex = new List<int>();
            mIntIndex = GetPeaksIndex(TrendSign(OneDiff(v_source_data)));
            //int mIntLevel = 1;
            //while (v_dis_peak > mIntLevel)
            //{
            //    mIntLevel++;
            //    List<int> mIntResult = DoPeakInstance(v_source_data, mIntIndex, mIntLevel);
            //    mIntIndex = null;
            //    mIntIndex = mIntResult;
            //}
            //mIntIndex = GetFinalPeaks(v_source_data, mIntIndex, v_dis_peak);
            return mIntIndex;
        }
        /// <summary>
        /// 一步差
        /// </summary>
        /// <param name="v_source_data"></param>
        /// <returns></returns>
        private static double[] OneDiff(List<double> v_source_data)
        {
            double[] mDblResult = new double[v_source_data.Count - 1];
            for (int i = 0; i < mDblResult.Length; i++)
            {
                mDblResult[i] = v_source_data[i + 1] - v_source_data[i];
            }
            return mDblResult;
        }

        /// <summary>
        /// 趋势判定
        /// </summary>
        /// <param name="v_source_data"></param>
        /// <returns></returns>
        private static int[] TrendSign(double[] v_source_data)
        {
            int[] mIntSign = new int[v_source_data.Length];
            for (int i = 0; i < mIntSign.Length; i++)
            {
                if (v_source_data[i] > 0) mIntSign[i] = 1;
                else if (v_source_data[i] == 0) mIntSign[i] = 0;
                else mIntSign[i] = -1;
            }

            for (int i = mIntSign.Length - 1; i >= 0; i--)
            {
                if (mIntSign[i] == 0 && i == mIntSign.Length - 1)
                {
                    mIntSign[i] = 1;
                }
                else if (mIntSign[i] == 0)
                {
                    if (mIntSign[i + 1] >= 0)
                    {
                        mIntSign[i] = 1;
                    }
                    else
                    {
                        mIntSign[i] = -1;
                    }
                }
            }
            return mIntSign;
        }

        /// <summary>
        /// 获取峰值坐标
        /// </summary>
        /// <param name="v_diff_data"></param>
        /// <returns></returns>
        private static List<int> GetPeaksIndex(int[] v_diff_data)
        {
            List<int> mIntIndexData = new List<int>();
            for (int i = 0; i != v_diff_data.Length - 1; i++)
            {
                if (v_diff_data[i + 1] - v_diff_data[i] == -2)
                {
                    mIntIndexData.Add(i + 1);
                }
                if (v_diff_data[i + 1] - v_diff_data[i] == 2)
                {
                    mIntIndexData.Add(i + 1);
                }
            }
            return mIntIndexData;
        }

        /// <summary>
        /// 扩大寻峰范围
        /// </summary>
        /// <param name="v_source_data"></param>
        /// <param name="v_peak_index"></param>
        /// <param name="v_fonud_level"></param>
        /// <returns></returns>
        private static List<int> DoPeakInstance(List<double> v_source_data, List<int> v_peak_index, int v_fonud_level)
        {
            List<int> mIntResult = new List<int>();
            for (int i = 0; i < v_peak_index.Count; i++)
            {
                if (v_peak_index[i] - v_fonud_level >= 0 && v_peak_index[i] + v_fonud_level < v_source_data.Count)
                {
                    if (v_source_data[v_peak_index[i] + v_fonud_level] <= v_source_data[v_peak_index[i]] && v_source_data[v_peak_index[i] - v_fonud_level] <= v_source_data[v_peak_index[i]])
                    {
                        mIntResult.Add(v_peak_index[i]);
                    }
                }
            }
            return mIntResult;
        }

        /// <summary>
        /// 边峰问题
        /// </summary>
        /// <param name="v_source_data"></param>
        /// <param name="v_peak_index"></param>
        /// <param name="v_dis_peak"></param>
        /// <returns></returns>
        private static List<int> GetFinalPeaks(List<double> v_source_data, List<int> v_peak_index, int v_dis_peak)
        {
            int mIntTopIndex = 0;
            int mIntBottomIndex = v_source_data.Count - 1;
            for (int i = 0; i < v_dis_peak; i++)
            {
                if (v_source_data[i] >= v_source_data[mIntTopIndex])
                {
                    mIntTopIndex = i;
                }
                if (v_source_data[mIntBottomIndex - i] >= v_source_data[mIntBottomIndex])
                {
                    mIntBottomIndex = v_source_data.Count - 1 - i;
                }
            }

            int mIntNewTopIndex = mIntTopIndex;
            int mIntNewBottomIndex = mIntBottomIndex;
            for (int i = 0; i <= v_dis_peak; i++)
            {
                if (v_source_data[mIntTopIndex + i] >= v_source_data[mIntTopIndex])
                {
                    mIntNewTopIndex = mIntTopIndex + i;
                }
                if (v_source_data[mIntBottomIndex - i] > v_source_data[mIntBottomIndex])
                {
                    mIntNewBottomIndex = mIntBottomIndex + i;
                }
            }

            mIntTopIndex = mIntNewTopIndex;

            mIntBottomIndex = mIntNewBottomIndex;

            if (mIntTopIndex <= v_dis_peak)
            {
                v_peak_index.Insert(0, mIntTopIndex);
            }
            if (mIntBottomIndex >= v_source_data.Count - v_dis_peak)
            {
                v_peak_index.Add(mIntBottomIndex);
            }
            return v_peak_index;
        }
    }
}
