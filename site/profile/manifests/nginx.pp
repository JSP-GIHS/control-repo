# Install Nginx and FCGI. This is not called profile::web or
# similar because we deploy a myriad of webservers here. including
# IIS, Nginx, Apache. I would like to standardise on Nginx one
# day
class profile::nginx {

  include openssl

  package { ['nginx-core', 'fcgiwrap', 'spawn-fcgi']:
    ensure => 'latest',
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

  file { '/etc/nginx/nginx.conf':
    ensure => 'present',
    source => 'puppet:///modules/profile/nginx/nginx.conf',
    notify => Service['nginx'],
  }

  file { '/etc/nginx/ssl':
    ensure => 'directory',
  }

  openssl::dhparam { '/etc/nginx/ssl/dhparam.pem':
    size    => 4096,
    require => File['/etc/nginx/ssl'],
    notify  => Service['nginx'],
  }

  file { '/etc/nginx/sites-enabled/default':
    ensure => 'absent',
    notify => Service['nginx'],
  }

}
