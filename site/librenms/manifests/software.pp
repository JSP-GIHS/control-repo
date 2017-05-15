# Include software programs
#
# Note that some of this software is automatically installed
# by other profiles
class librenms::software {

  package { [
      'snmp',
      'graphviz',
      'fping',
      'imagemagick',
      'whois',
      'mtr-tiny',
      'nmap',
      'python-mysqldb',
      'rrdtool',
    ]:
    ensure => 'latest',
  }

}
