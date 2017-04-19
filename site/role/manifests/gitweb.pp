# Xymon role
class role::gitweb {
  include profile::base
  include profile::gitweb
  include profile::nginx
  include profile::gitweb::nginx
}
