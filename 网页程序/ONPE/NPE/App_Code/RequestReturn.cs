using System;
using System.Collections.Generic;
using System.Web;

/// <summary>
///error 的摘要说明
/// </summary>
public class RequestReturn
{
    private Boolean _responstResult;
    public Boolean responstResult 
    {
        set { _responstResult = value; }
        get { return _responstResult; }

    }
    private object _responstDetial;
    public object responstDetial
    {
        set { _responstDetial = value; }
        get { return _responstDetial; }
    }
    
    private string _responstMsg;
    public string responstMsg
    {
        set { _responstMsg = value; }
        get { return _responstMsg; }
    }
}