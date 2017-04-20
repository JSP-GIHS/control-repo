# Mostly timeservers are controlled by hiera, so just add the
# proper applicationtier by using the profile::timeserver and
# let the puppetlabs/ntp module do the rest with our hiera
# tiers.
#
# One of the simpler roles
class role::timeserver {

  include profile::base
  include profile::timeserver

}
