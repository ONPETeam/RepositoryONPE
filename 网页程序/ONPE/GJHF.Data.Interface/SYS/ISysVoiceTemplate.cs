using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;

namespace GJHF.Data.Interface.SYS
{
    public interface ISysVoiceTemplate
    {
        /// <summary>
        /// 获取即信模板数量
        /// </summary>
        /// <param name="v_template_no">即信模板编号 支持模糊匹配</param>
        /// <param name="v_template_type">模板类型 </param>
        /// <param name="v_template_name">模板名称 支持模糊匹配</param>
        /// <param name="v_template_content">模板内容 支持模糊匹配</param>
        /// <param name="v_template_state">模板状态 -99 审核中 0 正常 -1 停用 -2 未上线 -100 所有</param>
        /// <returns></returns>
        int GetJXTemplateCount(string v_template_no, int v_template_type, string v_template_name, string v_template_content, int v_template_state=-100);

        /// <summary>
        /// 获取即信模板数据
        /// </summary>
        /// <param name="v_template_no">即信模板编号 支持模糊匹配</param>
        /// <param name="v_template_type">模板类型 </param>
        /// <param name="v_template_name">模板名称 支持模糊匹配</param>
        /// <param name="v_template_content">模板内容 支持模糊匹配</param>
        /// <param name="v_template_state">模板状态 -99 审核中 0 正常 -1 停用 -2 未上线 -100 所有</param>
        /// <returns></returns>
        DataTable GetJXTemplateData(string v_template_no, int v_template_type, string v_template_name, string v_template_content, int v_template_state=-100);

        /// <summary>
        /// 获取即信模板数据
        /// </summary>
        /// <param name="v_template_no">即信模板编号 支持模糊匹配</param>
        /// <param name="v_template_type">模板类型 </param>
        /// <param name="v_template_name">模板名称 支持模糊匹配</param>
        /// <param name="v_template_content">模板内容 支持模糊匹配</param>
        /// <param name="v_sort"></param>
        /// <param name="v_order"></param>
        /// <param name="v_template_state">模板状态 -99 审核中 0 正常 -1 停用 -2 未上线 -100 所有</param>
        /// <returns></returns>
        DataTable GetJXTemplateData(string v_template_no, int v_template_type, string v_template_name, string v_template_content,string v_sort,string v_order, int v_template_state = -100);

        /// <summary>
        /// 获取即信模板数据
        /// </summary>
        /// <param name="v_page"></param>
        /// <param name="v_rows"></param>
        /// <param name="v_template_no">即信模板编号 支持模糊匹配</param>
        /// <param name="v_template_type">模板类型 </param>
        /// <param name="v_template_name">模板名称 支持模糊匹配</param>
        /// <param name="v_template_content">模板内容 支持模糊匹配</param>
        /// <param name="v_sort"></param>
        /// <param name="v_order"></param>
        /// <param name="v_template_state">模板状态 -99 审核中 0 正常 -1 停用 -2 未上线 -100 所有</param>
        /// <returns></returns>
        DataTable GetJXTemplateData(int v_page,int v_rows,string v_template_no, int v_template_type, string v_template_name, string v_template_content,string v_sort,string v_order, int v_template_state = -100);

        /// <summary>
        /// 上线模板（提交即信审核）
        /// </summary>
        /// <param name="v_template_id">待提交审核得系统模板编号</param>
        /// <returns></returns>
        int OnlineJXTemplate(string v_template_id);

        /// <summary>
        /// 添加模板
        /// </summary>
        /// <param name="v_template_type">模板类型</param>
        /// <param name="v_template_content">模板内容</param>
        /// <param name="v_template_name">模板名称</param>
        /// <param name="v_template_remark">备注说明</param>
        /// <returns></returns>
        int AddJxTemplate(int v_template_type, string v_template_content, string v_template_name, string v_template_remark);

        /// <summary>
        /// 下线模板（先下线才能修改）
        /// </summary>
        /// <param name="v_template_id"></param>
        /// <returns></returns>
        int OfflineJXTemplate(string v_template_id);

        /// <summary>
        /// 修改模板信息
        /// </summary>
        /// <param name="v_template_id">待修改的模板系统编号</param>
        /// <param name="v_template_content">模板内容</param>
        /// <param name="v_template_name">模板名称</param>
        /// <param name="v_template_remark">模板备注</param>
        /// <returns></returns>
        int UpdateJXTemplate(string v_template_id, string v_template_content, string v_template_name, string v_template_remark);

        int GetTemplateNoByID(string v_template_id);
    }
}
