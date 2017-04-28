# Whilst we can not easily automate the installation of nagios core 4
# application of this profile to a given server will at least ensure
# that everything is in place to make it work.
#
# Installing_Nagios_Core_From_Source.pdf is available from the Nagios
# website. There is no need to make install-webconf
class profile::nagios::server {
  
  user { 'nagios':
    ensure => 'present',
  }
  
  group { 'nagcmd':
    ensure  => 'present',
    members => 'nagios',
  }
  
  group { 'nagios':
    ensure  => 'present',
    members => 'nagios,www-data',
  }

  group { 'www-data':
    ensure  => 'present',
    members => 'nagios,nagcmd',
  }
  
  package { ['build-essential', 'php7.0-gd', 'libgd-dev', 'unzip', 'monitoring-plugins']:
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
  
}
