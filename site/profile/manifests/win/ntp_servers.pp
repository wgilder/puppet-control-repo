# profile::win::ntp_servers
#
# A description of what this class does
#
# @summary A short summary of the purpose of this class
#
# @example
#   include profile::win::ntp_servers
class profile::win::ntp_servers {
    class { 'windowstime':
      servers  => { '0.nl.pool.ntp.org' => '0x09',
                    '1.nl.pool.ntp.org' => '0x09',
                    '2.nl.pool.ntp.org' => '0x09',
                    '3.nl.pool.ntp.org' => '0x09' }
    }
}
