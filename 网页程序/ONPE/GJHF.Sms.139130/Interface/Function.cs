using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace GJHF.Sms._139130.Interface
{
    public class Function
    {
        public static int  SendNotify(string v_called_no, string v_templet_id, List<string> v_params,string v_data_guid)
        {
            int mStrReturn = -1;
            string mStrURL = Request.Address.GetAddress(typeof(Request.VoiceNotifyAddress));
            DateTime mDtmNow = System.DateTime.Now;

            Request.Content mContent=new Request.Content();
            mContent.info=new Request.Info();
            mContent.subject=new Request.Subject();
            mContent.subject.called = v_called_no;
            mContent.subject.calledDisplay = "";
            mContent.subject.templateID=v_templet_id;
            mContent.subject.Params=new List<string>();
            mContent.subject.Params=v_params;
            mContent.subject.playTimes = 2;
            mContent.subject.playDelay = 3000;
            mContent.data = v_data_guid;
            mContent.timestamp=Common.Global.GenerateTimeStamp(System.DateTime.Now);

            string mStrContent=Newtonsoft.Json.JsonConvert.SerializeObject(mContent);
            int mIntContentLength = UnicodeEncoding.UTF8.GetByteCount(mStrContent);

            string mStrSig = Request.Header.GetSig(mDtmNow);
            mStrURL = mStrURL + "?sig=" + mStrSig;

            Dictionary<string, string> mDicHeaderParam = new Dictionary<string, string>();
            mDicHeaderParam.Add("Authorization", Request.Header.GetHeaderAuthorization(mDtmNow));
            mDicHeaderParam.Add("Accept",Request.Header.GetAcceptType(Request.AcceptType.JSON));
            mDicHeaderParam.Add("Content-Type", Request.Header.GetContentType(Request.ContentType.JSON));
            mDicHeaderParam.Add("Content-Length",mIntContentLength.ToString());

            string mStrResponseContent = Common.Global.PostURL(mStrURL, mDicHeaderParam, mStrContent);
            try
            {
                Response.ResponseContent mResponseContent = (Response.ResponseContent)Newtonsoft.Json.JsonConvert.DeserializeObject<Response.ResponseContent>(mStrResponseContent);
                mStrReturn = mResponseContent.result.code;//Response.ErrorCode.GetErrorDiscriptByCode(mResponseContent.result.code);
            }
            catch(Exception ex)
            {
                mStrReturn = -1;
            }
            return mStrReturn;
        }


    }
}
