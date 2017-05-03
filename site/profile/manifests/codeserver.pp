# All codeserver systems should have their applicationtier custom
# fact set to "codeservers" and include git for code management
#
# Only one applicationtier fact can be set at a time
class profile::codeserver {

  package { ['git']:
    ensure => 'latest',
  }

  File {
    owner => 'root',
    group => 'root',
  }

  file_line { 'applicationtier_codeservers':
    ensure => 'present',
    path   => '/etc/puppetlabs/facter/facts.d/facts.yaml',
    line   => 'applicationtier: codeservers',
    match  => '^applicationtier:',
  }

}
