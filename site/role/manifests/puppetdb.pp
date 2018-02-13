# Configure the PuppetDB Server
class role::puppetdb {

  include profile::base

  # PuppetDB
  class { 'puppetdb':
    listen_address => lookup('puppet::puppetdb::listenip'),
  }

  # Puppetboard (and Nginx to run it)
  include profile::nginx
  include profile::puppetboard::nginx

  firewall { '8080 allow puppetdb':
    dport  => '8080',
    proto  => 'tcp',
    action => 'accept',
  }

  firewall { '8081 allow puppetdb':
    dport  => '8081',
    proto  => 'tcp',
    action => 'accept',
  }

}
