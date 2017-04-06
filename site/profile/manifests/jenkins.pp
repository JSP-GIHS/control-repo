class profile::jenkins (
  Optional[Array] $plugins = undef,
) {
  include ::jenkins

  if $plugins {
    $plugins.each |$plugin| {
      jenkins::plugin { $plugin: }
    }
  }
}
