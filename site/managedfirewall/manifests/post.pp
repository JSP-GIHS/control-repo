# Default deny rule
class managedfirewall::post {

  firewallchain { 'FORWARD:filter:IPv4':
    ensure => 'present',
    policy => 'drop',
  }

  firewallchain { 'INPUT:filter:IPv4':
    ensure => 'present',
    policy => 'drop',
  }

  firewallchain { 'OUTPUT:filter:IPv4':
    ensure => 'present',
    policy => 'accept',
  }

  firewallchain { 'FORWARD:filter:IPv6':
    ensure => 'present',
    policy => 'drop',
  }

  firewallchain { 'INPUT:filter:IPv6':
    ensure => 'present',
    policy => 'drop',
  }

  firewallchain { 'OUTPUT:filter:IPv6':
    ensure => 'present',
    policy => 'accept',
  }

}
