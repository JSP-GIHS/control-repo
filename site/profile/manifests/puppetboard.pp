# Puppetboard Setup for Nginx. Taken from github issue 143:
# https://github.com/voxpupuli/puppet-puppetboard/issues/143
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

  #
  # Nginx Site Template
  $nginx_site_template = @(END)
upstream puppetboard {
  server    127.0.0.1:9090;
}

server {
  listen       80;
  server_name  <%= @fqdn %>
  charset      utf-8;

  location /static {
    alias <%= @basedir %>/puppetboard/puppetboard/static;
  }

  location / {
    uwsgi_pass puppetboard;
    include    /etc/nginx/uwsgi_params;
  }
}
  END

  file { '/etc/nginx/sites-available/puppetboard':
    ensure  => 'file',
    content => inline_template( $nginx_site_template ),
    require => Package['nginx-core'],
  }

  case $::operatingsystem {
    'Ubuntu': {
      if versioncmp($::operatingsystemmajrelease, '16.04') >= 0 {
        #
        # Systemd service template
        # Note that puppetboard_settings is not created or controlled
        # by this profile as it's not necessary for a profile
        # intended to be on the same server as puppetdb
        $systemd_service_template = @(END)
[Unit]
Description=uWSGI Instance of Puppetboard
After=network.target

[Service]
User=<%= @user %>
Group=<%= @group %>
WorkingDirectory=<%= @docroot %>
Environment='PUPPETBOARD_SETTINGS=/var/www/puppetboard/settings.py'
ExecStart=/usr/local/bin/uwsgi --socket '127.0.0.1:9090' --wsgi-file wsgi.py

[Install]
WantedBy=multi-user.target
END

        $pbservice = 'puppetboarduwsgi.service'

        file { "/lib/systemd/system/${pbservice}":
          ensure  => 'file',
          content => inline_template( $systemd_service_template ),
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
      }
    }
    default: {
      $doingnothing = true
    }
  }
}
