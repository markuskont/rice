$SHELL = <<SCRIPT
pacman -Syyu --noconfirm
pacman -Syyu --noconfirm git rsync
git clone --recurse https://github.com/markuskont/rice /home/vagrant/rice
chown -R vagrant:vagrant /home/vagrant/rice
SCRIPT

MEM=2048
CPUS=4

Vagrant.configure("2") do |config|
  config.vm.box = "archlinux/archlinux"
  config.vm.provider "libvirt" do |v|
    v.memory = MEM
    v.cpus = CPUS
  end
  config.vm.provider :virtualbox do |vb|
    vb.customize ["modifyvm", :id, "--memory", MEM]
    vb.customize ["modifyvm", :id, "--cpus", CPUS]
  end
  config.vm.provision "shell", inline: $SHELL
  config.vm.synced_folder ".", "/vagrant", 
    disabled: false, 
    type: "rsync", 
    rsync__exclude: ".git/"
end
