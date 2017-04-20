# CODE server role - providing jenkins and git and gitweb
# and the assosciated bits ( mcollective, nginx )
class role::codeserver {

  include profile::base

  # CI Services
  include profile::codeserver
  include profile::jenkins

  # Gitweb
  include profile::nginx::cgi
  include profile::gitweb::nginx

  # Mcollective RPC
  include r10k::mcollective

}
