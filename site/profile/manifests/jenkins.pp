# Install and Configure Jenkins
#
# Plugin data is read from Hiera.
#
# Note that puppet-lint is installed here
# as Jenkins is used to test puppet code
class profile::jenkins (
  Optional[Array] $plugins = undef,
) {

  package { 'ruby':
    ensure => 'latest',
  }

  package { 'puppet-lint':
    ensure   => 'latest',
    provider => 'gem',
    require  => Package['ruby'],
  }

  include ::jenkins

  if $plugins {
    $plugins.each |$plugin| {
      jenkins::plugin { $plugin: }
    }
  }

}
