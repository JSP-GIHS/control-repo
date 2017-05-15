# Include php programs
#
# Note that we assume installation of php7.0-gd
# and php7.0-fpm as part of a separate Nginx/profile
class librenms::php {

  package { [
      'php7.0-cli',
      'php7.0-mysql',
      #'php7.0-gd',
      'php7.0-snmp',
      'php-pear',
      'php7.0-curl',
      #'php7.0-fpm',
      'php7.0-mcrypt',
      'php7.0-json',
      'php-net-ipv4',
      'php-net-ipv6',
    ]:
    ensure => 'latest',
  }

}
