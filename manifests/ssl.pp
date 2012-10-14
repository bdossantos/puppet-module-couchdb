class couchdb::ssl {

  package { ['openssl']:
    ensure => installed,
  }

  file { $couchdb::cert_path:
    ensure  => directory,
    mode    => '0600',
    owner   => 'couchdb',
    group   => 'couchdb';
  }

  exec { 'generate-certs':
    command => "/usr/bin/openssl req -new -inform PEM -x509 -nodes -days 999 -subj \
                '/C=ZZ/ST=AutoSign/O=AutoSign/localityName=AutoSign/commonName=${::hostname}/organizationalUnitName=AutoSign/emailAddress=AutoSign/' \
                -newkey rsa:2048 -out ${couchdb::cert_path}/couchdb_cert.pem -keyout ${couchdb::cert_path}/couchdb_key.pem",
    unless  => "/usr/bin/test -f ${couchdb::cert_path}/couchdb_cert.pem &&
                /usr/bin/test -f ${couchdb::cert_path}/couchdb_key.pem",
    require => [
      File[$couchdb::cert_path],
      Exec['make-install']
    ],
    notify  => Service['couchdb'],
  }
}