# role::demo::webapp_frontend
#
# A description of what this class does
#
# @summary A short summary of the purpose of this class
#
# @example
#   include role::demo::webapp_frontend
class role::demo::webapp_frontend {
  include profile::demo::ntp
  include profile::demo::motd
  include profile::demo::apache
}
