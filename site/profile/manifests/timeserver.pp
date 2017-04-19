# Timeservers need a specific application tier setting
class profile::timeserver {

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

  file_line { 'applicationtier_timeservers':
    ensure => 'present',
    path   => '/etc/puppetlabs/facter/facts.d/facts.yaml',
    line   => 'applicationtier: timeservers',
    match  => '^applicationtier:',
  }

}
