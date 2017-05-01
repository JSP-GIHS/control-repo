# Nagios resource hostgroup definition
define nagios::resource::hostgroup(
  $target,
  $ensure = 'present',
  $hostgroup_alias = '',
  $exported = false,
) {

  include nagios::params

  if $exported {
    fail("It is not appropriate to export the Nagios_hostgroup type")
  } else {
    nagios_hostgroup { $name:
      ensure  => $ensure,
      target  => $target,
      require => File[$nagios::params::resourced],
    }
  }

}
