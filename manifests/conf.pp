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
    ensure  => present,
    owner   => 'couchdb',
    group   => 'couchdb',
    require => Exec['make-install'],
    notify  => Service['couchdb'],
    content => $config;
  }
}