# Xymon role
class role::xymon {
  include profile::base
  include profile::nginx
  include profile::xymon
}
