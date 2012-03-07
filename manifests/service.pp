class couchdb::service {
    
    service { 
        'couchdb': 
        ensure      => running, 
        hasstatus   => true,
        hasrestart  => true, 
        enable      => true,
        require     => File['/etc/init.d/couchdb'];
    }
}