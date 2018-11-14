using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace GJHF.Sms._139130.Request
{
    public class Address
    {
        private static readonly string URI = "https://api.139130.com:9999/api/";

        private static readonly string version = "v1.0.0";

        private static string GetAddress(string domain, string function)
        {
            string mStrAllAddress = "";
            if (domain != "" && function != "")
            {
                mStrAllAddress = URI + version;
                if (domain.Substring(0, 1) == "/")
                {
                    mStrAllAddress = mStrAllAddress + domain;
                }
                else
                {
                    mStrAllAddress = mStrAllAddress + "/" + domain;
                }
                if (function.Substring(0, 1) == "/" || mStrAllAddress.Substring(mStrAllAddress.Length - 1, 1) == "/")
                {
                    mStrAllAddress = mStrAllAddress + function;
                }
                else
                {
                    mStrAllAddress = mStrAllAddress + "/" + function;
                }
            }
            else
            {
                mStrAllAddress = "";
            }
            return mStrAllAddress;
        }

        public static string GetAddress(Type t)
        {
            string mStrAllAddress = "";
            switch (t.Name)
            {
                case "VoiceVerifyAddress":
                    mStrAllAddress = GetAddress(VoiceVerifyAddress.domin, VoiceVerifyAddress.function);
                    break;
                case "VoiceNotifyAddress":
                    mStrAllAddress = GetAddress(VoiceNotifyAddress.domin, VoiceNotifyAddress.function);
                    break;
                case "VoiceClickCallAddress":
                    mStrAllAddress = GetAddress(VoiceClickCallAddress.domin, VoiceClickCallAddress.function);
                    break;
                default:
                    mStrAllAddress = "";
                    break;
            }
            return mStrAllAddress;
        }
    }

    internal class VoiceVerifyAddress
    {
        public static readonly string domin = "voice";
        public static readonly string function = "verify";
    }
    internal class VoiceNotifyAddress
    {
        public static readonly string domin = "voice";
        public static readonly string function = "notify";
    }
    internal class VoiceClickCallAddress
    {
        public static readonly string domin = "voice";
        public static readonly string function = "clickcall";
    }
}
