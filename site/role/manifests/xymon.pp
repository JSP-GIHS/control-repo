# Xymon role
class role::xymon {
  include profile::nginx
  include profile::xymon::server
}
