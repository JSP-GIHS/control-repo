# Install Xymon and configure the CGI Urls to
# be a little more generic.
#
# This profile requires nginx at this time.
class profile::xymon::server {

  package { ['xymon']:
    ensure  => 'latest',
    require => [
      Service['nginx'],
      Package['fcgiwrap'],
      Package['spawn-fcgi'],
    ],
  }

  service { 'xymon':
    ensure  => 'running',
    enable  => true,
    require => Package['xymon'],
  }

  file_line { 'xymonserver_cgiurl':
    ensure  => 'present',
    path    => '/etc/xymon/xymonserver.cfg',
    line    => 'XYMONSERVERCGIURL="/cgi-bin"',
    match   => 'XYMONSERVERCGIURL=',
    require => Package['xymon'],
    notify  => Service['xymon'],
  }

  file_line { 'xymonserver_securecgiurl':
    ensure  => 'present',
    path    => '/etc/xymon/xymonserver.cfg',
    line    => 'XYMONSERVERSECURECGIURL="/cgi-secure"',
    match   => 'XYMONSERVERSECURECGIURL=',
    require => Package['xymon'],
    notify  => Service['xymon'],
  }

  file { '/etc/xymon/hosts.cfg':
    ensure  => 'present',
    source  => 'puppet:///modules/profile/xymon/hosts.cfg',
    require => Package['xymon'],
    notify  => Service['xymon'],
  }

  file { '/etc/nginx/.htpasswd.xymon':
    ensure  => 'present',
    require => Service['nginx'],
  }

  file { '/etc/nginx/sites-available/xymon':
    ensure  => 'present',
    source  => template('xymon/nginx.cfg.erb'),
    require => Service['nginx'],
    notify  => Service['nginx'],
  }

  file { '/etc/nginx/sites-enabled/xymon':
    ensure  => link,
    target  => '/etc/nginx/sites-available/xymon',
    require => File['/etc/nginx/sites-available/xymon'],
    notify  => Service['nginx'],
  }

}
