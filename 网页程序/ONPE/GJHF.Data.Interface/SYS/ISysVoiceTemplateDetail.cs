using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;

namespace GJHF.Data.Interface.SYS
{
    public interface ISysVoiceTemplateDetail
    {
        /// <summary>
        /// 获取模板参数数量
        /// </summary>
        /// <param name="v_template_id">模板系统编号</param>
        /// <returns></returns>
        int GetJXTemplateParamCount(string v_template_id);

        /// <summary>
        /// 获取模板参数
        /// </summary>
        /// <param name="v_template_id">模板系统编号</param>
        /// <returns></returns>
        DataTable GetJXTemplateParamData(string v_template_id);

        /// <summary>
        /// 添加参数
        /// </summary>
        /// <param name="v_param_name">参数名称</param>
        /// <param name="v_param_code">参数代码</param>
        /// <param name="v_param_type">参数类型</param>
        /// <param name="v_param_length">参数长度</param>
        /// <param name="v_template_id">模板编号</param>
        /// <param name="v_param_remark">参数说明</param>
        /// <returns></returns>
        int AddTemplateParam( string v_param_name, string v_param_code, int v_param_type, int v_param_length, string v_template_id, string v_param_remark);

        /// <summary>
        /// 删除参数
        /// </summary>
        /// <param name="v_param_id">参数编号</param>
        /// <returns></returns>
        int DelTemplateParam(string v_param_id);
    }
}
