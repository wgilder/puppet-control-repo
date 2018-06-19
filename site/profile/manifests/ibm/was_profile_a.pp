# Profile for Main IBM WAS Server (160)
class profile::ibm::was_profile_a {

  websphere_application_server::instance { 'WebSphere850000':
    target       => '/opt/IBM/WebSphere/AppServer',
    package      => 'com.ibm.websphere.NDTRIAL.v85',
    version      => '8.5.0000.20120501_1108',
    profile_base => '/opt/IBM/WebSphere/AppServer/profiles',
    repository   => '/mnt/wasrepo/NDTRIAL_8.5.0000.20120501_1108/repository.config',
    require      => Mount['/mnt/wasrepo'],
  }

}
