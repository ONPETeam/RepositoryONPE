using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;

namespace GJHF.Data.Interface.SYS
{
    public interface ISysCarousel
    {
        int AddSysCarousel(string v_image_name, string v_image_address, int v_image_state);
        int EditSysCarousel(int v_data_id, string v_image_name, string v_image_address, int v_image_state);
        int DelSysCarousel(int v_data_id);
        int UpdateSysCarouselState(int v_data_id, int v_image_state);
        int GetSysCarouselCount(int v_image_state);
        DataTable GetSysCarousel(int v_image_state);
    }
}
