# Add nginx configuration for gitweb
class profile::gitweb::nginx inherits profile::gitweb {

  $sitename = $::fqdn

  file { '/etc/nginx/.htpasswd.git':
    ensure  => 'present',
    require => Service['nginx'],
  }

  file { '/etc/nginx/sites-available/gitweb':
    ensure  => 'present',
    source  => template('gitweb/nginx.cfg.erb'),
    require => Service['nginx'],
    notify  => Service['nginx'],
  }

  file { '/etc/nginx/sites-enabled/gitweb':
    ensure  => 'symlink',
    target  => '/etc/nginx/sites-available/gitweb',
    require => Service['nginx'],
    notify  => Service['nginx'],
  }

}
