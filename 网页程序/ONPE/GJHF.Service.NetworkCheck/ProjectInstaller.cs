using System;
using System.Collections;
using System.Collections.Generic;
using System.ComponentModel;
using System.Configuration.Install;
using System.Linq;


namespace GJHF.Service.NetworkCheck
{
    [RunInstaller(true)]
    public partial class ProjectInstaller : System.Configuration.Install.Installer
    {
        public ProjectInstaller()
        {
            InitializeComponent();
            using (SettingHelper sh = new SettingHelper())
            {
                serviceInstaller1.ServiceName = sh.ServiceName;
                serviceInstaller1.DisplayName = sh.DisplayName;
                serviceInstaller1.Description = sh.Description;
            }
        }
    }
}
