# Nagios Parameters File
#
# Referring to multitude of websites here, but a lot comes from the
# linuxjournal puppet and nagios roadmap advanced configuration
class nagios::params {

  $resourced = '/usr/local/nagios/etc/resource.d'
  $user      = 'nagios'

  case $::operatingsystem {
    'Ubuntu': {
      $service = 'nagios'
    }
    default: {
      fail("This module is not supported on $::operatingsystem")
    }
  }

}
