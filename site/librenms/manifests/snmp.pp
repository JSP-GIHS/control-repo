# Configure SNMP
#
# This is a dirty module, doesn't require much
# but we're having to account for the SNMP changes
# that LibreNMS asks for during installation whilst
# still permitting other modules to manage /etc/snmp/snmpd.conf
class librenms::snmp {

  $snmp = lookup('monitor::snmp::community')

  file_line { '/etc/snmp/snmpd.conf_librenms_com2sec':
    ensure => 'present',
    path   => '/etc/snmp/snmpd.conf',
    line   => "com2sec readonly default ${snmp}",
    notify => Service['snmpd'],
  }

  file_line { '/etc/snmp/snmpd.conf_group':
    ensure => 'present',
    path   => '/etc/snmp/snmpd.conf',
    line   => 'group	MyROGroup	v2c	readonly',
    notify => Service['snmpd'],
  }

  file_line { '/etc/snmp/snmpd.conf_viewall':
    ensure => 'present',
    path   => '/etc/snmp/snmpd.conf',
    line   => 'view all	included	.1	80',
    notify => Service['snmpd'],
  }

  file_line { '/etc/snmp/snmpd.conf_groupaccess':
    ensure => 'present',
    path   => '/etc/snmp/snmpd.conf',
    line   => 'access MyROGroup ""  any	noauth	exact	all	none	none',
    notify => Service['snmpd'],
  }

  file_line { '/etc/snmp/snmpd.conf_distrodetection':
    ensure => 'present',
    path   => '/etc/snmp/snmpd.conf',
    line   => 'extend .1.3.6.1.4.1.2021.7890.1 distro /usr/bin/distro',
    notify => Service['snmpd'],
  }

}
