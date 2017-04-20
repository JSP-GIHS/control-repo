# Install and configure gitweb with repositories in the /srv/git
# location
class profile::gitweb::nginx {
  package { ['libcgi-fast-perl']:
    ensure  => 'latest',
    require => [
      Package['nginx-core'],
      Package['fcgiwrap'],
      Package['gitweb'],
      Package['git'],
    ],
  }

  $sitename = $::fqdn

  file { '/etc/nginx/.htpasswd.git':
    ensure  => present,
    require => Package['nginx-core'],
  }

  file { '/etc/nginx/sites-available/git':
    ensure  => present,
    source  => 'puppet:///modules/profile/git/nginx.cfg',
    require => Package['nginx-core'],
    notify  => Service['nginx'],
  }

  file { '/etc/nginx/sites-enabled/default':
    ensure  => 'symlink',
    target  => '/etc/nginx/sites-available/git',
    require => Package['nginx-core'],
    notify  => Service['nginx'],
  }
}
