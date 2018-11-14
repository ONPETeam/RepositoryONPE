using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class html_plc_Default : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected bool isNumberic(string message)
    {
        System.Text.RegularExpressions.Regex rex =
        new System.Text.RegularExpressions.Regex(@"^[+-]?\d*[.]?\d*$");

        if (rex.IsMatch(message))
        {
            return true;
        }
        else
            return false;
    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        Label1.Text = isNumberic(TextBox1.Text).ToString();
    }
}