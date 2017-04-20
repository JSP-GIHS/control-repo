# Xymon Monitoring Server
class role::xymon {

  include profile::base

  # Xymon and associated web services
  include profile::nginx
  include profile::xymon
  include profile::xymon::nginx

}
