# Defines config for a WAS Repo (HTTP) running on Windows
class profile::ibm::was_repo {

  package { '7zip':
    ensure   => present,
    provider => 'chocolatey',
  }

  $iis_features = ['Web-WebServer','Web-Dir-Browsing']
  $pshell = 'C:/Windows/System32/WindowsPowerShell/v1.0/powershell.exe -NoProfile -NoLogo -NonInteractive'
  $site = 'wasrepo'

  iis_feature { $iis_features:
    ensure => present,
  }

  iis_site { 'Default Web Site':
    ensure => 'stopped',
  }
  -> iis_site { $site:
    ensure           => 'started',
    physicalpath     => 'C:\\repo',
    applicationpool  => 'DefaultAppPool',
    enabledprotocols => 'http',
    bindings         => [
      {
        'bindinginformation' => '*:80:',
        'protocol'           => 'http',
      },
    ],
    require          => File[$site],
  }
  -> exec { "Set ${site} Directory Browsing":
    #lint:ignore:140chars
    command => "${pshell} -Command Set-WebConfigurationProperty -filter /system.webServer/directoryBrowse -name enabled -PSPath 'IIS:\\Sites\\${site}' -value true",
    unless  => "${pshell} -Command Get-WebConfigurationProperty -filter /system.webServer/directoryBrowse -name enabled -PSPath 'IIS:\\Sites\\${site}' | Select-Object -property value | %{ if (\$_.value -eq \$true) {exit 0} else {exit 1} }"
    #lint:endignore
  }

  file { $site:
    ensure => 'directory',
    path   => 'C:\\repo',
  }

  windowsfeature { 'FS-NFS-Service':
    ensure => present,
  }
  -> exec { "Set ${site} NFS Share":
    #lint:ignore:140chars
    command => "${pshell} -Command New-NfsShare -Name ${site} -Path C:\\repo -EnableAnonymousAccess",
    unless  => "${pshell} -Command Get-NfsShare -Name ${site} | Select-Object -property Name | %{ if (\$_.Name -eq '${site}') {exit 0} else {exit 1} }",
    #lint:endignore
  }

}
