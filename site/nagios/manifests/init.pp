# Whilst we can not easily automate the installation of nagios core 4
# application of this profile to a given server will at least ensure
# that everything is in place to make it work.
#
# Installing_Nagios_Core_From_Source.pdf is available from the Nagios
# website. There is no need to make install-webconf
#
# Rather than passing class parameters which would mean I can't use
# the pretty-form monitor::nagios::hostgroups we will do a hiera
# lookup for these values
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

  file { [$nagios::params::resourced, "${nagios::params::resourced}/commands"]:
    ensure => 'directory',
    path   => $nagios::params::resourced,
    owner  => $nagios::params::user,
  }

  file_line { '/usr/local/nagios/etc/nagios.cfg_resourced':
    ensure => 'present',
    path   => '/usr/local/nagios/etc/nagios.cfg',
    line   => "cfg_dir=${nagios::params::resourced}",
    notify => Service['nagios'],
  }

  file_line { '/usr/local/nagios/etc/nagios.cfg_localhostcfg':
    ensure => 'absent',
    path   => '/usr/local/nagios/etc/nagios.cfg',
    line   => 'cfg_file=/usr/local/nagios/etc/objects/localhost.cfg',
    notify => Service['nagios'],
  }

  $hostgroups = lookup('monitor::nagios::hostgroups')
  if $hostgroups {
    $hostgroups.each |String $hgname| {
      nagios::resource { $hgname:
        type     => 'hostgroup',
        exported => false,
      }
    }
  }

  nagios_command { 'check_snmp':
    command_line => '$USER1$/check_snmp -H $HOSTADDRESS$ $ARG1$',
    target       => "${nagios::params::resourced}/commands/check_snmp.cfg",
  }

  nagios_command { 'check_ping':
    command_line => '$USER1$/check_ping -H $HOSTADDRESS$ $ARG1$',
    target       => "${nagios::params::resourced}/commands/check_ping.cfg",
  }

  nagios_service { 'check_ping':
    ensure              => 'present',
    use                 => 'local-service',
    service_description => 'ICMP Echo Request',
    hostgroup_name      => 'windows-servers,linux-servers',
    check_command       => 'check_ping!100,20%!200,30%',
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
