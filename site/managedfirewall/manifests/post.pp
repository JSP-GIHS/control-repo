# Default deny rule
class managedfirewall::post {

  firewall { '65536 drop all':
    proto  => 'all',
    action => 'drop',
    before => undef,
  }

}
