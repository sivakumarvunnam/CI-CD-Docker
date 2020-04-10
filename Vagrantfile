# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|
  config.vm.box = "ubuntu/bionic64"
  config.ssh.forward_agent = true
  config.vm.network "private_network", ip: "192.168.50.4"

  # this will bind ports from the guest localhost to the host localhost 
  config.vm.network "forwarded_port", guest: 8080, host: 8080

  config.vm.provider "virtualbox" do |vb|
    vb.memory = "6000"
    vb.customize ["modifyvm", :id, "--cpus", "2"]
  end

  # you can share any folders with the guest machine 
  # config.vm.synced_folder "c:/projects", "/home/vagrant/projects", owner: "vagrant", group: "vagrant"

  # this will copy files to the guest machine, those files are not kept in synch
  config.vm.provision "copy-ssh-keys", type: "file", source: "~/.ssh", destination: "/home/vagrant/.ssh"
  #config.vm.provision "copy-aws-configs", type: "file", source: "~/.aws", destination: "/home/vagrant/.aws"
  config.vm.provision "copy-gitconfig", type: "file", source: "~/.gitconfig", destination: "/home/vagrant/.gitconfig"

  config.vm.provision "install-bootstrap", type: "shell", path: "install-bootstrap.sh", privileged: true
end
