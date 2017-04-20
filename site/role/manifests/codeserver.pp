# CODE server role - providing jenkins and git and gitweb
class role::codeserver {
  include profile::base
  include profile::codeserver
  include profile::jenkins
  include profile::nginx
  include profile::gitweb
  include profile::gitweb::nginx
  include r10k::mcollective
}
