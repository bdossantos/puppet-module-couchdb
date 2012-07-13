# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant::Config.run do |config|
  # All Vagrant configuration is done here. The most common configuration
  # options are documented and commented below. For a complete reference,
  # please see the online documentation at vagrantup.com.

  # Every Vagrant virtual environment requires a box to build off of.
  config.vm.box = "lucid32"

  # Customize memory
  config.vm.customize ["modifyvm", :id, "--memory", "256"]
  
  config.vm.provision :shell, :inline => "[ -f /tmp/updated ] || apt-get update && touch /tmp/updated"
  config.vm.provision :puppet do |puppet|
    puppet.manifests_path = "manifests"
    puppet.module_path = "../"
    puppet.manifest_file = "site.pp"
    puppet.options = "--verbose"
  end
    
  config.vm.define :couchdb do |couchdb_config|
    couchdb_config.vm.host_name = "couchdb"
    couchdb_config.vm.network :hostonly, "192.168.33.10"
    couchdb_config.vm.forward_port 5984, 5984
  end
end