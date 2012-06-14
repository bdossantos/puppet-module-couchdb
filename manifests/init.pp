class couchdb($download = 'http://mirrors.ircam.fr/pub/apache/couchdb/1.1.1/apache-couchdb-1.1.1.tar.gz',
              $cwd = '/usr/local/src',
              $filename = 'apache-couchdb-1.1.1.tar.gz',
              $extension = '.tar.gz',
              $foldername = 'apache-couchdb-1.1.1',
              $buildopts = '',
              $rm_build_folder = false,
              $bind = '127.0.0.1',
              $database_dir = '/usr/local/var/lib/couchdb',
              $view_index_dir = '/usr/local/var/lib/couchdb',
              $log_file = '/usr/local/var/log/couchdb/couch.log',
              $log_level = 'error',
              $os_process_limit = '200',
              $uuids = 'utc_random',
              $cert_path = '/usr/local/etc/certs',
              $ulimit = '65536') {

    case $operatingsystem {
      'Ubuntu': {
        case $operatingsystemrelease {
          '10.04': {
            $packages = ['build-essential',
                         'xulrunner-1.9.2-dev',
                         'libicu-dev',
                         'libcurl4-gnutls-dev',
                         'libtool',
                         'erlang',
                         'erlang-eunit']
            $buildoptions = '--with-js-include=/usr/lib/xulrunner-devel-1.9.2.28/include --with-js-lib=/usr/lib/xulrunner-devel-1.9.2.28/lib'
          }
          default: {}
        }
      }
      default: {
        $packages = ['build-essential',
                              'erlang',
                              'libicu-dev',
                              'libmozjs-dev',
                              'libcurl4-openssl-dev',
                              'curl']
        $buildoptions = $buildopts
      }
    }

    include couchdb::install,
            couchdb::service,
            couchdb::ssl
}
