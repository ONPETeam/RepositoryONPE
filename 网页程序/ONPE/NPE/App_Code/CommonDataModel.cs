using System;
using System.Collections.Generic;
using System.Web;
using ModelClass;

namespace NPE.UIDataClass
{
    public class TreeNode
    {
        public string id { get; set; }
        public string text { get; set; }
        /// <summary>
        /// 'open' 或 'closed'，默认是 'open'。
        /// 如果为'closed'的时候，将不自动展开该节点。
        /// </summary>
        public string state { get; set; }
        public bool ischecked { get; set; }// replace checked
        public object attributes { get; set; }
        public string iconCls { get; set; }
        public List<TreeNode> children { get; set; }
    }

    public class PropertyGrid
    {
        public int total { get; set; }
        public List<PropertyGridNode> rows { get; set; }
    }

    public class PropertyGridNode
    {
        public string name { get; set; }
        public string value { get; set; }

        public string group { get; set; }
        public object editor { get; set; }
    }

    public class Editror
    {
        public string type { get; set; }
        public List<object> options { get; set; }
    }

    public class combotree
    {
        public string id { get; set; }
        public string text { get; set; }
        public string state { get; set; }
        public object attributes { get; set; }
        public string iconCls { get; set; }
        public List<combotree> children { get; set; }
    }
    public class combobox
    {
        public string id { get; set; }
        public string text { get; set; }
    }

    
    //public class grid
    //{
    //    public int total { get; set; }
    //    public List<plckgldy> rows { get; set; }
    //}
    
    //public class gridgzdc
    //{
    //    public int total { get; set; }
    //    public List<plcgzdc> rows { get; set; }
    //}

   
    //public class gridddz
    //{
    //    public int total { get; set; }
    //    public List<plcddz> rows { get; set; }

    //}
    
    //public class gridgzbj
    //{
    //    public int total { get; set; }
    //    public List<plcgzbj> rows { get; set; }
    //}



}
