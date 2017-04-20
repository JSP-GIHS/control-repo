# Install CGI for Nginx. Note that this does not
# liven up CGI, merely makes it available for
# Nginx to use
class profile::nginx::cgi inherits profile::nginx {

  package { ['libcgi-fast-perl']:
    ensure  => 'latest',
    require => [
      Service['nginx'],
      Package['fcgiwrap'],
      Package['spawn-fcgi'],
    ],
  }

}
