# Create custom resource definitions
define nagios::resource (
  $exported,
  $type,
  $host_use = 'generic-host',
  $ensure = 'present',
  $owner = 'nagios',
  $address = '',
  $hostgroups = '',
  $check_command = '',
) {

  include nagios::params

  $target = "${nagios::params::resourced}/${type}_${name}.cfg"

  case $exported {
    true, false: {}
    default: {
      fail("The exported parameter must be true or false")
    }
  }

  case $type {
    'host': {
      nagios::resource::host { $name:
        ensure        => $ensure,
	use           => $host_use,
	check_command => $check_command,
	address       => $address,
	hostgroups    => $hostgroups,
	target        => $target,
	exported      => $exported,
      }
    }
    'hostgroup': {
      nagios::resource::hostgroup { $name:
        ensure   => $ensure,
	target   => $target,
	exported => $exported,
      }
    }
    default: {
      fail("Unknown type passed to this define: $type")
    }
  }

  nagios::resource::file { $target:
    ensure       => $ensure,
    exported     => $exported,
    resource_tag => "nagios_${type}",
    requires     => "Nagios_${type}[${name}]",
  }

}
