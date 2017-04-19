# Install and Configure Jenkins
# Plugin data is read from Hiera.
class profile::jenkins (
  Optional[Array] $plugins = undef,
) {

  package { 'ruby':
    ensure => 'latest',
  }

  package { 'puppet-lint':
    ensure   => 'latest',
    provider => 'gem',
    require  => Package['rubygems'],
  }

  include ::jenkins

  if $plugins {
    $plugins.each |$plugin| {
      jenkins::plugin { $plugin: }
    }
  }
}
