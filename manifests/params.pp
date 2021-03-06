#
# == Class: thunderbird::params
#
# Defines some variables based on the operating system
#
class thunderbird::params {

    include ::os::params

    case $::osfamily {
        'RedHat': {
            $package_name = 'thunderbird'
            $package_require = undef

            $global_config = $::hardwaremodel ? {
                'x86_64' => '/usr/lib64/thunderbird/defaults/pref/syspref.js',
                'i686'   => '/usr/lib/thunderbird/defaults/pref/syspref.js',
                default  => '/usr/lib/thunderbird/defaults/pref/syspref.js',
            }
            $file_perms = '0644'
            $dir_perms = '0755'
        }
        'Debian': {
            $package_require = undef
            $file_perms = '0644'
            $dir_perms = '0755'
            $package_name = 'thunderbird'

            case $::operatingsystem {
                'Debian': {
                    $global_config = '/etc/thunderbird/pref/syspref.js'
                    $package_name_locale = 'thunderbird-l10n'
                }
                'Ubuntu': {
                    $global_config = '/etc/thunderbird/syspref.js'
                    $package_name_locale = 'thunderbird-locale'
                }
                default: {
                    fail("Unsupported OS: ${::operatingsystem}")
                }
            }
        }
        'FreeBSD': {
            $package_name = 'thunderbird'
            $package_require = undef
            $global_config = '/etc/thunderbird/syspref.js'
            $file_perms = '0644'
            $dir_perms = '0755'
        }
        'Windows': {
            $package_name = 'thunderbird'
            $package_require = Class['chocolatey']
            $global_config = 'C:\\Program Files (x86)\\Mozilla Thunderbird\\defaults\\pref\\syspref.js'
            $file_perms = undef
            $dir_perms = undef
        }
        default: {
            fail("Unsupported OS: ${::osfamily}")
        }
    }
}
