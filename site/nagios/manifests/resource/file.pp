# File definition
define nagios::resource::file (
  $resource_tag,
  $requires,
  $exported = true,
  $ensure = 'present',
) {

  include nagios::params

  if $exported {

    @@file { $name:
      ensure  => $ensure,
      tag     => $resource_tag,
      owner   => $nagios::params::user,
      require => $requires,
    }

  } else {

    file { $name:
      ensure  => $ensure,
      tag     => $resource_tag,
      owner   => $nagios::params::user,
      require => $requires,
    }

  }

}
