# Configure a Nagios capable server
class role::nagiosserver {

  include profile::base
  include profile::nginx::php
  include profile::nginx::cgi
  include nagios

}
