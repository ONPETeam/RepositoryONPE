<%@ Application Language="C#" %>

<script runat="server">
    //System.Timers.Timer T1 = new System.Timers.Timer();
    //System.Timers.Timer T2 = new System.Timers.Timer();
    //string gStrFwq = "";
    //string gStrRun = "";

    //GJHF.Business.PLC.BPlcPushTemp BclaPlcPushTemp = new GJHF.Business.PLC.BPlcPushTemp();
    void Application_Start(object sender, EventArgs e) 
    {
        ////在应用程序启动时运行的代码
        //string t1 = System.Configuration.ConfigurationSettings.AppSettings["zhouqi1"].ToString();
        //string t2 = System.Configuration.ConfigurationSettings.AppSettings["zhouqi2"].ToString();
        //gStrFwq = System.Configuration.ConfigurationSettings.AppSettings["FWQ"].ToString();
        //gStrRun = System.Configuration.ConfigurationSettings.AppSettings["YX"].ToString();
        //int voIntReturn = 0;

        //if (gStrRun == "运行")
        //{
        //    if (string.IsNullOrEmpty(t1) == false)
        //    {
        //        if (int.TryParse(t1, out voIntReturn) == true)
        //        {
        //            T1.Interval = double.Parse(t1);
        //            T1.Enabled = true;
        //            T1.AutoReset = true;
        //            T1.Elapsed += new System.Timers.ElapsedEventHandler(run1);
        //        }
        //    }

        //    if (string.IsNullOrEmpty(t2) == false)
        //    {
        //        if (int.TryParse(t2, out voIntReturn) == true)
        //        {
        //            T2.Interval = double.Parse(t2);
        //            T2.Enabled = true;
        //            T2.AutoReset = true;
        //            T2.Elapsed += new System.Timers.ElapsedEventHandler(run2);
        //        }

        //    }
        //}

    }
    //private void run1(object sender, System.Timers.ElapsedEventArgs e)
    //{

    //    int result = 0;
    //    int dataid = -1;
    //    string cjdz = "";
    //    //string ddz = "";
    //    //string tsnr = "";
    //    //string value = "";
    //    string tspeople = "";
    //    //int mIntDqbz =0;
    //    //int mIntTsbz = 0;
    //    //int mIntCount = 0;
    //    string mStrMsg = "";
    //    string mStrDateTime = "";
    //    string ddzName = "";
    //    string ddz = "";
    //    string ddzDesciption = "";
    //    int voIntReturn;
        
    //    try
    //    {

    //        System.Data.DataTable dt = GJHF.Business.PLC.BPlcPushTemp.GetPushOneData();
    //        List<GJHF.Data.Model.PLC.tZPlcPointDiZhi> mlist = new List<GJHF.Data.Model.PLC.tZPlcPointDiZhi>();
            
    //        if(dt.Rows.Count >0)
    //        {
    //            if (string.IsNullOrEmpty(dt.Rows[0]["id"].ToString()) == false)
    //            {
    //                dataid = Int32.Parse(dt.Rows[0]["id"].ToString());
    //            }
    //            cjdz = dt.Rows[0]["dVchCjdz"].ToString();
    //            mStrDateTime = dt.Rows[0]["dDeaSystime"].ToString();
    //            //增加通过采集地址来获取名称描述的方法功能
    //            mlist = BclaPlcPushTemp.GetdzNameEF(cjdz);
    //            if (mlist.Count > 0)
    //            {
    //                ddzName = mlist[0].dVchAdressName;
    //                ddz = mlist[0].dVchAddress;
    //                ddzDesciption = mlist[0].dVchDescription;
    //            }
    //            //需要增加的代码块
    //            //end
                
    //            //推送代码
    //            tspeople = GJHF.Business.PLC.BPlcPushTemp.GetTsPeople(cjdz);
    //            //HashSet<string> m = new HashSet<string>();
    //            //m = GJHF.Utility.Convert.ConvertStringToHashSet(cjdz, ',');

    //            result = GJHF.Business.PUSH.PushMessage.SendNotification("employee", tspeople, gStrFwq + ddzDesciption +  cjdz + mStrDateTime + "-报警", null);
    //            if (result >= 0)
    //            {
    //                //添加推送数据到推送历史表中
    //                GJHF.Business.PLC.BPlcTsHistory.AddData(gStrFwq + cjdz + mStrDateTime + "-报警", "", 1, DateTime.Now, "", out mStrMsg);
    //                GJHF.Business.PLC.BPlcPushTemp.DelData(dataid, out mStrMsg);
    //                //修改已推送消息的状态
    //                //GJHF.Business.PLC.BPlcPushTemp.GetTsEnd(cjdz, 1);
    //            } 
    //        }


                
    //        ////按时间顺序来推送一条数据，推送成功后，删除这条数据
            
    //        ////在数据库中删除此条数据，并存入历史推送记录中
            
    //    }
    
    //    catch (Exception eee)
    //    {
    //        //FileOpetation.SaveRecord(string.Format(@"当前记录时间：{0},状况：程序运行正常！", DateTime.Now + eee.ToString()));
    //    }
    //}

    //private void run2(object sender,System.Timers.ElapsedEventArgs e)
    //{
    //    try
    //    {
            
    //        int result;
    //        string empcode = "PCHREP1703080107,PCHREP1703080048,PCHREP1703080106,PCHREP1703080042";
    //        string mStrMsg = "";
    //        int mIntTsState = -1;
    //        System.Data.DataTable dt = null;
    //        if (GJHF.Business.PLC.BPlcNetXr.GetNetDis() == true)
    //        {
    //            dt = GJHF.Business.PLC.BPlcNetXr.GetData(10, 1, "");
    //            if (dt.Rows.Count > 0)
    //            {
    //                if (string.IsNullOrEmpty(dt.Rows[0]["dIntTsState"].ToString()) == false)
    //                {
    //                    mIntTsState = Int32.Parse(dt.Rows[0]["dIntTsState"].ToString());
    //                }
    //            }
    //            //如果是否推送标识为0，代表新的信息没有被推送过
    //            if (mIntTsState == 0)
    //            {
    //                result = GJHF.Business.PUSH.PushMessage.SendNotification("employee", empcode, gStrFwq + "网络断开", null);

    //                if (result >= 0)
    //                {
    //                    //添加推送数据到推送历史表中
    //                    GJHF.Business.PLC.BPlcTsHistory.AddData(gStrFwq + "采集服务器网络断开", "", 2, DateTime.Now, "", out mStrMsg);
    //                    //更新是否推送标志为1，代表已经推送过
    //                    GJHF.Business.PLC.BPlcNetXr.SetTsState(1);
    //                }
    //            }
                
    //        }
    //         //如果没有超过断开时间，那么表示恢复正常
    //        else
    //        {
    //             //更新是否推送标识为0，重置推送标识
    //            GJHF.Business.PLC.BPlcNetXr.SetTsState(0);
    //        }
    //    }
    //    catch (Exception eee)
    //    {
    //        string mStrErr = eee.ToString();
    //    }
    //}
    void Application_End(object sender, EventArgs e) 
    {
      //  //在应用程序关闭时运行的代码
      //  //这里设置你的web地址，可以随便指向你的任意一个aspx页面甚至不存在的页面，目的是要激发Application_Start  

      //  string url = "Login.aspx";

      //  System.Net.HttpWebRequest myHttpWebRequest = (System.Net.HttpWebRequest)System.Net.WebRequest.Create(url);

      //  System.Net.HttpWebResponse myHttpWebResponse = (System.Net.HttpWebResponse)myHttpWebRequest.GetResponse();  
  
      //System.IO.Stream receiveStream = myHttpWebResponse.GetResponseStream();//得到回写的字节流  
    }
        
    void Application_Error(object sender, EventArgs e) 
    { 
        //在出现未处理的错误时运行的代码
    }

    void Session_Start(object sender, EventArgs e) 
    {
        //在新会话启动时运行的代码
    }

    void Session_End(object sender, EventArgs e) 
    {
        //在会话结束时运行的代码。 
        // 注意: 只有在 Web.config 文件中的 sessionstate 模式设置为
        // InProc 时，才会引发 Session_End 事件。如果会话模式 
        //设置为 StateServer 或 SQLServer，则不会引发该事件。
    }
       
</script>
