# Install and configure gitweb with repositories in the /srv/git
# location
class profile::gitweb {
  package { ['git', 'gitweb', 'libcgi-fast-perl']:
    ensure  => 'latest',
    require => [
      Package['nginx-core'],
      Package['fcgiwrap'],
    ],
  }

  file { ['/srv', '/srv/git']:
    ensure => 'directory',
  }

  $sitename = $::fqdn
  $home_link_str = $::fqdn

  file_line { '/etc/gitweb.conf_feature_pathinfo':
    ensure  => 'present',
    path    => '/etc/gitweb.conf',
    line    => '$feature{pathinfo}{default} = [1];',
    match   => '^\$feature\{pathinfo\}\{default\} =',
    require => Package['gitweb'],
  }

  file_line { '/etc/gitweb.conf_site_name':
    ensure  => 'present',
    path    => '/etc/gitweb.conf',
    line    => "\$site_name = '${sitename}'",
    match   => '^\$site_name =',
    require => Package['gitweb'],
  }

  file_line { '/etc/gitweb.conf_home_link_str':
    ensure  => 'present',
    path    => '/etc/gitweb.conf',
    line    => "\$home_link_str = '${home_link_str}'",
    match   => '^\$home_link_str =',
    require => Package['gitweb'],
  }
}
