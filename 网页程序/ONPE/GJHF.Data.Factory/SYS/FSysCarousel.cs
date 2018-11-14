using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace GJHF.Data.Factory.SYS
{
    public class FSysCarousel
    {
        public static Interface.SYS.ISysCarousel Create()
        {
            return new MSSQL.SYS.DSysCarousel();
        }
    }
}
