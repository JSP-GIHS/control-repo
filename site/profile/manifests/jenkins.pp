# Install and Configure Jenkins
# Plugin data is read from Hiera.
class profile::jenkins (
  Optional[Array] $plugins = undef,
) {

  package { ['puppet-lint']:
    ensure => 'latest',
  }

  include ::jenkins

  if $plugins {
    $plugins.each |$plugin| {
      jenkins::plugin { $plugin: }
    }
  }
}
