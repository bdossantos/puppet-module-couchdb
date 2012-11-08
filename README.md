# Puppet CouchDB Module

Module for configuring [CouchDB](http://couchdb.apache.org/)

Tested on :

* Debian GNU/Linux 6.0 Squeeze
* Ubuntu Lucid 32 Bit
* Ubuntu Precise 64 Bit

With Puppet 2.6.

Patches for other operating systems welcome.

## Installation

Clone this repo to a couchdb directory under your Puppet modules directory :

```bash
git clone git://github.com/Benjamin-Ds/puppet-module-couchdb.git couchdb
```

## Usage

### Puppet master-less

```bash
puppet apply -e "class { 'couchdb': bind => '0.0.0.0' }"
```

### With Vagrant + Ubuntu Precise 64 :

```bash
vagrant up
curl 127.0.0.1:5984
open http://127.0.0.1:5984/_utils/
```

### Install older version than v1.2.0

```puppet
# site.pp
node default {
  class { 'couchdb':
    bind        => '0.0.0.0',
    download    => 'http://mirrors.ircam.fr/pub/apache/couchdb/1.1.1/apache-couchdb-1.1.1.tar.gz',
    filename    => 'apache-couchdb-1.1.1.tar.gz',
    foldername  => 'apache-couchdb-1.1.1',
  }
}
```

```bash
puppet apply /path/to/site.pp --modulepath /etc/puppet/modules --logdest console
```

## TODO

* SSL cert options
* configure builds options
* dynamic foldername, filename, extension
* Tests w/ rspec-puppet

