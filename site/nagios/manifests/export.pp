# Nagios export class
#
# Used to generate the hosts configuration
class nagios::export {

  if $::osfamily == 'windows' {
    $templatetype = 'windows'
  } else {
    $templatetype = 'linux'
  }

  nagios::resource { $::fqdn:
    type          => 'host',
    address       => $::ipaddress,
    hostgroups    => "${templatetype}-servers",
    host_use      => "${templatetype}-server",
    check_command => 'check_ping!2000.00,80%!4000.00,100%!4',
    exported      => true,
  }

}
