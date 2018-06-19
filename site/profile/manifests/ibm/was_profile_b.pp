# Profile for Main IBM WAS Server (435)
class profile::ibm::was_profile_b {

  websphere_application_server::instance { 'WebSphere855000':
    target       => '/opt/IBM/WebSphere/AppServer',
    package      => 'com.ibm.websphere.NDTRIAL.v85',
    version      => '8.5.5000.20130514_1044',
    profile_base => '/opt/IBM/WebSphere/AppServer/profiles',
    repository   => '/mnt/wasrepo/NDTRIAL_8.5.5013.20180112_1418/repository.config',
    require      => Mount['/mnt/wasrepo'],
  }

  ibm_pkg { 'WebSphere_855004':
    ensure        => present,
    user          => 'wsadmin',
    package       => 'com.ibm.websphere.NDTRIAL.v85',
    version       => '8.5.5004.20141119_1746',
    target        => '/opt/IBM/WebSphere/AppServer',
    repository    => '/mnt/wasrepo/NDTRIAL_8.5.5004.20141119_1746/repository.config',
    package_owner => 'wsadmin',
    package_group => 'wsadmins',
    require       => [
      Websphere_application_server::Instance['WebSphere855000'],
      Mount['/mnt/wasrepo']
    ],
  }

  ibm_pkg { 'IBMJAVA_712000':
    ensure        => present,
    user          => 'wsadmin',
    package       => 'com.ibm.websphere.IBMJAVA.v71',
    version       => '7.1.2000.20141116_0823',
    target        => '/opt/IBM/WebSphere/AppServer',
    repository    => '/mnt/wasrepo/IBMJAVA_7.1.2000.20141116_0823/repository.config',
    package_owner => 'wsadmin',
    package_group => 'wsadmins',
    require       => Ibm_pkg['WebSphere_855004'],
  }

  # http://54.218.38.201:9060/ibm/console/login.do
  websphere_application_server::profile::dmgr { 'PROFILE_DMGR_01':
    instance_base => '/opt/IBM/WebSphere/AppServer',
    profile_base  => '/opt/IBM/WebSphere/AppServer/profiles',
    cell          => 'CELL_01',
    node_name     => 'dmgrNode01',
    subscribe     => [
      Ibm_pkg['WebSphere_855004'],
      Ibm_pkg['IBMJAVA_712000'],
    ],
  }

  websphere_application_server::cluster { 'MyCluster01':
    profile_base => '/opt/IBM/WebSphere/AppServer/profiles',
    dmgr_profile => 'PROFILE_DMGR_01',
    cell         => 'CELL_01',
    require      => Websphere_application_server::Profile::Dmgr['PROFILE_DMGR_01'],
  }

}
