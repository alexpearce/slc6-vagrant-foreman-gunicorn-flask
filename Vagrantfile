# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  # Scientific Linux 6.4
  config.vm.box = "SLC-6.4"
  config.vm.box_url = "http://lyte.id.au/vagrant/sl6-64-lyte.box"

  # Foreman starts web servers on port 5000, so forward to the dev machine
  config.vm.network :forwarded_port, guest: 5000, host: 5000

  # Provision with a shell script
  config.vm.provision "shell", path: "root_provisioning.sh"
end
