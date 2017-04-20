# Simple profile - include both xymon::server and
# xymon::client
class profile::xymon {

  include profile::xymon::server
  include profile::xymon::client

}
