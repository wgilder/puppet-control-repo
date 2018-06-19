# IBM Installation Manager 
class profile::ibm::installation_manager {

  class { 'ibm_installation_manager':
    user              => 'wsadmin',
    group             => 'wsadmins',
    user_home         => '/home/wsadmin',
    installation_mode => 'nonadministrator',
    deploy_source     => true,
    source            => 'http://wasrepo/agent.installer.linux.gtk.x86_64_1.8.9000.20180313_1417.zip',
    require           => [
      User['wsadmin'],
      File['/home/wsadmin'],
    ],
  }

}
