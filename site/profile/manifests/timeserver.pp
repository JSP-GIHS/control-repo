# Timeservers need a specific application tier setting
class profile::timeserver {

  file_line { 'applicationtier_timeservers':
    ensure => 'present',
    path   => '/etc/puppetlabs/facter/facts.d/facts.yaml',
    line   => 'applicationtier: timeservers',
    match  => '^applicationtier:',
  }

}
