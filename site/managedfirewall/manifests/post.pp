# Default deny rule
class managedfirewall::post {

  firewallchain { 'INPUT:filter:IPv4':
    ensure => 'present',
    policy => 'drop',
    before => 'undef',
  }

}
