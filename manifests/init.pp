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

  include couchdb::package,
          couchdb::install,
          couchdb::service,
          couchdb::ssl
}

# == Definition: couchdb::conf
#
# This definition installs a couchdb configuration for an application.
#
# === Sample Usage:
#
# The following installs the npm-dev config into local.d configs and
# restarts the couchdb service.
#    couchdb::conf{ 'npm-dev':
#      $config => template('npmjs/etc/couchdb/local.d/npmjs.erb');
#    }
#
define couchdb::conf($config = false, $isDefault = false) {

  $config_path = $isDefault ? {
    false   => '/usr/local/etc/couchdb/local.d',
    default => '/usr/local/etc/couchdb/default.d',
  }

  file { "${config_path}/${name}.ini":
    require => Exec['make-install'],
    ensure  => present,
    owner   => 'couchdb',
    group   => 'couchdb',
    notify  => Service['couchdb'],
    content => $config;
  }
}
