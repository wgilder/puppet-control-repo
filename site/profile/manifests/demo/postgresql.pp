# profile::demo::postgresql
#
# A description of what this class does
#
# @summary A short summary of the purpose of this class
#
# @example
#   include profile::demo::postgresql
class profile::demo::postgresql {
  class { 'postgresql::server': }
}
