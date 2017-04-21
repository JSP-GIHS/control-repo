# Puppetboard Setup for Nginx. Taken from github issue 143:
# https://github.com/voxpupuli/puppet-puppetboard/issues/143
# with some modifications for Ubuntu 16.04 services which
# are really because I haven't found a better way
class profile::puppetboard {

  $user        = 'puppetboard'
  $group       = 'puppetboard'
  $basedir     = '/opt/voxpupuli'
  $docroot     = "${basedir}/puppetboard"
  $wsgi_script = "${docroot}/wsgi.py"

  package { 'uwsgi':
    ensure   => 'latest',
    provider => 'pip',
  }

  class { 'puppetboard':
    user              => $user,
    group             => $group,
    basedir           => $basedir,
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

  case $::operatingsystem {
    'Ubuntu': {
      if versioncmp($::operatingsystemmajrelease, '16.04') >= 0 {

        $pbservice = 'puppetboarduwsgi.service'

        file { "/lib/systemd/system/${pbservice}":
          ensure  => 'file',
          content => template('profile/puppetboard/pbuwsgi.erb'),
        }

        file { "/etc/systemd/system/multi-user.target.wants/${pbservice}":
          ensure  => 'symlink',
          target  => "/lib/systemd/system/${pbservice}",
          require => [
            File["/lib/systemd/system/${pbservice}"],
          ],
        }

        exec { 'systemctl-reloaddaemon-puppetboarduwsgi':
          command     => '/bin/systemctl daemon-reload',
          require     => File["/lib/systemd/system/${pbservice}"],
          subscribe   => [
            File["/lib/systemd/system/${pbservice}"],
          ],
          refreshonly => true,
        }

        service { 'puppetboarduwsgi':
          ensure    => 'running',
          require   => [
            File["/etc/systemd/system/multi-user.target.wants/${pbservice}"],
          ],
          subscribe => [
            File["/lib/systemd/system/${pbservice}"],
          ],
        }
      }
    }
    default: {
      $doingnothing = true
    }
  }
}
