filebucket { 'filebucketserver':
  path   => false,
  server => lookup('filebucketserver'),
}

File {
  backup => filebucketserver,
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
