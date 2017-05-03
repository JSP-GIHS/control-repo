# Managed firewall main class - set up and configure
# the proper sorts of things we should do with pre
# and post rules
class managedfirewall {

  resources { 'firewall':
    purge => true,
  }

  Firewall {
    before  => Class['managedfirewall::post'],
    require => Class['managedfirewall::pre'],
  }

  include managedfirewall::pre
  include managedfirewall::post
  include firewall

  firewall { '0022 allow ssh':
    port   => '22',
    proto  => 'tcp',
    action => 'accept',
  }

}
