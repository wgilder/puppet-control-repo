# profile::demo::apache
#
# A description of what this class does
#
# @summary A short summary of the purpose of this class
#
# @example
#   include profile::demo::apache
class profile::demo::apache {
  class { 'apache': 
    default_vhost=> true,
  }

  file { '/var/www/html/index.html':
    ensure => file,
    source => 'puppet:///modules/profile/default.html',
    mode   => '0777',
    owner  => 'root',
  }
}
