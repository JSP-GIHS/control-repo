# Xymon Client configuration
class profile::xymon::client {
  package { ['xymon-client']:
    ensure => present,
  }

  service { ['xymon-client']:
    ensure  => 'running',
    enable  => true,
    require => Package['xymon-client'],
  }

  $xymonserver = lookup('xymon::server::ip')

  file_line { 'xymonclient_server':
    ensure  => present,
    path    => '/etc/default/xymon-client',
    line    => "XYMONSERVERS=\"${xymonserver}\"",
    match   => '^XYMONSERVERS=',
    require => Package['xymon-client'],
    notify  => Service['xymon-client'],
  }
}