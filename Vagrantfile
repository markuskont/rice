$SHELL = <<SCRIPT
pacman -Syyu --noconfirm git rsync
git clone --recurse https://github.com/markuskont/rice /home/vagrant/rice
chown -R vagrant:vagrant /home/vagrant/rice
SCRIPT

Vagrant.configure("2") do |config|
  config.vm.box = "archlinux/archlinux"
  config.vm.box_version = "2019.06.05"
  config.vm.provider "libvirt" do |v|
    v.memory = 4096
    v.cpus = 4
  end
  config.vm.synced_folder ".", "/vagrant", disabled: true
  config.vm.provision "shell", inline: $SHELL
end
