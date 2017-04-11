# Future Proofing the Xymon::Server module by ensuring that we can later do a Xymon::Client role
class role::xymon {
  include role::xymon::server
}
