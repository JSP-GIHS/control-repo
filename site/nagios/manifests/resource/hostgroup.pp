# Nagios resource hostgroup definition
define nagios::resource::hostgroup(
  $target,
  $ensure = 'present',
  $hostgroup_alias = '',
  $export = false,
) {

  include nagios::params

  if $export {
    fail("It is not appropriate to export the Nagios_hostgroup type")
  } else {
    nagios_hostgroup { $name:
      ensure  => $ensure,
      target  => $target,
      require => File[$nagios::params::resourced],
    }
  }

}
