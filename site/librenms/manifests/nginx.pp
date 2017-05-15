# Not a lot to this class - we simply drop the appopriate
# templates into the appropriate locations and reload Nginx
class librenms::nginx {

  file { '/etc/nginx/sites-available/librenms':
    ensure  => 'present',
    content => template('librenms/nginx.cfg.erb'),
    notify  => Service['nginx'],
  }

  file { '/etc/nginx/sites-enabled/librenms':
    ensure => 'symlink',
    target => '/etc/nginx/sites-available/librenms',
    notify => Service['nginx'],
  }

}
