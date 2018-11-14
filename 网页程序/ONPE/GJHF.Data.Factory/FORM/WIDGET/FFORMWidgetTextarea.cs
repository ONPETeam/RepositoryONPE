using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Reflection;
using GJHF.Data.Model.FORM.WIDGET;
using GJHF.Data.Interface.FORM.WIDGET;

namespace GJHF.Data.Factory.FORM.WIDGET
{
    public class FFORMWidgetTextarea
    {
        public static IFORMWidgetTextarea Create()
        {
            return new GJHF.Data.MSSQL.FORM.WIDGET.DFORMWidgetTextarea();
        }
    }
}
