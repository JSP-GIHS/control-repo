# ADFS Server Installation and Configuration
class profile::adfs::server {

  dsc_windowsfeature { 'InstallADFS':
    dsc_ensure => 'present',
    dsc_name   => 'ADFS-Federation',
  }

  dsc_windowsfeature { 'Windows-Internal-Database':
    dsc_ensure => 'present',
    dsc_name   => 'Windows-Internal-Database',
  }

}
