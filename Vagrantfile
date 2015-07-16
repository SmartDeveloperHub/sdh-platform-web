# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.define "vdocker" do |app|
    app.vm.box = "alejandrofcarrera/trusty64-docker"
    app.vm.network :forwarded_port, guest: 9000, host: 9000
    app.vm.provision "shell", path: "vagrant/provision.sh", :privileged => true, run: "once"
    app.vm.provision "shell", path: "vagrant/always.sh", :privileged => true, run: "always"
  end
end
