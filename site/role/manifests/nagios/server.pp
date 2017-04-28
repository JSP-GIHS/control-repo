# Configure a Nagios capable server
class role::nagios::server {

  include profile::base
  include profile::nginx::php
  include profile::nginx::cgi
  include profile::nagios::server

}
