# Nagios export class
#
# Used to generate the hosts configuration
class nagios::export (
  $hostgroups = '',
) {

  if $::osfamily == 'windows' {
    $templatetype = 'windows'
  } else {
    $templatetype = 'linux'
  }

  $hostgroup = ''
  if $hostgroups != '' {
    $hostgroups.each |String $hgname| {
      $hostgroup = "${hostgroup},${hgname}"
    }
  }

  nagios::resource { $::fqdn:
    type          => 'host',
    address       => $::ipaddress,
    hostgroups    => "${templatetype}-servers${hostgroup}",
    host_use      => "${templatetype}-server",
    check_command => 'check_ping!2000.00,80%!4000.00,100%!4',
    exported      => true,
  }

}
