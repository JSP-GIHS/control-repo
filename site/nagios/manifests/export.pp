# Nagios export class
#
# Used to generate the hosts configuration
class nagios::export {

  if $::osfamily == 'windows' {
    $templatetype = 'windows'
  } else {
    $templatetype = 'linux'
  }

  $addresstemplate = @(END/L)
    <%= has_variable ? ('my_nagios_interface') ?\
    eval('ipaddress_' + my_nagios_interface) : ipaddress %>
    |-END

  $hostgrouptemplate = @(END/L)
    <%= has_variable ? ('my_nagios_hostgroups') ?\
    $my_nagios_hostgroups : 'Other' %>
    |-END

  @@nagios_host { $::fqdn:
    type          => 'host',
    address       => inline_template($addresstemplate),
    hostgroups    => inline_template($hostgrouptemplate),
    use           => "${templatetype}-server",
    export        => true,
  }

}
