# profile::demo::motd
#
# A description of what this class does
#
# @summary A short summary of the purpose of this class
#
# @example
#   include profile::demo::motd
class profile::demo::motd {
  $ws_hostname = $::hostname

  class { 'motd':
    template => 'puppet:///modules/profile/motd-template.txt',
  }
}
