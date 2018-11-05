# profile::standard::sudo
#
# A description of what this class does
#
# @summary A short summary of the purpose of this class
#
# @example
#   include profile::standard::sudo
class profile::standard::sudo {
  file_line { 'sudo_path':
    path => '/etc/sudoers',
    line => 'Defaults secure_path = /sbin:/bin:/usr/sbin:/usr/bin:/opt/puppetlabs/bin',
    match => '^\s*Defaults\s+secure_path\s*',
  }
}
