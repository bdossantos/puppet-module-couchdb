class couchdb::package {

  package { ['curl', 'build-essential']:
    ensure => 'installed',
  }

  case $operatingsystem {
    'Ubuntu': {
      case $operatingsystemrelease {
        '10.04': {
          $dependencies = [
            'xulrunner-1.9.2-dev',
            'libicu-dev',
            'libcurl4-gnutls-dev',
            'libtool',
            'erlang',
            'erlang-eunit',
          ]
          $buildoptions = '--with-js-include=/usr/lib/xulrunner-devel-1.9.2.28/include --with-js-lib=/usr/lib/xulrunner-devel-1.9.2.28/lib'

          file { '/etc/ld.so.conf.d/xulrunner.conf':
            ensure  => 'file',
            content => template('couchdb/etc/ld.so.conf.d/xulrunner.conf.erb'),
          }

          exec { '/sbin/ldconfig':
            require => File['/etc/ld.so.conf.d/xulrunner.conf'],
            notify  => Service['couchdb'],
          }
        }
        default: {}
      }
    }
    default: {
      $dependencies = [
        'erlang',
        'libicu-dev',
        'libmozjs-dev',
        'libcurl4-openssl-dev',
      ]
      $buildoptions = $buildopts
    }
  }
}
