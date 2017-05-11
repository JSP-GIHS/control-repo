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
      include profile::monitor::xymon::client
      include profile::snmp::linux
      include managedfirewall::pre
      include managedfirewall::post
      include firewall
    }
  }

  include nagios::export

  File {
    owner => 'root',
    group => 'root',
  }

  file { ['/etc/puppetlabs/facter', '/etc/puppetlabs/facter/facts.d']:
    ensure => 'directory',
  }

  file { '/etc/puppetlabs/facter/facts.d/facts.yaml':
    ensure => 'present',
  }

  service { 'puppet':
    ensure => 'running',
    enable => true,
  }

}
