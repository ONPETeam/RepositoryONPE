using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

public class tabs
{
    public string title { get; set; }
    public string font_color { get; set; }
    public string font_size { get; set; }
    public string background_color { get; set; }
    public List<tabsItemGroup> groups { get; set; }
}
public class tabsItemGroup
{
    public string text { get; set; }
    public List<tabsItem> tools { get; set; }
}
public class tabsItem
{
    public string name { get; set; }
    public string text { get; set; }
    public string iconCls { get; set; }
    public string iconAlign { get; set; }
    public string size { get; set; }
    public string font_size { get; set; }
    public string font_color { get; set; }
    public string background_color { get; set; }
}