require 'spec_helper'

describe 'couchdb', :type => :class do
  let(:title) { 'couchdb' }
  let(:params) do {
      :download   => 'http://mir2.ovh.net/ftp.apache.org/dist/couchdb/source/1.3.0/apache-couchdb-1.3.0.tar.gz',
      :filename   => 'apache-couchdb-1.3.0.tar.gz',
      :foldername => 'apache-couchdb-1.3.0',
    }
  end

  it do
    should contain_exec('download').with({
      'command' => '/usr/bin/wget -q http://mir2.ovh.net/ftp.apache.org/dist/couchdb/source/1.3.0/apache-couchdb-1.3.0.tar.gz -O apache-couchdb-1.3.0.tar.gz',
      'cwd'     => '/usr/local/src',
    })
  end

  it do
    should contain_exec('extract').with({
      'command' => '/bin/tar -xzvf apache-couchdb-1.3.0.tar.gz',
      'cwd'     => '/usr/local/src',
    })
  end

  it do
    should contain_exec('configure').with({
      'cwd' => '/usr/local/src/apache-couchdb-1.3.0',
    })
  end

  it do
    should contain_exec('make-install').with({
      'command' => '/usr/bin/make && /usr/bin/make install',
      'cwd'     => '/usr/local/src/apache-couchdb-1.3.0',
    })
  end

  it do
    should contain_file(
    '/usr/local/var/lib/couchdb',
    '/usr/local/etc/couchdb',
    '/usr/local/var/log/couchdb',
    '/usr/local/var/run/couchdb').with({
      'ensure'  => 'directory',
      'owner'   => 'couchdb',
      'group'   => 'couchdb',
      'mode'    => '0700',
    })
  end

  it do
    should contain_file('/usr/local/etc/couchdb/local.ini').with({
      'ensure'  => 'file',
      'owner'   => 'couchdb',
      'group'   => 'couchdb',
      'mode'    => '0600',
    })
  end

  it do
    should contain_file(
      '/usr/local/etc/logrotate.d/couchdb',
      '/etc/logrotate.d/couchdb',
      '/etc/security/limits.d/100-couchdb.conf').with({
      'ensure'  => 'file',
      'owner'   => 'root',
      'group'   => 'root',
      'mode'    => '0600',
    })
  end

  it do
    should contain_file('/etc/init.d/couchdb').with({
      'ensure'  => 'link',
      'target'  => '/usr/local/etc/init.d/couchdb',
    })
  end
end