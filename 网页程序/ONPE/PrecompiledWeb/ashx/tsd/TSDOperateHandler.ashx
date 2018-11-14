<%@ WebHandler Language="C#" Class="TSDOperateHandler" %>

using System;
using System.Web;

public class TSDOperateHandler : IHttpHandler
{
    private GJHF.Business.TSD.TSDOperate mTSDOperate;

    public TSDOperateHandler()
    {
        this.mTSDOperate = new GJHF.Business.TSD.TSDOperate(); 
    }
    
    public void ProcessRequest (HttpContext context) {
        string mStrReturn = "";
        context.Response.ContentType = "text/plain";
        string action = "";
        if (context.Request.Params["action"] != null)
        {
            action = context.Request.Params["action"].ToString(); 
        }
        switch (action.ToLower())
        {
            case "poweroffrequest":
                mStrReturn = PowerOffRequest(context);
                break;
            case "cancelpoweroff":
                mStrReturn = CancelPowerOff(context);
                break;
            case "examinepoweroff":
                mStrReturn = ExaminePowerOff(context);
                break;
            case "confirmpoweroff":
                mStrReturn = ConfirmPowerOff(context);
                break;
            case "poweroff":
                mStrReturn = PowerOff(context);
                break;
            case "poweronrequest":
                mStrReturn = PowerOnRequest(context);
                break;
            case "cancelpoweron":
                mStrReturn = CancelPowerOn(context);
                break;
            case "examinepoweron" :
                mStrReturn = ExaminePowerOn(context);
                break;
            case "confirmpoweron":
                mStrReturn = ConfirmPowerOn(context);
                break;
            case "poweron":
                mStrReturn = PowerOn(context);
                break;
            case "archiveflow":
                mStrReturn = ArchiveFlow(context);
                break;
            default:
                mStrReturn = GJHF.Utility.WEBUI.EasyuiControl.GetMissParamReturn();
                break;
        }
        context.Response.Write(mStrReturn);
    }

    private string PowerOffRequest(HttpContext context)
    {
        int m_request_company = 0;
        if (context.Request.Params["request_company"] != null)
        {
            if (int.TryParse(context.Request.Params["request_company"], out m_request_company) == false)
            {
                m_request_company = 0; 
            } 
        }
        if (m_request_company == 0) return GJHF.Utility.WEBUI.EasyuiControl.GetParamFailRetuen();
        int m_request_branch = 0;
        if (context.Request.Params["request_branch"] != null)
        {
            if (int.TryParse(context.Request.Params["request_branch"], out m_request_branch) == false)
            {
                m_request_branch = 0;
            }
        }
        if (m_request_branch == 0) return GJHF.Utility.WEBUI.EasyuiControl.GetParamFailRetuen();
        string m_request_people = "";
        if (context.Request.Params["request_people"] != null)
        {
            m_request_people = context.Request.Params["request_people"].ToString(); 
        }
        if (m_request_people == "") return GJHF.Utility.WEBUI.EasyuiControl.GetParamFailRetuen();
        DateTime m_request_time = DateTime.Parse("1900-01-01 00:00");
        if (context.Request.Params["request_time"] != null)
        {
            if (DateTime.TryParse(context.Request.Params["request_time"], out m_request_time) == false)
            {
                m_request_time = DateTime.Parse("1900-01-01 00:00");
            }
        }
        if (m_request_time == DateTime.Parse("1900-01-01 00:00")) return GJHF.Utility.WEBUI.EasyuiControl.GetParamFailRetuen();
        string m_stop_equip = "";
        if (context.Request.Params["stop_equip"] != null)
        {
            m_stop_equip = context.Request.Params["stop_equip"].ToString();
        }
        if (m_stop_equip == "") return GJHF.Utility.WEBUI.EasyuiControl.GetParamFailRetuen();
        DateTime m_stop_time = DateTime.Parse("1900-01-01 00:00");
        if (context.Request.Params["stop_time"] != null)
        {
            if (DateTime.TryParse(context.Request.Params["stop_time"], out m_stop_time) == false)
            {
                m_stop_time = DateTime.Parse("1900-01-01 00:00");
            }
        }
        if (m_stop_time == DateTime.Parse("1900-01-01 00:00")) return GJHF.Utility.WEBUI.EasyuiControl.GetParamFailRetuen();
        float m_stop_duration = -1;
        if (context.Request.Params["stop_duration"] != null)
        {
            if (float.TryParse(context.Request.Params["stop_duration"], out m_stop_duration) == false)
            {
                m_stop_duration = -1;
            }
        }
        if (m_stop_duration == -1) return GJHF.Utility.WEBUI.EasyuiControl.GetParamFailRetuen();
        string m_request_remark = "";
        if (context.Request.Params["request_remark"] != null)
        {
            m_request_remark = context.Request.Params["request_remark"].ToString(); 
        }
        int mIntReturn = mTSDOperate.AddPowerOffRequest(m_request_company, m_request_branch, m_request_people, m_request_time, m_stop_equip, m_stop_time, m_stop_duration, m_request_remark);
        return GJHF.Utility.WEBUI.EasyuiControl.GetAddReturn(mIntReturn, 1);
    }

    private string CancelPowerOff(HttpContext context)
    {
        string m_poweroff_id = "";
        if (context.Request.Params["poweroff_id"] != null)
        {
            m_poweroff_id = context.Request.Params["poweroff_id"].ToString();
        }
        if (m_poweroff_id == "") return GJHF.Utility.WEBUI.EasyuiControl.GetParamFailRetuen();
        int mIntReturn = mTSDOperate.CancelPowerOffRequest(m_poweroff_id);
        if (mIntReturn == 0) return GJHF.Utility.WEBUI.EasyuiControl.GetReturn(true, "取消申请成功", false);
        return GJHF.Utility.WEBUI.EasyuiControl.GetReturn(false, "取消申请失败", false);
    }

    private string ExaminePowerOff(HttpContext context)
    {
        string m_poweroff_id = "";
        if (context.Request.Params["poweroff_id"] != null)
        {
            m_poweroff_id = context.Request.Params["poweroff_id"].ToString();
        }
        if (m_poweroff_id == "") return GJHF.Utility.WEBUI.EasyuiControl.GetParamFailRetuen();
        DateTime m_examine_time = DateTime.Parse("1900-01-01 00:00");
        if (context.Request.Params["examine_time"] != null)
        {
            if (DateTime.TryParse(context.Request.Params["examine_time"], out m_examine_time) == false)
            {
                m_examine_time = DateTime.Parse("1900-01-01 00:00");
            }
        }
        if (m_examine_time == DateTime.Parse("1900-01-01 00:00")) return GJHF.Utility.WEBUI.EasyuiControl.GetParamFailRetuen();
        string m_examine_people = "";
        if (context.Request.Params["examine_people"] != null)
        {
            m_examine_people = context.Request.Params["examine_people"].ToString(); 
        }
        if (m_examine_people == "") return GJHF.Utility.WEBUI.EasyuiControl.GetParamFailRetuen();
        string m_equip_code = "";
        if (context.Request.Params["equip_code"] != null)
        {
            m_equip_code = context.Request.Params["equip_code"].ToString();
        }
        if (m_equip_code == "") return GJHF.Utility.WEBUI.EasyuiControl.GetParamFailRetuen();
        string m_equip_value = "";
        if (context.Request.Params["equip_value"] != null)
        {
            m_equip_value = context.Request.Params["equip_value"].ToString();
        }
        if (m_equip_value == "") return GJHF.Utility.WEBUI.EasyuiControl.GetParamFailRetuen();
        DateTime m_value_time = DateTime.Parse("1900-01-01 00:00");
        if (context.Request.Params["value_time"] != null)
        {
            if (DateTime.TryParse(context.Request.Params["value_time"], out m_value_time) == false)
            {
                m_value_time = DateTime.Parse("1900-01-01 00:00");
            }
        }
        if (m_value_time == DateTime.Parse("1900-01-01 00:00")) return GJHF.Utility.WEBUI.EasyuiControl.GetParamFailRetuen();
        int m_examine_result = -99;
        if (context.Request.Params["examine_result"] != null)
        {
            if (int.TryParse(context.Request.Params["examine_result"], out m_examine_result) == false)
            {
                m_examine_result = -99;
            }
        }
        if (m_examine_result == -99) return GJHF.Utility.WEBUI.EasyuiControl.GetParamFailRetuen();
        string m_examine_remark = "";
        if (context.Request.Params["examine_remark"] != null)
        {
            m_examine_remark = context.Request.Params["examine_remark"].ToString();
        }
        int mIntReturn = mTSDOperate.ExaminePowerOffRequest(m_poweroff_id, m_examine_time, m_examine_people, m_equip_code, m_equip_value, m_value_time, m_examine_result, m_examine_remark);
        if (mIntReturn == 1)
        {
            return GJHF.Utility.WEBUI.EasyuiControl.GetReturn(true, "审核停电申请成功", false); 
        }
        return GJHF.Utility.WEBUI.EasyuiControl.GetReturn(false, "审核停电申请失败", false);
    }
    
    private string ConfirmPowerOff(HttpContext context)
    {
        string m_flow_id = "";
        if (context.Request.Params["flow_id"] != null)
        {
            m_flow_id = context.Request.Params["flow_id"].ToString(); 
        }
        if (m_flow_id == "") return GJHF.Utility.WEBUI.EasyuiControl.GetParamFailRetuen();
        string m_confirm_people = "";
        if (context.Request.Params["confirm_people"] != null)
        {
            m_confirm_people = context.Request.Params["confirm_people"].ToString();
        }
        if (m_confirm_people == "") return GJHF.Utility.WEBUI.EasyuiControl.GetParamFailRetuen();
        DateTime m_confirm_time = DateTime.Parse("1900-01-01 00:00");
        if (context.Request.Params["confirm_time"] != null)
        {
            if (DateTime.TryParse(context.Request.Params["confirm_time"], out m_confirm_time) == false)
            {
                m_confirm_time = DateTime.Parse("1900-01-01 00:00");
            }
        }
        if (m_confirm_time == DateTime.Parse("1900-01-01 00:00")) return GJHF.Utility.WEBUI.EasyuiControl.GetParamFailRetuen();
        string m_location_info = "";
        if (context.Request.Params["location_info"] != null)
        {
            m_location_info = context.Request.Params["location_info"].ToString();
        }
        string m_equip_code = "";
        if (context.Request.Params["equip_code"] != null)
        {
            m_equip_code = context.Request.Params["equip_code"].ToString();
        }
        if (m_equip_code == "") return GJHF.Utility.WEBUI.EasyuiControl.GetParamFailRetuen();
        int m_equip_status = -99;
        if (context.Request.Params["equip_status"] != null)
        {
            if (int.TryParse(context.Request.Params["equip_status"], out m_equip_status) == false)
            {
                m_equip_status = -99;
            }
        }
        if (m_equip_status == -99) return GJHF.Utility.WEBUI.EasyuiControl.GetParamFailRetuen();
        string m_confirm_remark = "";
        if (context.Request.Params["confirm_remark"] != null)
        {
            m_confirm_remark = context.Request.Params["confirm_remark"].ToString();
        }
        int mIntReturn = mTSDOperate.ConfirmPowerOff(m_flow_id, m_confirm_people, m_confirm_time, m_location_info, m_equip_code, m_equip_status, m_confirm_remark);
        if (mIntReturn == 1)
        {
            return GJHF.Utility.WEBUI.EasyuiControl.GetReturn(true, "确认停电成功", false); 
        }
        return GJHF.Utility.WEBUI.EasyuiControl.GetReturn(false, "确认停电失败", false);
    }

    private string PowerOff(HttpContext context)
    {
        string m_flow_id = "";
        if (context.Request.Params["flow_id"] != null)
        {
            m_flow_id = context.Request.Params["flow_id"].ToString();
        }
        if (m_flow_id == "") return GJHF.Utility.WEBUI.EasyuiControl.GetParamFailRetuen();
        DateTime m_poweroff_time = DateTime.Parse("1900-01-01 00:00");
        if (context.Request.Params["poweroff_time"] != null)
        {
            if (DateTime.TryParse(context.Request.Params["poweroff_time"], out m_poweroff_time) == false)
            {
                m_poweroff_time = DateTime.Parse("1900-01-01 00:00");
            }
        }
        if (m_poweroff_time == DateTime.Parse("1900-01-01 00:00")) return GJHF.Utility.WEBUI.EasyuiControl.GetParamFailRetuen();
        int m_poweroff_branch = 0;
        if (context.Request.Params["poweroff_branch"] != null)
        {
            if (int.TryParse(context.Request.Params["poweroff_branch"], out m_poweroff_branch) == false)
            {
                m_poweroff_branch = 0;
            }
        }
        if (m_poweroff_branch == 0) return GJHF.Utility.WEBUI.EasyuiControl.GetParamFailRetuen();
        string m_poweroff_employee = "";
        if (context.Request.Params["poweroff_employee"] != null)
        {
            m_poweroff_employee = context.Request.Params["poweroff_employee"].ToString();
        }
        if (m_poweroff_employee == "") return GJHF.Utility.WEBUI.EasyuiControl.GetParamFailRetuen();
        int mIntReturn = mTSDOperate.PowerOff(m_flow_id, m_poweroff_time, m_poweroff_branch, m_poweroff_employee);
        if (mIntReturn == 1)
        {
            return GJHF.Utility.WEBUI.EasyuiControl.GetReturn(true, "停电成功", false);
        }
        return GJHF.Utility.WEBUI.EasyuiControl.GetReturn(false, "停电失败", false);
    }

    private string PowerOnRequest(HttpContext context)
    {
        string m_poweroff_id = "";
        if (context.Request.Params["poweroff_id"] != null)
        {
            m_poweroff_id = context.Request.Params["poweroff_id"].ToString();
        }
        if (m_poweroff_id == "") return GJHF.Utility.WEBUI.EasyuiControl.GetParamFailRetuen();
        int m_request_company = 0;
        if (context.Request.Params["request_company"] != null)
        {
            if (int.TryParse(context.Request.Params["request_company"], out m_request_company) == false)
            {
                m_request_company = 0;
            }
        }
        if (m_request_company == 0) return GJHF.Utility.WEBUI.EasyuiControl.GetParamFailRetuen();
        int m_request_branch = 0;
        if (context.Request.Params["request_branch"] != null)
        {
            if (int.TryParse(context.Request.Params["request_branch"], out m_request_branch) == false)
            {
                m_request_branch = 0;
            }
        }
        if (m_request_branch == 0) return GJHF.Utility.WEBUI.EasyuiControl.GetParamFailRetuen();
        string m_request_people = "";
        if (context.Request.Params["request_people"] != null)
        {
            m_request_people = context.Request.Params["request_people"].ToString();
        }
        if (m_request_people == "") return GJHF.Utility.WEBUI.EasyuiControl.GetParamFailRetuen();
        DateTime m_request_time = DateTime.Parse("1900-01-01 00:00");
        if (context.Request.Params["request_time"] != null)
        {
            if (DateTime.TryParse(context.Request.Params["request_time"], out m_request_time) == false)
            {
                m_request_time = DateTime.Parse("1900-01-01 00:00");
            }
        }
        if (m_request_time == DateTime.Parse("1900-01-01 00:00")) return GJHF.Utility.WEBUI.EasyuiControl.GetParamFailRetuen();
        DateTime m_star_time = DateTime.Parse("1900-01-01 00:00");
        if (context.Request.Params["start_time"] != null)
        {
            if (DateTime.TryParse(context.Request.Params["start_time"], out m_star_time) == false)
            {
                m_star_time = DateTime.Parse("1900-01-01 00:00");
            }
        }
        if (m_star_time == DateTime.Parse("1900-01-01 00:00")) return GJHF.Utility.WEBUI.EasyuiControl.GetParamFailRetuen();
        string m_request_remark = "";
        if (context.Request.Params["request_remark"] != null)
        {
            m_request_remark = context.Request.Params["request_remark"].ToString();
        }
        int mIntReturn = mTSDOperate.AddPowerOnRequest(m_poweroff_id, m_request_company, m_request_branch, m_request_people, m_request_time, m_star_time, m_request_remark);
        if (mIntReturn == 1)
        {
            return GJHF.Utility.WEBUI.EasyuiControl.GetReturn(true, "添加送电申请成功", false);
        }
        return GJHF.Utility.WEBUI.EasyuiControl.GetReturn(false, "添加送电申请失败", false);
    }
    private string CancelPowerOn(HttpContext context)
    {
        string m_poweron_id = "";
        if (context.Request.Params["poweron_id"] != null)
        {
            m_poweron_id = context.Request.Params["poweron_id"].ToString();
        }
        if (m_poweron_id == "") return GJHF.Utility.WEBUI.EasyuiControl.GetParamFailRetuen();
        int mIntReturn = mTSDOperate.CancelPowerOnRequest(m_poweron_id);
        if (mIntReturn == 1)
        {
            return GJHF.Utility.WEBUI.EasyuiControl.GetReturn(true, "取消送电申请成功", false);
        }
        return GJHF.Utility.WEBUI.EasyuiControl.GetReturn(false, "取消送电申请失败", false);
    }
    private string ExaminePowerOn(HttpContext context)
    {
        string m_poweron_id = "";
        if (context.Request.Params["poweron_id"] != null)
        {
            m_poweron_id = context.Request.Params["poweron_id"].ToString();
        }
        if (m_poweron_id == "") return GJHF.Utility.WEBUI.EasyuiControl.GetParamFailRetuen();
        DateTime m_examine_time = DateTime.Parse("1900-01-01 00:00");
        if (context.Request.Params["examine_time"] != null)
        {
            if (DateTime.TryParse(context.Request.Params["examine_time"], out m_examine_time) == false)
            {
                m_examine_time = DateTime.Parse("1900-01-01 00:00");
            }
        }
        if (m_examine_time == DateTime.Parse("1900-01-01 00:00")) return GJHF.Utility.WEBUI.EasyuiControl.GetParamFailRetuen();
        string m_examine_people = "";
        if (context.Request.Params["examine_people"] != null)
        {
            m_examine_people = context.Request.Params["examine_people"].ToString();
        }
        if (m_examine_people == "") return GJHF.Utility.WEBUI.EasyuiControl.GetParamFailRetuen();
        string m_equip_code = "";
        if (context.Request.Params["equip_code"] != null)
        {
            m_equip_code = context.Request.Params["equip_code"].ToString();
        }
        if (m_equip_code == "") return GJHF.Utility.WEBUI.EasyuiControl.GetParamFailRetuen();
        string m_equip_value = "";
        if (context.Request.Params["equip_value"] != null)
        {
            m_equip_value = context.Request.Params["equip_value"].ToString();
        }
        if (m_equip_value == "") return GJHF.Utility.WEBUI.EasyuiControl.GetParamFailRetuen();
        DateTime m_value_time = DateTime.Parse("1900-01-01 00:00");
        if (context.Request.Params["value_time"] != null)
        {
            if (DateTime.TryParse(context.Request.Params["value_time"], out m_value_time) == false)
            {
                m_value_time = DateTime.Parse("1900-01-01 00:00");
            }
        }
        if (m_value_time == DateTime.Parse("1900-01-01 00:00")) return GJHF.Utility.WEBUI.EasyuiControl.GetParamFailRetuen();
        int m_examine_result = -99;
        if (context.Request.Params["examine_result"] != null)
        {
            if (int.TryParse(context.Request.Params["examine_result"], out m_examine_result) == false)
            {
                m_examine_result = -99;
            }
        }
        if (m_examine_result == -99) return GJHF.Utility.WEBUI.EasyuiControl.GetParamFailRetuen();
        string m_examine_remark = "";
        if (context.Request.Params["examine_remark"] != null)
        {
            m_examine_remark = context.Request.Params["examine_remark"].ToString();
        }
        int mIntReturn = mTSDOperate.ExaminePowerOnRequest(m_poweron_id, m_examine_time, m_examine_people, m_equip_code, m_equip_value, m_value_time, m_examine_result, m_examine_remark);
        if (mIntReturn == 1)
        {
            return GJHF.Utility.WEBUI.EasyuiControl.GetReturn(true, "审核送电申请成功", false);
        }
        return GJHF.Utility.WEBUI.EasyuiControl.GetReturn(false, "审核送电申请失败", false);
    }
    private string ConfirmPowerOn(HttpContext context)
    {
        string m_flow_id = "";
        if (context.Request.Params["flow_id"] != null)
        {
            m_flow_id = context.Request.Params["flow_id"].ToString();
        }
        if (m_flow_id == "") return GJHF.Utility.WEBUI.EasyuiControl.GetParamFailRetuen();
        string m_confirm_people = "";
        if (context.Request.Params["confirm_people"] != null)
        {
            m_confirm_people = context.Request.Params["confirm_people"].ToString();
        }
        if (m_confirm_people == "") return GJHF.Utility.WEBUI.EasyuiControl.GetParamFailRetuen();
        DateTime m_confirm_time = DateTime.Parse("1900-01-01 00:00");
        if (context.Request.Params["confirm_time"] != null)
        {
            if (DateTime.TryParse(context.Request.Params["confirm_time"], out m_confirm_time) == false)
            {
                m_confirm_time = DateTime.Parse("1900-01-01 00:00");
            }
        }
        if (m_confirm_time == DateTime.Parse("1900-01-01 00:00")) return GJHF.Utility.WEBUI.EasyuiControl.GetParamFailRetuen();
        string m_location_info = "";
        if (context.Request.Params["location_info"] != null)
        {
            m_location_info = context.Request.Params["location_info"].ToString();
        }
        string m_equip_code = "";
        if (context.Request.Params["equip_code"] != null)
        {
            m_equip_code = context.Request.Params["equip_code"].ToString();
        }
        if (m_equip_code == "") return GJHF.Utility.WEBUI.EasyuiControl.GetParamFailRetuen();
        int m_equip_status = -99;
        if (context.Request.Params["equip_status"] != null)
        {
            if (int.TryParse(context.Request.Params["equip_status"], out m_equip_status) == false)
            {
                m_equip_status = -99;
            }
        }
        if (m_equip_status == -99) return GJHF.Utility.WEBUI.EasyuiControl.GetParamFailRetuen();
        string m_confirm_remark = "";
        if (context.Request.Params["confirm_remark"] != null)
        {
            m_confirm_remark = context.Request.Params["confirm_remark"].ToString();
        }
        int mIntReturn = mTSDOperate.ConfirmPowerOn(m_flow_id, m_confirm_people, m_confirm_time, m_location_info, m_equip_code, m_equip_status, m_confirm_remark);
        if (mIntReturn == 1)
        {
            return GJHF.Utility.WEBUI.EasyuiControl.GetReturn(true, "确认送电成功", false);
        }
        return GJHF.Utility.WEBUI.EasyuiControl.GetReturn(false, "确认送电失败", false);
    }
    private string PowerOn(HttpContext context)
    {
        string m_flow_id = "";
        if (context.Request.Params["flow_id"] != null)
        {
            m_flow_id = context.Request.Params["flow_id"].ToString();
        }
        if (m_flow_id == "") return GJHF.Utility.WEBUI.EasyuiControl.GetParamFailRetuen();
        DateTime m_poweron_time = DateTime.Parse("1900-01-01 00:00");
        if (context.Request.Params["poweron_time"] != null)
        {
            if (DateTime.TryParse(context.Request.Params["poweron_time"], out m_poweron_time) == false)
            {
                m_poweron_time = DateTime.Parse("1900-01-01 00:00");
            }
        }
        if (m_poweron_time == DateTime.Parse("1900-01-01 00:00")) return GJHF.Utility.WEBUI.EasyuiControl.GetParamFailRetuen();
        int m_poweron_branch = 0;
        if (context.Request.Params["poweron_branch"] != null)
        {
            if (int.TryParse(context.Request.Params["poweron_branch"], out m_poweron_branch) == false)
            {
                m_poweron_branch = 0;
            }
        }
        if (m_poweron_branch == 0) return GJHF.Utility.WEBUI.EasyuiControl.GetParamFailRetuen();
        string m_poweron_employee = "";
        if (context.Request.Params["poweron_employee"] != null)
        {
            m_poweron_employee = context.Request.Params["poweron_employee"].ToString();
        }
        if (m_poweron_employee == "") return GJHF.Utility.WEBUI.EasyuiControl.GetParamFailRetuen();
        int mIntReturn = mTSDOperate.PowerOn(m_flow_id, m_poweron_time, m_poweron_branch, m_poweron_employee);
        if (mIntReturn == 1)
        {
            return GJHF.Utility.WEBUI.EasyuiControl.GetReturn(true, "送电成功", false);
        }
        return GJHF.Utility.WEBUI.EasyuiControl.GetReturn(false, "送电失败", false);
    }

    private string ArchiveFlow(HttpContext context)
    {
        string m_flow_id = "";
        if (context.Request.Params["flow_id"] != null)
        {
            m_flow_id = context.Request.Params["flow_id"].ToString();
        }
        if (m_flow_id == "") return GJHF.Utility.WEBUI.EasyuiControl.GetParamFailRetuen();
        int mIntReturn = mTSDOperate.ArchiveFlow(m_flow_id);
        if (mIntReturn == 1)
        {
            return GJHF.Utility.WEBUI.EasyuiControl.GetReturn(true, "归档成功", false);
        }
        return GJHF.Utility.WEBUI.EasyuiControl.GetReturn(false, "归档失败", false);
    }
    
    public bool IsReusable {
        get {
            return false;
        }
    }

}