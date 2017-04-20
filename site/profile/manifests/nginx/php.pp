# Nginx PHP Configuration.
#
# Note that this does not light up the PHP inside Nginx, simply
# installs the php7.0-fpm module.
#
class profile::nginx::php inherits profile::nginx  {

  package { ['php7.0-fpm']:
    ensure  => 'latest',
    require => Service['nginx'],
  }

  file { '/etc/php/7.0/fpm/php.ini':
    ensure  => 'present',
    require => Package['php7.0-fpm'],
  }

  service { 'php7.0-fpm':
    ensure  => 'running',
    enable  => true,
    require => Package['php7.0-fpm'],
  }

  ini_setting { 'php_fpm_cgi_fix_pathinfo':
    ensure  => 'present',
    path    => '/etc/php/7.0/fpm/php.ini',
    section => 'PHP',
    setting => 'cgi.fix_pathinfo',
    value   => '0',
    require => Package['php7.0-fpm'],
    notify  => Service['php7.0-fpm'],
  }

  ini_setting { 'php_fpm_expose_php_off':
    ensure  => 'present',
    path    => '/etc/php/7.0/fpm/php.ini',
    section => 'PHP',
    setting => 'expose_php',
    value   => 'Off',
    require => Package['php7.0-fpm'],
    notify  => Service['php7.0-fpm'],
  }

}
