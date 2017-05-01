# Create custom resource definitions
define nagios::resource (
  $export,
  $type,
  $host_use = 'generic-host',
  $ensure = 'present',
  $owner = 'nagios',
  $address = '',
  $hostgroups = '',
  $check_command = '',
) {

  include nagios::params

  $targettemplate = @(END/L)
    ${nagios::params::resourced/${type}_\
    <%=name.gsub(/\\s+/, '_').downcase %>.cfg\
    |-END

  $target = inline_template( $targettemplate )

  case $export {
    true, false: {}
    default: {
      fail("The export parameter must be true or false")
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
	export        => $export,
      }
    }
    'hostgroup': {
      nagios::resource::hostgroup { $name:
        ensure => $ensure,
	target => $target,
	export => $export,
      }
    }
    default: {
      fail("Unknown type passed to this define: $type")
    }
  }

  nagios::resource::file { $target:
    ensure       => $ensure,
    export       => $export,
    resource_tag => "nagios_${type}",
    requires     => "Nagios_${type}[${name}]",
  }

}
