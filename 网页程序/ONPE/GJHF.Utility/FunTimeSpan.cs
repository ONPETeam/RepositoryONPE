using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace GJHF.Utility
{
    public class FunTimeSpan
    {
        private FunTimeSpan() { 
        }
        public static long GetYearsFromSpan(TimeSpan v_time_span)
        {
            if (v_time_span != null)
            {
                if (v_time_span.Days > 0)
                {
                    return v_time_span.Days / 30 / 12;
                }
                else
                {
                    return 0;
                }
            }
            else
            {
                return 0;
            }
        }
        public static long GetMonthsFromSpan(TimeSpan v_time_span)
        {
            if (v_time_span != null)
            {
                if (v_time_span.Days > 0)
                {
                    return v_time_span.Days / 30 ;
                }
                else
                {
                    return 0;
                }
            }
            else
            {
                return 0;
            }
        }
        public static long GetDaysFromSpan(TimeSpan v_time_span)
        {
            if (v_time_span != null)
            {
                return v_time_span.Days;
            }
            else
            {
                return 0;
            }
        }
        public static long GetHoursFromSpan(TimeSpan v_time_span)
        {
            if (v_time_span != null)
            {
                return v_time_span.Days * 24 + v_time_span.Hours;
            }
            else
            {
                return 0;
            }
        }
        public static long GetMinutesFromSpan(TimeSpan v_time_span)
        {
            if (v_time_span != null)
            {
                return v_time_span.Days * 24 * 60 + v_time_span.Hours * 60 + v_time_span.Minutes;
            }
            else
            {
                return 0;
            }
        }
        public static long GetSecondsFromSpan(TimeSpan v_time_span)
        {
            if (v_time_span != null)
            {
                return v_time_span.Days * 24 * 60 * 60 + v_time_span.Hours * 60 * 60 + v_time_span.Minutes * 60 + v_time_span.Seconds;
            }
            else
            {
                return 0;
            }
        }
        /// <summary>
        /// 获取TimeSpan的中文描述，例如“123天4小时5分钟6秒7毫秒”
        /// </summary>
        /// <param name="v_time_span">TimeSpan</param>
        /// <param name="v_spara_year_month">为True时表示使用“年月日”注：年月日方式不准确，只能为“大约”  为False时不拆解为年月日</param>
        /// <returns></returns>
        public static string GetChinaDescription(TimeSpan v_time_span,bool v_spara_year_month)
        {
            string mStrChinaDescription = "";
            if (v_time_span != null)
            {
                if (v_time_span.Days > 0)
                {
                    if (v_time_span.Days / 365 > 0)
                    {
                        mStrChinaDescription = mStrChinaDescription + (v_time_span.Days / 365).ToString() + "年";
                    }
                    if (v_time_span.Days % 365 / 30 > 0)
                    {
                        mStrChinaDescription = mStrChinaDescription + (v_time_span.Days % 365 / 30).ToString() + "月";
                    }
                    if (v_time_span.Days % 365 % 30 > 0)
                    {
                        mStrChinaDescription = mStrChinaDescription + (v_time_span.Days % 365 % 30).ToString() + "天";
                    }
                }
                if (v_time_span.Hours > 0)
                {
                    mStrChinaDescription = mStrChinaDescription + v_time_span.Hours.ToString() + "小时";
                }
                if (v_time_span.Minutes > 0)
                {
                    mStrChinaDescription = mStrChinaDescription + v_time_span.Minutes.ToString() + "分钟";
                }
                if (v_time_span.Seconds > 0)
                {
                    mStrChinaDescription = mStrChinaDescription + v_time_span.Seconds.ToString() + "秒";
                }
                if (v_time_span.Milliseconds > 0)
                {
                    mStrChinaDescription = mStrChinaDescription + v_time_span.Milliseconds.ToString() + "毫秒";
                }
            }
            return mStrChinaDescription;
        }
    }
}
