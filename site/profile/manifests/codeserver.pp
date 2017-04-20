# Code hosting services (specifically jenkins and gitweb)
class profile::codeserver {

  package { ['git']:
    ensure => 'latest',
  }

  File {
    owner => 'root',
    group => 'root',
  }

  file { ['/etc/puppetlabs/facter', '/etc/puppetlabs/facter/facts.d']:
    ensure => 'directory',
  }

  file { '/etc/puppetlabs/facter/facts.d/facts.yaml':
    ensure => 'present',
  }

  file_line { 'applicationtier_codeservers':
    ensure => 'present',
    path   => '/etc/puppetlabs/facter/facts.d/facts.yaml',
    line   => 'applicationtier: codeservers',
    match  => '^applicationtier:',
  }

}
