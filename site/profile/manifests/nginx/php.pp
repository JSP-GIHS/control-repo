# Nginx PHP Configuration.
#
# Note that this does not light up the PHP inside Nginx, simply
# installs the php7.0-fpm module.
#
# This is specified as an Nginx module as configuration of
# apache may be different (but I do not know at this time)
class profile::nginx::php {
  package { ['php7.0-fpm']:
    ensure  => present,
    require => Package['nginx-core'],
  }

  file { '/etc/php/7.0/fpm/php.ini':
    ensure  => present,
    require => Package['php7.0-fpm'],
  }

  service { 'php7.0-fpm':
    ensure  => running,
    require => Package['php7.0-fpm'],
  }

  ini_setting { 'php_fpm_cgi_fix_pathinfo':
    ensure  => present,
    path    => '/etc/php/7.0/fpm/php.ini',
    section => 'PHP',
    setting => 'cgi.fix_pathinfo',
    value   => '0',
    require => Package['php7.0-fpm'],
    notify  => Service['php7.0-fpm'],
  }
}
