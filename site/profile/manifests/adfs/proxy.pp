# ADFS Server Installation and Configuration
class profile::adfs::proxy {

  dsc_windowsfeature { 'Web-Application-Proxy':
    dsc_ensure => 'present',
    dsc_name   => 'Web-Application-Proxy',
  }

  dsc_windowsfeature { 'Windows-Internal-Database':
    dsc_ensure => 'present',
    dsc_name   => 'Windows-Internal-Database',
  }

}
