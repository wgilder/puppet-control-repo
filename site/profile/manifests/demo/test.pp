# profile::demo::test
#
# A description of what this class does
#
# @summary A short summary of the purpose of this class
#
# @example
#   include profile::demo::test
class profile::demo::test {

  file { '/tmp/this-is-a-test':
    ensure => file,
    content => 'Hi, this is a Puppet test!!',
    mode   => '0777',
    owner  => 'root',
  }
}
