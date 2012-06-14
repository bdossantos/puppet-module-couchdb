class couchdb::install {

    Exec {
        unless => '/usr/bin/test -f /usr/local/bin/couchdb',
    }

    package {
      $couchdb::packages :
        ensure => 'installed',
    }

    user {
        'couchdb':
        ensure      => 'present',
        home        => '/usr/local/var/lib/couchdb',
        managehome  => false,
        comment     => 'CouchDB Administrator',
        shell       => '/bin/bash'
    }

    file {
        '/usr/local/etc/couchdb/local.ini':
        ensure  => 'file',
        mode    => '0644',
        owner   => 'couchdb',
        group   => 'couchdb',
        content => template('couchdb/usr/local/etc/couchdb/local.ini.erb'),
        notify  => Service['couchdb'];
    }

    exec {
        'download':
        cwd         => $couchdb::cwd,
        command     => "/usr/bin/wget -q ${couchdb::download} -O ${couchdb::filename}",
        timeout     => '120',
    }

    exec {
        'extract':
        cwd         => $couchdb::cwd,
        command     => "/bin/tar -xzvf ${couchdb::filename}",
        timeout     => '120',
        require     => Exec['download'],
    }

    exec {
        'configure':
        cwd     => "${couchdb::cwd}/${couchdb::foldername}",
        command => "${couchdb::cwd}/${couchdb::foldername}/configure ${couchdb::buildoptions}",
        timeout => '600',
        require => [
            Exec['extract'],
            Package[$couchdb::packages]
        ],
    }

    exec {
        'make-install':
        cwd         => "${couchdb::cwd}/${couchdb::foldername}",
        command     => '/usr/bin/make && /usr/bin/make install',
        timeout     => '600',
        require     => Exec['configure'],
    }

    file {
        [$couchdb::database_dir, '/usr/local/etc/couchdb',
        '/usr/local/var/log/couchdb', '/usr/local/var/run/couchdb']:
        ensure  => 'directory',
        owner   => 'couchdb',
        group   => 'couchdb',
        mode    => '2755',
        require => [Exec['make-install'], User['couchdb']];
    }

    file {
        '/etc/init.d/couchdb':
        ensure  => 'link',
        target  => '/usr/local/etc/init.d/couchdb',
        require => Exec['make-install'];

        ['/usr/local/etc/logrotate.d/couchdb', '/etc/logrotate.d/couchdb']:
        ensure  => 'file',
        content => template('couchdb/usr/local/etc/logrotate.d/couchdb.erb'),
        require => Exec['make-install'];

        '/etc/security/limits.d/100-couchdb.conf':
        ensure  => 'file',
        content => template('couchdb/etc/security/limits.d/100-couchdb.conf.erb'),
        require => Exec['make-install'];
    }

    # remove build folder
    case $couchdb::rm_build_folder {
        true: {
            notice('remove build folder')
            exec {
                'remove-build-folder':
                cwd     => $couchdb::cwd,
                command => "/usr/bin/rm -rf ${couchdb::cwd}/${couchdb::foldername}",
                require => Exec['make-install'],
            }
        }
    }
}
