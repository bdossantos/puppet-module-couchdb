# Puppet CouchDB Module

Module for configuring [CouchDB](http://couchdb.apache.org/)

Tested on Debian GNU/Linux 6.0 Squeeze with Puppet 2.6. Patches for other operating systems welcome.

Inspired of [puppet-module-build](https://github.com/jfqd/puppet-module-build/)

## Installation

Clone this repo to a couchdb directory under your Puppet modules directory :

    git clone git://github.com/Benjamin-Ds/puppet-module-couchdb.git couchdb
    
## Usage

    puppet apply -e "class { 'couchdb': bind => '0.0.0.0' }"

## TODO

* SSL cert options
* configure builds options
* dynamic foldername, filename, extension



