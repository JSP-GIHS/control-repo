# Create a LibreNMS monitoring capable server
class role::monitor::librenms {

  include profile::base

  # PHP Enabled Nginx
  include profile::nginx::php

  # Monitoring software and configuration
  # Install MySQL
  include profile::monitor::librenms
  include profile::monitor::librenms::mysql

}
