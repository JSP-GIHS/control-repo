# Future Proofing the Xymon::Server module by ensuring
# that we can later do a Xymon::Client profile
class profile::xymon {
  include profile::xymon::server
}
