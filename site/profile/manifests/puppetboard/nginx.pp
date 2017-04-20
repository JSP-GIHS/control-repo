# Puppetboard Setup for Nginx. Taken from github issue 143:
# https://github.com/voxpupuli/puppet-puppetboard/issues/143
class profile::puppetboard::nginx inherits profile::puppetboard {
  $user        = 'puppetboard'
  $group       = 'puppetboard'
  $basedir     = '/opt/voxpupuli'
  $docroot     = "${basedir}/puppetboard"
  $wsgi_script = "${docroot}/wsgi.py"

  # Unused at this time.
  file { '/etc/nginx/.htpasswd.puppetboard':
    ensure  => 'present',
    require => Service['nginx'],
  }

  file { '/etc/nginx/sites-available/puppetboard':
    ensure  => 'file',
    content => template('puppetboard/nginx.cfg.erb'),
    require => Service['nginx'],
    notify  => Service['nginx'],
  }

  file { '/etc/nginx/sites-enabled/puppetboard':
    ensure  => 'symlink',
    target  => '/etc/nginx/sites-available/puppetboard',
    require => [
      Service['nginx'],
      File['/etc/nginx/sites-available/puppetboard'],
    ],
    notify  => Service['nginx'],
  }
}
