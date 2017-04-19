# Xymon role
class role::gitweb {
  include profile::basic
  include profile::gitweb
  include profile::nginx
  include profile::gitweb::nginx
}
