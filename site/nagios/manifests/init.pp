# Whilst we can not easily automate the installation of nagios core 4
# application of this profile to a given server will at least ensure
# that everything is in place to make it work.
#
# Installing_Nagios_Core_From_Source.pdf is available from the Nagios
# website. There is no need to make install-webconf
class nagios {

  include nagios::params

  package { ['build-essential', 'php7.0-gd', 'libgd-dev', 'unzip']:
    ensure => 'latest',
  }

  file { '/etc/nginx/sites-available/nagios':
    ensure  => 'present',
    content => template('nagios/nginx.cfg.erb'),
    notify  => Service['nginx'],
  }

  file { '/etc/nginx/sites-enabled/nagios':
    ensure => 'symlink',
    target => '/etc/nginx/sites-available/nagios',
    notify => Service['nginx'],
  }

  file { '/etc/nginx/.htpasswd.nagios':
    ensure => 'present',
  }

  group { 'nagcmd':
    ensure => 'present',
  }

  group { 'nagios':
    ensure => 'present',
  }

  user { $nagios::params::user:
    ensure  => 'present',
    groups  => [
      'nagcmd',
    ],
    require => [
      Group['nagcmd'],
    ],
  }

  user { 'www-data':
    ensure  => 'present',
    groups  => [
      'nagcmd',
      'nagios',
    ],
    require => [
      Group['nagcmd'],
      Group['nagios'],
    ],
  }

  service { 'nagios':
    ensure => 'running',
    enable => true,
  }

  file { $nagios::params::resourced:
    path   => $nagios::params::resourced,
    ensure => 'directory',
    owner  => $nagios::params::user,
  }

  Nagios_host <<||>> {
    owner   => $nagios::params::user,
    require => [
      File[$nagios::params::resourced],
      User[$nagios::params::user],
      Group['nagios'],
    ],
    notify  => Service['nagios'],
  }

}
