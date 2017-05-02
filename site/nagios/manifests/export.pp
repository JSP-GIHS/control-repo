# Nagios export class
#
# Used to generate the hosts configuration
class nagios::export (
  $hostgroups = '',
) {

  if $::osfamily == 'windows' {
    $templatetype = 'windows-server'
  } else {
    $templatetype = 'linux-server'
  }

  if $hostgroups != '' {
    $hostgroup = join(["${templatetype}s", join($hostgroups, ',')], ',')
  } else {
    $hostgroup = "${templatetype}s"
  }

  nagios::resource { $::fqdn:
    type          => 'host',
    address       => $::ipaddress,
    hostgroups    => $hostgroup,
    host_use      => $templatetype,
    check_command => 'check_ping!2000.00,80%!4000.00,100%!4',
    exported      => true,
  }

}
