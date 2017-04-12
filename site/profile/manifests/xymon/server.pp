# Configure the Xymon Server to use the default CGI
# URL's on an Ubuntu Xenial installation.
#
# This requires Nginx as we run this for our web
# environment over the default apache.
class profile::xymon::server {

  package { ['xymon']:
    ensure  => present,
    require => [
      Package['nginx-core'],
      Package['fcgiwrap'],
      Package['spawn-fcgi'],
    ],
  }

  service { 'xymon':
    ensure  => 'running',
    enable  => true,
    require => Package['xymon'],
  }

  #file_line { 'xymonserver_cgiurl':
  #  ensure  => present,
  #  path    => '/etc/xymon/xymonserver.cfg',
  #  line    => 'XYMONSERVERCGIURL="/cgi-bin"',
  #  match   => 'XYMONSERVERCGIURL=',
  #  require => Package['xymon'],
  #  notify  => Service['xymon'],
  #}

  #file_line { 'xymonserver_securecgiurl':
  #  ensure  => present,
  #  path    => '/etc/xymon/xymonserver.cfg',
  #  line    => 'XYMONSERVERSECURECGIURL="/cgi-secure"',
  #  match   => 'XYMONSERVERSECURECGIURL=',
  #  require => Package['xymon'],
  #  notify  => Service['xymon'],
  #}

  file { '/etc/xymon/hosts.cfg':
    ensure  => present,
    source  => 'puppet:///files/modules/xymon/hosts.cfg',
    require => Package['xymon'],
    notify  => Service['xymon'],
  }

  file { '/etc/nginx/sites-available/xymon':
    ensure  => present,
    source  => 'puppet:///files/modules/xymon/xymon-web.cfg',
    require => Package['nginx-core'],
  }

  file { '/etc/nginx/sites-enabled/default':
    ensure => link,
    target => '/etc/nginx/sites-available/xymon',
    notify => Service['nginx'],
  }

}
