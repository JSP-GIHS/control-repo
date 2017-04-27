# The base profile should include components and modules
# that will be on all nodes.
class profile::base {

  include mcollective

  case $facts['os']['name'] {
    'Windows': {
      include profile::snmp::windows
    }
    default: {
      include ntp
      include profile::xymon::client
    }
  }

  service { 'puppet':
    ensure => 'running',
    enable => 'true',
  }
}
