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
            'erlang-eunit',
            'erlang-dev',
          ]
          $buildoptions = '--with-js-include=/usr/lib/xulrunner-devel-1.9.2.28/include --with-js-lib=/usr/lib/xulrunner-devel-1.9.2.28/lib'
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