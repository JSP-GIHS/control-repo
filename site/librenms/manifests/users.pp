# Manage users and groups for LibreNMS
class librenms::users {

  group { 'librenms':
    ensure => 'present',
  }

  user { 'librenms':
    ensure     => 'present',
    home       => '/opt/librenms',
    system     => true,
    managehome => true,
    groups     => [
      'www-data',
      'librenms',
    ],
  }

  file { ['/opt/librenms/rrd', '/opt/librenms/logs']:
    ensure  => 'directory',
    mode    => '0775',
    owner   => 'librenms',
    group   => 'librenms',
    require => User['librenms'],
  }

}
