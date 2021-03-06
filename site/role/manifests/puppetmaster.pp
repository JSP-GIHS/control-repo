# Puppet server role for the environment.
#
# Deployment is for an all in one puppet server which includes
# an mcollective control and PuppetDB
class role::puppetmaster {

  include profile::base

  # Mcollective NATS
  include nats

  # Configure puppetdb server config
  class { 'puppetdb::master::config':
    puppetdb_server => lookup('puppet::puppetdb::server'),
  }

  # Configure r10k for dynamic environments
  # including the Mcollective RPC services
  class { 'r10k':
    remote => lookup('r10k::remote'),
  }
  include r10k::mcollective

  firewall { '8140 allow puppet':
    dport  => '8140',
    proto  => 'tcp',
    action => 'accept',
  }

}
