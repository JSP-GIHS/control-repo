#configure the jenkins role
class role::jenkins {
  include profile::base
  include profile::jenkins
}

