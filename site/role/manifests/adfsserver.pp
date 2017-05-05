# ADFS Server Role
class role::adfsserver {

  include profile::base
  include profile::iis
  include profile::adfs::server

}
