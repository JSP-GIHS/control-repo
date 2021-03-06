# Host resource definition
define nagios::resource::host (
  $address,
  $hostgroups,
  $exported,
  $target,
  $check_command,
  $use,
  $ensure = 'present',
) {

  include nagios::params

  $selectedhostgroups = $hostgroups ? {
    ''      => undef,
    default => $hostgroups,
  }

  if $exported {

    @@nagios_host { $name:
      ensure        => $ensure,
      address       => $address,
      check_command => $check_command,
      use           => $use,
      target        => $target,
      hostgroups    => $selectedhostgroups,
    }

  } else {

    nagios_host { $name:
      ensure        => $ensure,
      address       => $address,
      check_command => $check_command,
      use           => $use,
      target        => $target,
      require       => File[$nagios::params::resourced],
      hostgroups    => $selectedhostgroups,
    }

  }

}
