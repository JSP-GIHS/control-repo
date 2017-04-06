filebucket { 'main':
  path   => false,
  server => lookup("filebucketserver"),
}

File {
  backup => main,
}

node 'default' {
  include mcollective
}

node 'puppet01.curric.gihs.sa.edu.au' {
  class { 'puppetdb::master::config':
    puppetdb_server => 'puppet02.curric.gihs.sa.edu.au',
  }
  include nats
  include mcollective
  include role::jenkins
}

node 'puppet02.curric.gihs.sa.edu.au' {
  class { 'puppetdb':
    listen_address => '0.0.0.0',
  }
  include mcollective
}

