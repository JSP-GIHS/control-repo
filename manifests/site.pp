filebucket { 'filebucketserver':
  path   => false,
  server => lookup('filebucketserver'),
}

File {
  backup => filebucketserver,
}

resources { 'firewall':
  purge => true,
}

resources { 'firewallchain':
  purge => true,
}

Firewall {
  before  => Class['managedfirewall::post'],
  require => Class['managedfirewall::pre'],
}

node 'default' {
  include profile::base
}

node 'puppet01.curric.gihs.sa.edu.au' {
  include role::puppetmaster
}

node 'puppet02.curric.gihs.sa.edu.au' {
  include role::puppetdb
}

node 'testclient.curric.gihs.sa.edu.au' {
  include role::codeserver
}
