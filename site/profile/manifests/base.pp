# The base profile should include components and modules
# that will be on all nodes.
class profile::base {

  include mcollective
  include ntp
  include profile::xymon::client

}
