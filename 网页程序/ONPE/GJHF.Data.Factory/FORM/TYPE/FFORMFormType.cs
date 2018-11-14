using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Reflection;
using GJHF.Data.Model.FORM.TYPE;
using GJHF.Data.Interface.FORM.TYPE;

namespace GJHF.Data.Factory.FORM.TYPE
{
    public class FFORMFormType
    {
        public static IFORMFormType Create()
        {
            return new GJHF.Data.MSSQL.FORM.TYPE.DFORMFormType();
        }
    }
}
