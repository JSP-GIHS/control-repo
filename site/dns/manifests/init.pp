# Simple DNS module. Configure with auto-hiera
# dns::searchdomain: "dev.internal"
# dns::nameservers:
#   - 192.168.10.10
#   - 192.168.10.11
class dns (
  $nameservers = '192.168.10.10',
  $searchdomain = 'dev.internal',
) {

  file { '/etc/resolv.conf':
    ensure  => 'file',
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template('dns/resolv.conf.erb'),
  }

}
