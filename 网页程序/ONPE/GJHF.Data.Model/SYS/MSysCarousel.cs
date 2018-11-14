using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace GJHF.Data.Model.SYS
{
    public class MSysCarousel
    {
        public int   data_id {get;set;}
        public string    image_name    {get;set;}
        public string   image_address       {get;set;}
        /// <summary>
        /// 图片状态  1 可用 0 不可用
        /// </summary>
        public int image_state { get; set; }
    }
}
