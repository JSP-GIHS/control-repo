# Whilst we can not easily automate the installation of nagios core 4
# application of this profile to a given server will at least ensure
# that everything is in place to make it work.
#
# Installing_Nagios_Core_From_Source.pdf is available from the Nagios
# website. There is no need to make install-webconf
class profile::nagios::server {

  package { ['build-essential', 'php7.0-gd', 'libgd-dev', 'unzip']:
    ensure => 'latest',
  }

  file { '/etc/nginx/sites-available/nagios':
    ensure  => 'present',
    content => template('profile/nagios/nginx.cfg.erb'),
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

  user { 'nagios':
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

  file { 'nagios-resource-d':
    path   => '/usr/local/nagios/etc/resource.d',
    ensure => 'directory',
    owner  => 'nagios',
    group  => 'nagios',
  }

  Nagios_host <<||>> {
    owner   => 'nagios',
    group   => 'nagios',
    require => [
      File['resource-d'],
      User['nagios'],
      Group['nagios'],
    ],
    notify  => Service['nagios'],
  }

}
