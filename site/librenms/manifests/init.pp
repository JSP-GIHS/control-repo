# Initialise a LibreNMS installation
#
# As this is a puppet based installation
# you will need to manage your web server.
#
# For our site, we already load php7.0-fpm and php7.0-gd
# into our fcgiwrap installation so those items will be
# commented out
class librenms {

  include librenms::users
  include librenms::php
  include librenms::software

  file { '/usr/bin/distro':
    ensure => 'present',
    owner  => 'root',
    mode   => '0755',
    source => 'puppet:///modules/librenms/distro.sh',
  }

}
