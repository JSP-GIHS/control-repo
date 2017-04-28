# Configure SNMP Services for Linux Server. This will rely on the
# two hiera values:
#
# monitor::snmp::community
# monitor::snmp::manager
#
class profile::snmp::linux {

  package { 'snmpd':
    ensure => 'latest',
  }

  service { 'snmpd':
    ensure => 'running',
    enable => true,
  }

  $snmpcommunity = lookup('monitor::snmp::community')
  $snmpmanager = lookup('monitor::snmp::manager')

  file_line { '/etc/snmp/snmpd.conf_defaultcommunity':
    ensure   => 'present',
    path     => '/etc/snmp/snmpd.conf',
    match    => '^ rocommunity',
    line     => '# rocommunity line with space - removed',
    multiple => true,
    require  => Package['snmpd'],
    notify   => Service['snmpd'],
  }

  file_line { '/etc/snmp/snmpd.conf_rocommunity':
    ensure  => 'present',
    path    => '/etc/snmp/snmpd.conf',
    match   => '^rocommunity',
    line    => "rocommunity ${snmpcommunity} ${snmpmanager}",
    require => Package['snmpd'],
    notify  => Service['snmpd'],
  }

  file_line { '/etc/snmp/snmpd.conf_agentaddress':
    ensure  => 'present',
    path    => '/etc/snmp/snmpd.conf',
    match   => '^agentAddress',
    line    => 'agentAddress udp:161',
    require => Package['snmpd'],
    notify  => Service['snmpd'],
  }

}
