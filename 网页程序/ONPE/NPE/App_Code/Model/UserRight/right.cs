using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace ModelClass
{
    /// <summary>
    /// 菜单组
    /// </summary>

    public class menugroup
    {
        /// <summary>
        /// 菜单组编号
        /// </summary>		
        public string menugroup_id { get; set; }
        /// <summary>
        /// 菜单组类型
        /// </summary>
        public int menugroup_class { get; set; }
        /// <summary>
        /// 菜单组名称
        /// </summary>		
        public string menugroup_name { get; set; }

        /// <summary>
        /// 菜单组排序
        /// </summary>
        public int menugroup_sort { get; set; }
        /// <summary>
        /// 字体颜色
        /// </summary>
        public string font_color { get; set; }
        /// <summary>
        /// 字体大小
        /// </summary>
        public string font_size { get; set; }
        /// <summary>
        /// 背景颜色
        /// </summary>
        public string background_color { get; set; }

    }
    /// <summary>
    /// 菜单项
    /// </summary>
    public class menu
    {
        /// <summary>
        /// 菜单编号
        /// </summary>
        public string menu_id { get; set; }
        /// <summary>
        /// 菜单类型
        /// </summary>
        public int menu_class { get; set; }
        /// <summary>
        /// 菜单名称
        /// </summary>
        public string menu_name { get; set; }
        /// <summary>
        /// 上级菜单编号
        /// </summary>
        public string menu_parent { get; set; }
        /// <summary>
        /// 菜单组编号
        /// </summary>
        public string menugroup_id { get; set; }
        /// <summary>
        /// 菜单组名称
        /// </summary>
        public string menugroup_name { get; set; }
        /// <summary>
        /// 编码
        /// </summary>
        public string menu_code { get; set; }
        /// <summary>
        /// 菜单标题
        /// </summary>
        public string menu_title { get; set; }
        /// <summary>
        /// 链接地址
        /// </summary>
        public string menu_link { get; set; }
        /// <summary>
        /// 字体颜色
        /// </summary>
        public string font_color { get; set; }
        /// <summary>
        /// 字体大小
        /// </summary>
        public string font_size { get; set; }
        /// <summary>
        /// 背景颜色
        /// </summary>
        public string background_color { get; set; }


        /// <summary>
        /// 图标
        /// </summary>
        public string menu_iconcls { get; set; }
        /// <summary>
        /// 图标对齐方式
        /// </summary>
        public string menu_iconalign { get; set; }
        /// <summary>
        /// 图标大小
        /// </summary>
        public string menu_iconsize { get; set; }
        /// <summary>
        /// 显示顺序
        /// </summary>
        public int menu_sort { get; set; }
        /// <summary>
        /// 分组序号
        /// </summary>
        public int menu_no { get; set; }
        /// <summary>
        /// 添加时间
        /// </summary>
        public string add_time { get; set; }
        /// <summary>
        /// 备注说明
        /// </summary>
        public string menu_remark { get; set; }
    }

    public class menugroupmenu
    {
        /// <summary>
        /// 菜单组编号
        /// </summary>		
        public string menugroup_id { get; set; }
        /// <summary>
        /// 菜单编号
        /// </summary>
        public string menu_id { get; set; }
        /// <summary>
        /// 菜单名称
        /// </summary>
        public string menu_name { get; set; }
        /// <summary>
        /// 菜单标题
        /// </summary>
        public string menu_title { get; set; }
        /// <summary>
        /// 链接地址
        /// </summary>
        public string menu_link { get; set; }
        /// <summary>
        /// 显示顺序
        /// </summary>
        public string menu_sort { get; set; }
        /// <summary>
        /// 分组序号
        /// </summary>
        public string menu_no { get; set; }
        /// <summary>
        /// 显示图标
        /// </summary>
        public string menu_iconcls { get; set; }
    }

    /// <summary>
    /// 权限项
    /// </summary>
    public class pageitem
    {
        /// <summary>
        /// item_id
        /// </summary>		
        public string item_id { get; set; }
        /// <summary>
        /// item_name
        /// </summary>		
        public string item_name { get; set; }
        /// <summary>
        /// item_class
        /// </summary>		
        public int item_class { get; set; }
        /// <summary>
        /// item_parent
        /// </summary>		
        public string item_parent { get; set; }
        /// <summary>
        /// item_title
        /// </summary>		
        public string item_title { get; set; }
        /// <summary>
        /// item_code
        /// </summary>		
        public string item_code { get; set; }
        /// <summary>
        /// item_icon
        /// </summary>		
        public string item_icon { get; set; }
        /// <summary>
        /// item_iconalign
        /// </summary>		
        public string item_iconalign { get; set; }
        /// <summary>
        /// item_iconsize
        /// </summary>		
        public string item_iconsize { get; set; }
        /// <summary>
        /// add_time
        /// </summary>		
        public DateTime add_time { get; set; }
        /// <summary>
        /// item_remark
        /// </summary>		
        public string item_remark { get; set; }  
    }
    public class rights
    {
        /// <summary>
        /// right_code
        /// </summary>		
        public string right_code { get; set; }
        /// <summary>
        /// right_name
        /// </summary>		
        public string right_name { get; set; }
        /// <summary>
        /// right_menu
        /// </summary>		
        public string right_menugroup { get; set; }
        /// <summary>
        /// right_menu
        /// </summary>		
        public string right_menu { get; set; }
        /// <summary>
        /// right_item
        /// </summary>		
        public string right_item { get; set; }

        /// <summary>
        /// right_menugroup_name
        /// </summary>		
        public string right_menugroup_name { get; set; }
        /// <summary>
        /// right_item_title
        /// </summary>		
        /// <summary>
        /// right_menu_title
        /// </summary>		
        public string right_menu_title { get; set; }
        /// <summary>
        /// right_item_title
        /// </summary>		
        public string right_item_title { get; set; }
        /// <summary>
        /// right_class
        /// </summary>		
        public int right_class { get; set; }
        /// <summary>
        /// right_remark
        /// </summary>		
        public string right_remark { get; set; }
    }
    public class groupright {
        public string right_code { get; set; }
        public string right_name { get; set; }
        public string right_menugroup { get; set; }
        public string right_menugroup_name { get; set; }
        public string right_menu { get; set; }
        public string right_menu_title { get; set; }
        public string right_item { get; set; }
        public string right_item_title { get; set; }
        public string right_type { get; set; }
        public string author_user { get; set; }
        public string author_start { get; set; }
        public string author_end { get; set; }
        public string _parentId { get; set; }
        public Boolean @checked { get; set; }
    }
    public class roleright {
        public string right_code { get; set; }
        public string right_name { get; set; }
        public string right_menugroup { get; set; }
        public string right_menugroup_name { get; set; }
        public string right_menu { get; set; }
        public string right_menu_title { get; set; }
        public string right_item { get; set; }
        public string right_item_title { get; set; }
        public string right_type { get; set; }
        public string author_user { get; set; }
        public string author_start { get; set; }
        public string author_end { get; set; }
    }
    public class userright
    {
        public string right_code { get; set; }
        public string right_name { get; set; }
        public string right_menugroup { get; set; }
        public string right_menugroup_name { get; set; }
        public string right_menu { get; set; }
        public string right_menu_title { get; set; }
        public string right_item { get; set; }
        public string right_item_title { get; set; }
        public string right_type { get; set; }
        public string author_user { get; set; }
        public string author_start { get; set; }
        public string author_end { get; set; }
    }
}