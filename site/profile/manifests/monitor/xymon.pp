# Simple profile - include both xymon::server and
# xymon::client
class profile::monitor::xymon {

  include profile::monitor::xymon::server
  include profile::monitor::xymon::client

}
