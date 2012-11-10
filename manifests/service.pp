class couchdb::service {

  service { 'couchdb':
    ensure      => running,
    hasstatus   => true,
    hasrestart  => true,
    enable      => true,
    require     => Class['couchdb::install'],
  }
}