# Be a little bit creative with our SNMP profiles
# 
# Note that these rely on two bits of hiera:
#
# monitor::snmp::community
# monitor::snmp::manager
#
class profile::snmp {

  case $facts['os']['name'] {

    'Windows': {
      include profile::snmp::windows
    }
    default: { # Not technically true
      include profile::snmp::linux
    }

  }

}
