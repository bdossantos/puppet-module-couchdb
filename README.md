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

```bash
puppet apply -e "class { 'couchdb': bind => '0.0.0.0' }"
```

Test with Vagrant + Ubuntu Lucid 32 :

```bash
vagrant up
curl 127.0.0.1:5984
open 127.0.0.1/_utils/
```

## TODO

* SSL cert options
* configure builds options
* dynamic foldername, filename, extension
* Tests w/ rspec-puppet

