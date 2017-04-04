filebucket { 'main':
  path   => false,
  server => lookup("filebucketserver"),
}

File {
  backup => main,
}

node 'default' {
}

node 'puppet01.curric.gihs.sa.edu.au' {
  class { 'puppetdb::master::config':
    puppetdb_server => 'puppet02.curric.gihs.sa.edu.au',
  }
}

node 'puppet02.curric.gihs.sa.edu.au' {
  class { 'puppetdb':
    listen_address => '0.0.0.0',
  }
}

