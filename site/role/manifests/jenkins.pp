#configure the jenkins role
class role::jenkins {
  # be sure to add
  # mcollective::client: true
  # to the hiera for the nodes that you apply
  # this role to.
  include profile::base
  include profile::jenkins
  include r10k::mcollective
}

