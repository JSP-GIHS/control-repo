# Puppet server role for the environment.
#
# Deployment is for an all in one puppet server which includes
# an mcollective control and PuppetDB
class role::puppetmaster {
  include profile::base
  include nats
  class { 'puppetdb::master::config':
    puppetdb_server => lookup('puppet::puppetdb::server'),
  }
  class { 'r10k':
    remote => lookup('r10k::remote'),
  }
  include r10k::mcollective
}
