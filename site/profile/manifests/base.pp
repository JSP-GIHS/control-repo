# The base profile should include components and modules
# that will be on all nodes.
class profile::base {

  include mcollective

  case $facts['os']['name'] {
    'Ubuntu': {
      include ntp
      include profile::xymon::client
    }
    'Windows': {
      include profile::snmp::windows
    }
  }

  service { 'puppet':
    ensure => 'running',
    enable => 'true',
  }
}
