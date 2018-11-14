using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web;
using System.IO;

namespace GJHF.Business.File
{
    public class File
    {
        public static bool SaveFile(string path, string filename, HttpPostedFile file)
        {
            try
            {
                if (!Directory.Exists(HttpContext.Current.Server.MapPath(path)))
                {
                    Directory.CreateDirectory(HttpContext.Current.Server.MapPath(path));
                }
                file.SaveAs(HttpContext.Current.Server.MapPath(path + "/" + filename));
                return true;
            }
            catch (Exception ex)
            {
                return false;
            }
        }
    }
}
