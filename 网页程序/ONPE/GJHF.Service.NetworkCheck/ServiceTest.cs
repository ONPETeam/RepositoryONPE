using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Diagnostics;
using System.Linq;
using System.ServiceProcess;
using System.Text;
using System.Net;

namespace GJHF.Service.NetworkCheck
{
    public partial class ServiceTest : ServiceBase
    {
        private System.Timers.Timer tmrService;
        
        private GJHF.Business.SYS.NetworkState mNetworkState;
        private GJHF.Data.Model.SYS.MNetworkAlarmSet mMNetworkAlarmSet;
        private System.DateTime mDtmLstDisconnectAlarmTime=DateTime.Parse("1900-01-01");//网络断开上次报警时间
        private int mBlnNetworkState=0; //网络连接状态 0 初始状态 1 连接 -1 断开
        public ServiceTest()
        {
            InitializeComponent();
        }
        
        protected override void OnStart(string[] args)
        {
            mNetworkState = new Business.SYS.NetworkState();
            mMNetworkAlarmSet = new Data.Model.SYS.MNetworkAlarmSet();
            
            DateTime mDtmLastWriteTime = mNetworkState.GetLastWriteTime();
            EventLog.WriteEntry("GJHF.Service.NetworkCheck[" + mDtmLastWriteTime.ToString() + "]");
            tmrService= new System.Timers.Timer();
            tmrService.Interval = 1000;//每秒执行一次
            tmrService.AutoReset = true;
            tmrService.Enabled = true;
            tmrService.Start();
            tmrService.Elapsed += new System.Timers.ElapsedEventHandler(NetworkStateCheck);
            
        }
        private void NetworkStateCheck(object sender, System.Timers.ElapsedEventArgs e)
        {
            
            DateTime mDtmNow=System.DateTime.Now;
            //获取数据库中由客户端写入的时间与现在时间差
            long mLngTimeSpan = GJHF.Utility.FunTimeSpan.GetSecondsFromSpan(mDtmNow - mNetworkState.GetLastWriteTime());
            int mIntDisconnectFlag = 4;
            if (int.TryParse(System.Configuration.ConfigurationSettings.AppSettings["Disconnect_time"], out mIntDisconnectFlag) == false)
            {
                mIntDisconnectFlag = 4;
            }
            if (System.Math.Abs(mLngTimeSpan) > mIntDisconnectFlag)//如果时间差大于设定值，则认为网络已经断开
            {
                mMNetworkAlarmSet = mNetworkState.GetNetworkSetModel();
                if (mMNetworkAlarmSet.alarm_when_disconnect == 1)//检查配置为是否报警
                {
                    if (mMNetworkAlarmSet.alarm_time_span != 0)
                    {
                        long mLngLastTimeSpan = System.Math.Abs(GJHF.Utility.FunTimeSpan.GetSecondsFromSpan(mDtmNow - mDtmLstDisconnectAlarmTime));
                        if (mBlnNetworkState == 1)
                        {
                            SendMessage(mDtmNow, false, mMNetworkAlarmSet.disconnect_employee_code);
                            mDtmLstDisconnectAlarmTime = mDtmNow;
                        }
                        else
                        {
                            if (mLngLastTimeSpan > long.Parse(mMNetworkAlarmSet.alarm_time_span.ToString()))
                            {
                                SendMessage(mDtmNow, false, mMNetworkAlarmSet.disconnect_employee_code);
                                mDtmLstDisconnectAlarmTime = mDtmNow;
                            }
                        }
                    }
                    else
                    {
                        SendMessage(mDtmNow, false, mMNetworkAlarmSet.disconnect_employee_code);
                        mDtmLstDisconnectAlarmTime = mDtmNow;
                    }
                }
                mBlnNetworkState = -1;//设置网络状态为断开
            }
            else
            {
                if (mBlnNetworkState == -1)
                {
                    mMNetworkAlarmSet = mNetworkState.GetNetworkSetModel();
                    if (mMNetworkAlarmSet.alarm_when_connect == 1)
                    {
                        SendMessage(mDtmNow, true, mMNetworkAlarmSet.connect_employee_code);
                        mDtmLstDisconnectAlarmTime = mDtmNow;
                    }
                }
                mBlnNetworkState = 1;
            }
        }
        private void SendMessage(DateTime v_message_time, bool v_connect_state, string v_receive_employee_code)
        {
            string mStrMessageContext = "";
            string mStrAlarmAppsiteName=System.Configuration.ConfigurationSettings.AppSettings["AppsiteName"].ToString();
            if (v_connect_state)
            {
                mStrMessageContext = "【" + v_message_time.ToString() + "】" + mStrAlarmAppsiteName + "采集服务器与云端网络连接恢复！";
            } 
            else
            {
                mStrMessageContext = "【" + v_message_time.ToString() + "】" + mStrAlarmAppsiteName + "采集服务器与云端断开连接！！请检查网络";
            }
            GJHF.Business.PUSH.PushMessage.SendNotification(2, mStrAlarmAppsiteName, "employee", v_receive_employee_code, mStrMessageContext, null);
        }
        protected override void OnStop()
        {
            if (this.tmrService != null && this.tmrService.Enabled == true)
            {
                this.tmrService.Enabled = false;
            }
        }
    }
}
