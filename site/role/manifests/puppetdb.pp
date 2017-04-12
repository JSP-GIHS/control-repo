# Configure the PuppetDB Server
class role::puppetdb {
  include profile::base

  class { 'puppetdb':
    listen_address => lookup('puppet::puppetdb::listenip'),
  }
}
