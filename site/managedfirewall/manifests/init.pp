# Managed firewall main class - set up and configure
# the proper sorts of things we should do with pre
# and post rules
class managedfirewall {

  include managedfirewall::pre
  include managedfirewall::post
  include firewall

  firewall { '0022 allow ssh':
    dport  => '22',
    proto  => 'tcp',
    action => 'accept',
  }

  firewall { '0161 allow snmp':
    dport  => '161',
    proto  => 'udp',
    action => 'accept',
  }

  firewall { '5666 allow nagios: nrpe':
    dport  => '5666',
    proto  => 'tcp',
    action => 'accept',
  }

}
