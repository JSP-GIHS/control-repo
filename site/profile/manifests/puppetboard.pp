# Puppetboard Setup for Nginx. Taken from github issue 143:
# https://github.com/voxpupuli/puppet-puppetboard/issues/143
class profile::puppetboard {
  $user        = 'puppetboard',
  $group       = 'puppetboard',
  $basedir     = '/opt/voxpupuli',
  $docroot     = "${basedir}/puppetboard"
  $wsgi_script = "${docroot}/wsgi.py"

  package { 'uwsgi':
    ensure   => 'latest',
    provider => 'pip',
  }

  class { 'puppetboard':
    user              => $user,
    group             => $group,
    $basedir          => $basedir,
    manage_virtualenv => true,
    reports_count     => 100,
  }

  file { $wsgi_script:
    ensure  => present,
    content => template('puppetboard/wsgi.py.erb'),
    owner   => $user,
    group   => $group,
    require => [
      User[$user],
      Vcsrepo[$docroot],
    ],
  }
}
