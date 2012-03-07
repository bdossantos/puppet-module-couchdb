class couchdb($download = 'http://mirrors.ircam.fr/pub/apache/couchdb/1.1.1/apache-couchdb-1.1.1.tar.gz',
              $cwd = '/usr/local/src',
              $filename = 'apache-couchdb-1.1.1.tar.gz',
              $extension = '.tar.gz',
              $foldername = 'apache-couchdb-1.1.1',
              $buildoptions = '',
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

    include couchdb::install,
            couchdb::service,
            couchdb::ssl
}