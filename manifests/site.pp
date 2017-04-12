filebucket { 'main':
  path   => false,
  server => lookup('filebucketserver'),
}

File {
  backup => main,
}

node 'default' {
  include profile::base
}

node 'puppet01.curric.gihs.sa.edu.au' {
  include role::puppetmaster
  include role::jenkins
  include role::xymon
}

node 'puppet02.curric.gihs.sa.edu.au' {
  include role::puppetdb
  include profile::xymon::client
}

