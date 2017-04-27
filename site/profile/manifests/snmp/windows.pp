# Configure SNMP Services for Windows Server. This will rely on the
# two hiera values:
#
# monitor::snmp::community
# monitor::snmp::manager
#
# There is no iteration for this module. One manager, in position
# number 2, only.
class profile::snmp::windows {

  dsc_windowsfeature { 'snmpserver':
    dsc_ensure               => 'present',
    dsc_name                 => 'SNMP-Service',
    dsc_includeallsubfeature => 'true',
  }

  dsc_windowsfeature { 'snmpserver-rsat':
    dsc_ensure => 'present',
    dsc_name   => 'RSAT-SNMP',
  }

  $snmpcommunitykey = @(END/L)
    HKEY_LOCAL_MACHINE\\SYSTEM\\CurrentControlSet\\services\
    \\SNMP\\Parameters\\ValidCommunities
    |-END

  dsc_registry { 'SNMPMonitor-CommunityString':
    dsc_ensure    => 'present',
    dsc_key       => "$snmpcommunitykey",
    dsc_valuename => lookup('monitor::snmp::community'),
    dsc_valuetype => 'Dword',
    dsc_valuedata => '4',
    notify        => Service['SNMP Service'],
  }

  $snmpmanagerskey = @(END/L)
    HKEY_LOCAL_MACHINE\\SYSTEM\\CurrentControlSet\\services\
    \\SNMP\\Parameters\\PermittedManagers
    |-END

  dsc_registry { 'SNMPManager-Localhost':
    dsc_ensure    => 'present',
    dsc_key       => "$snmpmanagerskey",
    dsc_valuename => '1',
    dsc_valuetype => 'String',
    dsc_valuedata => 'localhost',
    notify        => Service['SNMP Service'],
  }

  dsc_registry { 'SNMPManager-monitor':
    dsc_ensure    => 'present',
    dsc_key       => "$snmpmanagerskey",
    dsc_valuename => '2',
    dsc_valuetype => 'String',
    dsc_valuedata => lookup('monitor::snmp::manager'),
    notify        => Service['SNMP Service'],
  }

  service { 'SNMP Service':
    name    => 'SNMP',
    ensure  => 'running',
    enable  => 'true',
    require => Dsc_windowsfeature['snmpserver'],
  }

}
