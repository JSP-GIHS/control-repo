# Mostly timeservers are controlled by hiera, so just add the
# proper applicationtier by using the profile::timeserver
class role::timeserver {
  include profile::base
  include profile::timeserver
}
