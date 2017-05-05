# IIS Server Installation and Configuration
class profile::iis {

  dsc_windowsfeature { 'IIS':
    dsc_ensure => 'present',
    dsc_name   => 'Web-Server',
  }

  dsc_windowsfeature { 'ASP.NET45':
    dsc_ensure => 'present',
    dsc_name   => 'Web-Asp-Net45',
    require    => Dsc_windowsfeature['IIS'],
  }

  dsc_windowsfeature { 'IISScriptingTools':
    dsc_ensure => 'present',
    dsc_name   => 'Web-Scripting-Tools',
    require    => Dsc_windowsfeature['IIS'],
  }

}
