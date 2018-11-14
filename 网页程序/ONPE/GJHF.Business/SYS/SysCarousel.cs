using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using System.IO;
using System.Web;

namespace GJHF.Business.SYS
{
    public class SysCarousel
    {
        private readonly static string _image_path = "~/img/Carousel/";
        private GJHF.Data.Interface.SYS.ISysCarousel BSysCarousel;
        private GJHF.Business.SYS.SysState _SysState;
        public SysCarousel()
        {
            this.BSysCarousel = GJHF.Data.Factory.SYS.FSysCarousel.Create();
            this._SysState = new SysState();
        }
        public int AddSysCarousel(HttpPostedFile v_file, int v_image_state)
        {
            string m_image_name = "";
            string m_image_address = "";
            string m_new_name = "";
            try
            {
                if (v_file != null)
                {
                    m_image_name = Path.GetFileNameWithoutExtension(v_file.FileName);
                    m_new_name = Guid.NewGuid().ToString() + Path.GetExtension(v_file.FileName);
                    m_image_address = _image_path.Replace("~", "") + m_new_name;
                    if (File.File.SaveFile(_image_path, m_new_name, v_file))
                    {
                        return BSysCarousel.AddSysCarousel(m_image_name, m_image_address, v_image_state);
                    }
                    else
                    {
                        return 0;
                    }
                }
                else
                {
                    return 0;
                }
            }
            catch (Exception e)
            {
                return 0;
            }
            
        }
        public int EditSysCarousel(int v_data_id, HttpPostedFile v_file, int v_image_state)
        {
            string m_image_name = "";
            string m_image_address = "";
            string m_new_name = "";
            try
            {
                if (v_file != null)
                {
                    m_image_name = Path.GetFileNameWithoutExtension(v_file.FileName);
                    m_new_name = Guid.NewGuid().ToString() + Path.GetExtension(v_file.FileName);
                    m_image_address = _image_path.Replace("~", "") + m_new_name;
                    if (File.File.SaveFile(_image_path, m_new_name, v_file))
                    {
                        return BSysCarousel.EditSysCarousel(v_data_id, m_image_name, m_image_address, v_image_state);
                    }
                    else
                    {
                        return 0;
                    }
                }
                else
                {
                    return 0;
                }
            }
            catch (Exception e)
            {
                return 0;
            }
        }
        public int DelSysCarousel(int v_data_id)
        {
            return BSysCarousel.DelSysCarousel(v_data_id);
        }
        public int UpdateSysCarouselState(int v_data_id, int v_image_state)
        {
            return BSysCarousel.UpdateSysCarouselState(v_data_id, v_image_state);
        }
        public int GetSysCarouselCount(int v_image_state)
        {
            return BSysCarousel.GetSysCarouselCount(v_image_state);
        }
        public DataTable GetSysCarousel(int v_image_state)
        {
            return BSysCarousel.GetSysCarousel(v_image_state);
        }
    }
}
