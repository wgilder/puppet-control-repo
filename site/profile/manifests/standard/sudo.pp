# profile::standard::sudo
#
# A description of what this class does
#
# @summary A short summary of the purpose of this class
#
# @example
#   include profile::standard::sudo
class profile::standard::demo_prep {
  file_line { 'sudo_path':
    path => '/etc/sudoers',
    line => 'Defaults secure_path = /sbin:/bin:/usr/sbin:/usr/bin:/opt/puppetlabs/bin',
    match => 'Defaults\s+secure_path',
  }

  user { 'centos':
    ensure => present,
    home   => '/home/centos',
  }->

  file { '/home/centos':
    ensure => directory,
    path   => '/home/centos',
    owner  => 'centos',
    mode   => '0700',
  }->

  ssh_authorized_key { 'wmg-mbp':
    ensure => present,
    user   => 'centos',
    type   => 'ssh-rsa',
    key    => 'AAAAB3NzaC1yc2EAAAADAQABAAABAQDbE92MWne4W/7E0EaGfVK4RvL4iyDcEJQg8t+3vEfDI9iq2FgghWRsUhzyn2WOHWg9lkAQ926tTGyUc9fOZU6uTNlhYUTNmWUUBzIJWlw2e4h0/wTG4/9AvPO25wvQhU90rbKzP+j/akEBXsWkf91Aa/2DkgvJoeQAmY2mGtoGWZ5irExEKDp/EazTYoapCEttJr/myDX4FeBEYkEdpWFQvEGZIxtRW8jaknT+goawaFjyO4+64EjGFUqyI8W0ykdfuPVZJ0+mhzAId/Vfc6UG0IbkOMgjurgppsstV82anbVJYf8rarPx3Ryf9eDcjmelj/ZIcAsbiZayMU/WqUBV',
  }

  file { '/etc/sudoers.d/90-cloud-init-users':
    ensure => file,
    mode   => '0440',
  }->

  file_line { 'centos_sudo':
    path => '/etc/sudoers.d/90-cloud-init-users',
    line => 'centos ALL=(ALL) NOPASSWD:ALL',
    match => '^centos\s',
  }
}
