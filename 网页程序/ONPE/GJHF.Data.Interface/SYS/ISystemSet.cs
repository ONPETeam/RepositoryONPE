using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;

namespace GJHF.Data.Interface.SYS
{
    public interface ISystemSet
    {
        string GetSystemSet(string v_set_key);

        int SaveSystemSet(string v_set_key,string v_set_context);

        Model.SYS.MNetworkWriteContext GetLastWriteContext();
    }
}
