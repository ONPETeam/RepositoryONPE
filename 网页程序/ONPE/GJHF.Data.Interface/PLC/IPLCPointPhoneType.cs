using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;

namespace GJHF.Data.Interface.PLC
{
    public interface IPLCPointPhoneType
    {

        int AddPLCPointPhoneType(int plc_point_address_id, int phone_type_id);

        int DelPLCPointPhoneType(int plc_point_address_id);

        int AddPLCPointPJ(int plc_point_address_id, string plc_point_pj);

        int DelPLCPointPJ(int plc_point_address_id);

        DataTable GetDataByid(int vIntDataID);
    }
}
