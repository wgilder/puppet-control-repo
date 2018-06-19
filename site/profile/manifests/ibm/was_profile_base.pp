# Profile for Main IBM WAS Server
class profile::ibm::was_profile_base {

  host { 'wasrepo':
    ip => '172.31.41.137',
  }

  # WAS Repo /mnt/wasrepo/ contains:
  # NDTRIAL_8.5.5013.20180112_1418
  # NDTRIAL_8.5.5012.20170627_1018
  # NDTRIAL_8.5.5010.20160721_0036
  # NDTRIAL_8.5.5004.20141119_1746
  # NDTRIAL_8.5.5000.20130514_1044
  # NDTRIAL_8.5.0000.20120501_1108

  file { '/mnt/wasrepo':
    ensure => directory,
  }
  mount { '/mnt/wasrepo':
    ensure  => 'mounted',
    device  => 'wasrepo:/wasrepo',
    fstype  => 'nfs',
    options => 'rw,user',
    atboot  => true,
    require => File['/mnt/wasrepo'],
  }

  group { 'wsadmins':
    ensure => present,
  }
  user { 'wsadmin':
    ensure     => present,
    gid        => 'wsadmins',
    home       => '/home/wsadmin',
    managehome => true,
    require    => Group['wsadmins'],
  }
  file { '/home/wsadmin':
    ensure  => directory,
    owner   => 'wsadmin',
    group   => 'wsadmins',
    mode    => '0770',
    require => User['wsadmin'],
  }

  class { 'websphere_application_server':
    base_dir     => '/opt/IBM',
    user         => 'wsadmin',
    group        => 'wsadmins',
    manage_user  => false,
    manage_group => false,
    require      => User['wsadmin'],
  }

}
