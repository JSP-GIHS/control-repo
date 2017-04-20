# Configure the PuppetDB Server
class role::puppetdb {

  include profile::base

  # PuppetDB
  class { 'puppetdb':
    listen_address => lookup('puppet::puppetdb::listenip'),
  }

  # Puppetboard (and Nginx to run it)
  include profile::nginx
  include profile::puppetboard
  include profile::puppetboard::nginx

}
