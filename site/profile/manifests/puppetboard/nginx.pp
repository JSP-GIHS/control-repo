# Puppetboard Setup for Nginx. Taken from github issue 143:
# https://github.com/voxpupuli/puppet-puppetboard/issues/143
class profile::puppetboard::nginx {
  $user        = 'puppetboard'
  $group       = 'puppetboard'
  $basedir     = '/opt/voxpupuli'
  $docroot     = "${basedir}/puppetboard"
  $wsgi_script = "${docroot}/wsgi.py"

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

  file { '/etc/nginx/sites-enabled/default':
    ensure  => 'symlink',
    target  => '/etc/nginx/sites-available/puppetboard',
    require => [
      Package['nginx-core'],
      File['/etc/nginx/sites-enabled/puppetboard'],
    ],
  }
}
