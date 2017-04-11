# Install Nginx and FCGI. This is not called profile::web or
# similar because we deploy a myriad of webservers here. including
# IIS, Nginx, Apache. I would like to standardise on Nginx one
# day
class profile::nginx {
  package { ['nginx-core', 'fcgiwrap', 'spawn-fcgi']:
    ensure => present,
  }

  service { 'nginx':
    ensure  => running,
    enable  => true,
    require => [
      Package['nginx-core'],
      Package['fcgiwrap'],
      Package['spawn-fcgi'],
    ],
  }
}
