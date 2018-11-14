using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace ModelClass
{
    /// <summary>
    ///diretory 的摘要说明
    /// </summary>
    public class diretory
    {
        public string diretory_code { get; set; }
        public string diretory_name { get; set; }
        public string diretory_innum { get; set; }
        public string diretory_create_time { get; set; }
        public string diretory_create_people { get; set; }
        public string diretory_visible { get; set; }
        public string fileclass_code { get; set; }
        public string fileclass_name { get; set; }
        public string diretory_parent { get; set; }
        public string diretory_parent_code { get; set; }
        public string diretory_parent_name { get; set; }
        public string diretory_remark { get; set; }
        public string diretory_general { get; set; }
        public string diretory_selectable { get; set; }
    }
    public class file
    {
        public string file_code { get; set; }
        public string file_name { get; set; }
        public string file_innum { get; set; }
        public string file_type { get; set; }
        public string fileclass_code { get; set; }
        public string fileclass_name { get; set; }
        public string diretory_code { get; set; }
        public string diretory_name { get; set; }
        public string file_size { get; set; }
        public string file_data_flag { get; set; }
        public string file_address { get; set; }
        public byte[] file_context { get; set; }
        public string file_time { get; set; }
        public string file_people { get; set; }
        public string file_remark { get; set; }
    }
    public class fileclass
    {
        public string fileclass_code { get; set; }
        public string fileclass_name { get; set; }
        public string fileclass_parent_code { get; set; }
        public string fileclass_parent_name { get; set; }
    }
}