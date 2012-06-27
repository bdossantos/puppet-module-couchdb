node default {
  class { 'couchdb':
    bind => '0.0.0.0'
  }
}