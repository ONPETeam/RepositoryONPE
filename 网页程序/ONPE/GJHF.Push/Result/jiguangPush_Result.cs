using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace GJHF.Push.Result
{
    public class jiguangPush_ReceivedResult
    {

        public long msg_id
        {
            get;
            set;
        }
        public string android_received
        {
            get;
            set;
        }
        public string ios_apns_sent
        {
            get;
            set;
        }
    }
    public class Device_Info
    {
        public string alias
        {
            get;
            set;
        }
        public List<string> tags
        {
            get;
            set;
        }
        public string mobile
        {
            get;
            set;
        }
        public bool isResultOK
        {
            get;
            set;
        }
    }
}
