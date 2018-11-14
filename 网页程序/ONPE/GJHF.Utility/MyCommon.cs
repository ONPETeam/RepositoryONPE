using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace GJHF.Utility
{
    public class MyCommon
    {
        public static  bool isNumberic(string message)
        {
            if (message != "")
            {
                System.Text.RegularExpressions.Regex rex =
                new System.Text.RegularExpressions.Regex(@"^[+-]?\d*[.]?\d*$");

                if (rex.IsMatch(message))
                {
                    return true;
                }
                else
                    return false;
            }
            else
            {
                return false;
            }
        }

        //根据填写的最大值、最小值范围来计算机实际值
        public static string GetSjValue(float mfltsjMax, float mfltsjMin, float mfltBdMax, float mfltBdMin, float mfltSjValue)
        {
            string mStrGetSjValue = "";
            float mflty = mfltBdMax - mfltBdMin;
            float mfltx = mfltsjMax - mfltsjMin;
            float mfltk = 1;
            if (mfltx != 0)
            {
                mfltk = mflty / mfltx;
                mStrGetSjValue = (mfltSjValue * mfltk + mfltBdMin).ToString();
            }
            else
            {
                mStrGetSjValue = mfltSjValue.ToString();
            }

            return mStrGetSjValue;
        }
    }
}
